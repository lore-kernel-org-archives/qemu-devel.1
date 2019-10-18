Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFEDCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E382082C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E382082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLYlc-0007DE-2i
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 16:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iLYkL-0005rW-O7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iLYkK-0005h6-I7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iLYkK-0005gu-Cs
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:21:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1ACA4E925;
 Fri, 18 Oct 2019 20:21:11 +0000 (UTC)
Received: from localhost (ovpn-116-92.ams2.redhat.com [10.36.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 318C35D9CA;
 Fri, 18 Oct 2019 20:21:02 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] pci: add option for net failover
Date: Fri, 18 Oct 2019 22:20:31 +0200
Message-Id: <20191018202040.30349-3-jfreimann@redhat.com>
In-Reply-To: <20191018202040.30349-1-jfreimann@redhat.com>
References: <20191018202040.30349-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 18 Oct 2019 20:21:11 +0000 (UTC)
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a net_failover_pair_id property to PCIDev which is
used to link the primary device in a failover pair (the PCI dev) to
a standby (a virtio-net-pci) device.

It only supports ethernet devices. Also currently it only supports
PCIe devices. QEMU will exit with an error message otherwise.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/pci/pci.c         | 17 +++++++++++++++++
 include/hw/pci/pci.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index aa05c2b9b2..fa9b5219f8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -75,6 +75,8 @@ static Property pci_props[] =3D {
                     QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
                     QEMU_PCIE_EXTCAP_INIT_BITNR, true),
+    DEFINE_PROP_STRING("net_failover_pair_id", PCIDevice,
+            net_failover_pair_id),
     DEFINE_PROP_END_OF_LIST()
 };
=20
@@ -2077,6 +2079,7 @@ static void pci_qdev_realize(DeviceState *qdev, Err=
or **errp)
     ObjectClass *klass =3D OBJECT_CLASS(pc);
     Error *local_err =3D NULL;
     bool is_default_rom;
+    uint16_t class_id;
=20
     /* initialize cap_present for pci_is_express() and pci_config_size()=
,
      * Note that hybrid PCIs are not set automatically and need to manag=
e
@@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState *qdev, Er=
ror **errp)
         }
     }
=20
+    if (pci_dev->net_failover_pair_id) {
+        if (!pci_is_express(pci_dev)) {
+            error_setg(errp, "failover device is not a PCIExpress device=
");
+            error_propagate(errp, local_err);
+            return;
+        }
+        class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
+        if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
+            error_setg(errp, "failover device is not an Ethernet device"=
);
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     /* rom loading */
     is_default_rom =3D false;
     if (pci_dev->romfile =3D=3D NULL && pc->romfile !=3D NULL) {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f3f0ffd5fb..def5435685 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -352,6 +352,9 @@ struct PCIDevice {
     MSIVectorUseNotifier msix_vector_use_notifier;
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
+
+    /* ID of standby device in net_failover pair */
+    char *net_failover_pair_id;
 };
=20
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
--=20
2.21.0


