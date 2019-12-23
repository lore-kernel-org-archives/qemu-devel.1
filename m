Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A9C2D0D2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7958D2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7958D2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijRwO-0002WX-Jq
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 12:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1ijRu8-00082a-5K
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1ijRu6-0001Fr-Os
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:54:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1ijRu3-0001Ao-Ii; Mon, 23 Dec 2019 12:53:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so18513990ljg.3;
 Mon, 23 Dec 2019 09:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0eJsSV15zh5FOODAxqRrW+eNsLPo3IjuB0LWcMocytU=;
 b=kwThS1uiSA0B9bBzPkPMn1nlmQooIhMARO/JI65qmERd5wA0Wd+dDO42lqJ7siirXI
 r2SUAVexngD3WXT8X/59urMb1ziAiNlar0IwSxI9ITW1egcOA3a0vz9XKkgoO6PLx0RW
 qNdEX1/jEOtBo24gbyfYCzzqmcwM4dODtBmHMcWyRCtfr4F3q2vnDBBOqDlJ0uE8jEMm
 dXuY4aHaSFdr5xcaYHPaSX4j3/L3V2v+kBXsL4azsgOZ34DMybSAK3iqgqcW8lUUaKTS
 4gn4xuQZf2k0UYblRKhYj+ne3rkVnNlpaROy+o7Kw0EYYGh6DzNw5zjjhOdyV9/AAV8F
 e/cw==
X-Gm-Message-State: APjAAAVDWkwiLMw6sKrfCk2ygDLhaAn7errY8rM75xTxUKMGRvft/EAa
 aNgislfqnMmFqxV05xCxqdc=
X-Google-Smtp-Source: APXvYqw62okUvMeruB2gtLiEyCrPWJMUtFfZkDCbHBEbXSesZiUdCa2evUvQ33j/KBVZCCVzD7Z6Og==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr19746265lji.214.1577123638291; 
 Mon, 23 Dec 2019 09:53:58 -0800 (PST)
Received: from localhost.localdomain ([213.87.155.175])
 by smtp.gmail.com with ESMTPSA id y14sm8892345ljk.46.2019.12.23.09.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 09:53:57 -0800 (PST)
From: Alexander Popov <alex.popov@linux.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 pmatouse@redhat.com, sstabellini@kernel.org, mdroth@linux.vnet.ibm.com,
 pjp@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Alexander Popov <alex.popov@linux.com>
Subject: [PATCH v3 2/2] tests/ide-test: Create a single unit-test covering
 more PRDT cases
Date: Mon, 23 Dec 2019 20:51:17 +0300
Message-Id: <20191223175117.508990-3-alex.popov@linux.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191223175117.508990-1-alex.popov@linux.com>
References: <20191223175117.508990-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.194
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

Fuzzing the Linux kernel with syzkaller allowed to find how to crash qemu
using a special SCSI_IOCTL_SEND_COMMAND. It hits the assertion in
ide_dma_cb() introduced in the commit a718978ed58a in July 2015.
Currently this bug is not reproduced by the unit tests.

Let's improve the ide-test to cover more PRDT cases including one
that causes this particular qemu crash.

The test is developed according to the Programming Interface for
Bus Master IDE Controller (Revision 1.0 5/16/94).

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 tests/ide-test.c | 174 ++++++++++++++++++++---------------------------
 1 file changed, 74 insertions(+), 100 deletions(-)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index 0277e7d5a9..5cfd97f915 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -445,104 +445,81 @@ static void test_bmdma_trim(void)
     test_bmdma_teardown(qts);
 }
 
-static void test_bmdma_short_prdt(void)
-{
-    QTestState *qts;
-    QPCIDevice *dev;
-    QPCIBar bmdma_bar, ide_bar;
-    uint8_t status;
-
-    PrdtEntry prdt[] = {
-        {
-            .addr = 0,
-            .size = cpu_to_le32(0x10 | PRDT_EOT),
-        },
-    };
-
-    qts = test_bmdma_setup();
-
-    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
-
-    /* Normal request */
-    status = send_dma_request(qts, CMD_READ_DMA, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-
-    /* Abort the request before it completes */
-    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
-}
-
-static void test_bmdma_one_sector_short_prdt(void)
-{
-    QTestState *qts;
-    QPCIDevice *dev;
-    QPCIBar bmdma_bar, ide_bar;
-    uint8_t status;
-
-    /* Read 2 sectors but only give 1 sector in PRDT */
-    PrdtEntry prdt[] = {
-        {
-            .addr = 0,
-            .size = cpu_to_le32(0x200 | PRDT_EOT),
-        },
-    };
-
-    qts = test_bmdma_setup();
-
-    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
-
-    /* Normal request */
-    status = send_dma_request(qts, CMD_READ_DMA, 0, 2,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-
-    /* Abort the request before it completes */
-    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 2,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
-}
-
-static void test_bmdma_long_prdt(void)
+/*
+ * This test is developed according to the Programming Interface for
+ * Bus Master IDE Controller (Revision 1.0 5/16/94)
+ */
+static void test_bmdma_various_prdts(void)
 {
-    QTestState *qts;
-    QPCIDevice *dev;
-    QPCIBar bmdma_bar, ide_bar;
-    uint8_t status;
-
-    PrdtEntry prdt[] = {
-        {
-            .addr = 0,
-            .size = cpu_to_le32(0x1000 | PRDT_EOT),
-        },
-    };
-
-    qts = test_bmdma_setup();
-
-    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
-
-    /* Normal request */
-    status = send_dma_request(qts, CMD_READ_DMA, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, BM_STS_ACTIVE | BM_STS_INTR);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+    int sectors = 0;
+    uint32_t size = 0;
+
+    for (sectors = 1; sectors <= 256; sectors *= 2) {
+        QTestState *qts = NULL;
+        QPCIDevice *dev = NULL;
+        QPCIBar bmdma_bar, ide_bar;
+
+        qts = test_bmdma_setup();
+        dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+        for (size = 0; size < 65536; size += 256) {
+            uint32_t req_size = sectors * 512;
+            uint32_t prd_size = size & 0xfffe; /* bit 0 is always set to 0 */
+            uint8_t ret = 0;
+            uint8_t req_status = 0;
+            uint8_t abort_req_status = 0;
+            PrdtEntry prdt[] = {
+                {
+                    .addr = 0,
+                    .size = cpu_to_le32(size | PRDT_EOT),
+                },
+            };
+
+            /* A value of zero in PRD size indicates 64K */
+            if (prd_size == 0) {
+                prd_size = 65536;
+            }
+
+            /*
+             * 1. If PRDs specified a smaller size than the IDE transfer
+             * size, then the Interrupt and Active bits in the Controller
+             * status register are not set (Error Condition).
+             *
+             * 2. If the size of the physical memory regions was equal to
+             * the IDE device transfer size, the Interrupt bit in the
+             * Controller status register is set to 1, Active bit is set to 0.
+             *
+             * 3. If PRDs specified a larger size than the IDE transfer size,
+             * the Interrupt and Active bits in the Controller status register
+             * are both set to 1.
+             */
+            if (prd_size < req_size) {
+                req_status = 0;
+                abort_req_status = 0;
+            } else if (prd_size == req_size) {
+                req_status = BM_STS_INTR;
+                abort_req_status = BM_STS_INTR;
+            } else {
+                req_status = BM_STS_ACTIVE | BM_STS_INTR;
+                abort_req_status = BM_STS_INTR;
+            }
+
+            /* Test the request */
+            ret = send_dma_request(qts, CMD_READ_DMA, 0, sectors,
+                                   prdt, ARRAY_SIZE(prdt), NULL);
+            g_assert_cmphex(ret, ==, req_status);
+            assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+
+            /* Now test aborting the same request */
+            ret = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0,
+                                   sectors, prdt, ARRAY_SIZE(prdt), NULL);
+            g_assert_cmphex(ret, ==, abort_req_status);
+            assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+        }
 
-    /* Abort the request before it completes */
-    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, BM_STS_INTR);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
+        free_pci_device(dev);
+        test_bmdma_teardown(qts);
+    }
 }
 
 static void test_bmdma_no_busmaster(void)
@@ -1066,10 +1043,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ide/bmdma/simple_rw", test_bmdma_simple_rw);
     qtest_add_func("/ide/bmdma/trim", test_bmdma_trim);
-    qtest_add_func("/ide/bmdma/short_prdt", test_bmdma_short_prdt);
-    qtest_add_func("/ide/bmdma/one_sector_short_prdt",
-                   test_bmdma_one_sector_short_prdt);
-    qtest_add_func("/ide/bmdma/long_prdt", test_bmdma_long_prdt);
+    qtest_add_func("/ide/bmdma/various_prdts", test_bmdma_various_prdts);
     qtest_add_func("/ide/bmdma/no_busmaster", test_bmdma_no_busmaster);
 
     qtest_add_func("/ide/flush", test_flush);
-- 
2.23.0


