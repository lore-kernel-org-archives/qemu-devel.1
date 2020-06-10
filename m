Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7920C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0AD2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhjMuyRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0AD2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jithh-0004wZ-Qw
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMP-0005FR-Lf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMC-0003r0-MJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okxGBk8PlN7HrILM599B1hF2I8fEO6HkadHoEsxHfC8=;
 b=BhjMuyRBhU5H2PgAXKOAL1d4vLOo3iLEeycBfhcCBXWTLg5StaUU18eWZnQiHfCy2Q9aev
 d0XTQeKLJNKQiaS8KfBLaSotBgvLJbxZdrhBTnI+htKJOuzu/WwPKrBA05s20GpgX095sC
 wd7cH4N3v1LxlB3vmWvQCkp+NSQgNbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-GYgmGM6oPuu_BT4C8J-cBQ-1; Wed, 10 Jun 2020 01:32:57 -0400
X-MC-Unique: GYgmGM6oPuu_BT4C8J-cBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32A1D107ACF6;
 Wed, 10 Jun 2020 05:32:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6540C5C1D2;
 Wed, 10 Jun 2020 05:32:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB6831138462; Wed, 10 Jun 2020 07:32:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 13/58] pci: New pci_new(),
 pci_realize_and_unref() etc.
Date: Wed, 10 Jun 2020 07:32:02 +0200
Message-Id: <20200610053247.1583243-14-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

I'm converting from qdev_create()/qdev_init_nofail() to
qdev_new()/qdev_realize_and_unref(); recent commit "qdev: New
qdev_new(), qdev_realize(), etc." explains why.

PCI devices use qdev_create() through pci_create() and
pci_create_multifunction().

Provide pci_new(), pci_new_multifunction(), and
pci_realize_and_unref() for converting PCI devices.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/pci/pci.h |  5 +++++
 hw/pci/pci.c         | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cfedf5a995..66f8ba519b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -712,6 +712,11 @@ pci_get_quad_by_mask(uint8_t *config, uint64_t mask)
     return (val & mask) >> ctz32(mask);
 }
 
+PCIDevice *pci_new_multifunction(int devfn, bool multifunction,
+                                    const char *name);
+PCIDevice *pci_new(int devfn, const char *name);
+bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp);
+
 PCIDevice *pci_create_multifunction(PCIBus *bus, int devfn, bool multifunction,
                                     const char *name);
 PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6947c741c3..92f3f0f134 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2147,6 +2147,27 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     }
 }
 
+PCIDevice *pci_new_multifunction(int devfn, bool multifunction,
+                                 const char *name)
+{
+    DeviceState *dev;
+
+    dev = qdev_new(name);
+    qdev_prop_set_int32(dev, "addr", devfn);
+    qdev_prop_set_bit(dev, "multifunction", multifunction);
+    return PCI_DEVICE(dev);
+}
+
+PCIDevice *pci_new(int devfn, const char *name)
+{
+    return pci_new_multifunction(devfn, false, name);
+}
+
+bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp)
+{
+    return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
+}
+
 PCIDevice *pci_create_multifunction(PCIBus *bus, int devfn, bool multifunction,
                                     const char *name)
 {
-- 
2.26.2


