Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD2FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCEF20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XknF5j3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCEF20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihl6-0006jk-2i
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihI5-0004SU-KN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHw-0003EF-Li
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UObykoq9TV3iiisuu0TD//n6coWTSPzTVvQxciC7ek=;
 b=XknF5j3+1j4Qu1Cj0ixHjDz939l0cYHJTbsA4gjB3EM0SjuAnYBDk8PrAk3EFZT+gf3/hW
 CHQ0KbCMQn7SCBC8ZFaO1gB5abHitpM8RNjXmYs/zEqMWzh0/w7rzMdBG5XASHKCR87WJq
 B2nB8P2sMlwygOMsHtc0MkN2sVhLSa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-Ur8yocBjOtavTst8MTDe3g-1; Tue, 09 Jun 2020 12:39:41 -0400
X-MC-Unique: Ur8yocBjOtavTst8MTDe3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05CB78015CE;
 Tue,  9 Jun 2020 16:39:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C15819D61;
 Tue,  9 Jun 2020 16:39:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C0E471138466; Tue,  9 Jun 2020 18:39:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/39] pci: pci_create(),
 pci_create_multifunction() are now unused, drop
Date: Tue,  9 Jun 2020 18:39:10 +0200
Message-Id: <20200609163932.1566209-18-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/pci/pci.h |  3 ---
 hw/pci/pci.c         | 16 ----------------
 2 files changed, 19 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 66f8ba519b..a4e9c33416 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -717,12 +717,9 @@ PCIDevice *pci_new_multifunction(int devfn, bool multifunction,
 PCIDevice *pci_new(int devfn, const char *name);
 bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp);
 
-PCIDevice *pci_create_multifunction(PCIBus *bus, int devfn, bool multifunction,
-                                    const char *name);
 PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
                                            bool multifunction,
                                            const char *name);
-PCIDevice *pci_create(PCIBus *bus, int devfn, const char *name);
 PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
 
 void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ab8b71fe72..aaffbd7f94 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2168,17 +2168,6 @@ bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp)
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-PCIDevice *pci_create_multifunction(PCIBus *bus, int devfn, bool multifunction,
-                                    const char *name)
-{
-    DeviceState *dev;
-
-    dev = qdev_create(&bus->qbus, name);
-    qdev_prop_set_int32(dev, "addr", devfn);
-    qdev_prop_set_bit(dev, "multifunction", multifunction);
-    return PCI_DEVICE(dev);
-}
-
 PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
                                            bool multifunction,
                                            const char *name)
@@ -2188,11 +2177,6 @@ PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
     return dev;
 }
 
-PCIDevice *pci_create(PCIBus *bus, int devfn, const char *name)
-{
-    return pci_create_multifunction(bus, devfn, false, name);
-}
-
 PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
 {
     return pci_create_simple_multifunction(bus, devfn, false, name);
-- 
2.26.2


