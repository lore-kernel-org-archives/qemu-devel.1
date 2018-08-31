Received: from eggs.gnu.org ([2001:4830:134:3::10]:60524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvkny-0002aH-Ca
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvknw-0005Rf-Tg
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:53:46 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Aug 2018 16:53:12 +0200
Message-Id: <20180831145314.14736-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180831145314.14736-1-marcandre.lureau@redhat.com>
References: <20180831145314.14736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] util: add qemu_write_pidfile()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

There are variants of qemu_create_pidfile() in qemu-pr-helper and
qemu-ga. Let's have a common implementation in libqemuutil.

The code is initially based from pr-helper write_pidfile(), with
various improvements and suggestions from Daniel Berrang=C3=A9:

  QEMU will leave the pidfile existing on disk when it exits which
  initially made me think it avoids the deletion race. The app
  managing QEMU, however, may well delete the pidfile after it has
  seen QEMU exit, and even if the app locks the pidfile before
  deleting it, there is still a race.

  eg consider the following sequence

        QEMU 1        libvirtd        QEMU 2

  1.    lock(pidfile)

  2.    exit()

  3.                 open(pidfile)

  4.                 lock(pidfile)

  5.                                  open(pidfile)

  6.                 unlink(pidfile)

  7.                 close(pidfile)

  8.                                  lock(pidfile)

  IOW, at step 8 the new QEMU has successfully acquired the lock, but
  the pidfile no longer exists on disk because it was deleted after
  the original QEMU exited.

  While we could just say no external app should ever delete the
  pidfile, I don't think that is satisfactory as people don't read
  docs, and admins don't like stale pidfiles being left around on
  disk.

  To make this robust, I think we might want to copy libvirt's
  approach to pidfile acquisition which runs in a loop and checks that
  the file on disk /after/ acquiring the lock matches the file that
  was locked. Then we could in fact safely let QEMU delete its own
  pidfiles on clean exit..

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/osdep.h  |  3 +-
 os-posix.c            | 24 ---------------
 os-win32.c            | 25 ----------------
 qga/main.c            | 54 +++++++---------------------------
 scsi/qemu-pr-helper.c | 40 ++++---------------------
 util/oslib-posix.c    | 68 +++++++++++++++++++++++++++++++++++++++++++
 util/oslib-win32.c    | 27 +++++++++++++++++
 vl.c                  |  4 +--
 8 files changed, 114 insertions(+), 131 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index a91068df0e..47fa570bd4 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -448,7 +448,8 @@ bool qemu_has_ofd_lock(void);
 #define FMT_pid "%d"
 #endif
=20
-int qemu_create_pidfile(const char *filename);
+bool qemu_write_pidfile(const char *pidfile, Error **errp);
+
 int qemu_get_thread_id(void);
=20
 #ifndef CONFIG_IOVEC
diff --git a/os-posix.c b/os-posix.c
index 9ce6f74513..0e9403b4ff 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -352,30 +352,6 @@ void os_set_line_buffering(void)
     setvbuf(stdout, NULL, _IOLBF, 0);
 }
=20
-int qemu_create_pidfile(const char *filename)
-{
-    char buffer[128];
-    int len;
-    int fd;
-
-    fd =3D qemu_open(filename, O_RDWR | O_CREAT, 0600);
-    if (fd =3D=3D -1) {
-        return -1;
-    }
-    if (lockf(fd, F_TLOCK, 0) =3D=3D -1) {
-        close(fd);
-        return -1;
-    }
-    len =3D snprintf(buffer, sizeof(buffer), FMT_pid "\n", getpid());
-    if (write(fd, buffer, len) !=3D len) {
-        close(fd);
-        return -1;
-    }
-
-    /* keep pidfile open & locked forever */
-    return 0;
-}
-
 bool is_daemonized(void)
 {
     return daemonize;
diff --git a/os-win32.c b/os-win32.c
index 0674f94b57..0e0d7f50f3 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -97,28 +97,3 @@ int os_parse_cmd_args(int index, const char *optarg)
 {
     return -1;
 }
-
-int qemu_create_pidfile(const char *filename)
-{
-    char buffer[128];
-    int len;
-    HANDLE file;
-    OVERLAPPED overlap;
-    BOOL ret;
-    memset(&overlap, 0, sizeof(overlap));
-
-    file =3D CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ, NULL,
-                      OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
-
-    if (file =3D=3D INVALID_HANDLE_VALUE) {
-        return -1;
-    }
-    len =3D snprintf(buffer, sizeof(buffer), "%d\n", getpid());
-    ret =3D WriteFile(file, (LPCVOID)buffer, (DWORD)len,
-                    NULL, &overlap);
-    CloseHandle(file);
-    if (ret =3D=3D 0) {
-        return -1;
-    }
-    return 0;
-}
diff --git a/qga/main.c b/qga/main.c
index 6d70242d05..c399320d3c 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -340,46 +340,6 @@ static FILE *ga_open_logfile(const char *logfile)
     return f;
 }
=20
-#ifndef _WIN32
-static bool ga_open_pidfile(const char *pidfile)
-{
-    int pidfd;
-    char pidstr[32];
-
-    pidfd =3D qemu_open(pidfile, O_CREAT|O_WRONLY, S_IRUSR|S_IWUSR);
-    if (pidfd =3D=3D -1 || lockf(pidfd, F_TLOCK, 0)) {
-        g_critical("Cannot lock pid file, %s", strerror(errno));
-        if (pidfd !=3D -1) {
-            close(pidfd);
-        }
-        return false;
-    }
-
-    if (ftruncate(pidfd, 0)) {
-        g_critical("Failed to truncate pid file");
-        goto fail;
-    }
-    snprintf(pidstr, sizeof(pidstr), "%d\n", getpid());
-    if (write(pidfd, pidstr, strlen(pidstr)) !=3D strlen(pidstr)) {
-        g_critical("Failed to write pid file");
-        goto fail;
-    }
-
-    /* keep pidfile open & locked forever */
-    return true;
-
-fail:
-    unlink(pidfile);
-    close(pidfd);
-    return false;
-}
-#else /* _WIN32 */
-static bool ga_open_pidfile(const char *pidfile)
-{
-    return true;
-}
-#endif
-
 static gint ga_strcmp(gconstpointer str1, gconstpointer str2)
 {
     return strcmp(str1, str2);
@@ -479,8 +439,11 @@ void ga_unset_frozen(GAState *s)
     ga_enable_logging(s);
     g_warning("logging re-enabled due to filesystem unfreeze");
     if (s->deferred_options.pid_filepath) {
-        if (!ga_open_pidfile(s->deferred_options.pid_filepath)) {
-            g_warning("failed to create/open pid file");
+        Error *err =3D NULL;
+
+        if (!qemu_write_pidfile(s->deferred_options.pid_filepath, &err))=
 {
+            g_warning("%s", error_get_pretty(err));
+            error_free(err);
         }
         s->deferred_options.pid_filepath =3D NULL;
     }
@@ -515,8 +478,11 @@ static void become_daemon(const char *pidfile)
     }
=20
     if (pidfile) {
-        if (!ga_open_pidfile(pidfile)) {
-            g_critical("failed to create pidfile");
+        Error *err =3D NULL;
+
+        if (!qemu_write_pidfile(pidfile, &err)) {
+            g_critical("%s", error_get_pretty(err));
+            error_free(err);
             exit(EXIT_FAILURE);
         }
     }
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index ed037aabee..ce40008bfc 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -117,39 +117,6 @@ QEMU_COPYRIGHT "\n"
     , name);
 }
=20
-static void write_pidfile(void)
-{
-    int pidfd;
-    char pidstr[32];
-
-    pidfd =3D qemu_open(pidfile, O_CREAT|O_WRONLY, S_IRUSR|S_IWUSR);
-    if (pidfd =3D=3D -1) {
-        error_report("Cannot open pid file, %s", strerror(errno));
-        exit(EXIT_FAILURE);
-    }
-
-    if (lockf(pidfd, F_TLOCK, 0)) {
-        error_report("Cannot lock pid file, %s", strerror(errno));
-        goto fail;
-    }
-    if (ftruncate(pidfd, 0)) {
-        error_report("Failed to truncate pid file");
-        goto fail;
-    }
-
-    snprintf(pidstr, sizeof(pidstr), "%d\n", getpid());
-    if (write(pidfd, pidstr, strlen(pidstr)) !=3D strlen(pidstr)) {
-        error_report("Failed to write pid file");
-        goto fail;
-    }
-    return;
-
-fail:
-    unlink(pidfile);
-    close(pidfd);
-    exit(EXIT_FAILURE);
-}
-
 /* SG_IO support */
=20
 typedef struct PRHelperSGIOData {
@@ -1080,8 +1047,11 @@ int main(int argc, char **argv)
         }
     }
=20
-    if (daemonize || pidfile_specified)
-        write_pidfile();
+    if ((daemonize || pidfile_specified) &&
+        !qemu_write_pidfile(pidfile, &local_err)) {
+        error_report_err(local_err);
+        exit(EXIT_FAILURE);
+    }
=20
 #ifdef CONFIG_LIBCAP
     if (drop_privileges() < 0) {
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 13b6f8d776..0e3ab9d959 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -88,6 +88,74 @@ int qemu_daemon(int nochdir, int noclose)
     return daemon(nochdir, noclose);
 }
=20
+bool qemu_write_pidfile(const char *path, Error **errp)
+{
+    int fd;
+    char pidstr[32];
+
+    while (1) {
+        struct stat a, b;
+
+        fd =3D qemu_open(path, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
+        if (fd =3D=3D -1) {
+            error_setg_errno(errp, errno, "Cannot open pid file");
+            return false;
+        }
+
+        if (fstat(fd, &b) < 0) {
+            error_setg_errno(errp, errno, "Cannot stat file");
+            goto fail_close;
+        }
+
+        if (lockf(fd, F_TLOCK, 0) < 0) {
+            error_setg_errno(errp, errno, "Cannot lock pid file");
+            goto fail_close;
+        }
+
+        /*
+         * Now make sure the path we locked is the same one that now
+         * exists on the filesystem.
+         */
+        if (stat(path, &a) < 0) {
+            /*
+             * PID file disappeared, someone else must be racing with
+             * us, so try again.
+             */
+            close(fd);
+            continue;
+        }
+
+        if (a.st_ino =3D=3D b.st_ino) {
+            break;
+        }
+
+        /*
+         * PID file was recreated, someone else must be racing with
+         * us, so try again.
+         */
+        close(fd);
+    }
+
+    if (ftruncate(fd, 0) < 0) {
+        error_setg_errno(errp, errno, "Failed to truncate pid file");
+        goto fail_unlink;
+    }
+
+    snprintf(pidstr, sizeof(pidstr), FMT_pid "\n", getpid());
+    if (write(fd, pidstr, strlen(pidstr)) !=3D strlen(pidstr)) {
+        error_setg(errp, "Failed to write pid file");
+        goto fail_unlink;
+    }
+
+    return true;
+
+fail_unlink:
+    unlink(path);
+fail_close:
+    close(fd);
+    return false;
+}
+
 void *qemu_oom_check(void *ptr)
 {
     if (ptr =3D=3D NULL) {
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 25dd1595ad..a83fc24a33 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -776,3 +776,30 @@ ssize_t qemu_recvfrom_wrap(int sockfd, void *buf, si=
ze_t len, int flags,
     }
     return ret;
 }
+
+bool qemu_write_pidfile(const char *filename, Error **errp)
+{
+    char buffer[128];
+    int len;
+    HANDLE file;
+    OVERLAPPED overlap;
+    BOOL ret;
+    memset(&overlap, 0, sizeof(overlap));
+
+    file =3D CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ, NULL,
+                      OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
+
+    if (file =3D=3D INVALID_HANDLE_VALUE) {
+        error_setg(errp, "Failed to create PID file");
+        return false;
+    }
+    len =3D snprintf(buffer, sizeof(buffer), FMT_pid "\n", getpid());
+    ret =3D WriteFile(file, (LPCVOID)buffer, (DWORD)len,
+                    NULL, &overlap);
+    CloseHandle(file);
+    if (ret =3D=3D 0) {
+        error_setg(errp, "Failed to write PID file");
+        return false;
+    }
+    return true;
+}
diff --git a/vl.c b/vl.c
index 5ba06adf78..0eaf948d32 100644
--- a/vl.c
+++ b/vl.c
@@ -3996,8 +3996,8 @@ int main(int argc, char **argv, char **envp)
     os_daemonize();
     rcu_disable_atfork();
=20
-    if (pid_file && qemu_create_pidfile(pid_file) !=3D 0) {
-        error_report("could not acquire pid file: %s", strerror(errno));
+    if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
+        error_reportf_err(err, "cannot create PID file: ");
         exit(1);
     }
=20
--=20
2.19.0.rc1
