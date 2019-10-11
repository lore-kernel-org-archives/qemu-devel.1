Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51172ECE58E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A48D214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A48D214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIszg-0007Lz-3W
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 07:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iIsyS-00068G-0X
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iIsyR-0001f3-1i
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:20:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iIsyQ-0001ev-SZ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:20:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26BFA316E535;
 Fri, 11 Oct 2019 11:20:42 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C861A60A9F;
 Fri, 11 Oct 2019 11:20:36 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/10] pci: mark devices partially unplugged
Date: Fri, 11 Oct 2019 13:20:07 +0200
Message-Id: <20191011112015.11785-3-jfreimann@redhat.com>
In-Reply-To: <20191011112015.11785-1-jfreimann@redhat.com>
References: <20191011112015.11785-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 11 Oct 2019 11:20:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: parav@mellanox.com, mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only the guest unplug request was triggered. This is needed for
the failover feature. In case of a failed migration we need to
plug the device back to the guest.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/pci/pci.c         | 2 ++
 hw/pci/pcie.c        | 3 +++
 include/hw/pci/pci.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index aa05c2b9b2..c140b37765 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2078,6 +2078,8 @@ static void pci_qdev_realize(DeviceState *qdev, Err=
or **errp)
     Error *local_err =3D NULL;
     bool is_default_rom;
=20
+    pci_dev->partially_hotplugged =3D false;
+
     /* initialize cap_present for pci_is_express() and pci_config_size()=
,
      * Note that hybrid PCIs are not set automatically and need to manag=
e
      * QEMU_PCI_CAP_EXPRESS manually */
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index a6beb567bd..19363ff8ce 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -456,6 +456,9 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice=
 *dev, void *opaque)
 {
     HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(DEVICE(dev=
));
=20
+    if (dev->partially_hotplugged) {
+        return;
+    }
     hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
     object_unparent(OBJECT(dev));
 }
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f3f0ffd5fb..f3a39c9bbd 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -265,6 +265,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
=20
 struct PCIDevice {
     DeviceState qdev;
+    bool partially_hotplugged;
=20
     /* PCI config space */
     uint8_t *config;
--=20
2.21.0


