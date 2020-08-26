Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D176C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C4A42078A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvpwVATv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4A42078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAx2i-0004kw-HY
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAwnR-0007Ar-B9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAwnP-0008NU-Gx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598453582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtNfs9Y7alg7kpJbY2NUPkJ1krlAjwWxnSjia7sxiR0=;
 b=dvpwVATvkfBI9e92lrMF7slWJlIJUKbis/ylqCzgnIm7heQdVLWYPW/5WhUwgXTxkUxl8Y
 An2xe30Ru5tNbn0R9OIDHHI81yzW6ThkEEKBgnt+U5U1tAzXppYpCGuxXUeS7jDBwhwC4A
 HNuFVJ4KehDYN+OVNZ3drjuwlJVYmPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-_v97pHrPO1CXd93OkEEyqw-1; Wed, 26 Aug 2020 10:52:47 -0400
X-MC-Unique: _v97pHrPO1CXd93OkEEyqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3299107464A;
 Wed, 26 Aug 2020 14:52:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE7A747C6;
 Wed, 26 Aug 2020 14:52:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 47B4F31FC6; Wed, 26 Aug 2020 16:52:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] hw/usb: Add U2F device check to passthru mode
Date: Wed, 26 Aug 2020 16:52:36 +0200
Message-Id: <20200826145239.6077-16-kraxel@redhat.com>
In-Reply-To: <20200826145239.6077-1-kraxel@redhat.com>
References: <20200826145239.6077-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: César Belley <cesar.belley@lse.epita.fr>

This patchs adds a check to verify that the device passed through the
hidraw property is a U2F device.

The check is done by ensuring that the first values of the report
descriptor (USAGE PAGE and USAGE) correspond to those of a U2F device.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
Message-id: 20200826114209.28821-12-cesar.belley@lse.epita.fr
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/u2f-passthru.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index 106b5abf9ecc..f8771966c747 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -34,6 +34,12 @@
 
 #include "u2f.h"
 
+#ifdef CONFIG_LIBUDEV
+#include <libudev.h>
+#endif
+#include <linux/hidraw.h>
+#include <sys/ioctl.h>
+
 #define NONCE_SIZE 8
 #define BROADCAST_CID 0xFFFFFFFF
 #define TRANSACTION_TIMEOUT 120000
@@ -344,6 +350,34 @@ static void u2f_passthru_recv_from_guest(U2FKeyState *base,
     }
 }
 
+static bool u2f_passthru_is_u2f_device(int fd)
+{
+    int ret, rdesc_size;
+    struct hidraw_report_descriptor rdesc;
+    const uint8_t u2f_hid_report_desc_header[] = {
+        0x06, 0xd0, 0xf1, /* Usage Page (FIDO) */
+        0x09, 0x01,       /* Usage (FIDO) */
+    };
+
+    /* Get report descriptor size */
+    ret = ioctl(fd, HIDIOCGRDESCSIZE, &rdesc_size);
+    if (ret < 0 || rdesc_size < sizeof(u2f_hid_report_desc_header)) {
+        return false;
+    }
+
+    /* Get report descriptor */
+    memset(&rdesc, 0x0, sizeof(rdesc));
+    rdesc.size = rdesc_size;
+    ret = ioctl(fd, HIDIOCGRDESC, &rdesc);
+    if (ret < 0) {
+        return false;
+    }
+
+    /* Header bytes cover specific U2F rdesc values */
+    return memcmp(u2f_hid_report_desc_header, rdesc.value,
+                  sizeof(u2f_hid_report_desc_header)) == 0;
+}
+
 static void u2f_passthru_unrealize(U2FKeyState *base)
 {
     U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
@@ -368,6 +402,13 @@ static void u2f_passthru_realize(U2FKeyState *base, Error **errp)
                    key->hidraw);
         return;
     }
+
+    if (!u2f_passthru_is_u2f_device(fd)) {
+        qemu_close(fd);
+        error_setg(errp, "%s: Passed hidraw does not represent "
+                   "a U2F HID device", TYPE_U2F_PASSTHRU);
+        return;
+    }
     key->hidraw_fd = fd;
     u2f_passthru_reset(key);
 }
-- 
2.27.0


