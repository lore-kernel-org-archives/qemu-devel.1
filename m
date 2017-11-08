Received: from eggs.gnu.org ([2001:4830:134:3::10]:35145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZNI-000188-7v
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZNG-0003r4-0s
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:12 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:56 -0800
Message-ID: <f71203227749e2afb8564b3388b2b34f6652b009.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 42/45] util: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_re=
port("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

The error in aio_poll() was removed manually.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>
Cc: qemu-block@nongnu.org
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
V4:
 - Remove the error in aio_poll()

 util/aio-posix.c             | 1 +
 util/coroutine-sigaltstack.c | 2 +-
 util/error.c                 | 4 ++--
 util/main-loop.c             | 2 +-
 util/mmap-alloc.c            | 3 ++-
 util/module.c                | 6 +++---
 util/osdep.c                 | 4 ++--
 util/oslib-posix.c           | 3 ++-
 util/oslib-win32.c           | 3 ++-
 util/qemu-coroutine.c        | 5 +++--
 util/qemu-progress.c         | 3 ++-
 util/qemu-thread-posix.c     | 5 +++--
 util/qemu-thread-win32.c     | 5 +++--
 util/qemu-timer-common.c     | 3 ++-
 util/qht.c                   | 2 +-
 15 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 1427f49b4a..8eeba93da6 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -15,6 +15,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/error-report.h"
 #include "block/block.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.c
index f6fc49a0e5..96a01c2c88 100644
--- a/util/coroutine-sigaltstack.c
+++ b/util/coroutine-sigaltstack.c
@@ -80,7 +80,7 @@ static void __attribute__((constructor)) coroutine_init(v=
oid)
=20
     ret =3D pthread_key_create(&thread_state_key, qemu_coroutine_thread_cl=
eanup);
     if (ret !=3D 0) {
-        fprintf(stderr, "unable to create leader key: %s\n", strerror(errn=
o));
+        error_report("unable to create leader key: %s", strerror(errno));
         abort();
     }
 }
diff --git a/util/error.c b/util/error.c
index 3efdd69162..f524e138ec 100644
--- a/util/error.c
+++ b/util/error.c
@@ -32,8 +32,8 @@ Error *error_fatal;
 static void error_handle_fatal(Error **errp, Error *err)
 {
     if (errp =3D=3D &error_abort) {
-        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
-                err->func, err->src, err->line);
+        error_report("Unexpected error in %s() at %s:%d:",
+                     err->func, err->src, err->line);
         error_report_err(err);
         abort();
     }
diff --git a/util/main-loop.c b/util/main-loop.c
index 7558eb5f53..d8369716b2 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -95,7 +95,7 @@ static int qemu_signal_init(void)
     sigdelset(&set, SIG_IPI);
     sigfd =3D qemu_signalfd(&set);
     if (sigfd =3D=3D -1) {
-        fprintf(stderr, "failed to create signalfd\n");
+        error_report("failed to create signalfd");
         return -errno;
     }
=20
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 3ec029a9ea..11887aac69 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -11,6 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/host-utils.h"
=20
@@ -51,7 +52,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     } while (ret !=3D 0 && errno =3D=3D EINTR);
=20
     if (ret !=3D 0) {
-        fprintf(stderr, "Couldn't statfs() memory path: %s\n",
+        error_report("Couldn't statfs() memory path: %s",
                 strerror(errno));
         exit(1);
     }
diff --git a/util/module.c b/util/module.c
index c90973721f..1153e3ebb0 100644
--- a/util/module.c
+++ b/util/module.c
@@ -124,13 +124,13 @@ static int module_load_file(const char *fname)
=20
     g_module =3D g_module_open(fname, G_MODULE_BIND_LAZY | G_MODULE_BIND_L=
OCAL);
     if (!g_module) {
-        fprintf(stderr, "Failed to open module: %s\n",
+        error_report("Failed to open module: %s",
                 g_module_error());
         ret =3D -EINVAL;
         goto out;
     }
     if (!g_module_symbol(g_module, DSO_STAMP_FUN_STR, (gpointer *)&sym)) {
-        fprintf(stderr, "Failed to initialize module: %s\n",
+        error_report("Failed to initialize module: %s",
                 fname);
         /* Print some info if this is a QEMU module (but from different bu=
ild),
          * this will make debugging user problems easier. */
@@ -169,7 +169,7 @@ void module_load_one(const char *prefix, const char *li=
b_name)
     static GHashTable *loaded_modules;
=20
     if (!g_module_supported()) {
-        fprintf(stderr, "Module is not supported by system.\n");
+        error_report("Module is not supported by system.");
         return;
     }
=20
diff --git a/util/osdep.c b/util/osdep.c
index 1231f9f876..ec0ec7ed2c 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -466,7 +466,7 @@ void fips_set_state(bool requested)
 #endif /* __linux__ */
=20
 #ifdef _FIPS_DEBUG
-    fprintf(stderr, "FIPS mode %s (requested %s)\n",
+    error_report("FIPS mode %s (requested %s)",
 	    (fips_enabled ? "enabled" : "disabled"),
 	    (requested ? "enabled" : "disabled"));
 #endif
@@ -493,7 +493,7 @@ int socket_init(void)
     ret =3D WSAStartup(MAKEWORD(2, 2), &Data);
     if (ret !=3D 0) {
         err =3D WSAGetLastError();
-        fprintf(stderr, "WSAStartup: %d\n", err);
+        error_report("WSAStartup: %d", err);
         return -1;
     }
     atexit(socket_cleanup);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 77369c92ce..e34ebf094f 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -34,6 +34,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include <libgen.h>
 #include <sys/signal.h>
@@ -91,7 +92,7 @@ int qemu_daemon(int nochdir, int noclose)
 void *qemu_oom_check(void *ptr)
 {
     if (ptr =3D=3D NULL) {
-        fprintf(stderr, "Failed to allocate memory: %s\n", strerror(errno)=
);
+        error_report("Failed to allocate memory: %s", strerror(errno));
         abort();
     }
     return ptr;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 69a6286d50..2197a6a4fc 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -30,6 +30,7 @@
  * see the license comment there.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include <windows.h>
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
@@ -44,7 +45,7 @@
 void *qemu_oom_check(void *ptr)
 {
     if (ptr =3D=3D NULL) {
-        fprintf(stderr, "Failed to allocate memory: %lu\n", GetLastError()=
);
+        error_report("Failed to allocate memory: %lu", GetLastError());
         abort();
     }
     return ptr;
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d6095c1d5a..1f7cce6706 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -13,6 +13,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "trace.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
@@ -110,7 +111,7 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutin=
e *co)
     trace_qemu_aio_coroutine_enter(ctx, self, co, co->entry_arg);
=20
     if (co->caller) {
-        fprintf(stderr, "Co-routine re-entered recursively\n");
+        error_report("Co-routine re-entered recursively");
         abort();
     }
=20
@@ -164,7 +165,7 @@ void coroutine_fn qemu_coroutine_yield(void)
     trace_qemu_coroutine_yield(self, to);
=20
     if (!to) {
-        fprintf(stderr, "Co-routine is yielding to no one\n");
+        error_report("Co-routine is yielding to no one");
         abort();
     }
=20
diff --git a/util/qemu-progress.c b/util/qemu-progress.c
index 3c2223c1a2..84598f0fbb 100644
--- a/util/qemu-progress.c
+++ b/util/qemu-progress.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
=20
 struct progress_state {
@@ -68,7 +69,7 @@ static void sigusr_print(int signal)
 static void progress_dummy_print(void)
 {
     if (print_pending) {
-        fprintf(stderr, "    (%3.2f/100%%)\n", state.current);
+        error_report("    (%3.2f/100%%)", state.current);
         print_pending =3D 0;
     }
 }
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 7306475899..1207ef71d6 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -11,6 +11,7 @@
  *
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
@@ -25,14 +26,14 @@ void qemu_thread_naming(bool enable)
 #ifndef CONFIG_THREAD_SETNAME_BYTHREAD
     /* This is a debugging option, not fatal */
     if (enable) {
-        fprintf(stderr, "qemu: thread naming not supported on this host\n"=
);
+        error_report("thread naming not supported on this host");
     }
 #endif
 }
=20
 static void error_exit(int err, const char *msg)
 {
-    fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
+    error_report("%s: %s", msg, strerror(err));
     abort();
 }
=20
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 94f3491a87..02b94e22da 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -16,6 +16,7 @@
 #endif
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
@@ -29,7 +30,7 @@ void qemu_thread_naming(bool enable)
     /* But note we don't actually name them on Windows yet */
     name_threads =3D enable;
=20
-    fprintf(stderr, "qemu: thread naming not supported on this host\n");
+    error_report("thread naming not supported on this host");
 }
=20
 static void error_exit(int err, const char *msg)
@@ -38,7 +39,7 @@ static void error_exit(int err, const char *msg)
=20
     FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUF=
FER,
                   NULL, err, 0, (LPTSTR)&pstr, 2, NULL);
-    fprintf(stderr, "qemu: %s: %s\n", msg, pstr);
+    error_report("%s: %s", msg, pstr);
     LocalFree(pstr);
     abort();
 }
diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
index 06d084d364..ab7b702c4f 100644
--- a/util/qemu-timer-common.c
+++ b/util/qemu-timer-common.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/timer.h"
=20
 /***********************************************************/
@@ -37,7 +38,7 @@ static void __attribute__((constructor)) init_get_clock(v=
oid)
     int ret;
     ret =3D QueryPerformanceFrequency(&freq);
     if (ret =3D=3D 0) {
-        fprintf(stderr, "Could not calibrate ticks\n");
+        error_report("Could not calibrate ticks");
         exit(1);
     }
     clock_freq =3D freq.QuadPart;
diff --git a/util/qht.c b/util/qht.c
index ff4d2e6974..bfab5c7e5e 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -154,7 +154,7 @@ static void qht_bucket_debug__locked(struct qht_bucket =
*b)
                 continue;
             }
             if (seen_empty) {
-                fprintf(stderr, "%s: b: %p, pos: %i, hash: 0x%x, p: %p\n",
+                error_report("%s: b: %p, pos: %i, hash: 0x%x, p: %p",
                         __func__, b, i, b->hashes[i], b->pointers[i]);
                 corrupt =3D true;
             }
--=20
2.14.1
