Received: from eggs.gnu.org ([209.51.188.92]:34120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbkv-0006bZ-Rs
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMbku-000143-IQ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMbku-00012U-Bu
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:13:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id h4so8762063wre.7
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:13:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 May 2019 18:13:46 +0100
Message-Id: <20190503171347.13747-2-peter.maydell@linaro.org>
In-Reply-To: <20190503171347.13747-1-peter.maydell@linaro.org>
References: <20190503171347.13747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] hw/arm/boot: Avoid placing the initrd on
 top of the kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Mark Rutland <mark.rutland@arm.com>

We currently put the initrd at the smaller of:
 * 128MB into RAM
 * halfway into the RAM
(with the dtb following it).

However for large kernels this might mean that the kernel
overlaps the initrd. For some kinds of kernel (self-decompressing
32-bit kernels, and ELF images with a BSS section at the end)
we don't know the exact size, but even there we have a
minimum size. Put the initrd at least further into RAM than
that. For image formats that can give us an exact kernel size, this
will mean that we definitely avoid overlaying kernel and initrd.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index a830655e1af..7c978fedde4 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -998,20 +998,6 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     if (info->nb_cpus == 0)
         info->nb_cpus = 1;
 
-    /*
-     * We want to put the initrd far enough into RAM that when the
-     * kernel is uncompressed it will not clobber the initrd. However
-     * on boards without much RAM we must ensure that we still leave
-     * enough room for a decent sized initrd, and on boards with large
-     * amounts of RAM we must avoid the initrd being so far up in RAM
-     * that it is outside lowmem and inaccessible to the kernel.
-     * So for boards with less  than 256MB of RAM we put the initrd
-     * halfway into RAM, and for boards with 256MB of RAM or more we put
-     * the initrd at 128MB.
-     */
-    info->initrd_start = info->loader_start +
-        MIN(info->ram_size / 2, 128 * 1024 * 1024);
-
     /* Assume that raw images are linux kernels, and ELF images are not.  */
     kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
                                &elf_high_addr, elf_machine, as);
@@ -1056,6 +1042,26 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         exit(1);
     }
     info->entry = entry;
+
+    /*
+     * We want to put the initrd far enough into RAM that when the
+     * kernel is uncompressed it will not clobber the initrd. However
+     * on boards without much RAM we must ensure that we still leave
+     * enough room for a decent sized initrd, and on boards with large
+     * amounts of RAM we must avoid the initrd being so far up in RAM
+     * that it is outside lowmem and inaccessible to the kernel.
+     * So for boards with less  than 256MB of RAM we put the initrd
+     * halfway into RAM, and for boards with 256MB of RAM or more we put
+     * the initrd at 128MB.
+     * We also refuse to put the initrd somewhere that will definitely
+     * overlay the kernel we just loaded, though for kernel formats which
+     * don't tell us their exact size (eg self-decompressing 32-bit kernels)
+     * we might still make a bad choice here.
+     */
+    info->initrd_start = info->loader_start +
+        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
+    info->initrd_start = TARGET_PAGE_ALIGN(info->initrd_start);
+
     if (is_linux) {
         uint32_t fixupcontext[FIXUP_MAX];
 
-- 
2.20.1
