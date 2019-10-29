Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FC1CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F7F222C7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfNIRFTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F7F222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQ2O-0006Xr-JU
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 07:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iPQ0w-0005FK-5c
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iPQ0u-0002Lo-0p
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:50:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31995
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iPQ0t-0002LV-TE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572349815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1+Dj+oJ0W2gdUtrFcQu9e/PwdooobomOmASz0Vr4QI=;
 b=RfNIRFTU+xdtE/X0UehMEy6iHnZJjG7AAvpAtgwQvFJrU6ib8MsBBSmHiBDh+YNZ7YdF9G
 w3HeU1BaknOa8tNt4sq5QiOevuzQkz42MVLjZmA4qNYftJuWdDLZJzFDvSAu6PCjF3F5u+
 9sIUNEx6jn2Q2E22RwW3J2ZaXepWBig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-Vp5CA-o0MrG_mMsRlw1e-Q-1; Tue, 29 Oct 2019 07:50:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD8158017DD;
 Tue, 29 Oct 2019 11:50:10 +0000 (UTC)
Received: from localhost (ovpn-116-231.ams2.redhat.com [10.36.116.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F3985FCA6;
 Tue, 29 Oct 2019 11:49:58 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/11] pci: add option for net failover
Date: Tue, 29 Oct 2019 12:48:56 +0100
Message-Id: <20191029114905.6856-3-jfreimann@redhat.com>
In-Reply-To: <20191029114905.6856-1-jfreimann@redhat.com>
References: <20191029114905.6856-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Vp5CA-o0MrG_mMsRlw1e-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 jasowang@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
 armbru@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 pbonzini@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a failover_pair_id property to PCIDev which is
used to link the primary device in a failover pair (the PCI dev) to
a standby (a virtio-net-pci) device.

It only supports ethernet devices. Also currently it only supports
PCIe devices. The requirement for PCIe is because it doesn't support
other hotplug controllers at the moment. The failover functionality can
be added to other hotplug controllers like ACPI, SHCP,... later on.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/pci/pci.c         | 31 +++++++++++++++++++++++++++++++
 include/hw/pci/pci.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index aa05c2b9b2..824ab4ed7b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -75,6 +75,8 @@ static Property pci_props[] =3D {
                     QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
                     QEMU_PCIE_EXTCAP_INIT_BITNR, true),
+    DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
+                       failover_pair_id),
     DEFINE_PROP_END_OF_LIST()
 };
=20
@@ -2077,6 +2079,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error=
 **errp)
     ObjectClass *klass =3D OBJECT_CLASS(pc);
     Error *local_err =3D NULL;
     bool is_default_rom;
+    uint16_t class_id;
=20
     /* initialize cap_present for pci_is_express() and pci_config_size(),
      * Note that hybrid PCIs are not set automatically and need to manage
@@ -2101,6 +2104,34 @@ static void pci_qdev_realize(DeviceState *qdev, Erro=
r **errp)
         }
     }
=20
+    if (pci_dev->failover_pair_id) {
+        if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
+            error_setg(errp, "failover primary device must be on "
+                             "PCIExpress bus");
+            error_propagate(errp, local_err);
+            pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+            return;
+        }
+        class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
+        if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
+            error_setg(errp, "failover primary device is not an "
+                             "Ethernet device");
+            error_propagate(errp, local_err);
+            pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+            return;
+        }
+        if (!(pci_dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION)
+            && (PCI_FUNC(pci_dev->devfn) =3D=3D 0)) {
+            qdev->allow_unplug_during_migration =3D true;
+        } else {
+            error_setg(errp, "failover: primary device must be in its own =
"
+                              "PCI slot");
+            error_propagate(errp, local_err);
+            pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+            return;
+        }
+    }
+
     /* rom loading */
     is_default_rom =3D false;
     if (pci_dev->romfile =3D=3D NULL && pc->romfile !=3D NULL) {
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f3f0ffd5fb..69d1f0228b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -352,6 +352,9 @@ struct PCIDevice {
     MSIVectorUseNotifier msix_vector_use_notifier;
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
+
+    /* ID of standby device in net_failover pair */
+    char *failover_pair_id;
 };
=20
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
--=20
2.21.0


