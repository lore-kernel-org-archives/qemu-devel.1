Received: from eggs.gnu.org ([2001:4830:134:3::10]:59951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1e0rRp-0003mG-TP
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 11:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1e0rRn-0001eH-9s
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 11:55:29 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:58550
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan@weilnetz.de>) id 1e0rRm-0001dS-MQ
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 11:55:26 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Sat,  7 Oct 2017 17:55:22 +0200
Message-Id: <20171007155522.25436-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] oslib-posix: Fix compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>

gcc warning:

/qemu/util/oslib-posix.c:304:11: error:
 variable =E2=80=98addr=E2=80=99 might be clobbered by =E2=80=98longjmp=E2=
=80=99 or =E2=80=98vfork=E2=80=99
 [-Werror=3Dclobbered]

Use also an unsigned loop variable which better matches numpages.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

Please cc qemu-trivial if you think this is trivial enough.

Thanks,
Stefan

index 80086c549f..eb66a6f63c 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
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
+        uint64_t numpages =3D memset_args->numpages;
+        uint64_t hpagesize =3D memset_args->hpagesize;
+        unsigned i;
         for (i =3D 0; i < numpages; i++) {
             /*
              * Read & write back the same value, so we don't
--=20
2.11.0
