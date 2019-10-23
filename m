Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B707CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3779C2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdDQCWAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3779C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNCBm-0001DP-Cn
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNBze-0002vF-DN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNBzc-0005vZ-6j
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60226
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNBzc-0005sN-1p
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571819262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kprYC2KPvV+4Y2xOO3jQb8weHZrVvaPaWMGwzcgV3KU=;
 b=fdDQCWAXbzKXU3sibKljPKgVpmx1lpIXC9+sEu3KuEHt+ASoz5iO2m3U0prBwqqljG7IeR
 R8a6ys77FTcjPcwnz+lozbJCb/5jTprU6Zo3Qim9W76yFtRlM7MLo/rmb3tDIOB/843zBu
 9ihuNvigb1dBHhy3bRF8zLozQiyzVsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-W5o8t1UWMzueesezgljQrA-1; Wed, 23 Oct 2019 04:27:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C7441005509;
 Wed, 23 Oct 2019 08:27:38 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 097205D6C8;
 Wed, 23 Oct 2019 08:27:30 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/11] pci: add option for net failover
Date: Wed, 23 Oct 2019 10:27:02 +0200
Message-Id: <20191023082711.16694-3-jfreimann@redhat.com>
In-Reply-To: <20191023082711.16694-1-jfreimann@redhat.com>
References: <20191023082711.16694-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: W5o8t1UWMzueesezgljQrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
@@ -2077,6 +2079,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error=
 **errp)
     ObjectClass *klass =3D OBJECT_CLASS(pc);
     Error *local_err =3D NULL;
     bool is_default_rom;
+    uint16_t class_id;
=20
     /* initialize cap_present for pci_is_express() and pci_config_size(),
      * Note that hybrid PCIs are not set automatically and need to manage
@@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState *qdev, Erro=
r **errp)
         }
     }
=20
+    if (pci_dev->net_failover_pair_id) {
+        if (!pci_is_express(pci_dev)) {
+            error_setg(errp, "failover device is not a PCIExpress device")=
;
+            error_propagate(errp, local_err);
+            return;
+        }
+        class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
+        if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
+            error_setg(errp, "failover device is not an Ethernet device");
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


