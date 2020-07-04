Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C030DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849F520708
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4jxX4cx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849F520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkXs-0006h2-Pk
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkHl-00030i-7b
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:41:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkHi-0008Mc-13
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCf98bap8NX9iIcnvvB/aw+3vfPbNUjO6+kAZbeXlU0=;
 b=B4jxX4cxpTV8McV+q2CCieOT4GXuZIeyIC0tK8nFmHOlwDbeUVsxIH1qxUXv8lBHCstWx4
 Nun8o53aVG8bGdMo1S27FL6BDfRUNOexQ167PNlIsZS/uwbBTtESlcT5f4dev/KTdhV4gM
 DBEHkDSsnGf58ivj5k0uU9TiORPECe8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-UyxLMv0tNjy0kdoy4Tm2QQ-1; Sat, 04 Jul 2020 11:40:56 -0400
X-MC-Unique: UyxLMv0tNjy0kdoy4Tm2QQ-1
Received: by mail-wm1-f71.google.com with SMTP id v24so39801439wmh.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nCf98bap8NX9iIcnvvB/aw+3vfPbNUjO6+kAZbeXlU0=;
 b=jmYPNmH07OntXolaBSjaYFPhsxu4uug0D3X1hKsx4ggUbrCVakRZHcHCsoIA5xkAVI
 ucfy7RIOJAfqkna40efjWmigjOi7REM1/FlBbJYbYiu9ziW16UkgqhDu+XWn6Gv3SJxM
 dWNklxvj9jdUgDi2y4Rz1HoQAk/sUUvFiyIwO7PC2gKx9G50lTQucN4i0bKNbpf61ZsI
 gtewTzrxiiKusT2nI8BTFaDgaQL9Wx4bQxsxuDZUlguC8gexGGzqmbQOTri/+NQ2ZsOh
 TH66Qj8+j8TY0SJ9JuJBPIrADXNnx3MBfdJArDquLGr6QfsLPZUZQt34gEKhEPc0+BoJ
 ngmQ==
X-Gm-Message-State: AOAM531qjcFBKjPtEvAw1H5HX0FbI56tgjgi3Nijv+EDhNKkA1xI5cqD
 beKjeBXzNMAgo9oxaVCMxNYWtxz8juZy/GF+05QF+mt+4SyxlmF6IrT3EpvLNDHqcF07w5Z/ZWG
 Hrrm8hjZdkXLJLwc=
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr12447101wro.245.1593877254706; 
 Sat, 04 Jul 2020 08:40:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjEOw2VbtlzuJ8OjgiprTB5xydMhy9LHFfH4+nXG5Wee0cvkS9DMyrXD570f/h6RMrnzjQBQ==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr12447059wro.245.1593877254354; 
 Sat, 04 Jul 2020 08:40:54 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u16sm16549090wmn.11.2020.07.04.08.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:40:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 19/23] hw/ppc/ppc4xx: Emit warning when old code is used
Date: Sat,  4 Jul 2020 17:39:04 +0200
Message-Id: <20200704153908.12118-20-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704153908.12118-1-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/ppc/ppc405_boards.c |  5 +++++
 hw/ppc/ppc405_uc.c     | 21 +++++++++++++++++++++
 hw/ppc/ppc4xx_devs.c   |  7 +++++++
 3 files changed, 33 insertions(+)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 6198ec1035..eb1216b5f0 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -41,6 +41,7 @@
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
 #include "qemu/cutils.h"
+#include "hw/qdev-deprecated.h"
 
 #define BIOS_FILENAME "ppc405_rom.bin"
 #define BIOS_SIZE (2 * MiB)
@@ -129,6 +130,8 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem, uint32_t base)
     ref405ep_fpga_t *fpga;
     MemoryRegion *fpga_memory = g_new(MemoryRegion, 1);
 
+    qdev_warn_deprecated_function_used();
+
     fpga = g_malloc0(sizeof(ref405ep_fpga_t));
     memory_region_init_io(fpga_memory, NULL, &ref405ep_fpga_ops, fpga,
                           "fpga", 0x00000100);
@@ -408,6 +411,8 @@ static void taihu_cpld_init(MemoryRegion *sysmem, uint32_t base)
     taihu_cpld_t *cpld;
     MemoryRegion *cpld_memory = g_new(MemoryRegion, 1);
 
+    qdev_warn_deprecated_function_used();
+
     cpld = g_malloc0(sizeof(taihu_cpld_t));
     memory_region_init_io(cpld_memory, NULL, &taihu_cpld_ops, cpld, "cpld", 0x100);
     memory_region_add_subregion(sysmem, base, cpld_memory);
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 381720aced..160604c62e 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -36,6 +36,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
+#include "hw/qdev-deprecated.h"
 
 //#define DEBUG_OPBA
 //#define DEBUG_SDRAM
@@ -182,6 +183,8 @@ void ppc4xx_plb_init(CPUPPCState *env)
 {
     ppc4xx_plb_t *plb;
 
+    qdev_warn_deprecated_function_used();
+
     plb = g_malloc0(sizeof(ppc4xx_plb_t));
     ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
     ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
@@ -267,6 +270,8 @@ static void ppc4xx_pob_init(CPUPPCState *env)
 {
     ppc4xx_pob_t *pob;
 
+    qdev_warn_deprecated_function_used();
+
     pob = g_malloc0(sizeof(ppc4xx_pob_t));
     ppc_dcr_register(env, POB0_BEAR, pob, &dcr_read_pob, &dcr_write_pob);
     ppc_dcr_register(env, POB0_BESR0, pob, &dcr_read_pob, &dcr_write_pob);
@@ -351,6 +356,8 @@ static void ppc4xx_opba_init(hwaddr base)
 {
     ppc4xx_opba_t *opba;
 
+    qdev_warn_deprecated_function_used();
+
     opba = g_malloc0(sizeof(ppc4xx_opba_t));
 #ifdef DEBUG_OPBA
     printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
@@ -549,6 +556,8 @@ void ppc405_ebc_init(CPUPPCState *env)
 {
     ppc4xx_ebc_t *ebc;
 
+    qdev_warn_deprecated_function_used();
+
     ebc = g_malloc0(sizeof(ppc4xx_ebc_t));
     qemu_register_reset(&ebc_reset, ebc);
     ppc_dcr_register(env, EBC0_CFGADDR,
@@ -632,6 +641,8 @@ static void ppc405_dma_init(CPUPPCState *env, qemu_irq irqs[4])
 {
     ppc405_dma_t *dma;
 
+    qdev_warn_deprecated_function_used();
+
     dma = g_malloc0(sizeof(ppc405_dma_t));
     memcpy(dma->irqs, irqs, 4 * sizeof(qemu_irq));
     qemu_register_reset(&ppc405_dma_reset, dma);
@@ -735,6 +746,8 @@ static void ppc405_gpio_init(hwaddr base)
 {
     ppc405_gpio_t *gpio;
 
+    qdev_warn_deprecated_function_used();
+
     gpio = g_malloc0(sizeof(ppc405_gpio_t));
 #ifdef DEBUG_GPIO
     printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
@@ -897,6 +910,8 @@ static void ppc405_ocm_init(CPUPPCState *env)
 {
     ppc405_ocm_t *ocm;
 
+    qdev_warn_deprecated_function_used();
+
     ocm = g_malloc0(sizeof(ppc405_ocm_t));
     /* XXX: Size is 4096 or 0x04000000 */
     memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4 * KiB,
@@ -1142,6 +1157,8 @@ static void ppc4xx_gpt_init(hwaddr base, qemu_irq irqs[5])
     ppc4xx_gpt_t *gpt;
     int i;
 
+    qdev_warn_deprecated_function_used();
+
     gpt = g_malloc0(sizeof(ppc4xx_gpt_t));
     for (i = 0; i < 5; i++) {
         gpt->irqs[i] = irqs[i];
@@ -1410,6 +1427,8 @@ static void ppc405cr_cpc_init (CPUPPCState *env, clk_setup_t clk_setup[7],
 {
     ppc405cr_cpc_t *cpc;
 
+    qdev_warn_deprecated_function_used();
+
     cpc = g_malloc0(sizeof(ppc405cr_cpc_t));
     memcpy(cpc->clk_setup, clk_setup,
            PPC405CR_CLK_NB * sizeof(clk_setup_t));
@@ -1755,6 +1774,8 @@ static void ppc405ep_cpc_init (CPUPPCState *env, clk_setup_t clk_setup[8],
 {
     ppc405ep_cpc_t *cpc;
 
+    qdev_warn_deprecated_function_used();
+
     cpc = g_malloc0(sizeof(ppc405ep_cpc_t));
     memcpy(cpc->clk_setup, clk_setup,
            PPC405EP_CLK_NB * sizeof(clk_setup_t));
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index f1651e04d9..b09d7ab5c6 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -33,6 +33,7 @@
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
+#include "hw/qdev-deprecated.h"
 
 /*#define DEBUG_UIC*/
 
@@ -303,6 +304,8 @@ qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
     ppcuic_t *uic;
     int i;
 
+    qdev_warn_deprecated_function_used();
+
     uic = g_malloc0(sizeof(ppcuic_t));
     uic->dcr_base = dcr_base;
     uic->irqs = irqs;
@@ -647,6 +650,8 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
 {
     ppc4xx_sdram_t *sdram;
 
+    qdev_warn_deprecated_function_used();
+
     sdram = g_malloc0(sizeof(ppc4xx_sdram_t));
     sdram->irq = irq;
     sdram->nbanks = nbanks;
@@ -908,6 +913,8 @@ void ppc4xx_mal_init(CPUPPCState *env, uint8_t txcnum, uint8_t rxcnum,
     ppc4xx_mal_t *mal;
     int i;
 
+    qdev_warn_deprecated_function_used();
+
     assert(txcnum <= 32 && rxcnum <= 32);
     mal = g_malloc0(sizeof(*mal));
     mal->txcnum = txcnum;
-- 
2.21.3


