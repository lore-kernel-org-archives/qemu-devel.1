Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD93BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877CB206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="DHKOWM28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877CB206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAB3w-00050r-Ec
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=45nv=cc=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kAAyj-00034L-Jf
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:49:33 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:54854
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=45nv=cc=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kAAyg-0003e1-Lk
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:49:32 -0400
Received: from MattGorko-Laptop.home
 (lfbn-idf1-1-1395-83.w90-79.abo.wanadoo.fr [90.79.87.83])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 7185D412DD;
 Mon, 24 Aug 2020 13:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1598269759; bh=oV+J1fqI2mcTVzHKlE6s1N2B0KJ3I3Q7UEclmD7xnak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DHKOWM28qKcqN30RBm6HL+5B5YiUTMs+RJjyM3za1RjK+dseqTVtxJJgYhkf/2asl
 jbBsCvNGWDqsKgevaYx1tua3kIQ0fP50Z0M//inOtt6RMp1Mg/Pqdib4TPCGrhdPgn
 9xWdXZtN2ZItZIb5AkC+mRcxBvDHXHBebPPMLv8w=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/13] hw/usb: Add U2F device check to passthru mode
Date: Mon, 24 Aug 2020 13:48:26 +0200
Message-Id: <20200824114827.81623-13-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824114827.81623-1-cesar.belley@lse.epita.fr>
References: <20200824114827.81623-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=45nv=cc=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 07:49:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patchs adds a check to verify that the device passed through the
hidraw property is a U2F device.

The check is done by ensuring that the first values of the report
descriptor (USAGE PAGE and USAGE) correspond to those of a U2F device.

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 hw/usb/u2f-passthru.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index 106b5abf9e..f8771966c7 100644
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
2.28.0


