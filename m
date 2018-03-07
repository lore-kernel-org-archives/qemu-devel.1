Received: from eggs.gnu.org ([2001:4830:134:3::10]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etdQD-00052R-Km
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etdQC-0004a9-Pz
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:04:13 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Mar 2018 19:03:57 +0100
Message-Id: <20180307180358.30393-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] arm: fix load ELF error leak
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
QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64 tests/boot-serial=
-test

Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7ff8a9b0ca38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea3=
8)
    #1 0x7ff8a8ea7f75 in g_malloc0 ../glib/gmem.c:124
    #2 0x55fef3d99129 in error_setv /home/elmarco/src/qemu/util/error.c:5=
9
    #3 0x55fef3d99738 in error_setg_internal /home/elmarco/src/qemu/util/=
error.c:95
    #4 0x55fef323acb2 in load_elf_hdr /home/elmarco/src/qemu/hw/core/load=
er.c:393
    #5 0x55fef2d15776 in arm_load_elf /home/elmarco/src/qemu/hw/arm/boot.=
c:830
    #6 0x55fef2d16d39 in arm_load_kernel_notify /home/elmarco/src/qemu/hw=
/arm/boot.c:1022
    #7 0x55fef3dc634d in notifier_list_notify /home/elmarco/src/qemu/util=
/notify.c:40
    #8 0x55fef2fc3182 in qemu_run_machine_init_done_notifiers /home/elmar=
co/src/qemu/vl.c:2716
    #9 0x55fef2fcbbd1 in main /home/elmarco/src/qemu/vl.c:4679
    #10 0x7ff89dfed009 in __libc_start_main (/lib64/libc.so.6+0x21009)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 6d0c92ab88..784d301683 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -829,6 +829,7 @@ static uint64_t arm_load_elf(struct arm_boot_info *in=
fo, uint64_t *pentry,
=20
     load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, &err);
     if (err) {
+        error_free(err);
         return ret;
     }
=20
--=20
2.16.2.346.g9779355e34
