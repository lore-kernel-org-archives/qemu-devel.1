Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0BEC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05862068D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCwmiTM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05862068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbMBo-00062a-U6
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 06:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbMA9-0004PH-Rk
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbMA5-0002qv-RL
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604747617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rsOTDP4czRCB3IH/wLXFhyThYgQQTJJgr4u4VHvy1U=;
 b=BCwmiTM+DnV4zCTxEBmBUrygqeqKSOPH9uSesiYjaEQNGjYuBFCefvnqkqOo1MH49E7nRI
 rNHuCzrJpEoBLnsUGICyLITcJ9og4Diy/gELOd8uJzGhKF5YQDDWNcM91hj3uERamjvBAm
 YRwcCSScNCHbJmzynpjnGFfvY9rP7oo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-l_IAIGWHMai1lc0sZpA8XA-1; Sat, 07 Nov 2020 06:13:35 -0500
X-MC-Unique: l_IAIGWHMai1lc0sZpA8XA-1
Received: by mail-wm1-f70.google.com with SMTP id s85so1000784wme.3
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 03:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+rsOTDP4czRCB3IH/wLXFhyThYgQQTJJgr4u4VHvy1U=;
 b=Kuzntlh7Kmoa3T6P9b9+Cfp9xFS3h1KsvbaQVOlSQ8fqC1kkq4oQ3zjiqFGcWmaQ31
 SOjkBn2W/OvxEBaNtd7YtsZGUlSned85/gXmjFfnzqeUZKhDzcW973Y9fUmdpuyip7HA
 K1t0K+pwipw9B37JEF95mWIB1nkNviCSar8ZJMt84h2Zp/06wEh30Ank0JvVjqpI4N8N
 Q9EQnuUP5+Gil/c5noHntXeV0IztpwsX4qts0YSHdZkIoBDldDBM0qNkQMVaSvzeLKTX
 D9RdI9qLX3z0Jco+Crhaz1dnfZTsMkBG5SV9ymtSw8s49J9I5xFzoHxv6/kbTmhtXg+A
 DEdg==
X-Gm-Message-State: AOAM532C8xBwEHz0p8t9zhS0/VJ0wtgzFbanKSphIeFq8186FL3NE3Wo
 LHCU8cWcgzfxO0fqfg7JgWU8W+VFDGHjerlgyzVFzhY8l2gCatyQ8KnFY0Wl4dqJeqs0zww20Mz
 couMyGNKqWbHrs1k=
X-Received: by 2002:adf:dc85:: with SMTP id r5mr7895359wrj.66.1604747614100;
 Sat, 07 Nov 2020 03:13:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbVqzh9ChQ8w8+tideUGSp8JwkNAR5G1+fSYU1aYAF3L9goKk4J+n3jYwzd7ph7LD+PxAAKw==
X-Received: by 2002:adf:dc85:: with SMTP id r5mr7895342wrj.66.1604747613903;
 Sat, 07 Nov 2020 03:13:33 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e3sm6094614wrn.32.2020.11.07.03.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 03:13:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 5/5] hw/usb/hcd-xhci-pci: Rename "pci-xhci" as
 TYPE_XHCI_PCI_COMMON
Date: Sat,  7 Nov 2020 12:13:07 +0100
Message-Id: <20201107111307.262263-6-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:12:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 2ca018a4290..9490988b1c9 100644
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


