Received: from eggs.gnu.org ([2001:4830:134:3::10]:53164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsU9O-00054K-SI
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsU9N-00013F-OI
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:30:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fsU9N-00012o-Hb
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:30:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3468540241E8
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 14:30:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Aug 2018 16:29:56 +0200
Message-Id: <20180822142956.6859-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180822142956.6859-1-marcandre.lureau@redhat.com>
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/3] seccomp: set the seccomp filter to all
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pmoore@redhat.com, Eduardo Otubo <otubo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

When using "-seccomp on", the seccomp policy is only applied to the
main thread, the vcpu worker thread and other worker threads created
after seccomp policy is applied; the seccomp policy is not applied to
e.g. the RCU thread because it is created before the seccomp policy is
applied and SECCOMP_FILTER_FLAG_TSYNC isn't used.

This can be verified with
for task in /proc/`pidof qemu`/task/*; do cat $task/status | grep Secc ; =
done
Seccomp:	2
Seccomp:	0
Seccomp:	0
Seccomp:	2
Seccomp:	2
Seccomp:	2

Starting with libseccomp 2.2.0 and kernel >=3D 3.17, we can use
seccomp_attr_set(ctx, > SCMP_FLTATR_CTL_TSYNC, 1) to update the policy
on all threads.

Do it by default if possible, warn if not possible. Add an option to
set the tsync behaviour explicitly.

Note: we can't bump libseccomp to 2.2.0 since it's not available in
Debian oldstable (2.1.0).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-seccomp.c  | 65 +++++++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx |  2 ++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index f0c833f3ca..aa23eae970 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -119,6 +119,45 @@ qemu_seccomp(unsigned int operation, unsigned int fl=
ags, void *args)
 #endif
 }
=20
+static bool qemu_seccomp_syscall_check(void)
+{
+    int rc;
+
+    /*
+     * this is an invalid call because the second argument is non-zero, =
but
+     * depending on the errno value of ENOSYS or EINVAL we can guess if =
the
+     * seccomp() syscal is supported or not
+     */
+    rc =3D qemu_seccomp(SECCOMP_SET_MODE_STRICT, 1, NULL);
+    if (rc < 0 && errno =3D=3D EINVAL) {
+        return true;
+    }
+
+    return false;
+}
+
+static bool qemu_seccomp_get_default_tsync(void)
+{
+    bool tsync =3D true;
+
+    /* TSYNC support was added with the syscall */
+    if (!qemu_seccomp_syscall_check()) {
+        error_report("The host kernel doesn't support seccomp TSYNC!");
+        tsync =3D false;
+    }
+
+#if !(SCMP_VER_MAJOR >=3D 2 && SCMP_VER_MINOR >=3D 2)
+    error_report("libseccomp is too old to support TSYNC!");
+    tsync =3D false;
+#endif
+
+    if (!tsync) {
+        error_report("Only the main thread will be filtered by seccomp!"=
);
+    }
+
+    return tsync;
+}
+
 static uint32_t qemu_seccomp_get_kill_action(void)
 {
 #if defined(SECCOMP_GET_ACTION_AVAIL) && defined(SCMP_ACT_KILL_PROCESS) =
&& \
@@ -136,7 +175,7 @@ static uint32_t qemu_seccomp_get_kill_action(void)
 }
=20
=20
-static int seccomp_start(uint32_t seccomp_opts)
+static int seccomp_start(uint32_t seccomp_opts, bool tsync)
 {
     int rc =3D 0;
     unsigned int i =3D 0;
@@ -149,6 +188,17 @@ static int seccomp_start(uint32_t seccomp_opts)
         goto seccomp_return;
     }
=20
+    if (tsync) {
+#if SCMP_VER_MAJOR >=3D 2 && SCMP_VER_MINOR >=3D 2
+        rc =3D seccomp_attr_set(ctx, SCMP_FLTATR_CTL_TSYNC, 1);
+#else
+        rc =3D -1;
+#endif
+        if (rc !=3D 0) {
+            goto seccomp_return;
+        }
+    }
+
     for (i =3D 0; i < ARRAY_SIZE(blacklist); i++) {
         if (!(seccomp_opts & blacklist[i].set)) {
             continue;
@@ -175,6 +225,13 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Erro=
r **errp)
         uint32_t seccomp_opts =3D QEMU_SECCOMP_SET_DEFAULT
                 | QEMU_SECCOMP_SET_OBSOLETE;
         const char *value =3D NULL;
+        bool tsync;
+
+        if (qemu_opt_get(opts, "tsync")) {
+            tsync =3D qemu_opt_get_bool(opts, "tsync", true);
+        } else {
+            tsync =3D qemu_seccomp_get_default_tsync();
+        }
=20
         value =3D qemu_opt_get(opts, "obsolete");
         if (value) {
@@ -236,7 +293,7 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Error=
 **errp)
             }
         }
=20
-        if (seccomp_start(seccomp_opts) < 0) {
+        if (seccomp_start(seccomp_opts, tsync) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
             return -1;
@@ -271,6 +328,10 @@ static QemuOptsList qemu_sandbox_opts =3D {
             .name =3D "resourcecontrol",
             .type =3D QEMU_OPT_STRING,
         },
+        {
+            .name =3D "tsync",
+            .type =3D QEMU_OPT_BOOL,
+        },
         { /* end of list */ }
     },
 };
diff --git a/qemu-options.hx b/qemu-options.hx
index 5515dfaba5..dafacb60c6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3864,6 +3864,8 @@ Disable set*uid|gid system calls
 Disable *fork and execve
 @item resourcecontrol=3D@var{string}
 Disable process affinity and schedular priority
+@item tsync=3D@var{bool}
+Apply seccomp filter to all threads (default is auto, and will warn if f=
ail)
 @end table
 ETEXI
=20
--=20
2.18.0.547.g1d89318c48
