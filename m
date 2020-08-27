Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FFC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE772177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUXfIVhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE772177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGRu-0005iK-3F
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGRJ-00051E-Ix
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:51:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25681
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kBGRH-0007er-MT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598529090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=46KKeElKytQtSQA9C/Uds87savpatq7iUTshn3CYY1E=;
 b=GUXfIVhLfuRJxtXjGXsT2K2sbi+OKNaNU0QbpzyuTAn2/ZkKzn3hDrp7Vm9quFOHlnnCQV
 k2YZoJPHWtd7FRO0qhiM2ydmSgrAPMrkV5UXwSHpRcDg8BjdgdSp5i8fimnybezCxOaYtH
 EzYurDTyIQNxepyZZukFcWHgwfo4gE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-4yU6pdguNtOX5EkjHbqs2Q-1; Thu, 27 Aug 2020 07:51:26 -0400
X-MC-Unique: 4yU6pdguNtOX5EkjHbqs2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C41C10055B6;
 Thu, 27 Aug 2020 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-91.phx2.redhat.com
 [10.3.112.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00B3F1002D48;
 Thu, 27 Aug 2020 11:51:19 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] pci: check bus pointer before dereference
Date: Thu, 27 Aug 2020 17:19:17 +0530
Message-Id: <20200827114917.1851111-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While mapping IRQ level in pci_change_irq_level() routine,
it does not check if pci_get_bus() returned a valid pointer.
It may lead to a NULL pointer dereference issue. Add check to
avoid it.

 -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Flsi_nullptr1
    ==1183858==Hint: address points to the zero page.
    #0 pci_change_irq_level hw/pci/pci.c:259
    #1 pci_irq_handler hw/pci/pci.c:1445
    #2 pci_set_irq hw/pci/pci.c:1463
    #3 lsi_set_irq hw/scsi/lsi53c895a.c:488
    #4 lsi_update_irq hw/scsi/lsi53c895a.c:523
    #5 lsi_script_scsi_interrupt hw/scsi/lsi53c895a.c:554
    #6 lsi_execute_script hw/scsi/lsi53c895a.c:1149
    #7 lsi_reg_writeb hw/scsi/lsi53c895a.c:1984
    #8 lsi_io_write hw/scsi/lsi53c895a.c:2146
    ...

Reported-by: Ruhr-University <bugs-syssec@rub.de>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index de0fae10ab..df5a2c3294 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -253,6 +253,9 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
     PCIBus *bus;
     for (;;) {
         bus = pci_get_bus(pci_dev);
+        if (!bus) {
+            return;
+        }
         irq_num = bus->map_irq(pci_dev, irq_num);
         if (bus->set_irq)
             break;
-- 
2.26.2


