Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5W1K-0001xF-7C
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e5W1G-0007xm-9p
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:03:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e5W1G-0007w6-3Q
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:03:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 20 Oct 2017 14:02:35 +0200
Message-Id: <20171020120235.29142-2-stefanha@redhat.com>
In-Reply-To: <20171020120235.29142-1-stefanha@redhat.com>
References: <20171020120235.29142-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] oslib-posix: Fix compiler warning and some
 data types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Weil <sw@weilnetz.de>

gcc warning:

/qemu/util/oslib-posix.c:304:11: error:
 variable =E2=80=98addr=E2=80=99 might be clobbered by =E2=80=98longjmp=E2=
=80=99 or =E2=80=98vfork=E2=80=99
 [-Werror=3Dclobbered]

Fix also some related data types:

numpages, hpagesize are used as pointer offset.
Always use size_t for them and also for the derived
numpages_per_thread and size_per_thread.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Stefan Weil <sw@weilnetz.de>
Message-id: 20171016202912.1117-1-sw@weilnetz.de
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/oslib-posix.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 80086c549f..382bd4a231 100644
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
+        char *addr =3D memset_args->addr;
+        size_t numpages =3D memset_args->numpages;
+        size_t hpagesize =3D memset_args->hpagesize;
+        size_t i;
         for (i =3D 0; i < numpages; i++) {
             /*
              * Read & write back the same value, so we don't
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
2.13.6
