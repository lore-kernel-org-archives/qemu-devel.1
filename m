Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD26C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8C3206D6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7oe0196"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8C3206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j330G-0002HT-ET
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v7-0000E3-GW
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v6-0004Mv-6M
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:16:05 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:40702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v6-0004MC-05; Sat, 15 Feb 2020 14:16:04 -0500
Received: by mail-wr1-x434.google.com with SMTP id t3so14908809wru.7;
 Sat, 15 Feb 2020 11:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0PgaPd6utuLueTNrrtDgS+Bw/skHy3ghAte6j3Falcw=;
 b=n7oe0196VwDjaPNyM/0mwYPb5G12Cio580iDFc5tbSscMPDNRndra9JkEem50D/ebY
 JVbGXXs7MRvQS5Ow2L4btJS6auuy4mCrYIeJeh1zc1fnhDrchvyT9kkQ6p4+d1pRlOr/
 HQYmbES0rZVAyskKsMxeewa5qwyr3XauCLH+Xc1l9jp6/GKZ6rb6QF/WtBDuh9NUD9ON
 4KaRta+xKAnqo/rz2VGu1MaOnzsW4NIoA6FmOvkl0sieagC0ua1YzB1LwCchGaXVVZM2
 JLu7uwi9bdLyTlShFmH4d0jznEMep6CMZrhw6j3JKrwLE6akzC9QKKxAaGuINFHS5JAg
 Aw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0PgaPd6utuLueTNrrtDgS+Bw/skHy3ghAte6j3Falcw=;
 b=IT/1HmwGaJJqsa3bPX2OkhF0mnnaNbmMfl/FGadvH84G57veqZ34QIViwX+nQYFSFF
 nAFxoxdYHTVNStVKJUK5Y4v+a1BkeL4vdFVaQoCX7rVEJ6mYlfsFIyD+F63CWn/5U8KR
 t1Eq4YhkR72HrXIQaEarGC2Qz2IKJB5ole2wA/bSStckNeTvn+ODnsb9NcCCxuiQcr9d
 HGLRQwJVnVourTJZSJ6hRmjNve5mZ/WWI4All+kxlq3KQuiWTT1wzwIub2esZbCDZWKH
 YeBmvMYycNQWWoIFkLeNGlOv6hU87RQWXzFOP3GMZ4ckdLCf9ToBuLFiw/Nh9Wzx6S/m
 8+7Q==
X-Gm-Message-State: APjAAAWMOSFwkyFFsvzpR5FWZq40hvRY8QJ2qIJLVgMbfB8/fKcU5L7u
 6T1R48Lnp3JkTBiiRmiPhoRilZfpbpg=
X-Google-Smtp-Source: APXvYqw28eCXMVK9HBFxyQxR/Qz+0VfgY4gK4amZVt6QchtM0LH7aST31kXEJ2mkG9x3EFoLkSoqaA==
X-Received: by 2002:adf:aadb:: with SMTP id i27mr11888691wrc.105.1581794162724; 
 Sat, 15 Feb 2020 11:16:02 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm9678605wrw.20.2020.02.15.11.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:16:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/12] hw/arm/raspi: Add the Raspberry Pi Zero machine
Date: Sat, 15 Feb 2020 20:15:43 +0100
Message-Id: <20200215191543.3235-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215191543.3235-1-f4bug@amsat.org>
References: <20200215191543.3235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a Raspberry Pi Zero machine.

  $ qemu-system-arm -M raspi0 -serial stdio \
      -kernel raspberrypi/firmware/boot/kernel.img \
      -dtb raspberrypi/firmware/boot/bcm2708-rpi-zero-w.dtb \
      -append 'printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0'
  [    0.000000] Booting Linux on physical CPU 0x0
  [    0.000000] Linux version 4.19.69+ (dom@buildbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep 3 20:21:01 BST 2019
  [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W
  [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
  [    0.000000] bootconsole [pl11] enabled
  [    0.000000] Memory policy: Data cache writeback
  [    0.000000] cma: Reserved 8 MiB at 0x1b800000
  [    0.000000] random: get_random_bytes called from start_kernel+0x8c/0x49c with crng_init=0
  [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113680
  [    0.000000] Kernel command line: printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0 root=/dev/mmcblk0 rootwait
  Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
  Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
  Memory: 434380K/458752K available (6971K kernel code, 635K rwdata, 2080K rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
  Virtual kernel memory layout:
      vector  : 0xffff0000 - 0xffff1000   (   4 kB)
      fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
      vmalloc : 0xdc800000 - 0xff800000   ( 560 MB)
      lowmem  : 0xc0000000 - 0xdc000000   ( 448 MB)
      modules : 0xbf000000 - 0xc0000000   (  16 MB)
        .text : 0x(ptrval) - 0x(ptrval)   (6973 kB)
        .init : 0x(ptrval) - 0x(ptrval)   ( 464 kB)
        .data : 0x(ptrval) - 0x(ptrval)   ( 636 kB)
         .bss : 0x(ptrval) - 0x(ptrval)   ( 798 kB)
  SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
  ftrace: allocating 25193 entries in 74 pages
  NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
  sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
  clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
  bcm2835: system timer (irq = 27)
  Console: colour dummy device 80x30
  ...

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 7f7d0ee926..68114de173 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -324,6 +324,15 @@ static void raspi_machine_class_common_init(MachineClass *mc,
     mc->default_ram_size = board_ram_size(board_rev);
 };
 
+static void raspi0_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0x9000c1;
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+};
+
 static void raspi1_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -353,6 +362,10 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
+        .name           = MACHINE_TYPE_NAME("raspi0"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi0_machine_class_init,
+    }, {
         .name           = MACHINE_TYPE_NAME("raspi1"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1_machine_class_init,
-- 
2.21.1


