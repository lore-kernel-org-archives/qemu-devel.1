Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A83206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTGyiXyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A83206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoD4-0000VJ-Gr
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgoBr-00084a-3R
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:37:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgoBq-0003tU-BS
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591270661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GSS6k2OA8nkX1cHM024kmAM0soiqgUq2GQ6ckOLu0II=;
 b=QTGyiXyvYBRyXawaew2h4SYXjv+uqoOh8FQfvIETtFCa+z5H3h5gO2ZEI37U9GoOFD+qKE
 hKi6toXLlh11JX98Dpzu/yPA2BrGWCX5S6PHr11ZGWHGs4roRtAUy+F0pT8NIW13h3pXQM
 RCiK+tf+lkY2JvTSPX3RVPgqmZzvEwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-DRLbzgpzNwWxei_lLG8EEQ-1; Thu, 04 Jun 2020 07:37:37 -0400
X-MC-Unique: DRLbzgpzNwWxei_lLG8EEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68F1B1005510;
 Thu,  4 Jun 2020 11:37:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-200.sin2.redhat.com
 [10.67.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B361060C47;
 Thu,  4 Jun 2020 11:37:27 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] pci: assert configuration access is within bounds
Date: Thu,  4 Jun 2020 17:05:25 +0530
Message-Id: <20200604113525.58898-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While accessing PCI configuration bytes, assert that
'address + len' is within PCI configuration space.

Generally it is within bounds. This is more of a defensive
assert, in case a buggy device was to send 'address' which
may go out of bounds.

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

Update v1: defensive assert as separate patch
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00957.html
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00960.html

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 70c66965f5..7bf2ae6d92 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1381,6 +1381,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
 {
     uint32_t val = 0;
 
+    assert(address + len <= pci_config_size(d));
+
     if (pci_is_express_downstream_port(d) &&
         ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA, 2)) {
         pcie_sync_bridge_lnk(d);
@@ -1394,6 +1396,8 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
     int i, was_irq_disabled = pci_irq_disabled(d);
     uint32_t val = val_in;
 
+    assert(addr + l <= pci_config_size(d));
+
     for (i = 0; i < l; val >>= 8, ++i) {
         uint8_t wmask = d->wmask[addr + i];
         uint8_t w1cmask = d->w1cmask[addr + i];
-- 
2.26.2


