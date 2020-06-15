Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE3220707
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpY3ILIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE3220707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwe3-0005sU-F1
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvug-0003aQ-VJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:41:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34532
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvua-0000hX-28
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrvfWx83UsBfJ7c/RdnrGTuCzY0mtNPg669bRVttTU4=;
 b=dpY3ILIbVdS3AhgNk+oGqqrduB9REBzjg/M3afrHnznr5yi31jckrJAIwadwlmYUdRyKt6
 T9ypLqBQX8YTDhLCcImFymCWebKmoODdLJ2hQ5FuIE/XNdPdEIVubA08nMO6ZAy0OE4rj8
 PMOA0ajC60XI3zhBOieJqC8jvf9bPMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-odmh5d0lNhmqhkZpNJF6Ig-1; Mon, 15 Jun 2020 16:40:42 -0400
X-MC-Unique: odmh5d0lNhmqhkZpNJF6Ig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CFA0803308;
 Mon, 15 Jun 2020 20:40:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F2BD19C79;
 Mon, 15 Jun 2020 20:40:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B80911132FDD; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/84] pci: pci_create(),
 pci_create_multifunction() are now unused, drop
Date: Mon, 15 Jun 2020 22:39:27 +0200
Message-Id: <20200615204008.3069956-44-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:04
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

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200610053247.1583243-18-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
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
index 24f726d4cd..b22dedc88c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2184,17 +2184,6 @@ bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp)
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
@@ -2204,11 +2193,6 @@ PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
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


