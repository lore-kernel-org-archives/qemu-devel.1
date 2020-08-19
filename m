Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B9CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A2D207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zt1svg+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A2D207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8H2B-0001FV-Uu
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 01:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwP-0007gU-0M
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54221
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwH-0006ha-My
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597816013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BxuhH6+Drmw5uYT+dWlDJ45CLzXxno4jER49ygELXPk=;
 b=Zt1svg+er994ibbt1fi47+RmteRBgh5Z2iRjY74oZ52XxAAaASehPAJWIAep1KPmnIZJqD
 oUJacFUWIyRv7Zyu3DIAZw6ByefuZPglqp12qCcqmCqwUi/87pjBFxnaWQtLJowPH0t5H/
 uyLOOyDfuDMqxcvejigEBQGxH3asyS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-LuIgagPZMBuYhb5q8cOr9w-1; Wed, 19 Aug 2020 01:46:51 -0400
X-MC-Unique: LuIgagPZMBuYhb5q8cOr9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 976361084C89;
 Wed, 19 Aug 2020 05:46:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E2DA1014182;
 Wed, 19 Aug 2020 05:46:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E6AA331E43; Wed, 19 Aug 2020 07:46:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/17] hw/usb: Add U2F device check to passthru mode
Date: Wed, 19 Aug 2020 07:46:43 +0200
Message-Id: <20200819054644.30610-17-kraxel@redhat.com>
In-Reply-To: <20200819054644.30610-1-kraxel@redhat.com>
References: <20200819054644.30610-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Message-id: 20200812094135.20550-13-cesar.belley@lse.epita.fr
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/u2f-passthru.c | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/usb/Makefile.objs  |  3 ++-
 2 files changed, 43 insertions(+), 1 deletion(-)

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
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 7842a3175f8f..9e7e1f33a51e 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -38,7 +38,8 @@ endif
 endif
 
 ifeq ($(CONFIG_USB_U2F),y)
-common-obj-y                          += u2f.o u2f-passthru.o
+common-obj-y                          += u2f.o
+common-obj-$(CONFIG_LINUX)            += u2f-passthru.o
 common-obj-$(CONFIG_U2F)              += u2f-emulated.o
 u2f-emulated.o-cflags = $(U2F_CFLAGS)
 u2f-emulated.o-libs = $(U2F_LIBS)
-- 
2.18.4


