Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 20:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F42820734
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 20:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXThjarU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F42820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgZyB-0005fY-RK
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 16:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgZx4-0004dt-F0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 16:25:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgZx3-0000qI-G6
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 16:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591215928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iL+BFziTjgxkTLHJcTsnhCxr1fg4pJ4mFQ4EP9xvyzk=;
 b=HXThjarU1qeteNcuWBQPY6auT4CdDNfIqYWsnzoiC9elkslJ9Ut4VPU0uOEMNJ6pM9KZdx
 J/oMUEHE2/K6rmiIFUyrEFXb+QQCSxRMPqE3FbwBeeRic0pIgVjRMOKUWvTDRWWOByVbDI
 I3PfhOq0qFmK/TGgjbm2uBhMH41g9JM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-0X2t5JdaOByNjsCFvJKwvQ-1; Wed, 03 Jun 2020 16:25:25 -0400
X-MC-Unique: 0X2t5JdaOByNjsCFvJKwvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C29B9800685;
 Wed,  3 Jun 2020 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12B675C3E7;
 Wed,  3 Jun 2020 20:25:14 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 2/2] pci: ensure configuration access is within bounds
Date: Thu,  4 Jun 2020 01:52:51 +0530
Message-Id: <20200603202251.1199170-3-ppandit@redhat.com>
In-Reply-To: <20200603202251.1199170-1-ppandit@redhat.com>
References: <20200603202251.1199170-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:35
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While reading PCI configuration bytes, a guest may send an
address towards the end of the configuration space. It may lead
to an OOB access issue. Assert that 'address + len' is within
PCI configuration space.

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

Update v2: assert PCI configuration access is within bounds
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00711.html

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 70c66965f5..173bec4fd5 100644
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
-- 
2.26.2


