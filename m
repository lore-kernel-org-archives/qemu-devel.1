Received: from eggs.gnu.org ([209.51.188.92]:35364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hL6dc-0002he-K2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hL6db-0005ia-MU
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hL6db-0005fR-HC
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:48:07 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Apr 2019 15:47:57 +0200
Message-Id: <20190429134757.13570-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vl: fix -sandbox parsing crash when seccomp
 support is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, david@gibson.dropbear.id.au, otubo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

$ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
Segmentation fault

Commit 5780760f5e ("seccomp: check TSYNC host capability") wrapped one
use of the sandbox option group to produce a sensible error, it didn't
do the same for another call to qemu_opts_parse_noisily():

(gdb) bt
    at util/qemu-option.c:829
 #0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffffab=
5 "off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
     at util/qemu-option.c:829
 #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized out=
>, params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/qem=
u-option.c:890
 #2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimize=
d out>, envp=3D<optimized out>) at vl.c:3589

Fixes: 5780760f5ea6163939a5dabe7427318b4f07d1a2
Cc: david@gibson.dropbear.id.au
Cc: otubo@redhat.com
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index 4019a4387d..5fc4994d3c 100644
--- a/vl.c
+++ b/vl.c
@@ -3866,17 +3866,19 @@ int main(int argc, char **argv, char **envp)
                 qtest_log =3D optarg;
                 break;
             case QEMU_OPTION_sandbox:
-#ifdef CONFIG_SECCOMP
-                opts =3D qemu_opts_parse_noisily(qemu_find_opts("sandbox=
"),
-                                               optarg, true);
+                olist =3D qemu_find_opts("sandbox");
+                if (!olist) {
+#ifndef CONFIG_SECCOMP
+                    error_report("-sandbox support is not enabled "
+                                 "in this QEMU binary");
+#endif
+                    exit(1);
+                }
+
+                opts =3D qemu_opts_parse_noisily(olist, optarg, true);
                 if (!opts) {
                     exit(1);
                 }
-#else
-                error_report("-sandbox support is not enabled "
-                             "in this QEMU binary");
-                exit(1);
-#endif
                 break;
             case QEMU_OPTION_add_fd:
 #ifndef _WIN32
--=20
2.21.0.777.g83232e3864
