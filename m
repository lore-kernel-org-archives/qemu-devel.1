Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B87C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E132075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9jqjTRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E132075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAegh-0004Ea-11
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeW4-0007dc-03
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43798
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeW2-000681-9I
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6iKnWRukpvH6LdbmGN3rygOQcrKCO0sLfh/NcHM/98=;
 b=f9jqjTRRneuQFnmg1ktgJLxZ/UIR/WNhNKt9NqlcccOeU2yO7A8QTwfhn7WU7n7/xfY+SF
 IwHRmsLSDBloIFnnQvnAvd0kt8SGwyblsXuLSwcw7Oqa16Q4ZtFw1OnAfiJGy3r3WWgH4i
 XU8mjiUzknwN2ygICPCKRZ1sp3Omzg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-SxYYPvgENmuWclFEftoG3w-1; Tue, 25 Aug 2020 15:21:51 -0400
X-MC-Unique: SxYYPvgENmuWclFEftoG3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A3681CAF9;
 Tue, 25 Aug 2020 19:21:49 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2B9B18B59;
 Tue, 25 Aug 2020 19:21:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/74] pci: Move PCIBusClass typedef to pci.h
Date: Tue, 25 Aug 2020 15:20:13 -0400
Message-Id: <20200825192110.3528606-18-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 15:21:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move typedef closer to the type check macros, to make it easier
to convert the code to OBJECT_DEFINE_TYPE() in the future.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes v1 -> v2: none

---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/pci/pci.h     | 1 +
 include/hw/pci/pci_bus.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c1bf7d5356..4ca7258b5b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -396,6 +396,7 @@ typedef int (*pci_map_irq_fn)(PCIDevice *pci_dev, int irq_num);
 typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
 
 #define TYPE_PCI_BUS "PCI"
+typedef struct PCIBusClass PCIBusClass;
 #define PCI_BUS(obj) OBJECT_CHECK(PCIBus, (obj), TYPE_PCI_BUS)
 #define PCI_BUS_CLASS(klass) OBJECT_CLASS_CHECK(PCIBusClass, (klass), TYPE_PCI_BUS)
 #define PCI_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(PCIBusClass, (obj), TYPE_PCI_BUS)
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 0714f578af..347440d42c 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -10,14 +10,14 @@
  * use accessor functions in pci.h
  */
 
-typedef struct PCIBusClass {
+struct PCIBusClass {
     /*< private >*/
     BusClass parent_class;
     /*< public >*/
 
     int (*bus_num)(PCIBus *bus);
     uint16_t (*numa_node)(PCIBus *bus);
-} PCIBusClass;
+};
 
 enum PCIBusFlags {
     /* This bus is the root of a PCI domain */
-- 
2.26.2


