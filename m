Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E443C4CECC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E941214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4Z+eJqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E941214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8UA-00031u-HF
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1jT8RE-0005KM-Qe
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1jT8RC-0003dM-P6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:25:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1jT8RC-0003cw-CF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588011901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rjwKrRbF7TqI4JpiMawhHYLnga2FlH1hW5QJFIstEA=;
 b=C4Z+eJqq/3qLIjMpbK70p6U1MtIFycXtuSA9vkR8AEt+pWUYpexSBqcoleHLpEGtCqz1AT
 d7K1DCoS/RRw0uHjoU94rGjjzTU8Fl6hZEELgjDmNRZGw2Aow3x3LGSDlpKsCWrTqBTFAh
 cjiMtx2YxG0K6XCMuUakHUMg9+cCEbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-jn5-_37CNAaX3sesXe-ksA-1; Mon, 27 Apr 2020 14:24:59 -0400
X-MC-Unique: jn5-_37CNAaX3sesXe-ksA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B248F107ACCA;
 Mon, 27 Apr 2020 18:24:58 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 335F360BE2;
 Mon, 27 Apr 2020 18:24:56 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/pci/pcie: Forbid hot-plug if it's disabled on the
 slot
Date: Mon, 27 Apr 2020 20:24:39 +0200
Message-Id: <20200427182440.92433-2-jusual@redhat.com>
In-Reply-To: <20200427182440.92433-1-jusual@redhat.com>
References: <20200427182440.92433-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jusual@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Raise an error when trying to hot-plug/unplug a device through QMP to a dev=
ice
with disabled hot-plug capability. This makes the device behaviour more
consistent and provides an explanation of the failure in the case of
asynchronous unplug.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
v2:
    * Change error text [Igor, Michael]
    * Move cleanup to a separate patch [Marcel]

 hw/pci/pcie.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 0eb3a2a5d2..6b48d04d2c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -415,6 +415,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev,=
 DeviceState *dev,
 {
     PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplug_dev);
     uint8_t *exp_cap =3D hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
+    uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP);
     PCIDevice *pci_dev =3D PCI_DEVICE(dev);
=20
     /* Don't send event when device is enabled during qemu machine creatio=
n:
@@ -430,6 +431,13 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev=
, DeviceState *dev,
         return;
     }
=20
+    /* Check if hot-plug is disabled on the slot */
+    if ((sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
+        error_setg(errp, "Hot-plug failed: unsupported by the port device =
'%s'",
+                         DEVICE(hotplug_pdev)->id);
+        return;
+    }
+
     /* To enable multifunction hot-plug, we just ensure the function
      * 0 added last. When function 0 is added, we set the sltsta and
      * inform OS via event notification.
@@ -470,6 +478,17 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *h=
otplug_dev,
     Error *local_err =3D NULL;
     PCIDevice *pci_dev =3D PCI_DEVICE(dev);
     PCIBus *bus =3D pci_get_bus(pci_dev);
+    PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplug_dev);
+    uint8_t *exp_cap =3D hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
+    uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP);
+
+    /* Check if hot-unplug is disabled on the slot */
+    if ((sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
+        error_setg(errp, "Hot-unplug failed: "
+                         "unsupported by the port device '%s'",
+                         DEVICE(hotplug_pdev)->id);
+        return;
+    }
=20
     pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err);
     if (local_err) {
--=20
2.25.3


