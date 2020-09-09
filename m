Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251FBC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50F62087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYLuXWdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50F62087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvLe-0005zM-29
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFvIZ-0001p7-Qh
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFvIY-0003ls-52
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599639465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O9KyATISiZGeakA/smiHhII0pXyg7vLMCyRzJUo4cZU=;
 b=PYLuXWdWBid9N2hB+YtihcAUy7PQfVgpeWuOK2D57gFFAyhyybPZycJuekkE6QdlIHPR0l
 Eepkl8XaIsxzxvNuya/zggRr83dQemBxPhPCEclS34AleSp6eaC8vIrg6bWq13rnwH56ry
 psaHjJ97O8D/rjQKXWEoOkh1mnVXXx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-7wv1Re7-OM-6mmDmAqSFvw-1; Wed, 09 Sep 2020 04:17:43 -0400
X-MC-Unique: 7wv1Re7-OM-6mmDmAqSFvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B12E0800400;
 Wed,  9 Sep 2020 08:17:42 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F5981002D54;
 Wed,  9 Sep 2020 08:17:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH] pci: advertise a page aligned ATS
Date: Wed,  9 Sep 2020 16:17:31 +0800
Message-Id: <20200909081731.24688-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: eperezma@redhat.com, Jason Wang <jasowang@redhat.com>,
 qemu-stable@nongnu.org, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After Linux kernel commit 61363c1474b1 ("iommu/vt-d: Enable ATS only
if the device uses page aligned address."), ATS will be only enabled
if device advertises a page aligned request.

Unfortunately, vhost-net is the only user and we don't advertise the
aligned request capability in the past since both vhost IOTLB and
address_space_get_iotlb_entry() can support non page aligned request.

Though it's not clear that if the above kernel commit makes
sense. Let's advertise a page aligned ATS here to make vhost device
IOTLB work with Intel IOMMU again.

Note that in the future we may extend pcie_ats_init() to accept
parameters like queue depth and page alignment.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/pci/pcie.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 5b48bae0f6..d4010cf8f3 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -971,8 +971,9 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
 
     dev->exp.ats_cap = offset;
 
-    /* Invalidate Queue Depth 0, Page Aligned Request 0 */
-    pci_set_word(dev->config + offset + PCI_ATS_CAP, 0);
+    /* Invalidate Queue Depth 0, Page Aligned Request 1 */
+    pci_set_word(dev->config + offset + PCI_ATS_CAP,
+                 PCI_ATS_CAP_PAGE_ALIGNED);
     /* STU 0, Disabled by default */
     pci_set_word(dev->config + offset + PCI_ATS_CTRL, 0);
 
-- 
2.20.1


