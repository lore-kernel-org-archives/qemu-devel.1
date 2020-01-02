Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4EBC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 12:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3781C20863
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 12:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cqWU1Cee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3781C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imzBm-0001uQ-9S
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 07:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jason@zx2c4.com>) id 1imzAx-0001AQ-4i
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 07:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jason@zx2c4.com>) id 1imzAv-000310-VK
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 07:02:03 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:36245)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Jason@zx2c4.com>) id 1imzAv-00030i-OH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 07:02:01 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id cc148834;
 Thu, 2 Jan 2020 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; s=mail; bh=++GFLu2bysJEhyp/HhL2numvU
 Ug=; b=cqWU1CeenCcUIp61D9UHPZXI68X5j+f4aLXOPdcEl/ss30VPS8EGppa54
 OPRYJtu7DMOWA4P/YPG9d/xJIOgT+iqOeBggLjGVvDpi5hrBS7Z7Hj/h1cfQ8Sju
 D6IvdraFrKOb/k8Xa0blX4bDZGFAbphmFAWgnKx2cdv5EaI/6/Hkp+fWjNeC7z8Q
 igwU2xb7clLmsRpvlXk8YvUxg3DQJFg8xT5zjh00jZtFR+zPW8jfEh5UrdNG4V8M
 5v1tV/VHOJz4qtznlo8CIgiDdoTvOd5VLWUYzbX0tkgaAY+pryu0NKKgmwIKNVTw
 fAlyd6ObdvvXyR7TYPDHzCr9JEeNg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5192d7a9
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO); 
 Thu, 2 Jan 2020 11:03:30 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Subject: [PATCH v2] q800: implement mac rom reset function for BIOS-less mode
Date: Thu,  2 Jan 2020 13:01:50 +0100
Message-Id: <20200102120150.281082-1-Jason@zx2c4.com>
In-Reply-To: <d3eb847b-a6b9-4ac7-3c06-576686cca608@vivier.eu>
References: <d3eb847b-a6b9-4ac7-3c06-576686cca608@vivier.eu>
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
to power down. We also correct the value of ROMBASE while we're at it.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 hw/m68k/q800.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 4ca8678007..f03679e24c 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -47,7 +47,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/reset.h"
 
-#define MACROM_ADDR     0x40000000
+#define MACROM_ADDR     0x40800000
 #define MACROM_SIZE     0x00100000
 
 #define MACROM_FILENAME "MacROM.bin"
@@ -128,6 +128,27 @@ static void main_cpu_reset(void *opaque)
     cpu->env.pc = ldl_phys(cs->as, 4);
 }
 
+static uint8_t fake_mac_rom[] = {
+    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+
+    /* offset: 0xa - mac_reset */
+
+    /* via2[vDirB] |= VIA2B_vPower */
+    0x20, 0x7C, 0x50, 0xF0, 0x24, 0x00, /* moveal VIA2_BASE+vDirB,%a0 */
+    0x10, 0x10,                         /* moveb %a0@,%d0 */
+    0x00, 0x00, 0x00, 0x04,             /* orib #4,%d0 */
+    0x10, 0x80,                         /* moveb %d0,%a0@ */
+
+    /* via2[vBufB] &= ~VIA2B_vPower */
+    0x20, 0x7C, 0x50, 0xF0, 0x20, 0x00, /* moveal VIA2_BASE+vBufB,%a0 */
+    0x10, 0x10,                         /* moveb %a0@,%d0 */
+    0x02, 0x00, 0xFF, 0xFB,             /* andib #-5,%d0 */
+    0x10, 0x80,                         /* moveb %d0,%a0@ */
+
+    /* while (true) ; */
+    0x60, 0xFE                          /* bras [self] */
+};
+
 static void q800_init(MachineState *machine)
 {
     M68kCPU *cpu = NULL;
@@ -340,6 +361,12 @@ static void q800_init(MachineState *machine)
                   (graphic_width * graphic_depth + 7) / 8);
         BOOTINFO1(cs->as, parameters_base, BI_MAC_SCCBASE, SCC_BASE);
 
+        rom = g_malloc(sizeof(*rom));
+        memory_region_init_ram_ptr(rom, NULL, "m68k_fake_mac.rom",
+                                   sizeof(fake_mac_rom), fake_mac_rom);
+        memory_region_set_readonly(rom, true);
+        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
+
         if (kernel_cmdline) {
             BOOTINFOSTR(cs->as, parameters_base, BI_COMMAND_LINE,
                         kernel_cmdline);
-- 
2.24.1


