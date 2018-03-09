Received: from eggs.gnu.org ([2001:4830:134:3::10]:59529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmr-0008NL-4m
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmq-00063z-6j
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmq-00063U-0G
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:32 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmp-00076A-2c
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:09 +0000
Message-Id: <20180309172622.4277-13-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/25] arm: fix load ELF error leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Spotted by ASAN:
QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64 tests/boot-serial-test

Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7ff8a9b0ca38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea38)
    #1 0x7ff8a8ea7f75 in g_malloc0 ../glib/gmem.c:124
    #2 0x55fef3d99129 in error_setv /home/elmarco/src/qemu/util/error.c:59
    #3 0x55fef3d99738 in error_setg_internal /home/elmarco/src/qemu/util/error.c:95
    #4 0x55fef323acb2 in load_elf_hdr /home/elmarco/src/qemu/hw/core/loader.c:393
    #5 0x55fef2d15776 in arm_load_elf /home/elmarco/src/qemu/hw/arm/boot.c:830
    #6 0x55fef2d16d39 in arm_load_kernel_notify /home/elmarco/src/qemu/hw/arm/boot.c:1022
    #7 0x55fef3dc634d in notifier_list_notify /home/elmarco/src/qemu/util/notify.c:40
    #8 0x55fef2fc3182 in qemu_run_machine_init_done_notifiers /home/elmarco/src/qemu/vl.c:2716
    #9 0x55fef2fcbbd1 in main /home/elmarco/src/qemu/vl.c:4679
    #10 0x7ff89dfed009 in __libc_start_main (/lib64/libc.so.6+0x21009)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 6d0c92ab88..784d301683 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -829,6 +829,7 @@ static uint64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
 
     load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, &err);
     if (err) {
+        error_free(err);
         return ret;
     }
 
-- 
2.16.2
