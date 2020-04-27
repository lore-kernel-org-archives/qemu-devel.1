Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67516C4CECC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B2B20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAAZNnTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B2B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8W2-0005gT-B0
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1jT8RG-0005Px-JA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1jT8RG-0003dw-3l
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:25:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1jT8RF-0003dg-Kp
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588011904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKw15HZXrOsyxPbNOe6TeZKJXncQwxFCcckHAo0+GDA=;
 b=SAAZNnTcuBxKQhP5jn+nw395DUUKpZ+bDfu4N+WD9AhHZ7PZdndFC0Ovu6eqZeO5Xz/gAz
 WQ+LdJcMV9Oo9KqimThjh1/8C+vacvG6yjDVLIPaa9HCx/Ge8CWbAfdZh6hmh+SMRFJfHw
 sFUWBZY8QKN6h6qvOI2zccQG+i5xXsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-3yf-heSnNJ6VBxcRA9u4xw-1; Mon, 27 Apr 2020 14:25:02 -0400
X-MC-Unique: 3yf-heSnNJ6VBxcRA9u4xw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A68C045F;
 Mon, 27 Apr 2020 18:25:01 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18CBC60BE2;
 Mon, 27 Apr 2020 18:24:59 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] hw/pci/pcie: Replace PCI_DEVICE() casts with existing
 variable
Date: Mon, 27 Apr 2020 20:24:40 +0200
Message-Id: <20200427182440.92433-3-jusual@redhat.com>
In-Reply-To: <20200427182440.92433-1-jusual@redhat.com>
References: <20200427182440.92433-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 14:25:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A little cleanup is possible because of hotplug_pdev introduction.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 hw/pci/pcie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6b48d04d2c..abc99b6eff 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -449,7 +449,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev,=
 DeviceState *dev,
             pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
                                        PCI_EXP_LNKSTA_DLLLA);
         }
-        pcie_cap_slot_event(PCI_DEVICE(hotplug_dev),
+        pcie_cap_slot_event(hotplug_pdev,
                             PCI_EXP_HP_EV_PDC | PCI_EXP_HP_EV_ABP);
     }
 }
@@ -490,7 +490,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
         return;
     }
=20
-    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err);
+    pcie_cap_slot_plug_common(hotplug_pdev, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -509,7 +509,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
         return;
     }
=20
-    pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
+    pcie_cap_slot_push_attention_button(hotplug_pdev);
 }
=20
 /* pci express slot for pci express root/downstream port
--=20
2.25.3


