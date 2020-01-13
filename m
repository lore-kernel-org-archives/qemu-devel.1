Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81C9C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964672081E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2qMm+O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964672081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqzTb-00081c-KI
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iqzQt-0004gr-Sn
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iqzQs-0006cL-Kb
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34798
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iqzQs-0006bv-HC
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578920822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pcY8Q+W0ZLUOtvpY/RL3fptYrhELh5boNrmtE56r94=;
 b=L2qMm+O0VHS9m0hQ65B/5Zw8B40Yx1ogD11l6GxCtN6tJgeFEhoJE2VHTc6GycEWdN46eG
 PHloRK42SjSnGNZE+vLr9cd8foGH1hZN67WpQR7cSulVfVJMiakPoql7kTz/7kqpHfOhF8
 sN1FNzdtkW5XAQ+MfSaX/kEHZom3Hk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-qnSGKKJeO6K8NH-6m9WzAw-1; Mon, 13 Jan 2020 08:06:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23A8E1951295;
 Mon, 13 Jan 2020 13:06:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B3A680921;
 Mon, 13 Jan 2020 13:06:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5595131F63; Mon, 13 Jan 2020 14:06:46 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] usbredir: Prevent recursion in usbredir_write
Date: Mon, 13 Jan 2020 14:06:44 +0100
Message-Id: <20200113130646.30099-4-kraxel@redhat.com>
In-Reply-To: <20200113130646.30099-1-kraxel@redhat.com>
References: <20200113130646.30099-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: qnSGKKJeO6K8NH-6m9WzAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

I've got a case where usbredir_write manages to call back into itself
via spice; this patch causes the recursion to fail (0 bytes) the write;
this seems to avoid the deadlock I was previously seeing.

I can't say I fully understand the interaction of usbredir and spice;
but there are a few similar guards in spice and usbredir
to catch other cases especially onces also related to spice_server_char_dev=
ice_wakeup

This case seems to be triggered by repeated migration+repeated
reconnection of the viewer; but my debugging suggests the migration
finished before this hits.

The backtrace of the hang looks like:
  reds_handle_ticket
  reds_handle_other_links
  reds_channel_do_link
  red_channel_connect
  spicevmc_connect
  usbredir_create_parser
  usbredirparser_do_write
  usbredir_write
  qemu_chr_fe_write
  qemu_chr_write
  qemu_chr_write_buffer
  spice_chr_write
  spice_server_char_device_wakeup
  red_char_device_wakeup
  red_char_device_write_to_device
  vmc_write
  usbredirparser_do_write
  usbredir_write
  qemu_chr_fe_write
  qemu_chr_write
  qemu_chr_write_buffer
  qemu_mutex_lock_impl

and we fail as we lang through qemu_chr_write_buffer's lock
twice.

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1752320

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20191218113012.13331-1-dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/redirect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index b5c15586874a..04614778fea2 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -114,6 +114,7 @@ struct USBRedirDevice {
     CharBackend cs;
     bool enable_streams;
     bool suppress_remote_wake;
+    bool in_write;
     uint8_t debug;
     int32_t bootindex;
     char *filter_str;
@@ -291,6 +292,13 @@ static int usbredir_write(void *priv, uint8_t *data, i=
nt count)
         return 0;
     }
=20
+    /* Recursion check */
+    if (dev->in_write) {
+        DPRINTF("usbredir_write recursion\n");
+        return 0;
+    }
+    dev->in_write =3D true;
+
     r =3D qemu_chr_fe_write(&dev->cs, data, count);
     if (r < count) {
         if (!dev->watch) {
@@ -301,6 +309,7 @@ static int usbredir_write(void *priv, uint8_t *data, in=
t count)
             r =3D 0;
         }
     }
+    dev->in_write =3D false;
     return r;
 }
=20
--=20
2.18.1


