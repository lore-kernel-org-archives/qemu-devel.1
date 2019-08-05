Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB198C32751
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7706020651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPYuMRMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7706020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufWC-0004Xw-Pq
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPT-0008Qe-UG
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPS-0002l8-HU
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:31 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPS-0002jV-BZ; Mon, 05 Aug 2019 12:00:30 -0400
Received: by mail-pf1-x441.google.com with SMTP id r7so39875133pfl.3;
 Mon, 05 Aug 2019 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=oDcid3MTgtWkz4qqSCyI2LoyxuPlEnKJ6+RWQLcIJ3g=;
 b=IPYuMRMI2rxCMp/sOFI5nnsAzY67rC99I2cj4d3Oqsf3qBvStqWkAifO94Lk0JbFdw
 q5+xziCA+SylVQEQLjJe03Eioteg8Zvw32RhSzShnBjd/vNpbfshUABUlZRqw/aKSQxT
 U8POLzH5kr4GCnXGp2nLNYZk7WyTDf7IcEYDDls7nVoPVq1Ot8y7nlvFTFouuZn4x/Ax
 0ZXysBag32zk3XAKkVbSoaYXRtdmix2OWy5M9yZp//vNyA16HEBnwv3gVdYnide4/ZTD
 zz76OLyytEI/BgAno7ZDuWiOCHwhVNhn1nHfP7acz0RDotP6tpDIHRz9q9Lj+tzGqbfy
 bBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=oDcid3MTgtWkz4qqSCyI2LoyxuPlEnKJ6+RWQLcIJ3g=;
 b=KYildTwZc1jTPZOmc0o9U6XopuZhvMn1TA+xFxflPiXHoKB24Xec0ltIfnRF6f1OeN
 NGvv8fc6yUQu6XIURyeKiraIEKV06zk6N5m4IeCwGzCCEg6f8KahCRY4/M/U3l6bCFaV
 gnD+w3F4yWazmgBgQ8VAblpG6NnWfSviv+b9SiFNOfGGVsaSd7qVjv15IcqH/1/DrkV+
 PKYdpj2xsNirlib6TqgxzxqP0w/fOaa/8jZmfhhP5JKqvzR/IpmBLmVW3ZVxoVf0DSb3
 SWm8NtKxK2Bmyf4VKyNAJa9RTXqbdcKgld7QA2BTgzBnFCs7QoBtSWoHVw3AE/DtWCSx
 R50A==
X-Gm-Message-State: APjAAAXg0lDUkOjSOUBNmmihpPQ4VL2MJ3JORucM++E0uwnQ/y57N6K+
 nZ1O/ruKUN7LURnOfbPcr1En8mwZ
X-Google-Smtp-Source: APXvYqxjOgK66fbjYi9wSELLubC+3fODDp60F+VWqz8oxRmspubteMtHpWPSf91ZgHUZM7r6qOAGjw==
X-Received: by 2002:a17:90a:ad93:: with SMTP id
 s19mr18801025pjq.36.1565020829357; 
 Mon, 05 Aug 2019 09:00:29 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.28
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:28 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 08:59:56 -0700
Message-Id: <1565020823-24223-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 01/28] riscv: hw: Remove superfluous "linux,
 phandle" property
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

"linux,phandle" property is optional. Remove all instances in the
sifive_u and virt machine device tree.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 3 ---
 hw/riscv/virt.c     | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 71b8083..ef36948 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -125,7 +125,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
         qemu_fdt_add_subnode(fdt, intc);
         qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
-        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", cpu_phandle);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
@@ -184,7 +183,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
     qemu_fdt_setprop_cells(fdt, nodename, "phandle", plic_phandle);
-    qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
@@ -197,7 +195,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
         SIFIVE_U_GEM_CLOCK_FREQ);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", ethclk_phandle);
-    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", ethclk_phandle);
     ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 25faf3b..00be05a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -170,11 +170,9 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
         qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
-        qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", cpu_phandle);
         intc_phandle = phandle++;
         qemu_fdt_add_subnode(fdt, intc);
         qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandle);
-        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", intc_phandle);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
@@ -250,7 +248,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
     qemu_fdt_setprop_cells(fdt, nodename, "phandle", plic_phandle);
-    qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
-- 
2.7.4


