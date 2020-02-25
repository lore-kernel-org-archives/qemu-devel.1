Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7217EC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6972176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHuhEA4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6972176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ysc-0007f0-Ct
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykb-0000jJ-40
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkX-0006pa-4q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:45 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:35190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkW-0006jr-U2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:41 -0500
Received: by mail-wr1-x42c.google.com with SMTP id w12so14382467wrt.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C+vwkZOJ3f3oKCLCURtreZwB/bV/mwc6VlrVskQKUPU=;
 b=iHuhEA4Zr9CDJRbPk7N1/QpEpRxHnpHckz01HYfwcYUeoof2Cc4bdghNJDuLmQ4UQ7
 PBX2fpO/ou0yA723s4Pox38HqYk7k3jqeYvExrSIEA5cgHUCCMOwS9e9g7VqTo0MIa1d
 IlXZbPzPnMtG2sbYOnCavCbfvM8FcE7aNoDTtkbu0RVpUza2AYYYmB/y1u+yi68BoqgC
 K5JH6MbLnWA4qiubyD3CgnTWYJHCi/vbJZ/mCu7VneOxQSl0+rj9d/qtE1uqlkKOF62H
 v4AKmgMfnrDpkqIL0VBEP2jMbbMsM6G4ZJlyob8bhSUit0a1lhwskYQXILp8pXFFCo23
 YGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=C+vwkZOJ3f3oKCLCURtreZwB/bV/mwc6VlrVskQKUPU=;
 b=qUBCahkSPLAm6DbP26R/AzAsl3rGb40JlQSuPI1KdCLk/KYDFrT7KIIunudWYfI1NT
 AvojHEZni8PPfohFnNeJ4ovc+0AhQ0icmxGK5x1UXHAXd2xCcZgAa/Lp8vJ2lC7cufE9
 9pc7kbiuOS2tsZ3dFM2g2odTKXndeZHT30Z0X2gH18/v7Qxhvc7fZwJMq22d6Lq+CgI5
 ccqOGGsneeoctFbNODsaWz4uLTx3GG2uhOLDs4mt3G5b2nZtVsPlEwWdMNS7nQiAmMRi
 VZsOKJPWrU9kEXCsUUUN6VdUcT5sGV3684d5Uqm2DLMN+fvLzellJjTTBRLlnD91TJpm
 NxLQ==
X-Gm-Message-State: APjAAAWOIndajBn2QMJ7MA7TTaiEr00AKA3TxAmwzjNx16lJBz3pjycN
 seheeKW0UKN9IWEF6oi9h9Dpy06H
X-Google-Smtp-Source: APXvYqxCIV67BMWYjqUMDp6Bp0d8CaW0C7zc0vAa1KxNj6GHKLxMu+Si43aJ6pugC5t/QfT9di/Oyg==
X-Received: by 2002:adf:e546:: with SMTP id z6mr646090wrm.423.1582631498563;
 Tue, 25 Feb 2020 03:51:38 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 034/136] arm/xilinx_zynq: drop RAM size fixup
Date: Tue, 25 Feb 2020 12:49:24 +0100
Message-Id: <1582631466-13880-34-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

If user provided non-sense RAM size, board will complain and
continue running with max RAM size supported.
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-35-imammedo@redhat.com>
---
 hw/arm/xilinx_zynq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3a0fa5b..f548c44 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -158,7 +158,6 @@ static inline void zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 
 static void zynq_init(MachineState *machine)
 {
-    ram_addr_t ram_size = machine->ram_size;
     ARMCPU *cpu;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ext_ram = g_new(MemoryRegion, 1);
@@ -168,6 +167,12 @@ static void zynq_init(MachineState *machine)
     qemu_irq pic[64];
     int n;
 
+    /* max 2GB ram */
+    if (machine->ram_size > 2 * GiB) {
+        error_report("RAM size more than 2 GiB is not supported");
+        exit(EXIT_FAILURE);
+    }
+
     cpu = ARM_CPU(object_new(machine->cpu_type));
 
     /* By default A9 CPUs have EL3 enabled.  This board does not
@@ -184,14 +189,9 @@ static void zynq_init(MachineState *machine)
                             &error_fatal);
     object_property_set_bool(OBJECT(cpu), true, "realized", &error_fatal);
 
-    /* max 2GB ram */
-    if (ram_size > 0x80000000) {
-        ram_size = 0x80000000;
-    }
-
     /* DDR remapped to address zero.  */
     memory_region_allocate_system_memory(ext_ram, NULL, "zynq.ext_ram",
-                                         ram_size);
+                                         machine->ram_size);
     memory_region_add_subregion(address_space_mem, 0, ext_ram);
 
     /* 256K of on-chip memory */
@@ -300,7 +300,7 @@ static void zynq_init(MachineState *machine)
     sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
     sysbus_mmio_map(busdev, 0, 0xF8007000);
 
-    zynq_binfo.ram_size = ram_size;
+    zynq_binfo.ram_size = machine->ram_size;
     zynq_binfo.nb_cpus = 1;
     zynq_binfo.board_id = 0xd32;
     zynq_binfo.loader_start = 0;
-- 
1.8.3.1



