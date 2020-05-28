Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F50C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644FA207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDj+5DM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644FA207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIbE-0005jz-IA
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeIaf-0005II-U3
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:28:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34268
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeIae-0000If-NV
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590672535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xl5Pc1fQH8dVIQnMr8ItCmcE4UFwScE25zDm+xbM4Uo=;
 b=bDj+5DM6VfgfrNSeW1vv4uV24cJ7aBdT2NyjiJOG73PhEZ0K858ZPVPRvJ1uGTS0bw6QB4
 bwFsvFBpejYYRnMI+2jfzry18FlcA0bqpI28ubjnIHdG9ZSnG5JU+jUu4ywttxOciv6OdV
 sugDRT1V25m6/vrppGfzOa5Xv2ZjvWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-1PE1MWk3O4Ocoa9ZdgJY0g-1; Thu, 28 May 2020 09:28:53 -0400
X-MC-Unique: 1PE1MWk3O4Ocoa9ZdgJY0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D840107ACF4;
 Thu, 28 May 2020 13:28:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F52C768C2;
 Thu, 28 May 2020 13:28:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0BCC31753B; Thu, 28 May 2020 15:28:50 +0200 (CEST)
Date: Thu, 28 May 2020 15:28:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: USB pass-through problems
Message-ID: <20200528132850.gtxzkvor2u5kykqi@sirius.home.kraxel.org>
References: <alpine.BSF.2.22.395.2005272129480.93454@zero.eik.bme.hu>
 <20200528064039.yw5in3whgjvlni4z@sirius.home.kraxel.org>
 <alpine.BSF.2.22.395.2005281128460.96126@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2005281128460.96126@zero.eik.bme.hu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > #2  0x00007f23e8bfbb13 in libusb_handle_events_timeout_completed () at /lib64/libusb-1.0.so.0
> > > #3  0x000055e09854b7da in usb_host_abort_xfers (s=0x55e09b036dd0) at hw/usb/host-libusb.c:963

> > Hmm, does reverting 76d0a9362c6a6a7d88aa18c84c4186c9107ecaef change
> > behavior?
> 
> Yes it does. Reverting that patch fixes the problem, no hang and device
> reconnects without problem.

Hmm.  Looks like an libusb bug to me, it seems to not call the
completion callback for the canceled transfers (which it should do
according to the docs), so qemu waits for this to happen forever.

We can certainly add a limit here (see below), question is how to
handle the canceled but not completed transfers then.  I suspect
we have to leak them to make sure we don't get use-after-free
access from libusb ...

cheers,
  Gerd

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index e28441379d99..4c3b5b140d9d 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -944,30 +944,45 @@ fail:
         libusb_close(s->dh);
         s->dh = NULL;
         s->dev = NULL;
     }
     return -1;
 }
 
 static void usb_host_abort_xfers(USBHostDevice *s)
 {
     USBHostRequest *r, *rtmp;
+    int limit = 100;
 
     QTAILQ_FOREACH_SAFE(r, &s->requests, next, rtmp) {
         usb_host_req_abort(r);
     }
 
     while (QTAILQ_FIRST(&s->requests) != NULL) {
         struct timeval tv;
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
+                fprintf(stderr, "%s: leaking usb request %p\n", __func__, r);
+                QTAILQ_REMOVE(&s->requests, r, next);
+            }
+            return;
+        }
     }
 }
 
 static int usb_host_close(USBHostDevice *s)
 {
     USBDevice *udev = USB_DEVICE(s);
 
     if (s->dh == NULL) {
         return -1;
     }


