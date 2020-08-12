Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85311C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C6720838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="em0Vk0YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C6720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nIZ-0003ae-Fg
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHT-00023i-FD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:47 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:40874
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHR-0006kM-Py
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:47 -0400
Received: from MattGorko-Laptop.localdomain (unknown [78.194.154.81])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 995764150E;
 Wed, 12 Aug 2020 11:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1597225364; bh=cvFDhlHRNc+dPkxjMum8CmWTe5nwcNjnFM+clGU5O+A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=em0Vk0YKIG6rSMG59xPlsBi537X5MJZUR6dbM9NfSZvPO4aASiPLoEydWJWUqUww+
 C0FfLh7SU9h9uoz9szI+yMvAIQvSf5fIp9plvOTPl3Qa4XHXC9GWUc2PHC6pr05fzt
 5wYQcq7jxPISApHzVT89TSXP0HOTbdI5XrrDf0XM=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/13] hw/usb: Add U2F key base class
Date: Wed, 12 Aug 2020 11:41:25 +0200
Message-Id: <20200812094135.20550-4-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
References: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 05:42:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds the specification for the U2F key base class.
Used to group the common characteristics, this device class will be
inherited by its two variants, corresponding to the two modes:
passthrough and emulated

This prepares the U2F devices hierarchy which is as follow:
USB device -> u2f-key -> {u2f-passthru, u2f-emulated}.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 hw/usb/u2f.h | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 hw/usb/u2f.h

diff --git a/hw/usb/u2f.h b/hw/usb/u2f.h
new file mode 100644
index 0000000000..db30f3586b
--- /dev/null
+++ b/hw/usb/u2f.h
@@ -0,0 +1,92 @@
+/*
+ * U2F USB device.
+ *
+ * Copyright (c) 2020 César Belley <cesar.belley@lse.epita.fr>
+ * Written by César Belley <cesar.belley@lse.epita.fr>
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
+#ifndef U2F_H
+#define U2F_H
+
+#include "hw/qdev-core.h"
+
+#define U2FHID_PACKET_SIZE 64
+#define U2FHID_PENDING_IN_NUM 32
+
+typedef struct U2FKeyState U2FKeyState;
+typedef struct U2FKeyInfo U2FKeyInfo;
+
+#define TYPE_U2F_KEY "u2f-key"
+#define U2F_KEY(obj) \
+    OBJECT_CHECK(U2FKeyState, (obj), TYPE_U2F_KEY)
+#define U2F_KEY_CLASS(klass) \
+    OBJECT_CLASS_CHECK(U2FKeyClass, (klass), TYPE_U2F_KEY)
+#define U2F_KEY_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(U2FKeyClass, (obj), TYPE_U2F_KEY)
+
+/*
+ * Callbacks to be used by the U2F key base device (i.e. hw/u2f.c)
+ * to interact with its variants (i.e. hw/u2f-*.c)
+ */
+typedef struct U2FKeyClass {
+    /*< private >*/
+    USBDeviceClass parent_class;
+
+    /*< public >*/
+    void (*recv_from_guest)(U2FKeyState *key,
+                            const uint8_t packet[U2FHID_PACKET_SIZE]);
+    void (*realize)(U2FKeyState *key, Error **errp);
+    void (*unrealize)(U2FKeyState *key);
+} U2FKeyClass;
+
+/*
+ * State of the U2F key base device (i.e. hw/u2f.c)
+ */
+typedef struct U2FKeyState {
+    USBDevice dev;
+    USBEndpoint *ep;
+    uint8_t idle;
+
+    /* Pending packets to be send to the guest */
+    uint8_t pending_in[U2FHID_PENDING_IN_NUM][U2FHID_PACKET_SIZE];
+    uint8_t pending_in_start;
+    uint8_t pending_in_end;
+    uint8_t pending_in_num;
+} U2FKeyState;
+
+/*
+ * API to be used by the U2F key device variants (i.e. hw/u2f-*.c)
+ * to interact with the the U2F key base device (i.e. hw/u2f.c)
+ */
+void u2f_send_to_guest(U2FKeyState *key,
+                       const uint8_t packet[U2FHID_PACKET_SIZE]);
+
+extern const VMStateDescription vmstate_u2f_key;
+
+#define VMSTATE_U2F_KEY(_field, _state) {                            \
+    .name       = (stringify(_field)),                               \
+    .size       = sizeof(U2FKeyState),                               \
+    .vmsd       = &vmstate_u2f_key,                                  \
+    .flags      = VMS_STRUCT,                                        \
+    .offset     = vmstate_offset_value(_state, _field, U2FKeyState), \
+}
+
+#endif /* U2F_H */
-- 
2.28.0


