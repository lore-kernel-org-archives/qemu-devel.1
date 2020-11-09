Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F51C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386192068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc5mPdgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386192068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7gk-00010t-SV
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7bq-0003OZ-Gy
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7bo-0005GC-Hz
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604930003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJ9MpIv/7kmX06xCIU09e2TXqLlDymC3w5zG23mwJEU=;
 b=Nc5mPdgsMLeDY9YejvthcCpCkmPIUFWm1LD48wZZKBahRXbIORiRSXuZEQyvh+tn7QjizG
 m3POF+TOhZEVYqeomfuLqn7MBCDsQvkb/MJNo/KwvDeUnjTlV1EvDcAKB6vrg1An/oXn8v
 Nhz+SYVUkI98oTlpNe06CQTpOpmHfAM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-VPZwb4pdMFqkLZz2LMv4Zg-1; Mon, 09 Nov 2020 08:53:22 -0500
X-MC-Unique: VPZwb4pdMFqkLZz2LMv4Zg-1
Received: by mail-wm1-f71.google.com with SMTP id h2so2001521wmm.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hJ9MpIv/7kmX06xCIU09e2TXqLlDymC3w5zG23mwJEU=;
 b=aj4SeuOMa3w+W0LXDcRcrebHjZcRIp8I2YwjMsf3UThduWaebr27qMrSHdX/8ae5OD
 NjGi32/MyL9gX1USkiJj24JdS2QouGZUtQb9AAGlIj1qGertg+F7urrE28p8UUjJ4w9D
 Zp7eWiClSOWGRkp/N1nO+aFZvB04peuQ1Cfi8jF6sy0A7VOuSCBlQVtPil2Q+47gc0vJ
 JT+zx4fFM/H2NDWzsK0c9hqc0R1pW2mgTiWYxw0wW1t83qo2IXxB6WnvHcJpfDz9tOas
 9gzBPEmbxBXe33TXsxAzqbFkVE1yc3/35OFJCULfjbCNSCtsEGJ5NkQSP+jhM5ktN2L6
 JeSA==
X-Gm-Message-State: AOAM531txGWnzhqfcc3aw1m+HhPfQwfslmQZTO2BxCCV8Jyuidvm2iXa
 IFQWI8PB4NkWxwKY/MXBetDISmSNURCbEiWzz0ceFJANsjPJeb20s8H/bZSxhN8rOKWrDXGnGGw
 Ofjb3uH5ImLpJgs8=
X-Received: by 2002:adf:fd03:: with SMTP id e3mr12519470wrr.303.1604930001117; 
 Mon, 09 Nov 2020 05:53:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi5nMKAbfvzEMk9GcbBEY9y64Mv+3OOCdx00CrnBNGfDTw/hRZcCDIUQ5EP5S8IlnuTFfnDQ==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr12519448wrr.303.1604930000927; 
 Mon, 09 Nov 2020 05:53:20 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s8sm9315798wrn.33.2020.11.09.05.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 05:53:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v2 4/4] hw/usb/hcd-xhci-pci: Rename "pci-xhci" as
 TYPE_XHCI_PCI_COMMON
Date: Mon,  9 Nov 2020 14:53:00 +0100
Message-Id: <20201109135300.2592982-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109135300.2592982-1-philmd@redhat.com>
References: <20201109135300.2592982-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Follow the code base style by using the _COMMON suffix to
abstract QOM types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/usb/hcd-xhci-pci.h |  4 ++--
 hw/usb/hcd-xhci-nec.c |  2 +-
 hw/usb/hcd-xhci-pci.c | 16 ++++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index cf9a180caa4..c862e82d964 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -27,8 +27,8 @@
 #include "hw/usb.h"
 #include "hcd-xhci.h"
 
-#define TYPE_XHCI_PCI "pci-xhci"
-OBJECT_DECLARE_SIMPLE_TYPE(XHCIPciState, XHCI_PCI)
+#define TYPE_XHCI_PCI_COMMON "pci-xhci"
+OBJECT_DECLARE_SIMPLE_TYPE(XHCIPciState, XHCI_PCI_COMMON)
 
 typedef struct XHCIPciState {
     /*< private >*/
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 5707b2cabd1..16b3b46fd59 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -52,7 +52,7 @@ static void nec_xhci_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo nec_xhci_info = {
     .name          = TYPE_NEC_XHCI,
-    .parent        = TYPE_XHCI_PCI,
+    .parent        = TYPE_XHCI_PCI_COMMON,
     .class_init    = nec_xhci_class_init,
 };
 
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index b78fcd2bb2d..b4487cce4ba 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -80,14 +80,14 @@ static void xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
 
 static void xhci_pci_reset(DeviceState *dev)
 {
-    XHCIPciState *s = XHCI_PCI(dev);
+    XHCIPciState *s = XHCI_PCI_COMMON(dev);
 
     device_legacy_reset(DEVICE(&s->xhci));
 }
 
 static int xhci_pci_vmstate_post_load(void *opaque, int version_id)
 {
-    XHCIPciState *s = XHCI_PCI(opaque);
+    XHCIPciState *s = XHCI_PCI_COMMON(opaque);
     PCIDevice *pci_dev = PCI_DEVICE(s);
     int intr;
 
@@ -105,7 +105,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
 {
     int ret;
     Error *err = NULL;
-    XHCIPciState *s = XHCI_PCI(dev);
+    XHCIPciState *s = XHCI_PCI_COMMON(dev);
 
     dev->config[PCI_CLASS_PROG] = 0x30;    /* xHCI */
     dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin 1 */
@@ -165,7 +165,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
 
 static void usb_xhci_pci_exit(PCIDevice *dev)
 {
-    XHCIPciState *s = XHCI_PCI(dev);
+    XHCIPciState *s = XHCI_PCI_COMMON(dev);
     /* destroy msix memory region */
     if (dev->msix_table && dev->msix_pba
         && dev->msix_entry_used) {
@@ -187,7 +187,7 @@ static const VMStateDescription vmstate_xhci_pci = {
 
 static void xhci_instance_init(Object *obj)
 {
-    XHCIPciState *s = XHCI_PCI(obj);
+    XHCIPciState *s = XHCI_PCI_COMMON(obj);
     /*
      * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
      * line, therefore, no need to wait to realize like other devices
@@ -211,7 +211,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo xhci_pci_info = {
-    .name          = TYPE_XHCI_PCI,
+    .name          = TYPE_XHCI_PCI_COMMON,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(XHCIPciState),
     .class_init    = xhci_class_init,
@@ -235,7 +235,7 @@ static void qemu_xhci_class_init(ObjectClass *klass, void *data)
 
 static void qemu_xhci_instance_init(Object *obj)
 {
-    XHCIPciState *s = XHCI_PCI(obj);
+    XHCIPciState *s = XHCI_PCI_COMMON(obj);
     XHCIState *xhci = &s->xhci;
 
     s->msi      = ON_OFF_AUTO_OFF;
@@ -247,7 +247,7 @@ static void qemu_xhci_instance_init(Object *obj)
 
 static const TypeInfo qemu_xhci_info = {
     .name          = TYPE_QEMU_XHCI,
-    .parent        = TYPE_XHCI_PCI,
+    .parent        = TYPE_XHCI_PCI_COMMON,
     .class_init    = qemu_xhci_class_init,
     .instance_init = qemu_xhci_instance_init,
 };
-- 
2.26.2


