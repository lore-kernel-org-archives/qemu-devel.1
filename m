Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686B9C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3784F20873
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKd52Z6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3784F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1vtU-0006Un-Dy
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 12:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j1vqP-0001x6-I6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j1vqO-0000Hq-C7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:37 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:36468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j1vqO-0000Hc-78
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:36 -0500
Received: by mail-pg1-x52e.google.com with SMTP id d9so1572727pgu.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=Nt+v+2a2R8OCW2A8v7JDC7oUY4W0g3AaQIDKQopbjks=;
 b=sKd52Z6Odm/TNz5cB/oMDPd+Bb91Z9ItEJf0LY18v3AfUpnjDN+D1Jhw6NCKu31y2L
 MhiTFtLSz4oiV9vYDik9Pj9TXjnUQ69rk9EUrQXW4EakqrSog+Vt/fE2B+CfZcbRA3aI
 IkLDob3LB1EvZ+MP4MF+4/psYXhplUCDVUFK7V2dQ1V+6EvMg6H9/Kkn1MBFnPy1ESHF
 sM3zaSeBbuOzg31AZf9X/IfMMPp8Ey56PUswwwN25CbydJVj1d+/9acRJ496Tnlu+vco
 ngwKn/JiNCzB7CSgoqw4EqP6re4ODF1P/8KTyBTcj1kdvCLMfrxtyLekKmsp6I27SuBq
 UqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Nt+v+2a2R8OCW2A8v7JDC7oUY4W0g3AaQIDKQopbjks=;
 b=O9s7ybC0+NmrXrdSVDM7oS9/grdc1pDLh8a7G1B90eOrApdAs5ULFjyNlgrTmV1CqE
 yZvmhQTCyf7F/7uoI5gG0szCFbkH3h+nQ4uca5pXR2fxEgREgZ0FuzcE/c8vq00Pfys6
 tPmwkW0Qmg3BSz7vGXJOfTjpA6ktkTjudRqTc+zb3aLyhwVwN1z2VSGEBvmvH0geK825
 YhyFc9/N6juzVwrHE9o5vDXRV570iAsNf6YMRqyE2JHZYUPtpQL2bmWo+5wFCgLP7iwi
 EbnoOuOGgW1GLQ5c8FB3b64Av3C/lOAIZbAWtmT6Rfku7a4AJKa8b0iKwtTsU9VA9u/q
 /GGg==
X-Gm-Message-State: APjAAAXWWEB5zKKJIxfNY7tl57ZFBhOzrQRW2ISk1K2j81AxtvbllBJw
 bqVWngvnQRCXACLbhmRy+nuXc9ijzzs=
X-Google-Smtp-Source: APXvYqw9FseUqlYuywbmmkycabwrScfXLlguaoay0bTtwJ+CwJIqK1csvNwNwtG1ye6uF1CzFbnH9A==
X-Received: by 2002:aa7:991e:: with SMTP id z30mr12464445pff.259.1581528634938; 
 Wed, 12 Feb 2020 09:30:34 -0800 (PST)
Received: from localhost ([2620:0:1000:fd28:dc94:91b3:e554:4ae7])
 by smtp.gmail.com with ESMTPSA id 199sm1555910pfv.81.2020.02.12.09.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 09:30:34 -0800 (PST)
Subject: [PULL 4/5] riscv: virt: Use Goldfish RTC device
Date: Wed, 12 Feb 2020 09:29:20 -0800
Message-Id: <20200212172921.36796-5-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212172921.36796-1-palmerdabbelt@google.com>
References: <20200212172921.36796-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 Anup Patel <Anup.Patel@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <Anup.Patel@wdc.com>

We extend QEMU RISC-V virt machine by adding Goldfish RTC device
to it. This will allow Guest Linux to sync it's local date/time
with Host date/time via RTC device.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 16 ++++++++++++++++
 include/hw/riscv/virt.h |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index b12660b9f8..ff9fbe958a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -34,6 +34,7 @@ config RISCV_VIRT
     select PCI
     select HART
     select SERIAL
+    select GOLDFISH_RTC
     select VIRTIO_MMIO
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6d682f8a78..7f9e1e5176 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -58,6 +58,7 @@ static const struct MemmapEntry {
     [VIRT_DEBUG] =       {        0x0,         0x100 },
     [VIRT_MROM] =        {     0x1000,       0x11000 },
     [VIRT_TEST] =        {   0x100000,        0x1000 },
+    [VIRT_RTC] =         {   0x101000,        0x1000 },
     [VIRT_CLINT] =       {  0x2000000,       0x10000 },
     [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
     [VIRT_UART0] =       { 0x10000000,         0x100 },
@@ -404,6 +405,18 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     }
     g_free(nodename);
 
+    nodename = g_strdup_printf("/rtc@%lx",
+        (long)memmap[VIRT_RTC].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+        "google,goldfish-rtc");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[VIRT_RTC].base,
+        0x0, memmap[VIRT_RTC].size);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", RTC_IRQ);
+    g_free(nodename);
+
     nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
     qemu_fdt_add_subnode(s->fdt, nodename);
     qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "cfi-flash");
@@ -601,6 +614,9 @@ static void riscv_virt_board_init(MachineState *machine)
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
+        qdev_get_gpio_in(DEVICE(s->plic), RTC_IRQ));
+
     virt_flash_create(s);
 
     for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index b17048a93a..e69355efaf 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -44,6 +44,7 @@ enum {
     VIRT_DEBUG,
     VIRT_MROM,
     VIRT_TEST,
+    VIRT_RTC,
     VIRT_CLINT,
     VIRT_PLIC,
     VIRT_UART0,
@@ -57,6 +58,7 @@ enum {
 
 enum {
     UART0_IRQ = 10,
+    RTC_IRQ = 11,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
     PCIE_IRQ = 0x20, /* 32 to 35 */
-- 
2.25.0.225.g125e21ebc7-goog


