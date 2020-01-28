Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7D3C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 01:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473FC21739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 01:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0//kZWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473FC21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwFMc-0003T3-0p
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 20:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iwFLc-0002Cr-RX
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 20:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iwFLb-0003UE-Ds
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 20:07:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44375
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iwFLb-0003Tt-9q
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 20:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580173639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyRxWrOGbv9to/iNkAWzvepPIhJ+AKRYBpvFEqPlzw8=;
 b=R0//kZWEIEmniTpJLtHS8UL6YJi/FPYUCY40WXVPQEreH+/g7EWc6WBeemfDReqy95MSTJ
 KthK9ELsuDN+bZgo5HY5cXjhpi2FanCjoJJxf0PhqlQg32KJutzUSv68v/KbeI7kaOqdx6
 wY/MNaX6fIOUwkgx/oJD0YQpheMF65g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-na_2oIgKO9iEKx9qbxPvFg-1; Mon, 27 Jan 2020 20:07:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51331800D48;
 Tue, 28 Jan 2020 01:07:13 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-116.bos.redhat.com [10.18.17.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88A475D9CA;
 Tue, 28 Jan 2020 01:07:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 2/2] tests/ide-test: Create a single unit-test covering more
 PRDT cases
Date: Mon, 27 Jan 2020 20:07:07 -0500
Message-Id: <20200128010707.19572-3-jsnow@redhat.com>
In-Reply-To: <20200128010707.19572-1-jsnow@redhat.com>
References: <20200128010707.19572-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: na_2oIgKO9iEKx9qbxPvFg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alexander Popov <alex.popov@linux.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Popov <alex.popov@linux.com>

Fuzzing the Linux kernel with syzkaller allowed to find how to crash qemu
using a special SCSI_IOCTL_SEND_COMMAND. It hits the assertion in
ide_dma_cb() introduced in the commit a718978ed58a in July 2015.
Currently this bug is not reproduced by the unit tests.

Let's improve the ide-test to cover more PRDT cases including one
that causes this particular qemu crash.

The test is developed according to the Programming Interface for
Bus Master IDE Controller (Revision 1.0 5/16/94).

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Message-id: 20191223175117.508990-3-alex.popov@linux.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qtest/ide-test.c | 176 ++++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 101 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 0277e7d5a9..5cfd97f915 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -445,104 +445,81 @@ static void test_bmdma_trim(void)
     test_bmdma_teardown(qts);
 }
=20
-static void test_bmdma_short_prdt(void)
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
-    PrdtEntry prdt[] =3D {
-        {
-            .addr =3D 0,
-            .size =3D cpu_to_le32(0x10 | PRDT_EOT),
-        },
-    };
-
-    qts =3D test_bmdma_setup();
-
-    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
-
-    /* Normal request */
-    status =3D send_dma_request(qts, CMD_READ_DMA, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, =3D=3D, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-
-    /* Abort the request before it completes */
-    status =3D send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, =3D=3D, 0);
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
-    PrdtEntry prdt[] =3D {
-        {
-            .addr =3D 0,
-            .size =3D cpu_to_le32(0x200 | PRDT_EOT),
-        },
-    };
-
-    qts =3D test_bmdma_setup();
-
-    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
-
-    /* Normal request */
-    status =3D send_dma_request(qts, CMD_READ_DMA, 0, 2,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, =3D=3D, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-
-    /* Abort the request before it completes */
-    status =3D send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 2,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, =3D=3D, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
-}
-
-static void test_bmdma_long_prdt(void)
-{
-    QTestState *qts;
-    QPCIDevice *dev;
-    QPCIBar bmdma_bar, ide_bar;
-    uint8_t status;
-
-    PrdtEntry prdt[] =3D {
-        {
-            .addr =3D 0,
-            .size =3D cpu_to_le32(0x1000 | PRDT_EOT),
-        },
-    };
-
-    qts =3D test_bmdma_setup();
-
-    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
-
-    /* Normal request */
-    status =3D send_dma_request(qts, CMD_READ_DMA, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, =3D=3D, BM_STS_ACTIVE | BM_STS_INTR);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-
-    /* Abort the request before it completes */
-    status =3D send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
+    int sectors =3D 0;
+    uint32_t size =3D 0;
+
+    for (sectors =3D 1; sectors <=3D 256; sectors *=3D 2) {
+        QTestState *qts =3D NULL;
+        QPCIDevice *dev =3D NULL;
+        QPCIBar bmdma_bar, ide_bar;
+
+        qts =3D test_bmdma_setup();
+        dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+        for (size =3D 0; size < 65536; size +=3D 256) {
+            uint32_t req_size =3D sectors * 512;
+            uint32_t prd_size =3D size & 0xfffe; /* bit 0 is always set to=
 0 */
+            uint8_t ret =3D 0;
+            uint8_t req_status =3D 0;
+            uint8_t abort_req_status =3D 0;
+            PrdtEntry prdt[] =3D {
+                {
+                    .addr =3D 0,
+                    .size =3D cpu_to_le32(size | PRDT_EOT),
+                },
+            };
+
+            /* A value of zero in PRD size indicates 64K */
+            if (prd_size =3D=3D 0) {
+                prd_size =3D 65536;
+            }
+
+            /*
+             * 1. If PRDs specified a smaller size than the IDE transfer
+             * size, then the Interrupt and Active bits in the Controller
+             * status register are not set (Error Condition).
+             *
+             * 2. If the size of the physical memory regions was equal to
+             * the IDE device transfer size, the Interrupt bit in the
+             * Controller status register is set to 1, Active bit is set t=
o 0.
+             *
+             * 3. If PRDs specified a larger size than the IDE transfer si=
ze,
+             * the Interrupt and Active bits in the Controller status regi=
ster
+             * are both set to 1.
+             */
+            if (prd_size < req_size) {
+                req_status =3D 0;
+                abort_req_status =3D 0;
+            } else if (prd_size =3D=3D req_size) {
+                req_status =3D BM_STS_INTR;
+                abort_req_status =3D BM_STS_INTR;
+            } else {
+                req_status =3D BM_STS_ACTIVE | BM_STS_INTR;
+                abort_req_status =3D BM_STS_INTR;
+            }
+
+            /* Test the request */
+            ret =3D send_dma_request(qts, CMD_READ_DMA, 0, sectors,
+                                   prdt, ARRAY_SIZE(prdt), NULL);
+            g_assert_cmphex(ret, =3D=3D, req_status);
+            assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF |=
 ERR);
+
+            /* Now test aborting the same request */
+            ret =3D send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0,
+                                   sectors, prdt, ARRAY_SIZE(prdt), NULL);
+            g_assert_cmphex(ret, =3D=3D, abort_req_status);
+            assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF |=
 ERR);
+        }
+
+        free_pci_device(dev);
+        test_bmdma_teardown(qts);
+    }
 }
=20
 static void test_bmdma_no_busmaster(void)
@@ -1066,10 +1043,7 @@ int main(int argc, char **argv)
=20
     qtest_add_func("/ide/bmdma/simple_rw", test_bmdma_simple_rw);
     qtest_add_func("/ide/bmdma/trim", test_bmdma_trim);
-    qtest_add_func("/ide/bmdma/short_prdt", test_bmdma_short_prdt);
-    qtest_add_func("/ide/bmdma/one_sector_short_prdt",
-                   test_bmdma_one_sector_short_prdt);
-    qtest_add_func("/ide/bmdma/long_prdt", test_bmdma_long_prdt);
+    qtest_add_func("/ide/bmdma/various_prdts", test_bmdma_various_prdts);
     qtest_add_func("/ide/bmdma/no_busmaster", test_bmdma_no_busmaster);
=20
     qtest_add_func("/ide/flush", test_flush);
--=20
2.21.0


