Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0428EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73A32088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOvkad21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73A32088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo15c-0004rv-20
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0uu-0001BI-FH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:38:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0uj-00027Y-1N
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592987868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moxIcxhQKMKHNWnIdujNq15Soj5Q8ysu1jeTjwZ31L0=;
 b=VOvkad21+QS38fU2k2d7yKxD/jcNxfc9D/rKWDmBRZTBaBGsUDJCb13yvEEMunkRgHfZtJ
 5V6pDYLhUlUU2iN0pmgV3zI6EhXQb3OLcoaFB63NiFI3UkXAm/G7w7ENp7tweeJ6+nm5qw
 pGUsXo2L71rg7XMugNANzSl3W67LqEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-P02zaspwO0uHWcv4BYAcSw-1; Wed, 24 Jun 2020 04:37:45 -0400
X-MC-Unique: P02zaspwO0uHWcv4BYAcSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8D8C8015F0;
 Wed, 24 Jun 2020 08:37:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 068201A835;
 Wed, 24 Jun 2020 08:37:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 802751138470; Wed, 24 Jun 2020 10:37:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/25] pci: Delete useless error_propagate()
Date: Wed, 24 Jun 2020 10:37:14 +0200
Message-Id: <20200624083737.3086768-3-armbru@redhat.com>
In-Reply-To: <20200624083737.3086768-1-armbru@redhat.com>
References: <20200624083737.3086768-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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
Cc: Jens Freimann <jfreimann@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Jens Freimann <jfreimann@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/pci/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b22dedc88c..de0fae10ab 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2123,7 +2123,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
             error_setg(errp, "failover primary device must be on "
                              "PCIExpress bus");
-            error_propagate(errp, local_err);
             pci_qdev_unrealize(DEVICE(pci_dev));
             return;
         }
@@ -2131,7 +2130,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         if (class_id != PCI_CLASS_NETWORK_ETHERNET) {
             error_setg(errp, "failover primary device is not an "
                              "Ethernet device");
-            error_propagate(errp, local_err);
             pci_qdev_unrealize(DEVICE(pci_dev));
             return;
         }
@@ -2141,7 +2139,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         } else {
             error_setg(errp, "failover: primary device must be in its own "
                               "PCI slot");
-            error_propagate(errp, local_err);
             pci_qdev_unrealize(DEVICE(pci_dev));
             return;
         }
-- 
2.26.2


