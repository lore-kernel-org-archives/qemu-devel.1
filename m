Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14CDC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB9121655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RDW6g+3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB9121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imxrB-0003rM-Nz
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 05:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jason@zx2c4.com>) id 1imxqZ-0003Qp-7M
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jason@zx2c4.com>) id 1imxqY-0007pU-20
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:36:55 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:56857)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Jason@zx2c4.com>) id 1imxqX-0007nO-R0
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:36:54 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a438101f;
 Thu, 2 Jan 2020 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
 :subject:date:message-id:mime-version:content-transfer-encoding;
 s=mail; bh=iJFCMwYx1+oOy184iBhg9viKFeM=; b=RDW6g+3/lxx5bqaHZ+Ds
 RJ4UWKN/Z7wHcBUvdLP59lSb8r+MhI2UK5k/hfGkht5LqF3tzxzyHpisEYDLJEit
 smpAxWjJRcmLpwYWDpIXAQzbRvuy3m6u4qh/Oyw3/3YcI1gK3P9BdHU5+yCcpEq3
 u5NAUFJwv79pozUJNRSR9Kb5LZorNtshplnrOp9gsQbwkHq3s4EQxDd7e2ocexlK
 4TPVdFzmXl/VO8/4aWWxl/q4SHESCYG9lrnwF6ijQKQEUQZd+7PpDu90RxoSvrCF
 0xtPJ5I0g/GnN5xkm61ql9hmXl46x68PgTvSEbyYRmr9dXoYe8DBzmvJ8NCyVvOp
 6w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e683f42
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO); 
 Thu, 2 Jan 2020 09:38:23 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Subject: [PATCH] q800: implement mac rom reset function for BIOS-less mode
Date: Thu,  2 Jan 2020 11:36:44 +0100
Message-Id: <20200102103644.233370-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.95.5.64
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Linux, calling `reboot(RB_AUTOBOOT);` will result in
arch/m68k/mac/misc.c's mac_reset function being called. That in turn
looks at the rombase (or uses 0x40800000 is there's no rombase), adds
0xa, and jumps to that address. At the moment, there's nothing there, so
the kernel just crashes when trying to reboot. So, this commit adds a
very simple implementation at that location, which just writes to via2
to power down.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 hw/m68k/q800.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 4ca8678007..491ba11200 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -128,6 +128,20 @@ static void main_cpu_reset(void *opaque)
     cpu->env.pc = ldl_phys(cs->as, 4);
 }
 
+static uint8_t fake_mac_rom[] = {
+    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+    /* offset: 0xa - mac_reset */
+    0x20, 0x7C, 0x50, 0xF0, 0x24, 0x00,	/* moveal #1357915136,%a0 */
+    0x10, 0x10,				/* moveb %a0@,%d0 */
+    0x00, 0x00, 0x00, 0x04,		/* orib #4,%d0 */
+    0x10, 0x80,				/* moveb %d0,%a0@ */
+    0x20, 0x7C, 0x50, 0xF0, 0x20, 0x00,	/* moveal #1357914112,%a0 */
+    0x10, 0x10,				/* moveb %a0@,%d0 */
+    0x02, 0x00, 0xFF, 0xFB,		/* andib #-5,%d0 */
+    0x10, 0x80,				/* moveb %d0,%a0@ */
+    0x60, 0xFE				/* bras [self] */
+};
+
 static void q800_init(MachineState *machine)
 {
     M68kCPU *cpu = NULL;
@@ -339,6 +353,13 @@ static void q800_init(MachineState *machine)
         BOOTINFO1(cs->as, parameters_base, BI_MAC_VROW,
                   (graphic_width * graphic_depth + 7) / 8);
         BOOTINFO1(cs->as, parameters_base, BI_MAC_SCCBASE, SCC_BASE);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_ROMBASE, MACROM_ADDR);
+
+        rom = g_malloc(sizeof(*rom));
+        memory_region_init_ram_ptr(rom, NULL, "m68k_fake_mac.rom",
+                                   sizeof(fake_mac_rom), fake_mac_rom);
+        memory_region_set_readonly(rom, true);
+        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
 
         if (kernel_cmdline) {
             BOOTINFOSTR(cs->as, parameters_base, BI_COMMAND_LINE,
-- 
2.24.1


