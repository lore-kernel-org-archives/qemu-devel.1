Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC0FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C93207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICf8vs2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C93207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZPP-0001HO-8q
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeZLf-0003Ko-54
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeZLd-0000s9-GG
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590736951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=f9Z+lk+d+4suNhay0kd3vrGvIzqQmiqTsiF8rL/9v1I=;
 b=ICf8vs2z6e5y1YZWLJxPklCn/s7B5Xr15/j4mziQXGehswt5Ik1y1Dwe9eKcIBpuKtMPB3
 oAvHgtSCKXO9pzVwqGAw9eV/PA32keU7AldhFbF2EYNO4Nk6A5cO5GA3lsoPOYepOSc3c+
 frcXIhdxancVKpUlwozMCXklfNSqrSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-zdSU835UMFq3SxRQVxfJhw-1; Fri, 29 May 2020 03:22:29 -0400
X-MC-Unique: zdSU835UMFq3SxRQVxfJhw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A2CF100CC88
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 07:22:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2870E10013C2;
 Fri, 29 May 2020 07:22:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0978816E16; Fri, 29 May 2020 09:22:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] usb-host: workaround libusb bug
Date: Fri, 29 May 2020 09:22:24 +0200
Message-Id: <20200529072225.3195-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
---
 hw/usb/host-libusb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index e28441379d99..094010d5f849 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -951,6 +951,7 @@ fail:
 static void usb_host_abort_xfers(USBHostDevice *s)
 {
     USBHostRequest *r, *rtmp;
+    int limit = 100;
 
     QTAILQ_FOREACH_SAFE(r, &s->requests, next, rtmp) {
         usb_host_req_abort(r);
@@ -961,6 +962,19 @@ static void usb_host_abort_xfers(USBHostDevice *s)
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


