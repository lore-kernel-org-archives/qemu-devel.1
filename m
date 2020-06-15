Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1725FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCEF2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHyG5oCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCEF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkw9V-0002UC-UW
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 16:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuU-0003K2-Ck
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuP-0000bB-6Y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Bnkp7AdoFSFRITeS3mze8v2TxIwBQ3KEpMKWVqht5w=;
 b=hHyG5oCk7RE0zLIpCrX+6buXpn1PwRzZNt61WnGdkNQmObaOZYE2PbCQgQhDpkwernv7um
 6ChJdgWvMRRs9cUhyjOXmrYWD4zRKTNaZnlHof7Kl46p4sBXqTnpx9f5MxOQkqH4NfW0hN
 C7EEwAbNJtr3A6DbuknchIYk2TNeBIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-UDxMOdV2NsSVWzBOkm7zwA-1; Mon, 15 Jun 2020 16:40:42 -0400
X-MC-Unique: UDxMOdV2NsSVWzBOkm7zwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CC4A100CCCD;
 Mon, 15 Jun 2020 20:40:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 237789034B;
 Mon, 15 Jun 2020 20:40:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B49B31132FDA; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/84] pci: Convert uses of pci_create() etc. manually
Date: Mon, 15 Jun 2020 22:39:26 +0200
Message-Id: <20200615204008.3069956-43-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:00
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Same transformation as in the previous commit.  Manual, because
convincing Coccinelle to transform these cases is not worthwhile.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200610053247.1583243-17-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/sparc64/sun4u.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 6f29a013ca..0b898d6e3d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -635,24 +635,28 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     memset(&macaddr, 0, sizeof(MACAddr));
     onboard_nic = false;
     for (i = 0; i < nb_nics; i++) {
+        PCIBus *bus;
         nd = &nd_table[i];
 
         if (!nd->model || strcmp(nd->model, "sunhme") == 0) {
             if (!onboard_nic) {
-                pci_dev = pci_create_multifunction(pci_busA, PCI_DEVFN(1, 1),
+                pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1),
                                                    true, "sunhme");
+                bus = pci_busA;
                 memcpy(&macaddr, &nd->macaddr.a, sizeof(MACAddr));
                 onboard_nic = true;
             } else {
-                pci_dev = pci_create(pci_busB, -1, "sunhme");
+                pci_dev = pci_new(-1, "sunhme");
+                bus = pci_busB;
             }
         } else {
-            pci_dev = pci_create(pci_busB, -1, nd->model);
+            pci_dev = pci_new(-1, nd->model);
+            bus = pci_busB;
         }
 
         dev = &pci_dev->qdev;
         qdev_set_nic_properties(dev, nd);
-        qdev_init_nofail(dev);
+        pci_realize_and_unref(pci_dev, bus, &error_fatal);
     }
 
     /* If we don't have an onboard NIC, grab a default MAC address so that
-- 
2.26.2


