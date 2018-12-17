Received: from eggs.gnu.org ([2001:4830:134:3::10]:51127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveb-0000fn-QX
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveX-0000VH-GA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:22:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYveX-0000UU-6N
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 17 Dec 2018 17:21:28 +0100
Message-Id: <1545063690-10116-12-git-send-email-thuth@redhat.com>
In-Reply-To: <1545063690-10116-1-git-send-email-thuth@redhat.com>
References: <1545063690-10116-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/13] tests: Exit boot-serial-test loop if
 child dies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

There's no point in waiting 5 full minutes when there will be
no more output.  Compute timeout based on elapsed wall clock
time instead of N * delays, as the delay is a minimum sleep time.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
[thuth: Replaced global_qtest with local qts variable]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-serial-test.c | 20 ++++++++++----
 tests/libqtest.c         | 72 ++++++++++++++++++++++++++++++------------=
------
 tests/libqtest.h         |  8 ++++++
 3 files changed, 68 insertions(+), 32 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 366fe51..58a48f3 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -128,13 +128,14 @@ static testdef_t tests[] =3D {
     { NULL }
 };
=20
-static bool check_guest_output(const testdef_t *test, int fd)
+static bool check_guest_output(QTestState *qts, const testdef_t *test, i=
nt fd)
 {
-    int i, nbr =3D 0, pos =3D 0, ccnt;
+    int nbr =3D 0, pos =3D 0, ccnt;
+    time_t now, start =3D time(NULL);
     char ch;
=20
-    /* Poll serial output... Wait at most 360 seconds */
-    for (i =3D 0; i < 36000; ++i) {
+    /* Poll serial output... */
+    while (1) {
         ccnt =3D 0;
         while (ccnt++ < 512 && (nbr =3D read(fd, &ch, 1)) =3D=3D 1) {
             if (ch =3D=3D test->expect[pos]) {
@@ -148,6 +149,15 @@ static bool check_guest_output(const testdef_t *test=
, int fd)
             }
         }
         g_assert(nbr >=3D 0);
+        /* Wait only if the child is still alive.  */
+        if (!qtest_probe_child(qts)) {
+            break;
+        }
+        /* Wait at most 360 seconds.  */
+        now =3D time(NULL);
+        if (now - start >=3D 360) {
+            break;
+        }
         g_usleep(10000);
     }
=20
@@ -199,7 +209,7 @@ static void test_machine(const void *data)
         unlink(codetmp);
     }
=20
-    if (!check_guest_output(test, ser_fd)) {
+    if (!check_guest_output(qts, test, ser_fd)) {
         g_error("Failed to find expected string. Please check '%s'",
                 serialtmp);
     }
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 43be078..1d75d3c 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -39,10 +39,11 @@ struct QTestState
 {
     int fd;
     int qmp_fd;
-    bool irq_level[MAX_IRQ];
-    GString *rx;
     pid_t qemu_pid;  /* our child QEMU process */
+    int wstatus;
     bool big_endian;
+    bool irq_level[MAX_IRQ];
+    GString *rx;
 };
=20
 static GHookList abrt_hooks;
@@ -96,36 +97,52 @@ static int socket_accept(int sock)
     return ret;
 }
=20
-static void kill_qemu(QTestState *s)
+bool qtest_probe_child(QTestState *s)
 {
-    if (s->qemu_pid !=3D -1) {
-        int wstatus =3D 0;
-        pid_t pid;
+    pid_t pid =3D s->qemu_pid;
=20
-        kill(s->qemu_pid, SIGTERM);
-        TFR(pid =3D waitpid(s->qemu_pid, &wstatus, 0));
+    if (pid !=3D -1) {
+        pid =3D waitpid(pid, &s->wstatus, WNOHANG);
+        if (pid =3D=3D 0) {
+            return true;
+        }
+        s->qemu_pid =3D -1;
+    }
+    return false;
+}
=20
+static void kill_qemu(QTestState *s)
+{
+    pid_t pid =3D s->qemu_pid;
+    int wstatus;
+
+    /* Skip wait if qtest_probe_child already reaped.  */
+    if (pid !=3D -1) {
+        kill(pid, SIGTERM);
+        TFR(pid =3D waitpid(s->qemu_pid, &s->wstatus, 0));
         assert(pid =3D=3D s->qemu_pid);
-        /*
-         * We expect qemu to exit with status 0; anything else is
-         * fishy and should be logged with as much detail as possible.
-         */
-        if (wstatus) {
-            if (WIFEXITED(wstatus)) {
-                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate Q=
EMU "
-                        "process but encountered exit status %d\n",
-                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
-            } else if (WIFSIGNALED(wstatus)) {
-                int sig =3D WTERMSIG(wstatus);
-                const char *signame =3D strsignal(sig) ?: "unknown ???";
-                const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped=
)" : "";
-
-                fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death =
"
-                        "from signal %d (%s)%s\n",
-                        __FILE__, __LINE__, sig, signame, dump);
-            }
-            abort();
+    }
+
+    /*
+     * We expect qemu to exit with status 0; anything else is
+     * fishy and should be logged with as much detail as possible.
+     */
+    wstatus =3D s->wstatus;
+    if (wstatus) {
+        if (WIFEXITED(wstatus)) {
+            fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU =
"
+                    "process but encountered exit status %d\n",
+                    __FILE__, __LINE__, WEXITSTATUS(wstatus));
+        } else if (WIFSIGNALED(wstatus)) {
+            int sig =3D WTERMSIG(wstatus);
+            const char *signame =3D strsignal(sig) ?: "unknown ???";
+            const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped)" :=
 "";
+
+            fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
+                    "from signal %d (%s)%s\n",
+                    __FILE__, __LINE__, sig, signame, dump);
         }
+        abort();
     }
 }
=20
@@ -228,6 +245,7 @@ QTestState *qtest_init_without_qmp_handshake(const ch=
ar *extra_args)
=20
     g_test_message("starting QEMU: %s", command);
=20
+    s->wstatus =3D 0;
     s->qemu_pid =3D fork();
     if (s->qemu_pid =3D=3D 0) {
         setenv("QEMU_AUDIO_DRV", "none", true);
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 96a6c01..9758c51 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -1011,4 +1011,12 @@ bool qmp_rsp_is_err(QDict *rsp);
  */
 void qmp_assert_error_class(QDict *rsp, const char *class);
=20
+/**
+ * qtest_probe_child:
+ * @s: QTestState instance to operate on.
+ *
+ * Returns: true if the child is still alive.
+ */
+bool qtest_probe_child(QTestState *s);
+
 #endif
--=20
1.8.3.1
