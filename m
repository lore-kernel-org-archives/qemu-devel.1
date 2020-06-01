Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AFFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 05:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A772074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 05:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8cQZhx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A772074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfcpg-00033i-Gq
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 01:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jfcp6-0002Ts-Kx
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 01:17:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47665
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jfcp5-0005GQ-3q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 01:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590988637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oCiNvpJiTfcWHSHEFdz0CVcYmxnGRQLzbV5Jbd7xZBY=;
 b=N8cQZhx8+GZKanYz5r6gDVItGHCO/j1idwN4OCW34sPMYAwR5HshRGnkxo9QTMUE/+3/Cs
 MVnRBZ2ZhOJyUIri3lBiVPPMdAFdLcCSVYFiAqTM9twP8kYSusLn5vdzhnhld1Eon/4wWG
 xw0upZHe0P5dhMtWWgY0ZZRlTpPsVkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-pWdFGdV1OLy1RCc7FkE32A-1; Mon, 01 Jun 2020 01:17:14 -0400
X-MC-Unique: pWdFGdV1OLy1RCc7FkE32A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7276A107B7C5;
 Mon,  1 Jun 2020 05:17:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-190.sin2.redhat.com
 [10.67.116.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 087C419C4F;
 Mon,  1 Jun 2020 05:17:01 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] msix: add valid.accepts methods to check address
Date: Mon,  1 Jun 2020 10:44:54 +0530
Message-Id: <20200601051454.826415-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 23:56:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, Ren Ding <rding@gatech.edu>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While doing msi-x mmio operations, a guest may send an address
that leads to an OOB access issue. Add valid.accepts methods to
ensure that ensuing mmio r/w operation don't go beyond regions.

Reported-by: Ren Ding <rding@gatech.edu>
Reported-by: Hanqing Zhao <hanqing@gatech.edu>
Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/pci/msix.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 29187898f2..d90d66a3b8 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -193,6 +193,15 @@ static void msix_table_mmio_write(void *opaque, hwaddr addr,
     msix_handle_mask_update(dev, vector, was_masked);
 }
 
+static bool msix_table_accepts(void *opaque, hwaddr addr, unsigned size,
+                                    bool is_write, MemTxAttrs attrs)
+{
+    PCIDevice *dev = opaque;
+    uint16_t tbl_size = dev->msix_entries_nr * PCI_MSIX_ENTRY_SIZE;
+
+    return dev->msix_table + addr + 4 <= dev->msix_table + tbl_size;
+}
+
 static const MemoryRegionOps msix_table_mmio_ops = {
     .read = msix_table_mmio_read,
     .write = msix_table_mmio_write,
@@ -200,6 +209,7 @@ static const MemoryRegionOps msix_table_mmio_ops = {
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
+        .accepts = msix_table_accepts
     },
 };
 
@@ -221,6 +231,15 @@ static void msix_pba_mmio_write(void *opaque, hwaddr addr,
 {
 }
 
+static bool msix_pba_accepts(void *opaque, hwaddr addr, unsigned size,
+                                    bool is_write, MemTxAttrs attrs)
+{
+    PCIDevice *dev = opaque;
+    uint16_t pba_size = QEMU_ALIGN_UP(dev->msix_entries_nr, 64) / 8;
+
+    return dev->msix_pba + addr + 4 <= dev->msix_pba + pba_size;
+}
+
 static const MemoryRegionOps msix_pba_mmio_ops = {
     .read = msix_pba_mmio_read,
     .write = msix_pba_mmio_write,
@@ -228,6 +247,7 @@ static const MemoryRegionOps msix_pba_mmio_ops = {
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
+        .accepts = msix_pba_accepts
     },
 };
 
-- 
2.26.2


