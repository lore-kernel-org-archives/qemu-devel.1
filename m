Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EEBC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AFE2078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnIqR0sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AFE2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGcR-00008g-1V
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGbE-0006AH-Bg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:02:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGbC-0001p5-GK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599721345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4TiFU/E5h3g7pzVC+3Y38BqYPnJSqtGxVteMoOcLyc=;
 b=hnIqR0sqyocjmFNmXrMbQOtg40c1Ag7S1ykKNTg84rThJdxQzEf3K/3cK6NqxY2s82LGBI
 3y2m1631oJRiHPY3cHlEFL07GLQ/nBsN2MqgsQkiNEGVv/+4XaXlzilww2VHx1gfCw2TYk
 PCUpyjy5LBTpC+yjNeEh5ehvBbSj3/E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-tRsT0714MGK9SzopjMDGWw-1; Thu, 10 Sep 2020 03:02:04 -0400
X-MC-Unique: tRsT0714MGK9SzopjMDGWw-1
Received: by mail-wm1-f72.google.com with SMTP id x81so1295179wmg.8
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 00:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O4TiFU/E5h3g7pzVC+3Y38BqYPnJSqtGxVteMoOcLyc=;
 b=o6ipS3of5sFmrfI6IRMrOw9/l+LkCY/IklWQ8WFHaszSzPoRl8ootZhKajjlE3Z/m4
 +t4/b+lNSSuf/9neybtD4+O0aAdMxUQTDxLw1M323eU0pJUR8c6FxZi4Im4x8mnGO+me
 xgYtm4vVAQaUXauxoUNkgaM+a8PhzudVmXdLC3fiKlTbgiQG6Ey5PlEcz5TaIwuy3Wbj
 LkZtdBwgJOpMqbiA4t0Qpf9JGqpv0CGWrMmn3BEE0uBcECkxG1kgBbVRABTuIb1JKkhI
 IkSRFiOh2xv4rUIEMV2SlwBVBReiR27qoPOrDuEi7hsxcuk7GRo2J/ofP/bznEPwT7DW
 sxnA==
X-Gm-Message-State: AOAM530IykhL5VWGlsogdBvkyUXQiebE+MnXaQnmVMLdOsX4Y3FZQDnH
 iW3TZBHuShqb0izk9GClLxgzjd5AjY4iHV7WSXq5xNSfAlsi8V7qOwxAtvgTXNxMm8g159GX1WH
 DLdpm++oDQjSL2eg=
X-Received: by 2002:a1c:c256:: with SMTP id s83mr7016240wmf.93.1599721322696; 
 Thu, 10 Sep 2020 00:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRCTkH+/DmTsf56gy1ymOQ2OzxrWvy46F4cviEpju4FPjr5Ind5bZnv+UsKffp56Gc1+5NYw==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr7016210wmf.93.1599721322497; 
 Thu, 10 Sep 2020 00:02:02 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z15sm7347660wrv.94.2020.09.10.00.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:02:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] hw/pci-host/q35: Rename PCI 'black hole as '(memory) hole'
Date: Thu, 10 Sep 2020 09:01:30 +0200
Message-Id: <20200910070131.435543-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910070131.435543-1-philmd@redhat.com>
References: <20200910070131.435543-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to use inclusive terminology, rename "blackhole"
as "(memory)hole".

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci-host/q35.h |  4 ++--
 hw/pci-host/q35.c         | 38 +++++++++++++++++++-------------------
 tests/qtest/q35-test.c    |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 070305f83df..0fb90aca18b 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -48,8 +48,8 @@ typedef struct MCHPCIState {
     PAMMemoryRegion pam_regions[13];
     MemoryRegion smram_region, open_high_smram;
     MemoryRegion smram, low_smram, high_smram;
-    MemoryRegion tseg_blackhole, tseg_window;
-    MemoryRegion smbase_blackhole, smbase_window;
+    MemoryRegion tseg_hole, tseg_window;
+    MemoryRegion smbase_hole, smbase_window;
     bool has_smram_at_smbase;
     Range pci_hole;
     uint64_t below_4g_mem_size;
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index b67cb9c29f8..21f58ccfa28 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -266,20 +266,20 @@ static const TypeInfo q35_host_info = {
  * MCH D0:F0
  */
 
-static uint64_t blackhole_read(void *ptr, hwaddr reg, unsigned size)
+static uint64_t memoryhole_read(void *ptr, hwaddr reg, unsigned size)
 {
     return 0xffffffff;
 }
 
-static void blackhole_write(void *opaque, hwaddr addr, uint64_t val,
+static void memoryhole_write(void *opaque, hwaddr addr, uint64_t val,
                             unsigned width)
 {
     /* nothing */
 }
 
-static const MemoryRegionOps blackhole_ops = {
-    .read = blackhole_read,
-    .write = blackhole_write,
+static const MemoryRegionOps memoryhole_ops = {
+    .read = memoryhole_read,
+    .write = memoryhole_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
@@ -393,12 +393,12 @@ static void mch_update_smram(MCHPCIState *mch)
     } else {
         tseg_size = 0;
     }
-    memory_region_del_subregion(mch->system_memory, &mch->tseg_blackhole);
-    memory_region_set_enabled(&mch->tseg_blackhole, tseg_size);
-    memory_region_set_size(&mch->tseg_blackhole, tseg_size);
+    memory_region_del_subregion(mch->system_memory, &mch->tseg_hole);
+    memory_region_set_enabled(&mch->tseg_hole, tseg_size);
+    memory_region_set_size(&mch->tseg_hole, tseg_size);
     memory_region_add_subregion_overlap(mch->system_memory,
                                         mch->below_4g_mem_size - tseg_size,
-                                        &mch->tseg_blackhole, 1);
+                                        &mch->tseg_hole, 1);
 
     memory_region_set_enabled(&mch->tseg_window, tseg_size);
     memory_region_set_size(&mch->tseg_window, tseg_size);
@@ -456,7 +456,7 @@ static void mch_update_smbase_smram(MCHPCIState *mch)
     } else {
         lck = false;
     }
-    memory_region_set_enabled(&mch->smbase_blackhole, lck);
+    memory_region_set_enabled(&mch->smbase_hole, lck);
     memory_region_set_enabled(&mch->smbase_window, lck);
     memory_region_transaction_commit();
 }
@@ -601,13 +601,13 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_set_enabled(&mch->high_smram, true);
     memory_region_add_subregion(&mch->smram, 0xfeda0000, &mch->high_smram);
 
-    memory_region_init_io(&mch->tseg_blackhole, OBJECT(mch),
-                          &blackhole_ops, NULL,
-                          "tseg-blackhole", 0);
-    memory_region_set_enabled(&mch->tseg_blackhole, false);
+    memory_region_init_io(&mch->tseg_hole, OBJECT(mch),
+                          &memoryhole_ops, NULL,
+                          "tseg-hole", 0);
+    memory_region_set_enabled(&mch->tseg_hole, false);
     memory_region_add_subregion_overlap(mch->system_memory,
                                         mch->below_4g_mem_size,
-                                        &mch->tseg_blackhole, 1);
+                                        &mch->tseg_hole, 1);
 
     memory_region_init_alias(&mch->tseg_window, OBJECT(mch), "tseg-window",
                              mch->ram_memory, mch->below_4g_mem_size, 0);
@@ -619,13 +619,13 @@ static void mch_realize(PCIDevice *d, Error **errp)
      * This is not what hardware does, so it's QEMU specific hack.
      * See commit message for details.
      */
-    memory_region_init_io(&mch->smbase_blackhole, OBJECT(mch), &blackhole_ops,
-                          NULL, "smbase-blackhole",
+    memory_region_init_io(&mch->smbase_hole, OBJECT(mch), &memoryhole_ops,
+                          NULL, "smbase-hole",
                           MCH_HOST_BRIDGE_SMBASE_SIZE);
-    memory_region_set_enabled(&mch->smbase_blackhole, false);
+    memory_region_set_enabled(&mch->smbase_hole, false);
     memory_region_add_subregion_overlap(mch->system_memory,
                                         MCH_HOST_BRIDGE_SMBASE_ADDR,
-                                        &mch->smbase_blackhole, 1);
+                                        &mch->smbase_hole, 1);
 
     memory_region_init_alias(&mch->smbase_window, OBJECT(mch),
                              "smbase-window", mch->ram_memory,
diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
index b7cf1449906..7cddd0a7f61 100644
--- a/tests/qtest/q35-test.c
+++ b/tests/qtest/q35-test.c
@@ -231,7 +231,7 @@ static void test_smram_smbase_lock(void)
         qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
         g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x02);
 
-        /* RAM access should go into black hole */
+        /* RAM access should go into memory hole */
         qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
         g_assert_cmpint(qtest_readb(qts, SMBASE), ==, 0xff);
     }
-- 
2.26.2


