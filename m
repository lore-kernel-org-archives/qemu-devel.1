Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135CBC35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A61222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4oHyZGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A61222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58N8-0007I4-WE
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582d-0007rj-L7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582c-0003Fp-HY
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:27 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582c-0003Ej-AS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:26 -0500
Received: by mail-wr1-x436.google.com with SMTP id w12so2011193wrt.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PHKV1/R69DUOQ2y2kHNeixniaxNyfpVfww+ZCelTAL0=;
 b=x4oHyZGDZVnko1eCtADM64LHcHWwujVvendAfE/oeBRyMJh8bvixA79FV6uvEI6/T1
 m+yRI6RUoCA/91LiNr3ecyZ3BYgwikG8ULWNWjNfIhvc+6lx10KdDh1Kmv9RQZ548h8/
 Vylth1PcPh0vtmlGJXi3ozuVfjsuwcDaK+Dx6FTvg6J9H4JxqwresHdwSEF9FceAIrC0
 lrpIVJ4HJ/0PFcdGc8S9T3aADcXVB8ocqOoAqWmx59E12U4O5dbLbw903nKV5rhavXdg
 gaq73HcLqqJt6yo3M7Jn2gXHSNJ6Qa174tn2Pqakuyq11l8+4AJAyqPpwSV/tgNqOQIa
 WW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PHKV1/R69DUOQ2y2kHNeixniaxNyfpVfww+ZCelTAL0=;
 b=bi6zPY74abh/eQdkQkS5U4INJ0ylhrU+e68vVd9v65x3ifedNL7vnysUez1O85l7lN
 /JnEd2pBMg/okeRbSzV5Iz98Dk26B28KioGnCN5HzQJyMLrgpEJShCvuxWqGjnNDho76
 d/iV6aiPMi9ATPfpilTMGdkiR+YxTwOiI33Su86l/B6ZCl+rK6gzPjtrdbIE/9iIIgDD
 49gZ9SWSBGCJ5qR9K5JrOkQK3NScvxMfFqs9yyumruA6Xrki52qBJimzebNoqWPGbbrn
 1y9OIntbH87dltqXeZcIFHgK5MVZeTIbm6yTw6b4i17IGoZyD16/VPPPiC7KB6UVfyEy
 Nlxg==
X-Gm-Message-State: APjAAAWhN7h3ak6bDNf+2afFpgEUsv1IhyauNVi9uahBnVWW5O+rGlSv
 bVZ6S8D7ui1dG1WRqbXgX4txQcZJhSDvvw==
X-Google-Smtp-Source: APXvYqzzb2W2rwDPxNPWXQQPYdDws37F88a1o220sAazavrFUuKGKIrh2AEgY4h0sVuBf5kGSs3QHw==
X-Received: by 2002:adf:f802:: with SMTP id s2mr51597258wrp.201.1582290505068; 
 Fri, 21 Feb 2020 05:08:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/52] hw: usb: hcd-ohci: Move OHCISysBusState and
 TYPE_SYSBUS_OHCI to include file
Date: Fri, 21 Feb 2020 13:07:23 +0000
Message-Id: <20200221130740.7583-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

We need to be able to use OHCISysBusState outside hcd-ohci.c, so move it
to its include file.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200217204812.9857-2-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-ohci.h | 16 ++++++++++++++++
 hw/usb/hcd-ohci.c | 15 ---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index 16e3f1e13a3..5c8819aedf9 100644
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
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 8a94bd004a9..1e6e85e86a8 100644
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
-- 
2.20.1


