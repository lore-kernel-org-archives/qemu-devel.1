Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E15C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165F9204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165F9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htZAN-0001kJ-DQ
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 11:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47272)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jfreimann@redhat.com>) id 1htZ8u-0006Ff-0m
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1htZ8s-0005US-Om
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1htZ8s-0005UD-Jl
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:06:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC7F5307D88C
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 15:06:49 +0000 (UTC)
Received: from localhost (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D4EC5D9D3;
 Fri,  2 Aug 2019 15:06:49 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 17:06:04 +0200
Message-Id: <20190802150605.5880-9-jfreimann@redhat.com>
In-Reply-To: <20190802150605.5880-1-jfreimann@redhat.com>
References: <20190802150605.5880-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 15:06:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 8/9] pci: mark devices partially unplugged
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, laine@redhat.com, ailan@redhat.com
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
index 8076a80ab3..935127a98f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2074,6 +2074,8 @@ static void pci_qdev_realize(DeviceState *qdev, Err=
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
index aaf1b9f70d..e0b82d3ad4 100644
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


