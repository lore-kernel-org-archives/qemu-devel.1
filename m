Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D225C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E1A2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/lu8ZLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E1A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfJG-00070d-8u
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFZ-00089W-Ql
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFX-0006Zz-AY
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6J2zt+T0zv9qukEkUS4yvFYuQ+2v0y+WJwvBDg4/bkw=;
 b=N/lu8ZLJz32hWCiwp/ef1lACNKrTf/OUq/Pjw4LeCUxDzdnVaOGI30p3kWF+boTIzUYhvb
 Hxdhf8kcs35hizE0MrS8chpDCssehXHbv2ROhFd0sQxeAmgNwh01B2pHboh8Kxm5mIXEeK
 BD0rmj3bued6QB7SFzj7yLct4gJeYoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-RB-VYZXqPpmpMqFwe3_-ug-1; Mon, 31 Aug 2020 04:33:08 -0400
X-MC-Unique: RB-VYZXqPpmpMqFwe3_-ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8331110ABDA0;
 Mon, 31 Aug 2020 08:33:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAE66925BB;
 Mon, 31 Aug 2020 08:33:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2A4F6204AE; Mon, 31 Aug 2020 10:33:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] hw/usb: Add U2F key base class
Date: Mon, 31 Aug 2020 10:32:50 +0200
Message-Id: <20200831083301.6357-8-kraxel@redhat.com>
In-Reply-To: <20200831083301.6357-1-kraxel@redhat.com>
References: <20200831083301.6357-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: César Belley <cesar.belley@lse.epita.fr>

This patch adds the specification for the U2F key base class.
Used to group the common characteristics, this device class will be
inherited by its two variants, corresponding to the two modes:
passthrough and emulated

This prepares the U2F devices hierarchy which is as follow:
USB device -> u2f-key -> {u2f-passthru, u2f-emulated}.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
Message-id: 20200826114209.28821-4-cesar.belley@lse.epita.fr
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/u2f.h | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 hw/usb/u2f.h

diff --git a/hw/usb/u2f.h b/hw/usb/u2f.h
new file mode 100644
index 000000000000..db30f3586bf7
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
2.27.0


