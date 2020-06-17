Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADB3208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TS2CVvFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADB3208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVct-0006yF-F8
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlVbr-0005Vp-RQ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:47:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlVbq-0002fj-3f
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592390877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=O9zf9n7GEiVsmXcOFimTPQREBfNNWSvJ/Vo90Qn26VE=;
 b=TS2CVvFI9dzr5GCgQzCjPUBxuaQW+HvUbvP2UXoni9GAoDWoH8NuOH9zCuqRhSDbGXG1BS
 R1iBOFCK3IBF4p18QfZK7XUSdioD/AbmvXKaZyxs2YGSnPZJnBnQ5qNjM4yTSwPtM/+xr1
 ofRVlSD1DaLOzbVxiLZS2CsPiOjCkHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-iMjN69rXNEqbuQWFCR2zWg-1; Wed, 17 Jun 2020 06:47:55 -0400
X-MC-Unique: iMjN69rXNEqbuQWFCR2zWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC9DF10A86C8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:47:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB7A45C1C3;
 Wed, 17 Jun 2020 10:47:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 901E51753C; Wed, 17 Jun 2020 12:47:50 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] usb-host: workaround libusb bug
Date: Wed, 17 Jun 2020 12:47:50 +0200
Message-Id: <20200617104750.29511-3-kraxel@redhat.com>
In-Reply-To: <20200617104750.29511-1-kraxel@redhat.com>
References: <20200617104750.29511-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libusb seems to no allways call the completion callback for requests
canceled (which it is supposed to do according to the docs).  So add
a limit to avoid qemu waiting forever.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200529072225.3195-1-kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index e88db544bc9e..ad7ed8fb0c67 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -972,6 +972,7 @@ fail:
 static void usb_host_abort_xfers(USBHostDevice *s)
 {
     USBHostRequest *r, *rtmp;
+    int limit = 100;
 
     QTAILQ_FOREACH_SAFE(r, &s->requests, next, rtmp) {
         usb_host_req_abort(r);
@@ -982,6 +983,19 @@ static void usb_host_abort_xfers(USBHostDevice *s)
         memset(&tv, 0, sizeof(tv));
         tv.tv_usec = 2500;
         libusb_handle_events_timeout(ctx, &tv);
+        if (--limit == 0) {
+            /*
+             * Don't wait forever for libusb calling the complete
+             * callback (which will unlink and free the request).
+             *
+             * Leaking memory here, to make sure libusb will not
+             * access memory which we have released already.
+             */
+            QTAILQ_FOREACH_SAFE(r, &s->requests, next, rtmp) {
+                QTAILQ_REMOVE(&s->requests, r, next);
+            }
+            return;
+        }
     }
 }
 
-- 
2.18.4


