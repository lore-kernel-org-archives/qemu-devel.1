Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A25C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2252068D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCrWFiiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2252068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbMBj-0005qL-6x
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 06:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbM9y-0004FY-OR
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbM9w-0002nQ-9t
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604747607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kb1qV1CBxNvntGcbGLDYf9UbcevkpZpRBrcCPSdDmaA=;
 b=DCrWFiiZplh5zNMtbYn2DtY4h+R8j94ln9dEXp3qHMLogeLCZqwRFiBDtlggr6Z0VFJhsP
 tcsSNMnRnHdMul2Ycd1GzVkkNiJ5IMXL7tMcSWWU/kjHf9K8mcDWtOdTXFfzwwRckUlFqL
 K7xMCaFkr8pxo7xcUGCg+q/cTJqGbPo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-CLXRnURdMrS_qcvBen5GRw-1; Sat, 07 Nov 2020 06:13:25 -0500
X-MC-Unique: CLXRnURdMrS_qcvBen5GRw-1
Received: by mail-wr1-f69.google.com with SMTP id 67so1613261wra.2
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 03:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kb1qV1CBxNvntGcbGLDYf9UbcevkpZpRBrcCPSdDmaA=;
 b=Ew1Ki6QhT9jKEZHqnr3rsO/HfwMClKHr5m2KMhWGfX/NCUTGcrKQcmoiptRmb1Utjn
 hl4H6Xyq3+LFP966IZfg3NZjmy1ybpb+hFJK7Cn9zX87zasdlBzWtuWd766kpz3iS1v8
 jdEOpEm8Shcs/oxnU6z1j4PFU5mgXbyzq/FabCcn2o2UXZOBPLgdYkv/BHgjGcHGPNEV
 UNhjfyF7f5H4mbkMPK41xVFJCHKlZ+LTNGt8rO8Hga+bbZ03BjaIkR25mK2HaeV0TV7j
 LmFvljCoftOyqF13eDHgvCzs4LPdp1FsFYDM4+ORmH6/GHO0xesV5BQWQLQi/f9nRjmL
 GiZg==
X-Gm-Message-State: AOAM531XBg+qph/DMpLq450YZxnD7vR6eo7SUZ4PO0cCvVLb71f6Nu3X
 W0MUNaVwR/0/LvyCKc321rvni+wLK4ZP7LL+lcReMSe9T29m/Z8jmInP0MxyFx4cYasy1luf9hh
 OoiJHJqL7ppQJvK4=
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr4325136wme.0.1604747604486; 
 Sat, 07 Nov 2020 03:13:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsMPjMwctqQ+jeFdx/Vj9UhL1aJzboky1Ffv7uqtWHi2Dk56uFz6y18gW4L7HPCeogwgexvQ==
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr4325125wme.0.1604747604337; 
 Sat, 07 Nov 2020 03:13:24 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e7sm6330768wrm.6.2020.11.07.03.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 03:13:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 3/5] hw/usb/hcd-xhci: Rename "base-xhci" as
 TYPE_XHCI_COMMON
Date: Sat,  7 Nov 2020 12:13:05 +0100
Message-Id: <20201107111307.262263-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107111307.262263-1-philmd@redhat.com>
References: <20201107111307.262263-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:59:37
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Follow the code base style by using the _COMMON suffix to
abstract QOM types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/usb/hcd-xhci.h        |  4 +++-
 include/hw/usb/xhci.h    |  1 -
 hw/usb/hcd-xhci-pci.c    |  2 +-
 hw/usb/hcd-xhci-sysbus.c |  2 +-
 hw/usb/hcd-xhci.c        | 10 +++++-----
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index ccf50ae28be..7bd10964f92 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -27,7 +27,9 @@
 #include "hw/usb/xhci.h"
 #include "sysemu/dma.h"
 
-OBJECT_DECLARE_SIMPLE_TYPE(XHCIState, XHCI)
+#define TYPE_XHCI_COMMON "base-xhci" /* Common to PCI and Sysbus */
+
+OBJECT_DECLARE_SIMPLE_TYPE(XHCIState, XHCI_COMMON)
 
 /* Very pessimistic, let's hope it's enough for all cases */
 #define EV_QUEUE (((3 * 24) + 16) * XHCI_MAXSLOTS)
diff --git a/include/hw/usb/xhci.h b/include/hw/usb/xhci.h
index 5c90e1373e5..90b56429199 100644
--- a/include/hw/usb/xhci.h
+++ b/include/hw/usb/xhci.h
@@ -1,7 +1,6 @@
 #ifndef HW_USB_XHCI_H
 #define HW_USB_XHCI_H
 
-#define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
 #define TYPE_XHCI_SYSBUS "sysbus-xhci"
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index b78fcd2bb2d..2ca018a4290 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -193,7 +193,7 @@ static void xhci_instance_init(Object *obj)
      * line, therefore, no need to wait to realize like other devices
      */
     PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
-    object_initialize_child(obj, "xhci-core", &s->xhci, TYPE_XHCI);
+    object_initialize_child(obj, "xhci-core", &s->xhci, TYPE_XHCI_COMMON);
     qdev_alias_all_properties(DEVICE(&s->xhci), obj);
 }
 
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index 29185d2261f..f2ec08ffa4e 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -58,7 +58,7 @@ static void xhci_sysbus_instance_init(Object *obj)
 {
     XHCISysbusState *s = XHCI_SYSBUS(obj);
 
-    object_initialize_child(obj, "xhci-core", &s->xhci, TYPE_XHCI);
+    object_initialize_child(obj, "xhci-core", &s->xhci, TYPE_XHCI_COMMON);
     qdev_alias_all_properties(DEVICE(&s->xhci), obj);
 
     object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 57b692ad849..3abe416dfd6 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2637,7 +2637,7 @@ static void xhci_port_reset(XHCIPort *port, bool warm_reset)
 
 static void xhci_reset(DeviceState *dev)
 {
-    XHCIState *xhci = XHCI(dev);
+    XHCIState *xhci = XHCI_COMMON(dev);
     int i;
 
     trace_usb_xhci_reset();
@@ -2891,7 +2891,7 @@ static uint64_t xhci_oper_read(void *ptr, hwaddr reg, unsigned size)
 static void xhci_oper_write(void *ptr, hwaddr reg,
                             uint64_t val, unsigned size)
 {
-    XHCIState *xhci = XHCI(ptr);
+    XHCIState *xhci = XHCI_COMMON(ptr);
 
     trace_usb_xhci_oper_write(reg, val);
 
@@ -3327,7 +3327,7 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
 {
     int i;
 
-    XHCIState *xhci = XHCI(dev);
+    XHCIState *xhci = XHCI_COMMON(dev);
 
     if (xhci->numintrs > XHCI_MAXINTRS) {
         xhci->numintrs = XHCI_MAXINTRS;
@@ -3381,7 +3381,7 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
 static void usb_xhci_unrealize(DeviceState *dev)
 {
     int i;
-    XHCIState *xhci = XHCI(dev);
+    XHCIState *xhci = XHCI_COMMON(dev);
 
     trace_usb_xhci_exit();
 
@@ -3591,7 +3591,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo xhci_info = {
-    .name          = TYPE_XHCI,
+    .name          = TYPE_XHCI_COMMON,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
-- 
2.26.2


