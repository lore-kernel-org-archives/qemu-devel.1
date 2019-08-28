Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EDBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AD6217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AD6217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2xPH-0006rE-8j
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bsd@redhat.com>) id 1i2xOO-0006Rs-C5
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bsd@redhat.com>) id 1i2xOM-0003i3-OI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bsd@redhat.com>) id 1i2xOM-0003hY-J2
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:49:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0F56618B3D86
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:49:37 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com
 [10.18.17.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F38645D717;
 Wed, 28 Aug 2019 12:49:29 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 08:49:28 -0400
Message-ID: <jpga7bto3on.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 28 Aug 2019 12:49:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] usb-mtp: add sanity checks on rootdir
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Currently, we don't check if rootdir exists and is accessible.
Furthermore, a trailing slash results in a null "desc" string which
ends up in the share not visible in the guest. Add some simple
sanity checks for appropriate permissions. Also, bail out if the
user does not supply an absolute path.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 9846e4b513..7c07295519 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -2038,26 +2038,36 @@ static void usb_mtp_realize(USBDevice *dev, Error **errp)
 {
     MTPState *s = USB_MTP(dev);
 
-    usb_desc_create_serial(dev);
-    usb_desc_init(dev);
-    QTAILQ_INIT(&s->objects);
-    if (s->desc == NULL) {
-        if (s->root == NULL) {
-            error_setg(errp, "usb-mtp: rootdir property must be configured");
-            return;
-        }
-        s->desc = strrchr(s->root, '/');
-        if (s->desc && s->desc[0]) {
-            s->desc = g_strdup(s->desc + 1);
-        } else {
-            s->desc = g_strdup("none");
-        }
+    if ((s->root == NULL) || !g_path_is_absolute(s->root)) {
+        error_setg(errp, "usb-mtp: rootdir must be configured and be an absolute path");
+        return;
     }
+
+    if (access(s->root, R_OK) != 0) {
+        error_setg(errp, "usb-mtp: rootdir does not exist/not readable");
+        return;
+    } else if (!s->readonly && access(s->root, W_OK) != 0) {
+        error_setg(errp, "usb-mtp: rootdir does not have write permissions");
+        return;
+    }
+
     /* Mark store as RW */
     if (!s->readonly) {
         s->flags |= (1 << MTP_FLAG_WRITABLE);
     }
 
+    if (s->desc == NULL) {
+        /*
+         * This does not check if path exists
+         * but we have the checks above
+         */
+        s->desc = g_path_get_basename(s->root);
+    }
+
+    usb_desc_create_serial(dev);
+    usb_desc_init(dev);
+    QTAILQ_INIT(&s->objects);
+
 }
 
 static const VMStateDescription vmstate_usb_mtp = {
-- 
2.20.1


