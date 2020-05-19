Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AB320825
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9bwKlni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AB320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3o0-0003rn-JR
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f5-0001Mh-Uo
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60551
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f1-0003Vj-3S
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVoWTPaqL9+qnrwFOU/2iC3lMhqsOOIOIM9Lx0KhIo0=;
 b=E9bwKlniTP4Mgws4zwhNRjIRlV73BwZcXkE2JQLRIWDfvycK904HQzrCuQ520ExmE2VAST
 ZCYy1WhpIS7viHrniU4KZrrnmntykDpBBGAeDHtHE8A5f5gSyg7/N5HoZbsQzlxd/wG4Pd
 kkVSGo7reuONU5y0Y01cZzAPnHDWzAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-xMmeMShJOI2K24kr_pbuLQ-1; Tue, 19 May 2020 10:56:00 -0400
X-MC-Unique: xMmeMShJOI2K24kr_pbuLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D4AA1009628;
 Tue, 19 May 2020 14:55:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BE7B61980;
 Tue, 19 May 2020 14:55:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E972311358CD; Tue, 19 May 2020 16:55:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/55] pci: pci_create(),
 pci_create_multifunction() are now unused, drop
Date: Tue, 19 May 2020 16:55:12 +0200
Message-Id: <20200519145551.22836-17-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.21.1


