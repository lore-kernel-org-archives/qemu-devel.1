Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB543C35242
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBF1207FF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpoAqGYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBF1207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2l5f-0001EZ-O3
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 19:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2l4r-0008CA-Ok
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2l4q-00038v-Eo
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:12:57 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2l4o-00032V-90; Fri, 14 Feb 2020 19:12:54 -0500
Received: by mail-pg1-x544.google.com with SMTP id b9so5594978pgk.12;
 Fri, 14 Feb 2020 16:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lzWIP4VkwCYbcbIQG5CcKiRH3f3/MB+GZnEQK5D3umo=;
 b=hpoAqGYSAUvA47AEU/PM62h20f007z+dJx852KaAatQxwRGPsEi6rjW+/zXnNlrwp0
 L+N2Wj9uH9B2ZHtZZXSiWFsEP4b7q7GOb1UfJ9DfVXjqGVOvDyF8BrHs7DrDAJrUalq8
 oCJFGSEqxOHMyLZsNVSXDoCQa6Du46ryFFA+cJKUqiIgKkmScQwZlODFTbfhyTLT/BC1
 xrNFTqK+DT9T6W5siA6qSj2rJCHqiNnI7T4GlBqOWjR+nOhHzGOBmXvvhE/QcuB34n/l
 GRhF67HwKSjB27TCfjWAO5WlTG4sSoZAmd9Sm3u4fEnB4ab/oUw97O/NHnMVwceIyBb+
 /2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=lzWIP4VkwCYbcbIQG5CcKiRH3f3/MB+GZnEQK5D3umo=;
 b=o/qisdEqNcM0ycahQoWA9yfyX2ysigpbBuUhsY3eSBMda3WaJtfJ8kC+GLnGhg7zwe
 FGPk0bpvPY2EO6gvpn8FDi/2a6OAuI3UankbvCA1+RU6wT3QE61TifFT3exyQ+rqFEEi
 dRylFjvwdjxbnCRvxTHPUi6tUhkO2oZ/nrjHK1oIClfy1zzV+F+VNH+rVUDQVtJcWBiF
 Au6opNULviCkqnc/oOiDgQzSimX8TA4xDAW0kmeoIziVMYJpYaa66uWN4aawfoKOQGY9
 IpsxBBcB1xFIdHpTon+4Z1jxS3GI4CD83fIdPRmQLDz8sA7KYCtA9yW5J+Rb9ED97Zu3
 fA6g==
X-Gm-Message-State: APjAAAUqVA097wWKYDIAejGWLgRKzhmXT70uvp39kD3k69lQW7DS7nAg
 9am29auQL22pz8gtcKm6MnY=
X-Google-Smtp-Source: APXvYqxIEo02tNg08eQujp+12a4xWk1R/Cx2WaQTGOM1ydJ3rlVx6pJB6JcdWVJNxB8TrBLxzW2d2A==
X-Received: by 2002:a62:1a16:: with SMTP id a22mr5966524pfa.34.1581725573453; 
 Fri, 14 Feb 2020 16:12:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id v5sm8317720pgc.11.2020.02.14.16.12.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Feb 2020 16:12:52 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 1/3] hw: usb: hcd-ohci: Move OHCISysBusState and
 TYPE_SYSBUS_OHCI to include file
Date: Fri, 14 Feb 2020 16:12:46 -0800
Message-Id: <20200215001248.2642-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200215001248.2642-1-linux@roeck-us.net>
References: <20200215001248.2642-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to be able to use OHCISysBusState outside hcd-ohci.c, so move it
to its include file.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: no changes

 hw/usb/hcd-ohci.c | 15 ---------------
 hw/usb/hcd-ohci.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 8a94bd004a..1e6e85e86a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1870,21 +1870,6 @@ void ohci_sysbus_die(struct OHCIState *ohci)
     ohci_bus_stop(ohci);
 }
 
-#define TYPE_SYSBUS_OHCI "sysbus-ohci"
-#define SYSBUS_OHCI(obj) OBJECT_CHECK(OHCISysBusState, (obj), TYPE_SYSBUS_OHCI)
-
-typedef struct {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    OHCIState ohci;
-    char *masterbus;
-    uint32_t num_ports;
-    uint32_t firstport;
-    dma_addr_t dma_offset;
-} OHCISysBusState;
-
 static void ohci_realize_pxa(DeviceState *dev, Error **errp)
 {
     OHCISysBusState *s = SYSBUS_OHCI(dev);
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index 16e3f1e13a..5c8819aedf 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -22,6 +22,7 @@
 #define HCD_OHCI_H
 
 #include "sysemu/dma.h"
+#include "hw/usb.h"
 
 /* Number of Downstream Ports on the root hub: */
 #define OHCI_MAX_PORTS 15
@@ -90,6 +91,21 @@ typedef struct OHCIState {
     void (*ohci_die)(struct OHCIState *ohci);
 } OHCIState;
 
+#define TYPE_SYSBUS_OHCI "sysbus-ohci"
+#define SYSBUS_OHCI(obj) OBJECT_CHECK(OHCISysBusState, (obj), TYPE_SYSBUS_OHCI)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    OHCIState ohci;
+    char *masterbus;
+    uint32_t num_ports;
+    uint32_t firstport;
+    dma_addr_t dma_offset;
+} OHCISysBusState;
+
 extern const VMStateDescription vmstate_ohci_state;
 
 void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports,
-- 
2.17.1


