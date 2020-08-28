Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20480C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9F420665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDWWKc9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9F420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBZTy-0005o1-UB
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRW-0000d7-V2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:09:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRS-0003RI-2S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598602135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6J2zt+T0zv9qukEkUS4yvFYuQ+2v0y+WJwvBDg4/bkw=;
 b=IDWWKc9p6fxHgi/meVAPfQeWui7Di6ftryQGUFK8SU+c8LbODgxamDQz8D87hYOvVYJcsO
 vWyasWYUzMqY2YfDqqBs9XZeFlPksSsfB8pRnCGurfPBPH1BsBRm+S9BKJZuiy5wD4z1TS
 xeO3BmmvKRPcBq12m/qpfa/yZI19hUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-b6ocXnVNN3unaj7S8RMd4g-1; Fri, 28 Aug 2020 04:08:53 -0400
X-MC-Unique: b6ocXnVNN3unaj7S8RMd4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 173141084C96;
 Fri, 28 Aug 2020 08:08:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 312DF19D7D;
 Fri, 28 Aug 2020 08:08:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 26E1731E59; Fri, 28 Aug 2020 10:08:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] hw/usb: Add U2F key base class
Date: Fri, 28 Aug 2020 10:08:34 +0200
Message-Id: <20200828080845.28287-8-kraxel@redhat.com>
In-Reply-To: <20200828080845.28287-1-kraxel@redhat.com>
References: <20200828080845.28287-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 03:48:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


