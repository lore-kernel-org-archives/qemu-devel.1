Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA176C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE4620801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2apd/nZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE4620801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictky-00080E-I9
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ictf0-0002W3-JK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ictez-0007aA-6x
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ictez-0007Vg-0v
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575562040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzY2+flel7cUoD+n9jLwtG3t65kY9BOAOghRyMPnfis=;
 b=g2apd/nZUHqB12qgPvfXKPK8QiazRIV6Le7hKpgJxVUVHHYB2YCsCjAya5DIdf2o7+K8gl
 hRurxD4y4Nn4zHsIu+CqKU6TV//RvgRQ1zmqRmzfqyvV6QBzyDThH9uOgcJigXfPqWg35N
 5EBh2va081lUUrGoXDZv32h3s4aXjHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-aHDn-LFfMHqqhi2Xq7BbKQ-1; Thu, 05 Dec 2019 11:07:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3391DBF0;
 Thu,  5 Dec 2019 16:07:15 +0000 (UTC)
Received: from thuth.com (ovpn-116-87.ams2.redhat.com [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7BD6691BF;
 Thu,  5 Dec 2019 16:07:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] hw/pci: Remove the "command_serr_enable" property
Date: Thu,  5 Dec 2019 17:06:52 +0100
Message-Id: <20191205160652.23493-4-thuth@redhat.com>
In-Reply-To: <20191205160652.23493-1-thuth@redhat.com>
References: <20191205160652.23493-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: aHDn-LFfMHqqhi2Xq7BbKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the old pc-0.x machine types have been removed, this config
knob is not required anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/pci/pci.c         | 6 +-----
 include/hw/pci/pci.h | 3 ---
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cbc7a32568..e3d310365d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -69,8 +69,6 @@ static Property pci_props[] =3D {
     DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
-    DEFINE_PROP_BIT("command_serr_enable", PCIDevice, cap_present,
-                    QEMU_PCI_CAP_SERR_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
                     QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
@@ -751,9 +749,7 @@ static void pci_init_wmask(PCIDevice *dev)
     pci_set_word(dev->wmask + PCI_COMMAND,
                  PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER =
|
                  PCI_COMMAND_INTX_DISABLE);
-    if (dev->cap_present & QEMU_PCI_CAP_SERR) {
-        pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_S=
ERR);
-    }
+    pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR)=
;
=20
     memset(dev->wmask + PCI_CONFIG_HEADER_SIZE, 0xff,
            config_size - PCI_CONFIG_HEADER_SIZE);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index db75c6dfd0..5b6ebd15c6 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -174,9 +174,6 @@ enum {
 #define QEMU_PCI_CAP_MULTIFUNCTION_BITNR        3
     QEMU_PCI_CAP_MULTIFUNCTION =3D (1 << QEMU_PCI_CAP_MULTIFUNCTION_BITNR)=
,
=20
-    /* command register SERR bit enabled */
-#define QEMU_PCI_CAP_SERR_BITNR 4
-    QEMU_PCI_CAP_SERR =3D (1 << QEMU_PCI_CAP_SERR_BITNR),
     /* Standard hot plug controller. */
 #define QEMU_PCI_SHPC_BITNR 5
     QEMU_PCI_CAP_SHPC =3D (1 << QEMU_PCI_SHPC_BITNR),
--=20
2.18.1


