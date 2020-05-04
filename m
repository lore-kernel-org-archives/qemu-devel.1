Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19527C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63B020757
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa9W0n47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63B020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVc8j-0001Ti-Tl
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc5z-0004ZH-83
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc5y-0005nx-AR
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNQ9lS7EsKMnaq4ojaGLEYxIauihn/k1pWhlz/tga24=;
 b=aa9W0n47REg0q8OHy7sG+52xfRdz1Jq0Atyy2Zq/v+e91bvjwui1272olFLOg+/OBB4xAR
 f81/t2c9GCRVN8gLN6rfBlx6TJrE2WLsPbnPgjKR/WSML8zf+5KFBm8qj7VwWKHpCJYNnX
 +WIbI53cUAlzuAje+G8b09AbJtPoAI0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24--2tbKlS8NA-MkG3Gr7m4BA-1; Mon, 04 May 2020 10:29:19 -0400
X-MC-Unique: -2tbKlS8NA-MkG3Gr7m4BA-1
Received: by mail-wm1-f72.google.com with SMTP id o26so3595534wmh.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2TfSO6YI3NjUeMo8pj4D4ib48WZ7vfY2z5+JNtWiNow=;
 b=ijF4hmPGCeoJIAfYn9vZ/ZpCcWOnZ3pJPu9r0QKpUPvXuyJ+dKwh2tg6PzI8xQyLnC
 2ozMbVHJMGNBNF9StdXWM2MdVJVkrXNqf9O4y2g7Y7wJm2MA4/T84k3ARtXpEJHNagpw
 lgIBlXiOGt4UchVlOfvpSva28S0ijhau4f1eNd3/Su8McJkQHOo/5isG/cP8s48ztece
 Wpxvgyu3hEazQCvfDpfqeK2OoZX5bTno+6qF2vhmPSsyOIhgcpcEc2HZwrN+6R5yq+ck
 0uUKfV1nWjLmLm9/5l+hWgJla5YPe6JsP3f2pI9fEKM1HdKcVinrbS+m14ihM/gjUvwq
 s8Wg==
X-Gm-Message-State: AGi0PuaLC3YGcr+XHpPZG25bOTjuDT7X2PM+rm+QGKZRyX/3f6PVbnkb
 noA/l/WAMItm5sd/gemOFhqn8hQvC8sQGoi/zxx6PNQToPzqkF5tK42BKMnOPRn3Jm2KQ33soKs
 MxWDDqOAENh3tZrw=
X-Received: by 2002:adf:eec3:: with SMTP id a3mr14292602wrp.164.1588602557754; 
 Mon, 04 May 2020 07:29:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypI75pTeHi0Vq96RhfuCymuKTdrHh8JAMSoeXkncHs9sLO/cOObQueXlsWrRveiPhfE2LE0MpA==
X-Received: by 2002:adf:eec3:: with SMTP id a3mr14292510wrp.164.1588602556517; 
 Mon, 04 May 2020 07:29:16 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 z6sm6412504wrt.57.2020.05.04.07.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:16 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/29] hw/pci/pcie: Forbid hot-plug if it's disabled on the slot
Message-ID: <20200504142814.157589-2-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Julia Suvorova <jusual@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julia Suvorova <jusual@redhat.com>

Raise an error when trying to hot-plug/unplug a device through QMP to a dev=
ice
with disabled hot-plug capability. This makes the device behaviour more
consistent and provides an explanation of the failure in the case of
asynchronous unplug.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Message-Id: <20200427182440.92433-2-jusual@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
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
MST


