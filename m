Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC211C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E642168B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="kYje9DwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E642168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlJ3-00066g-TT
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:26:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39718)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
	id 1hRlHX-00055R-NA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
	id 1hRlHW-0005MA-Ev
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:24:51 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:59402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
	id 1hRlHW-000583-9W
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:24:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
	s=pic; 
	t=1558131890; h=Content-Transfer-Encoding: MIME-Version: References:
	In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
	bh=VH93TOUnG/HUHSJvTDoKgECjsrun7twRUpDzD4oM7xA=;
	b=kYje9DwVbzythP86OkEMCGU402zikqf7QFpZQE0qdD8K6/ViqGng0fj/Jg3050NW0OWnd1Co
	JNd3uwGpk/jzV2dDUry89p43u25zWS3aq81XZxp3bQARobF1pTwGDd8dcWJt0LeZRkHUcbFg
	quxZgH5WsZrVjuf0cdp8c7+GRqBKRHgfrTx/kJY/gvA48O8aH/OlNfMS8bb+Vw46VTjHY1Em
	Ph7t/xWEBMtPUE8ylxUHL/i9RlNF2n6dPh/dpTIFAHiQO16uhjPo9TEaaRP8KSxCbinNXF1h
	38DQsuUSBUH7tsFN7bkmXPjQNEVSk8Cn1VtnDfCiy7rHHRUKiVittw==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from jonathan-ThinkPad-X1-Carbon.csail.mit.edu
	(30-9-187.wireless.csail.mit.edu [128.30.9.187])
	by mxa.mailgun.org with ESMTP id 5cdf34b0.7ff77a124cb0-smtp-out-n01;
	Fri, 17 May 2019 22:24:48 -0000 (UTC)
From: Jonathan Behrens <jonathan@fintelia.io>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 17 May 2019 18:23:42 -0400
Message-Id: <20190517222342.26394-3-jonathan@fintelia.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517222342.26394-1-jonathan@fintelia.io>
References: <20190517222342.26394-1-jonathan@fintelia.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
Subject: [Qemu-devel] [PATCH for-4.1 2/2] target/riscv: Add support for
 -bios "firmware_filename" flag
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>, Jonathan Behrens <fintelia@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Jonathan Behrens <jonathan@fintelia.io>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not have any default firmware for RISC-V. However, it isn't possible
to run a normal kernel binary without firmware. Thus it has previously been
necessary to compile the two together into a single binary to pass with the
-kernel flag. This patch allows passing separate firmware and kernel binaries by
passing both the -bios and -kernel flags.

This is based on a previously proposed patch by Michael Clark:
https://patchwork.kernel.org/patch/10419975/

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
---
 hw/riscv/virt.c | 66 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 87cc08016b..d7b1792b58 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -62,6 +62,40 @@ static const struct MemmapEntry {
     [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
 };
 
+
+static target_ulong load_firmware_and_kernel(const char *firmware_filename,
+                                             const char *kernel_filename,
+                                             uint64_t mem_size,
+                                             uint64_t* kernel_start,
+                                             uint64_t* kernel_end)
+{
+    uint64_t firmware_entry, firmware_end;
+    int size;
+
+    if (load_elf(firmware_filename, NULL, NULL, NULL,
+                 &firmware_entry, NULL, &firmware_end,
+                 0, EM_RISCV, 1, 0) < 0) {
+        error_report("could not load firmware '%s'", firmware_filename);
+        exit(1);
+    }
+
+    /* align kernel load address to the megapage after the firmware */
+#if defined(TARGET_RISCV32)
+    *kernel_start = (firmware_end + 0x3fffff) & ~0x3fffff;
+#else
+    *kernel_start = (firmware_end + 0x1fffff) & ~0x1fffff;
+#endif
+
+    size = load_image_targphys(kernel_filename, *kernel_start,
+                               mem_size - *kernel_start);
+    if (size == -1) {
+        error_report("could not load kernel '%s'", kernel_filename);
+        exit(1);
+    }
+    *kernel_end = *kernel_start + size;
+    return firmware_entry;
+}
+
 static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry;
@@ -423,19 +457,29 @@ static void riscv_virt_board_init(MachineState *machine)
                                 mask_rom);
 
     uint64_t entry = memmap[VIRT_DRAM].base;
-    if (machine->kernel_filename) {
+    if (machine->firmware && machine->kernel_filename) {
+        uint64_t kernel_start, kernel_end;
+        entry = load_firmware_and_kernel(machine->firmware,
+                                         machine->kernel_filename,
+                                         machine->ram_size, &kernel_start,
+                                         &kernel_end);
+
+        qemu_fdt_setprop_cells(fdt, "/chosen", "riscv,kernel-end",
+                               kernel_end >> 32, kernel_end);
+        qemu_fdt_setprop_cells(fdt, "/chosen", "riscv,kernel-start",
+                               kernel_start >> 32, kernel_start);
+    } else if (machine->kernel_filename) {
         entry = load_kernel(machine->kernel_filename);
+    }
 
-        if (machine->initrd_filename) {
-            uint64_t start;
-            uint64_t end = load_initrd(machine->initrd_filename,
-                                       memmap[VIRT_DRAM].base, machine->ram_size,
-                                       &start);
-            qemu_fdt_setprop_cell(fdt, "/chosen",
-                                  "linux,initrd-start", start);
-            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
-                                  end);
-        }
+    if (machine->kernel_filename && machine->initrd_filename) {
+        uint64_t start;
+        uint64_t end = load_initrd(machine->initrd_filename,
+                                   memmap[VIRT_DRAM].base, machine->ram_size,
+                                   &start);
+
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start", start);
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end", end);
     }
 
     /* reset vector */
-- 
2.20.1

