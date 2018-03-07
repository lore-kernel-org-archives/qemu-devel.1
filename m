Received: from eggs.gnu.org ([2001:4830:134:3::10]:42492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etdQG-00054Z-NP
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etdQF-0004bP-QH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:04:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Mar 2018 19:03:58 +0100
Message-Id: <20180307180358.30393-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180307180358.30393-1-marcandre.lureau@redhat.com>
References: <20180307180358.30393-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] arm: avoid heap-buffer-overflow in
 load_aarch64_image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Spotted by ASAN:

elmarco@boraha:~/src/qemu/build (master *%)$ QTEST_QEMU_BINARY=3Daarch64-=
softmmu/qemu-system-aarch64 tests/boot-serial-test
/aarch64/boot-serial/virt: ** (process:19740): DEBUG: 18:39:30.275: foo /=
tmp/qtest-boot-serial-cXaS94D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D19740=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x603000069648 at pc 0x7f1d2201cc54 bp 0x7fff331f6a40 sp 0x7fff331f61e8
READ of size 4 at 0x603000069648 thread T0
    #0 0x7f1d2201cc53  (/lib64/libasan.so.4+0xafc53)
    #1 0x55bc86685ee3 in load_aarch64_image /home/elmarco/src/qemu/hw/arm=
/boot.c:894
    #2 0x55bc86687217 in arm_load_kernel_notify /home/elmarco/src/qemu/hw=
/arm/boot.c:1047
    #3 0x55bc877363b5 in notifier_list_notify /home/elmarco/src/qemu/util=
/notify.c:40
    #4 0x55bc869331ea in qemu_run_machine_init_done_notifiers /home/elmar=
co/src/qemu/vl.c:2716
    #5 0x55bc8693bc39 in main /home/elmarco/src/qemu/vl.c:4679
    #6 0x7f1d1652c009 in __libc_start_main (/lib64/libc.so.6+0x21009)
    #7 0x55bc86255cc9 in _start (/home/elmarco/src/qemu/build/aarch64-sof=
tmmu/qemu-system-aarch64+0x1ae5cc9)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/boot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 784d301683..196c7fb242 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -891,7 +891,8 @@ static uint64_t load_aarch64_image(const char *filena=
me, hwaddr mem_base,
     }
=20
     /* check the arm64 magic header value -- very old kernels may not ha=
ve it */
-    if (memcmp(buffer + ARM64_MAGIC_OFFSET, "ARM\x64", 4) =3D=3D 0) {
+    if (size > ARM64_MAGIC_OFFSET + 4 &&
+        memcmp(buffer + ARM64_MAGIC_OFFSET, "ARM\x64", 4) =3D=3D 0) {
         uint64_t hdrvals[2];
=20
         /* The arm64 Image header has text_offset and image_size fields =
at 8 and
--=20
2.16.2.346.g9779355e34
