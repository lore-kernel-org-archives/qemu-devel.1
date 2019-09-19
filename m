Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA4CC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD5E21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI7gKIxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD5E21907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4eI-0001Z7-JH
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49m-0001eR-TI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49f-0006FF-M6
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:06 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49X-0006CP-VO
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id 67so4471061oto.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=boJaD5eMnHUdi/NC4fPiImECEPwSfx1CFjfaYYLNAMs=;
 b=RI7gKIxTdywCXrwztQrfhsFae0j35xo2bZ1ctdQK0ZwOjFEk2p0qs5dS6EP5tlQ7Tk
 VDapJAOfM/n3o11zVaytnNkKrrOPD2EAquA+qqckli5f+fX/0GAzFABwNghCc8OgzIb3
 dsszFFDfGRWAllI0wcjho8qfpzxdGpOb5mimUfYF5EarFH+coCa8wOIR26PzktuqX1vb
 m1dwCEfa+PG2EWG4gN5tlfFGfTqjQ5VIDXKjFOjzeNFfI5HX9XICdGMMUNsgQU5UYk74
 bmHGIvTHPEDB+mv4bZtOfCl1ThGna+AZKHBlgvrXMs2TBct86QTFpZ2fe1oQzZ05deuS
 BhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=boJaD5eMnHUdi/NC4fPiImECEPwSfx1CFjfaYYLNAMs=;
 b=IPrYq1tudFq0Kai3ZOja1JIFQ10mPe0C8Hosh4DazZZA88BY8gLgSGo3S34jHhQP6+
 cH4FiB/sE1IZwfrWyhLEvFH/MAyguCn+++OSOwXocJJLFV8L2oxQ3O6lTzivF/qOBZf1
 FPWa2eGJ0GnqTJGIYNgYP98PxMWk47SyL2UsdVErjRX8qRqinomk8FQjMbPehb/u9vOv
 yjzukfRrgnSsVr57vfzy85SC6Eja1q1wGnLcO8PgtaU2naqWJoGP2hdq0SEQ5z05GRzS
 KctwfBR9YVnvtD49FI/QJHsJrn+/6GSnfoRg55z4j43TK87sZPIT2vuiaJCBkzpD4Ez0
 A7NQ==
X-Gm-Message-State: APjAAAX5OCAHPEGs0gL8i+T7ZYQzWpiYJK9OEVRsf6YTuQx/LPTzHIfn
 ig9lDpq0SrStCZTN+PIzCQ==
X-Google-Smtp-Source: APXvYqwq7dT+Bpmj16sKpXMPig2VDRXWPBkgk24G79YfJ+FITet6mrolk8j3klKBC/AfBLkkL5ykqQ==
X-Received: by 2002:a05:6830:1ac5:: with SMTP id
 r5mr9217517otc.338.1568929185792; 
 Thu, 19 Sep 2019 14:39:45 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id q14sm33551otc.50.2019.09.19.14.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:40 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id A479B1800CE;
 Thu, 19 Sep 2019 21:39:36 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 08/15] ipmi: Split out BT-specific code from ISA BT code
Date: Thu, 19 Sep 2019 16:39:17 -0500
Message-Id: <20190919213924.31852-9-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Get ready for PCI and other BT interfaces.

No functional changes, just split the code into generic BT code
and ISA-specific BT code.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/ipmi/Makefile.objs     |   2 +-
 hw/ipmi/ipmi_bt.c         | 426 ++++++++++++++++++++++++++++++++++++
 hw/ipmi/isa_ipmi_bt.c     | 441 ++------------------------------------
 include/hw/ipmi/ipmi_bt.h |  72 +++++++
 4 files changed, 520 insertions(+), 421 deletions(-)
 create mode 100644 hw/ipmi/ipmi_bt.c
 create mode 100644 include/hw/ipmi/ipmi_bt.h

diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
index 6835d2f64a..4ffa45a66c 100644
--- a/hw/ipmi/Makefile.objs
+++ b/hw/ipmi/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_IPMI) += ipmi.o ipmi_kcs.o
+common-obj-$(CONFIG_IPMI) += ipmi.o ipmi_kcs.o ipmi_bt.o
 common-obj-$(CONFIG_IPMI_LOCAL) += ipmi_bmc_sim.o
 common-obj-$(CONFIG_IPMI_EXTERN) += ipmi_bmc_extern.o
 common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
new file mode 100644
index 0000000000..e6765ca4f8
--- /dev/null
+++ b/hw/ipmi/ipmi_bt.c
@@ -0,0 +1,426 @@
+/*
+ * QEMU IPMI BT emulation
+ *
+ * Copyright (c) 2015 Corey Minyard, MontaVista Software, LLC
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/ipmi/ipmi_bt.h"
+
+/* Control register */
+#define IPMI_BT_CLR_WR_BIT         0
+#define IPMI_BT_CLR_RD_BIT         1
+#define IPMI_BT_H2B_ATN_BIT        2
+#define IPMI_BT_B2H_ATN_BIT        3
+#define IPMI_BT_SMS_ATN_BIT        4
+#define IPMI_BT_HBUSY_BIT          6
+#define IPMI_BT_BBUSY_BIT          7
+
+#define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)
+
+#define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)
+
+#define IPMI_BT_GET_H2B_ATN(d)     (((d) >> IPMI_BT_H2B_ATN_BIT) & 0x1)
+
+#define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
+#define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1)
+#define IPMI_BT_SET_B2H_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_B2H_ATN_MASK) | \
+                                        (!!(v) << IPMI_BT_B2H_ATN_BIT)))
+
+#define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
+#define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1)
+#define IPMI_BT_SET_SMS_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_SMS_ATN_MASK) | \
+                                        (!!(v) << IPMI_BT_SMS_ATN_BIT)))
+
+#define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
+#define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
+#define IPMI_BT_SET_HBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
+                                       (!!(v) << IPMI_BT_HBUSY_BIT)))
+
+#define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
+#define IPMI_BT_SET_BBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_BBUSY_MASK) | \
+                                       (!!(v) << IPMI_BT_BBUSY_BIT)))
+
+
+/* Mask register */
+#define IPMI_BT_B2H_IRQ_EN_BIT     0
+#define IPMI_BT_B2H_IRQ_BIT        1
+
+#define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
+#define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) & 0x1)
+#define IPMI_BT_SET_B2H_IRQ_EN(d, v) ((d) = (((d) & ~IPMI_BT_B2H_IRQ_EN_MASK) |\
+                                        (!!(v) << IPMI_BT_B2H_IRQ_EN_BIT)))
+
+#define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
+#define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0x1)
+#define IPMI_BT_SET_B2H_IRQ(d, v)    ((d) = (((d) & ~IPMI_BT_B2H_IRQ_MASK) | \
+                                        (!!(v) << IPMI_BT_B2H_IRQ_BIT)))
+
+#define IPMI_CMD_GET_BT_INTF_CAP        0x36
+
+static void ipmi_bt_raise_irq(IPMIBT *ib)
+{
+    if (ib->use_irq && ib->irqs_enabled && ib->raise_irq) {
+        ib->raise_irq(ib);
+    }
+}
+
+static void ipmi_bt_lower_irq(IPMIBT *ib)
+{
+    if (ib->lower_irq) {
+        ib->lower_irq(ib);
+    }
+}
+
+static void ipmi_bt_handle_event(IPMIInterface *ii)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIBT *ib = iic->get_backend_data(ii);
+
+    if (ib->inlen < 4) {
+        goto out;
+    }
+    /* Note that overruns are handled by handle_command */
+    if (ib->inmsg[0] != (ib->inlen - 1)) {
+        /* Length mismatch, just ignore. */
+        IPMI_BT_SET_BBUSY(ib->control_reg, 1);
+        ib->inlen = 0;
+        goto out;
+    }
+    if ((ib->inmsg[1] == (IPMI_NETFN_APP << 2)) &&
+                        (ib->inmsg[3] == IPMI_CMD_GET_BT_INTF_CAP)) {
+        /* We handle this one ourselves. */
+        ib->outmsg[0] = 9;
+        ib->outmsg[1] = ib->inmsg[1] | 0x04;
+        ib->outmsg[2] = ib->inmsg[2];
+        ib->outmsg[3] = ib->inmsg[3];
+        ib->outmsg[4] = 0;
+        ib->outmsg[5] = 1; /* Only support 1 outstanding request. */
+        if (sizeof(ib->inmsg) > 0xff) { /* Input buffer size */
+            ib->outmsg[6] = 0xff;
+        } else {
+            ib->outmsg[6] = (unsigned char) sizeof(ib->inmsg);
+        }
+        if (sizeof(ib->outmsg) > 0xff) { /* Output buffer size */
+            ib->outmsg[7] = 0xff;
+        } else {
+            ib->outmsg[7] = (unsigned char) sizeof(ib->outmsg);
+        }
+        ib->outmsg[8] = 10; /* Max request to response time */
+        ib->outmsg[9] = 0; /* Don't recommend retries */
+        ib->outlen = 10;
+        IPMI_BT_SET_BBUSY(ib->control_reg, 0);
+        IPMI_BT_SET_B2H_ATN(ib->control_reg, 1);
+        if (!IPMI_BT_GET_B2H_IRQ(ib->mask_reg) &&
+                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
+            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
+            ipmi_bt_raise_irq(ib);
+        }
+        goto out;
+    }
+    ib->waiting_seq = ib->inmsg[2];
+    ib->inmsg[2] = ib->inmsg[1];
+    {
+        IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ib->bmc);
+        bk->handle_command(ib->bmc, ib->inmsg + 2, ib->inlen - 2,
+                           sizeof(ib->inmsg), ib->waiting_rsp);
+    }
+ out:
+    return;
+}
+
+static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
+                                unsigned char *rsp, unsigned int rsp_len)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIBT *ib = iic->get_backend_data(ii);
+
+    if (ib->waiting_rsp == msg_id) {
+        ib->waiting_rsp++;
+        if (rsp_len > (sizeof(ib->outmsg) - 2)) {
+            ib->outmsg[0] = 4;
+            ib->outmsg[1] = rsp[0];
+            ib->outmsg[2] = ib->waiting_seq;
+            ib->outmsg[3] = rsp[1];
+            ib->outmsg[4] = IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
+            ib->outlen = 5;
+        } else {
+            ib->outmsg[0] = rsp_len + 1;
+            ib->outmsg[1] = rsp[0];
+            ib->outmsg[2] = ib->waiting_seq;
+            memcpy(ib->outmsg + 3, rsp + 1, rsp_len - 1);
+            ib->outlen = rsp_len + 2;
+        }
+        IPMI_BT_SET_BBUSY(ib->control_reg, 0);
+        IPMI_BT_SET_B2H_ATN(ib->control_reg, 1);
+        if (!IPMI_BT_GET_B2H_IRQ(ib->mask_reg) &&
+                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
+            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
+            ipmi_bt_raise_irq(ib);
+        }
+    }
+}
+
+
+static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigned size)
+{
+    IPMIInterface *ii = opaque;
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIBT *ib = iic->get_backend_data(ii);
+    uint32_t ret = 0xff;
+
+    switch (addr & 3) {
+    case 0:
+        ret = ib->control_reg;
+        break;
+    case 1:
+        if (ib->outpos < ib->outlen) {
+            ret = ib->outmsg[ib->outpos];
+            ib->outpos++;
+            if (ib->outpos == ib->outlen) {
+                ib->outpos = 0;
+                ib->outlen = 0;
+            }
+        } else {
+            ret = 0xff;
+        }
+        break;
+    case 2:
+        ret = ib->mask_reg;
+        break;
+    }
+    return ret;
+}
+
+static void ipmi_bt_signal(IPMIBT *ib, IPMIInterface *ii)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+
+    ib->do_wake = 1;
+    while (ib->do_wake) {
+        ib->do_wake = 0;
+        iic->handle_if_event(ii);
+    }
+}
+
+static void ipmi_bt_ioport_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size)
+{
+    IPMIInterface *ii = opaque;
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIBT *ib = iic->get_backend_data(ii);
+
+    switch (addr & 3) {
+    case 0:
+        if (IPMI_BT_GET_CLR_WR(val)) {
+            ib->inlen = 0;
+        }
+        if (IPMI_BT_GET_CLR_RD(val)) {
+            ib->outpos = 0;
+        }
+        if (IPMI_BT_GET_B2H_ATN(val)) {
+            IPMI_BT_SET_B2H_ATN(ib->control_reg, 0);
+        }
+        if (IPMI_BT_GET_SMS_ATN(val)) {
+            IPMI_BT_SET_SMS_ATN(ib->control_reg, 0);
+        }
+        if (IPMI_BT_GET_HBUSY(val)) {
+            /* Toggle */
+            IPMI_BT_SET_HBUSY(ib->control_reg,
+                              !IPMI_BT_GET_HBUSY(ib->control_reg));
+        }
+        if (IPMI_BT_GET_H2B_ATN(val)) {
+            IPMI_BT_SET_BBUSY(ib->control_reg, 1);
+            ipmi_bt_signal(ib, ii);
+        }
+        break;
+
+    case 1:
+        if (ib->inlen < sizeof(ib->inmsg)) {
+            ib->inmsg[ib->inlen] = val;
+        }
+        ib->inlen++;
+        break;
+
+    case 2:
+        if (IPMI_BT_GET_B2H_IRQ_EN(val) !=
+                        IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
+            if (IPMI_BT_GET_B2H_IRQ_EN(val)) {
+                if (IPMI_BT_GET_B2H_ATN(ib->control_reg) ||
+                        IPMI_BT_GET_SMS_ATN(ib->control_reg)) {
+                    IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
+                    ipmi_bt_raise_irq(ib);
+                }
+                IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 1);
+            } else {
+                if (IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
+                    IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
+                    ipmi_bt_lower_irq(ib);
+                }
+                IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 0);
+            }
+        }
+        if (IPMI_BT_GET_B2H_IRQ(val) && IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
+            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
+            ipmi_bt_lower_irq(ib);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps ipmi_bt_io_ops = {
+    .read = ipmi_bt_ioport_read,
+    .write = ipmi_bt_ioport_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void ipmi_bt_set_atn(IPMIInterface *ii, int val, int irq)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIBT *ib = iic->get_backend_data(ii);
+
+    if (!!val == IPMI_BT_GET_SMS_ATN(ib->control_reg)) {
+        return;
+    }
+
+    IPMI_BT_SET_SMS_ATN(ib->control_reg, val);
+    if (val) {
+        if (irq && !IPMI_BT_GET_B2H_ATN(ib->control_reg) &&
+                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
+            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
+            ipmi_bt_raise_irq(ib);
+        }
+    } else {
+        if (!IPMI_BT_GET_B2H_ATN(ib->control_reg) &&
+                IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
+            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
+            ipmi_bt_lower_irq(ib);
+        }
+    }
+}
+
+static void ipmi_bt_handle_reset(IPMIInterface *ii, bool is_cold)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIBT *ib = iic->get_backend_data(ii);
+
+    if (is_cold) {
+        /* Disable the BT interrupt on reset */
+        if (IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
+            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
+            ipmi_bt_lower_irq(ib);
+        }
+        IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 0);
+    }
+}
+
+static void ipmi_bt_set_irq_enable(IPMIInterface *ii, int val)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIBT *ib = iic->get_backend_data(ii);
+
+    ib->irqs_enabled = val;
+}
+
+static void ipmi_bt_init(IPMIInterface *ii, Error **errp)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIBT *ib = iic->get_backend_data(ii);
+
+    ib->io_length = 3;
+
+    memory_region_init_io(&ib->io, NULL, &ipmi_bt_io_ops, ii, "ipmi-bt", 3);
+}
+
+int ipmi_bt_vmstate_post_load(void *opaque, int version)
+{
+    IPMIBT *ib = opaque;
+
+    /* Make sure all the values are sane. */
+    if (ib->outpos >= MAX_IPMI_MSG_SIZE || ib->outlen >= MAX_IPMI_MSG_SIZE ||
+        ib->outpos >= ib->outlen) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ipmi:bt: vmstate transfer received bad out values: %d %d\n",
+                      ib->outpos, ib->outlen);
+        ib->outpos = 0;
+        ib->outlen = 0;
+    }
+
+    if (ib->inlen >= MAX_IPMI_MSG_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ipmi:bt: vmstate transfer received bad in value: %d\n",
+                      ib->inlen);
+        ib->inlen = 0;
+    }
+
+    return 0;
+}
+
+const VMStateDescription vmstate_IPMIBT = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "bt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = ipmi_bt_vmstate_post_load,
+    .fields      = (VMStateField[]) {
+        VMSTATE_BOOL(obf_irq_set, IPMIBT),
+        VMSTATE_BOOL(atn_irq_set, IPMIBT),
+        VMSTATE_BOOL(irqs_enabled, IPMIBT),
+        VMSTATE_UINT32(outpos, IPMIBT),
+        VMSTATE_UINT32(outlen, IPMIBT),
+        VMSTATE_UINT8_ARRAY(outmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
+        VMSTATE_UINT32(inlen, IPMIBT),
+        VMSTATE_UINT8_ARRAY(inmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
+        VMSTATE_UINT8(control_reg, IPMIBT),
+        VMSTATE_UINT8(mask_reg, IPMIBT),
+        VMSTATE_UINT8(waiting_rsp, IPMIBT),
+        VMSTATE_UINT8(waiting_seq, IPMIBT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+void ipmi_bt_get_fwinfo(struct IPMIBT *ib, IPMIFwInfo *info)
+{
+    info->interface_name = "bt";
+    info->interface_type = IPMI_SMBIOS_BT;
+    info->ipmi_spec_major_revision = 2;
+    info->ipmi_spec_minor_revision = 0;
+    info->base_address = ib->io_base;
+    info->register_length = ib->io_length;
+    info->register_spacing = 1;
+    info->memspace = IPMI_MEMSPACE_IO;
+    info->irq_type = IPMI_LEVEL_IRQ;
+}
+
+void ipmi_bt_class_init(IPMIInterfaceClass *iic)
+{
+    iic->init = ipmi_bt_init;
+    iic->set_atn = ipmi_bt_set_atn;
+    iic->handle_rsp = ipmi_bt_handle_rsp;
+    iic->handle_if_event = ipmi_bt_handle_event;
+    iic->set_irq_enable = ipmi_bt_set_irq_enable;
+    iic->reset = ipmi_bt_handle_reset;
+}
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index a696096cbb..c102778712 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -26,403 +26,46 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/ipmi/ipmi.h"
 #include "hw/irq.h"
+#include "hw/ipmi/ipmi_bt.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
-/* Control register */
-#define IPMI_BT_CLR_WR_BIT         0
-#define IPMI_BT_CLR_RD_BIT         1
-#define IPMI_BT_H2B_ATN_BIT        2
-#define IPMI_BT_B2H_ATN_BIT        3
-#define IPMI_BT_SMS_ATN_BIT        4
-#define IPMI_BT_HBUSY_BIT          6
-#define IPMI_BT_BBUSY_BIT          7
-
-#define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)
-
-#define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)
-
-#define IPMI_BT_GET_H2B_ATN(d)     (((d) >> IPMI_BT_H2B_ATN_BIT) & 0x1)
-
-#define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
-#define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1)
-#define IPMI_BT_SET_B2H_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_B2H_ATN_MASK) | \
-                                        (!!(v) << IPMI_BT_B2H_ATN_BIT)))
-
-#define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
-#define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1)
-#define IPMI_BT_SET_SMS_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_SMS_ATN_MASK) | \
-                                        (!!(v) << IPMI_BT_SMS_ATN_BIT)))
-
-#define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
-#define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
-#define IPMI_BT_SET_HBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
-                                       (!!(v) << IPMI_BT_HBUSY_BIT)))
-
-#define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
-#define IPMI_BT_SET_BBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_BBUSY_MASK) | \
-                                       (!!(v) << IPMI_BT_BBUSY_BIT)))
-
-
-/* Mask register */
-#define IPMI_BT_B2H_IRQ_EN_BIT     0
-#define IPMI_BT_B2H_IRQ_BIT        1
-
-#define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
-#define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) & 0x1)
-#define IPMI_BT_SET_B2H_IRQ_EN(d, v) ((d) = (((d) & ~IPMI_BT_B2H_IRQ_EN_MASK) |\
-                                        (!!(v) << IPMI_BT_B2H_IRQ_EN_BIT)))
-
-#define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
-#define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0x1)
-#define IPMI_BT_SET_B2H_IRQ(d, v)    ((d) = (((d) & ~IPMI_BT_B2H_IRQ_MASK) | \
-                                        (!!(v) << IPMI_BT_B2H_IRQ_BIT)))
-
-typedef struct IPMIBT {
-    IPMIBmc *bmc;
-
-    bool do_wake;
-
-    qemu_irq irq;
-
-    uint32_t io_base;
-    unsigned long io_length;
-    MemoryRegion io;
-
-    bool obf_irq_set;
-    bool atn_irq_set;
-    bool use_irq;
-    bool irqs_enabled;
-
-    uint8_t outmsg[MAX_IPMI_MSG_SIZE];
-    uint32_t outpos;
-    uint32_t outlen;
-
-    uint8_t inmsg[MAX_IPMI_MSG_SIZE];
-    uint32_t inlen;
-
-    uint8_t control_reg;
-    uint8_t mask_reg;
-
-    /*
-     * This is a response number that we send with the command to make
-     * sure that the response matches the command.
-     */
-    uint8_t waiting_rsp;
-    uint8_t waiting_seq;
-} IPMIBT;
-
-#define IPMI_CMD_GET_BT_INTF_CAP        0x36
-
-static void ipmi_bt_handle_event(IPMIInterface *ii)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIBT *ib = iic->get_backend_data(ii);
-
-    if (ib->inlen < 4) {
-        goto out;
-    }
-    /* Note that overruns are handled by handle_command */
-    if (ib->inmsg[0] != (ib->inlen - 1)) {
-        /* Length mismatch, just ignore. */
-        IPMI_BT_SET_BBUSY(ib->control_reg, 1);
-        ib->inlen = 0;
-        goto out;
-    }
-    if ((ib->inmsg[1] == (IPMI_NETFN_APP << 2)) &&
-                        (ib->inmsg[3] == IPMI_CMD_GET_BT_INTF_CAP)) {
-        /* We handle this one ourselves. */
-        ib->outmsg[0] = 9;
-        ib->outmsg[1] = ib->inmsg[1] | 0x04;
-        ib->outmsg[2] = ib->inmsg[2];
-        ib->outmsg[3] = ib->inmsg[3];
-        ib->outmsg[4] = 0;
-        ib->outmsg[5] = 1; /* Only support 1 outstanding request. */
-        if (sizeof(ib->inmsg) > 0xff) { /* Input buffer size */
-            ib->outmsg[6] = 0xff;
-        } else {
-            ib->outmsg[6] = (unsigned char) sizeof(ib->inmsg);
-        }
-        if (sizeof(ib->outmsg) > 0xff) { /* Output buffer size */
-            ib->outmsg[7] = 0xff;
-        } else {
-            ib->outmsg[7] = (unsigned char) sizeof(ib->outmsg);
-        }
-        ib->outmsg[8] = 10; /* Max request to response time */
-        ib->outmsg[9] = 0; /* Don't recommend retries */
-        ib->outlen = 10;
-        IPMI_BT_SET_BBUSY(ib->control_reg, 0);
-        IPMI_BT_SET_B2H_ATN(ib->control_reg, 1);
-        if (ib->use_irq && ib->irqs_enabled &&
-                !IPMI_BT_GET_B2H_IRQ(ib->mask_reg) &&
-                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
-            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
-            qemu_irq_raise(ib->irq);
-        }
-        goto out;
-    }
-    ib->waiting_seq = ib->inmsg[2];
-    ib->inmsg[2] = ib->inmsg[1];
-    {
-        IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ib->bmc);
-        bk->handle_command(ib->bmc, ib->inmsg + 2, ib->inlen - 2,
-                           sizeof(ib->inmsg), ib->waiting_rsp);
-    }
- out:
-    return;
-}
-
-static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
-                                unsigned char *rsp, unsigned int rsp_len)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIBT *ib = iic->get_backend_data(ii);
-
-    if (ib->waiting_rsp == msg_id) {
-        ib->waiting_rsp++;
-        if (rsp_len > (sizeof(ib->outmsg) - 2)) {
-            ib->outmsg[0] = 4;
-            ib->outmsg[1] = rsp[0];
-            ib->outmsg[2] = ib->waiting_seq;
-            ib->outmsg[3] = rsp[1];
-            ib->outmsg[4] = IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
-            ib->outlen = 5;
-        } else {
-            ib->outmsg[0] = rsp_len + 1;
-            ib->outmsg[1] = rsp[0];
-            ib->outmsg[2] = ib->waiting_seq;
-            memcpy(ib->outmsg + 3, rsp + 1, rsp_len - 1);
-            ib->outlen = rsp_len + 2;
-        }
-        IPMI_BT_SET_BBUSY(ib->control_reg, 0);
-        IPMI_BT_SET_B2H_ATN(ib->control_reg, 1);
-        if (ib->use_irq && ib->irqs_enabled &&
-                !IPMI_BT_GET_B2H_IRQ(ib->mask_reg) &&
-                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
-            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
-            qemu_irq_raise(ib->irq);
-        }
-    }
-}
-
-
-static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigned size)
-{
-    IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIBT *ib = iic->get_backend_data(ii);
-    uint32_t ret = 0xff;
-
-    switch (addr & 3) {
-    case 0:
-        ret = ib->control_reg;
-        break;
-    case 1:
-        if (ib->outpos < ib->outlen) {
-            ret = ib->outmsg[ib->outpos];
-            ib->outpos++;
-            if (ib->outpos == ib->outlen) {
-                ib->outpos = 0;
-                ib->outlen = 0;
-            }
-        } else {
-            ret = 0xff;
-        }
-        break;
-    case 2:
-        ret = ib->mask_reg;
-        break;
-    }
-    return ret;
-}
-
-static void ipmi_bt_signal(IPMIBT *ib, IPMIInterface *ii)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-
-    ib->do_wake = 1;
-    while (ib->do_wake) {
-        ib->do_wake = 0;
-        iic->handle_if_event(ii);
-    }
-}
-
-static void ipmi_bt_ioport_write(void *opaque, hwaddr addr, uint64_t val,
-                                 unsigned size)
-{
-    IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIBT *ib = iic->get_backend_data(ii);
-
-    switch (addr & 3) {
-    case 0:
-        if (IPMI_BT_GET_CLR_WR(val)) {
-            ib->inlen = 0;
-        }
-        if (IPMI_BT_GET_CLR_RD(val)) {
-            ib->outpos = 0;
-        }
-        if (IPMI_BT_GET_B2H_ATN(val)) {
-            IPMI_BT_SET_B2H_ATN(ib->control_reg, 0);
-        }
-        if (IPMI_BT_GET_SMS_ATN(val)) {
-            IPMI_BT_SET_SMS_ATN(ib->control_reg, 0);
-        }
-        if (IPMI_BT_GET_HBUSY(val)) {
-            /* Toggle */
-            IPMI_BT_SET_HBUSY(ib->control_reg,
-                              !IPMI_BT_GET_HBUSY(ib->control_reg));
-        }
-        if (IPMI_BT_GET_H2B_ATN(val)) {
-            IPMI_BT_SET_BBUSY(ib->control_reg, 1);
-            ipmi_bt_signal(ib, ii);
-        }
-        break;
-
-    case 1:
-        if (ib->inlen < sizeof(ib->inmsg)) {
-            ib->inmsg[ib->inlen] = val;
-        }
-        ib->inlen++;
-        break;
-
-    case 2:
-        if (IPMI_BT_GET_B2H_IRQ_EN(val) !=
-                        IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
-            if (IPMI_BT_GET_B2H_IRQ_EN(val)) {
-                if (IPMI_BT_GET_B2H_ATN(ib->control_reg) ||
-                        IPMI_BT_GET_SMS_ATN(ib->control_reg)) {
-                    IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
-                    qemu_irq_raise(ib->irq);
-                }
-                IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 1);
-            } else {
-                if (IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
-                    IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
-                    qemu_irq_lower(ib->irq);
-                }
-                IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 0);
-            }
-        }
-        if (IPMI_BT_GET_B2H_IRQ(val) && IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
-            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
-            qemu_irq_lower(ib->irq);
-        }
-        break;
-    }
-}
-
-static const MemoryRegionOps ipmi_bt_io_ops = {
-    .read = ipmi_bt_ioport_read,
-    .write = ipmi_bt_ioport_write,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void ipmi_bt_set_atn(IPMIInterface *ii, int val, int irq)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIBT *ib = iic->get_backend_data(ii);
-
-    if (!!val == IPMI_BT_GET_SMS_ATN(ib->control_reg)) {
-        return;
-    }
-
-    IPMI_BT_SET_SMS_ATN(ib->control_reg, val);
-    if (val) {
-        if (irq && ib->use_irq && ib->irqs_enabled &&
-                !IPMI_BT_GET_B2H_ATN(ib->control_reg) &&
-                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
-            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
-            qemu_irq_raise(ib->irq);
-        }
-    } else {
-        if (!IPMI_BT_GET_B2H_ATN(ib->control_reg) &&
-                IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
-            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
-            qemu_irq_lower(ib->irq);
-        }
-    }
-}
-
-static void ipmi_bt_handle_reset(IPMIInterface *ii, bool is_cold)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIBT *ib = iic->get_backend_data(ii);
-
-    if (is_cold) {
-        /* Disable the BT interrupt on reset */
-        if (IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
-            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
-            qemu_irq_lower(ib->irq);
-        }
-        IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 0);
-    }
-}
-
-static void ipmi_bt_set_irq_enable(IPMIInterface *ii, int val)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIBT *ib = iic->get_backend_data(ii);
-
-    ib->irqs_enabled = val;
-}
-
-static void ipmi_bt_init(IPMIInterface *ii, Error **errp)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIBT *ib = iic->get_backend_data(ii);
-
-    ib->io_length = 3;
-
-    memory_region_init_io(&ib->io, NULL, &ipmi_bt_io_ops, ii, "ipmi-bt", 3);
-}
-
-
 #define TYPE_ISA_IPMI_BT "isa-ipmi-bt"
 #define ISA_IPMI_BT(obj) OBJECT_CHECK(ISAIPMIBTDevice, (obj), \
-                                       TYPE_ISA_IPMI_BT)
+                                      TYPE_ISA_IPMI_BT)
 
 typedef struct ISAIPMIBTDevice {
     ISADevice dev;
     int32_t isairq;
+    qemu_irq irq;
     IPMIBT bt;
     uint32_t uuid;
 } ISAIPMIBTDevice;
 
-static void ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
+static void isa_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
 {
     ISAIPMIBTDevice *iib = ISA_IPMI_BT(ii);
 
-    info->interface_name = "bt";
-    info->interface_type = IPMI_SMBIOS_BT;
-    info->ipmi_spec_major_revision = 2;
-    info->ipmi_spec_minor_revision = 0;
-    info->base_address = iib->bt.io_base;
-    info->register_length = iib->bt.io_length;
-    info->register_spacing = 1;
-    info->memspace = IPMI_MEMSPACE_IO;
-    info->irq_type = IPMI_LEVEL_IRQ;
+    ipmi_bt_get_fwinfo(&iib->bt, info);
     info->interrupt_number = iib->isairq;
     info->i2c_slave_address = iib->bt.bmc->slave_addr;
     info->uuid = iib->uuid;
 }
 
-static void ipmi_bt_class_init(IPMIInterfaceClass *iic)
+static void isa_ipmi_bt_raise_irq(IPMIBT *ib)
 {
-    iic->init = ipmi_bt_init;
-    iic->set_atn = ipmi_bt_set_atn;
-    iic->handle_rsp = ipmi_bt_handle_rsp;
-    iic->handle_if_event = ipmi_bt_handle_event;
-    iic->set_irq_enable = ipmi_bt_set_irq_enable;
-    iic->reset = ipmi_bt_handle_reset;
-    iic->get_fwinfo = ipmi_bt_get_fwinfo;
+    ISAIPMIBTDevice *iib = ib->opaque;
+
+    qemu_irq_raise(iib->irq);
+}
+
+static void isa_ipmi_bt_lower_irq(IPMIBT *ib)
+{
+    ISAIPMIBTDevice *iib = ib->opaque;
+
+    qemu_irq_lower(iib->irq);
 }
 
 static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
@@ -440,14 +83,17 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
     iib->uuid = ipmi_next_uuid();
 
     iib->bt.bmc->intf = ii;
+    iib->bt.opaque = iib;
 
     iic->init(ii, errp);
     if (*errp)
         return;
 
     if (iib->isairq > 0) {
-        isa_init_irq(isadev, &iib->bt.irq, iib->isairq);
+        isa_init_irq(isadev, &iib->irq, iib->isairq);
         iib->bt.use_irq = 1;
+        iib->bt.raise_irq = isa_ipmi_bt_raise_irq;
+        iib->bt.lower_irq = isa_ipmi_bt_lower_irq;
     }
 
     qdev_set_legacy_instance_id(dev, iib->bt.io_base, iib->bt.io_length);
@@ -455,52 +101,6 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &iib->bt.io, iib->bt.io_base);
 }
 
-static int ipmi_bt_vmstate_post_load(void *opaque, int version)
-{
-    IPMIBT *ib = opaque;
-
-    /* Make sure all the values are sane. */
-    if (ib->outpos >= MAX_IPMI_MSG_SIZE || ib->outlen >= MAX_IPMI_MSG_SIZE ||
-        ib->outpos >= ib->outlen) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "ipmi:bt: vmstate transfer received bad out values: %d %d\n",
-                      ib->outpos, ib->outlen);
-        ib->outpos = 0;
-        ib->outlen = 0;
-    }
-
-    if (ib->inlen >= MAX_IPMI_MSG_SIZE) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "ipmi:bt: vmstate transfer received bad in value: %d\n",
-                      ib->inlen);
-        ib->inlen = 0;
-    }
-
-    return 0;
-}
-
-const VMStateDescription vmstate_IPMIBT = {
-    .name = TYPE_IPMI_INTERFACE_PREFIX "bt",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .post_load = ipmi_bt_vmstate_post_load,
-    .fields      = (VMStateField[]) {
-        VMSTATE_BOOL(obf_irq_set, IPMIBT),
-        VMSTATE_BOOL(atn_irq_set, IPMIBT),
-        VMSTATE_BOOL(irqs_enabled, IPMIBT),
-        VMSTATE_UINT32(outpos, IPMIBT),
-        VMSTATE_UINT32(outlen, IPMIBT),
-        VMSTATE_UINT8_ARRAY(outmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
-        VMSTATE_UINT32(inlen, IPMIBT),
-        VMSTATE_UINT8_ARRAY(inmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
-        VMSTATE_UINT8(control_reg, IPMIBT),
-        VMSTATE_UINT8(mask_reg, IPMIBT),
-        VMSTATE_UINT8(waiting_rsp, IPMIBT),
-        VMSTATE_UINT8(waiting_seq, IPMIBT),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static const VMStateDescription vmstate_ISAIPMIBTDevice = {
     .name = TYPE_IPMI_INTERFACE_PREFIX "isa-bt",
     .version_id = 2,
@@ -548,6 +148,7 @@ static void isa_ipmi_bt_class_init(ObjectClass *oc, void *data)
 
     iic->get_backend_data = isa_ipmi_bt_get_backend_data;
     ipmi_bt_class_init(iic);
+    iic->get_fwinfo = isa_ipmi_bt_get_fwinfo;
 }
 
 static const TypeInfo isa_ipmi_bt_info = {
diff --git a/include/hw/ipmi/ipmi_bt.h b/include/hw/ipmi/ipmi_bt.h
new file mode 100644
index 0000000000..9667aaa88a
--- /dev/null
+++ b/include/hw/ipmi/ipmi_bt.h
@@ -0,0 +1,72 @@
+/*
+ * QEMU IPMI BT emulation
+ *
+ * Copyright (c) 2015 Corey Minyard, MontaVista Software, LLC
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_IPMI_BT_H
+#define HW_IPMI_BT_H
+
+#include "hw/ipmi/ipmi.h"
+
+typedef struct IPMIBT {
+    IPMIBmc *bmc;
+
+    bool do_wake;
+
+    bool obf_irq_set;
+    bool atn_irq_set;
+    bool irqs_enabled;
+
+    uint8_t outmsg[MAX_IPMI_MSG_SIZE];
+    uint32_t outpos;
+    uint32_t outlen;
+
+    uint8_t inmsg[MAX_IPMI_MSG_SIZE];
+    uint32_t inlen;
+
+    uint8_t control_reg;
+    uint8_t mask_reg;
+
+    /*
+     * This is a response number that we send with the command to make
+     * sure that the response matches the command.
+     */
+    uint8_t waiting_rsp;
+    uint8_t waiting_seq;
+
+    uint32_t io_base;
+    unsigned long io_length;
+    MemoryRegion io;
+
+    void (*raise_irq)(struct IPMIBT *ib);
+    void (*lower_irq)(struct IPMIBT *ib);
+    void *opaque;
+
+    bool use_irq;
+} IPMIBT;
+
+void ipmi_bt_get_fwinfo(IPMIBT *ik, IPMIFwInfo *info);
+void ipmi_bt_class_init(IPMIInterfaceClass *iic);
+extern const VMStateDescription vmstate_IPMIBT;
+int ipmi_bt_vmstate_post_load(void *opaque, int version);
+
+#endif /* HW_IPMI_BT_H */
-- 
2.17.1


