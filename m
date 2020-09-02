Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161E7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CD82072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MHMJuaQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CD82072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVY0-0004E2-2j
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kDVWw-0002wV-TD
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:22:38 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:43446)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1kDVWt-0002vA-DG
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=qCEdw/S4IrIs/afZWI
 aYzQk1WsGow2KZ0FANMJCyoOQ=; b=MHMJuaQEigh+oLRlL5wycuh91eBxrmyLBS
 BKG6IFYZ/M6+p9Cw5ARtXB/NF9AlwMnKbds7XBzTcZT1nf3EzGZQB+2Btj+0WaQY
 lGweTRpH42+BS4sUJEx9IxtZK3miQtHeZwl5Wnj3xsdaICvrTn1lLobhJ2ROG5f4
 ySh4D1gZ4=
Received: from localhost.localdomain (unknown [183.134.168.235])
 by smtp1 (Coremail) with SMTP id GdxpCgAXbyO1xk9fAIYUAQ--.82S6;
 Thu, 03 Sep 2020 00:22:21 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com, kraxel@redhat.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, alxndr@bu.edu, peter.maydell@linaro.org,
 pbonzini@redhat.com
Subject: [RFC 2/3] xhci: make the IO handler reentrant
Date: Wed,  2 Sep 2020 09:22:05 -0700
Message-Id: <20200902162206.101872-3-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902162206.101872-1-liq3ea@163.com>
References: <20200902162206.101872-1-liq3ea@163.com>
X-CM-TRANSID: GdxpCgAXbyO1xk9fAIYUAQ--.82S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWrur4kWrWxCw4kCrW7Jwb_yoW7tr4rpF
 W0y34qgF4ftFsFgFs3J3yDAr15Grs7JF93Jr9xtryjvF4kAr9Ik3WayrWUtrsxWFy8G3yj
 9F4DZFyYkrnIyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdGYJUUUUU=
X-Originating-IP: [183.134.168.235]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiKR2TbVXlxi+gwAAAsz
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 12:22:24
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The guest can program the xhci DMA address to its MMIO.
This will cause an UAF issue.

Following is the reproducer:

cat << EOF | ./i386-softmmu/qemu-system-i386 -device nec-usb-xhci \
-trace usb\* -device usb-audio -device usb-storage,drive=mydrive \
-drive id=mydrive,file=null-co://,size=2M,format=raw,if=none \
-nodefaults -nographic -qtest stdio
outl 0xcf8 0x80001010
outl 0xcfc 0xc0202
outl 0xcf8 0x80001004
outl 0xcfc 0x1c77695e
writel 0xc0040 0xffffd855
writeq 0xc2000 0xff05140100000000
write 0x1d 0x1 0x27
write 0x2d 0x1 0x2e
write 0x17232 0x1 0x03
write 0x17254 0x1 0x05
write 0x17276 0x1 0x72
write 0x17278 0x1 0x02
write 0x3d 0x1 0x27
write 0x40 0x1 0x2e
write 0x41 0x1 0x72
write 0x42 0x1 0x01
write 0x4d 0x1 0x2e
write 0x4f 0x1 0x01
write 0x2007c 0x1 0xc7
writeq 0xc2000 0x5c05140100000000
write 0x20070 0x1 0x80
write 0x20078 0x1 0x08
write 0x2007c 0x1 0xfe
write 0x2007d 0x1 0x08
write 0x20081 0x1 0xff
write 0x20082 0x1 0x0b
write 0x20089 0x1 0x8c
write 0x2008d 0x1 0x04
write 0x2009d 0x1 0x10
writeq 0xc2000 0x2505ef019e092f00
EOF

This patch avoid this by adding a 'in_io' in XHCIState to indicate it is in IO
processing.

Buglink: https://bugs.launchpad.net/qemu/+bug/1891354

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/usb/hcd-xhci.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci.h |  1 +
 2 files changed, 61 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 46a2186d91..06cd235123 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2738,6 +2738,11 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
     XHCIState *xhci = ptr;
     uint32_t ret;
 
+    if (xhci->in_io) {
+        return 0;
+    }
+    xhci->in_io = true;
+
     switch (reg) {
     case 0x00: /* HCIVERSION, CAPLENGTH */
         ret = 0x01000000 | LEN_CAP;
@@ -2805,6 +2810,9 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
     }
 
     trace_usb_xhci_cap_read(reg, ret);
+
+    xhci->in_io = false;
+
     return ret;
 }
 
@@ -2813,6 +2821,11 @@ static uint64_t xhci_port_read(void *ptr, hwaddr reg, unsigned size)
     XHCIPort *port = ptr;
     uint32_t ret;
 
+    if (port->xhci->in_io) {
+        return 0;
+    }
+    port->xhci->in_io = true;
+
     switch (reg) {
     case 0x00: /* PORTSC */
         ret = port->portsc;
@@ -2828,6 +2841,9 @@ static uint64_t xhci_port_read(void *ptr, hwaddr reg, unsigned size)
     }
 
     trace_usb_xhci_port_read(port->portnr, reg, ret);
+
+    port->xhci->in_io = false;
+
     return ret;
 }
 
@@ -2837,6 +2853,11 @@ static void xhci_port_write(void *ptr, hwaddr reg,
     XHCIPort *port = ptr;
     uint32_t portsc, notify;
 
+    if (port->xhci->in_io) {
+        return;
+    }
+    port->xhci->in_io = true;
+
     trace_usb_xhci_port_write(port->portnr, reg, val);
 
     switch (reg) {
@@ -2896,6 +2917,7 @@ static void xhci_port_write(void *ptr, hwaddr reg,
     default:
         trace_usb_xhci_unimplemented("port write", reg);
     }
+    port->xhci->in_io = false;
 }
 
 static uint64_t xhci_oper_read(void *ptr, hwaddr reg, unsigned size)
@@ -2903,6 +2925,11 @@ static uint64_t xhci_oper_read(void *ptr, hwaddr reg, unsigned size)
     XHCIState *xhci = ptr;
     uint32_t ret;
 
+    if (xhci->in_io) {
+        return 0;
+    }
+    xhci->in_io = true;
+
     switch (reg) {
     case 0x00: /* USBCMD */
         ret = xhci->usbcmd;
@@ -2937,6 +2964,9 @@ static uint64_t xhci_oper_read(void *ptr, hwaddr reg, unsigned size)
     }
 
     trace_usb_xhci_oper_read(reg, ret);
+
+    xhci->in_io = false;
+
     return ret;
 }
 
@@ -2946,6 +2976,11 @@ static void xhci_oper_write(void *ptr, hwaddr reg,
     XHCIState *xhci = ptr;
     DeviceState *d = DEVICE(ptr);
 
+    if (xhci->in_io) {
+        return;
+    }
+    xhci->in_io = true;
+
     trace_usb_xhci_oper_write(reg, val);
 
     switch (reg) {
@@ -3008,6 +3043,7 @@ static void xhci_oper_write(void *ptr, hwaddr reg,
     default:
         trace_usb_xhci_unimplemented("oper write", reg);
     }
+    xhci->in_io = false;
 }
 
 static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
@@ -3016,6 +3052,11 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
     XHCIState *xhci = ptr;
     uint32_t ret = 0;
 
+    if (xhci->in_io) {
+        return 0;
+    }
+    xhci->in_io = true;
+
     if (reg < 0x20) {
         switch (reg) {
         case 0x00: /* MFINDEX */
@@ -3054,6 +3095,9 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
     }
 
     trace_usb_xhci_runtime_read(reg, ret);
+
+    xhci->in_io = false;
+
     return ret;
 }
 
@@ -3063,10 +3107,17 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
     XHCIState *xhci = ptr;
     int v = (reg - 0x20) / 0x20;
     XHCIInterrupter *intr = &xhci->intr[v];
+
+    if (xhci->in_io) {
+        return;
+    }
+    xhci->in_io = true;
+
     trace_usb_xhci_runtime_write(reg, val);
 
     if (reg < 0x20) {
         trace_usb_xhci_unimplemented("runtime write", reg);
+        xhci->in_io = false;
         return;
     }
 
@@ -3121,6 +3172,7 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
     default:
         trace_usb_xhci_unimplemented("oper write", reg);
     }
+    xhci->in_io = false;
 }
 
 static uint64_t xhci_doorbell_read(void *ptr, hwaddr reg,
@@ -3137,10 +3189,17 @@ static void xhci_doorbell_write(void *ptr, hwaddr reg,
     XHCIState *xhci = ptr;
     unsigned int epid, streamid;
 
+    if (xhci->in_io) {
+        return;
+    }
+
+    xhci->in_io = true;
+
     trace_usb_xhci_doorbell_write(reg, val);
 
     if (!xhci_running(xhci)) {
         DPRINTF("xhci: wrote doorbell while xHC stopped or paused\n");
+        xhci->in_io = false;
         return;
     }
 
@@ -3165,6 +3224,7 @@ static void xhci_doorbell_write(void *ptr, hwaddr reg,
             xhci_kick_ep(xhci, reg, epid, streamid);
         }
     }
+    xhci->in_io = false;
 }
 
 static void xhci_cap_write(void *opaque, hwaddr addr, uint64_t val,
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 946af51fc2..ed16232c96 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -227,6 +227,7 @@ struct XHCIState {
     XHCIRing cmd_ring;
 
     bool nec_quirks;
+    bool in_io;
 };
 
 #endif
-- 
2.17.1


