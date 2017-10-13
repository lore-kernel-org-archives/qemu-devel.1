Received: from eggs.gnu.org ([2001:4830:134:3::10]:54485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1e2sq9-0000LR-28
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 01:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1e2sq5-00033t-Ux
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 01:48:57 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:34688
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan@weilnetz.de>) id 1e2sq5-0002zC-L7
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 01:48:53 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Fri, 13 Oct 2017 07:48:42 +0200
Message-Id: <20171013054842.32120-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] oslib-posix: Fix compiler warning and some
 data types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>

gcc warning:

/qemu/util/oslib-posix.c:304:11: error:
 variable =E2=80=98addr=E2=80=99 might be clobbered by =E2=80=98longjmp=E2=
=80=99 or =E2=80=98vfork=E2=80=99
 [-Werror=3Dclobbered]

Fix also some related data types:

numpages, hpagesize are used as pointer offset.
Always use size_t for them and for the derived numpages_per_thread.

Avoid a type cast by declaring addr volatile.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

v2: Fix more data types (partially as discussed with Richard)

Please note that checkpatch.pl raises an error:

ERROR: Use of volatile is usually wrong: see Documentation/volatile-consi=
dered-harmful.txt

This error is wrong in the current context.
It also refers to a file which exists in the Linux sources
but not in the QEMU source.

Regards
Stefan

 util/oslib-posix.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 80086c549f..beef148c96 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -59,8 +59,8 @@
=20
 struct MemsetThread {
     char *addr;
-    uint64_t numpages;
-    uint64_t hpagesize;
+    size_t numpages;
+    size_t hpagesize;
     QemuThread pgthread;
     sigjmp_buf env;
 };
@@ -301,11 +301,7 @@ static void sigbus_handler(int signal)
 static void *do_touch_pages(void *arg)
 {
     MemsetThread *memset_args =3D (MemsetThread *)arg;
-    char *addr =3D memset_args->addr;
-    uint64_t numpages =3D memset_args->numpages;
-    uint64_t hpagesize =3D memset_args->hpagesize;
     sigset_t set, oldset;
-    int i =3D 0;
=20
     /* unblock SIGBUS */
     sigemptyset(&set);
@@ -315,6 +311,10 @@ static void *do_touch_pages(void *arg)
     if (sigsetjmp(memset_args->env, 1)) {
         memset_thread_failed =3D true;
     } else {
+        volatile char *addr =3D memset_args->addr;
+        size_t numpages =3D memset_args->numpages;
+        size_t hpagesize =3D memset_args->hpagesize;
+        size_t i;
         for (i =3D 0; i < numpages; i++) {
             /*
              * Read & write back the same value, so we don't
@@ -328,7 +328,7 @@ static void *do_touch_pages(void *arg)
              * don't need to write at all so we don't cause
              * wear on the storage backing the region...
              */
-            *(volatile char *)addr =3D *addr;
+            *addr =3D *addr;
             addr +=3D hpagesize;
         }
     }
@@ -351,7 +351,8 @@ static inline int get_memset_num_threads(int smp_cpus=
)
 static bool touch_all_pages(char *area, size_t hpagesize, size_t numpage=
s,
                             int smp_cpus)
 {
-    uint64_t numpages_per_thread, size_per_thread;
+    size_t numpages_per_thread;
+    size_t size_per_thread;
     char *addr =3D area;
     int i =3D 0;
=20
--=20
2.11.0
