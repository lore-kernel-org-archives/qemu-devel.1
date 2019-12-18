Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D69C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30CF21D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSeeGHCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30CF21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihXYJ-00061I-06
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 06:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ihXXC-0005Ps-It
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ihXX9-0000bc-NM
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:30:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ihXX9-0000QC-3R
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576668625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mJPaa+EVmrRMjHn2tKNl18VfH7AGHrQewZ1DL4y3XpE=;
 b=YSeeGHCua4ISdhgV1GMqjyP+zD5gu2Vw3zmHlKROohIygl/XKwNIKu6cruw03OAodghJ7a
 YaH4GneNJrKtB9L59NEFUMmrx8WLidC4foEkapGp61kChXdXk7PcHAAWUzqjZPSeW1asTV
 Skgfhq/Hvfg9DOJ0OKoJeGzG0DTzg3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-BA51mO9ANTmo5WrFb6PA3Q-1; Wed, 18 Dec 2019 06:30:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A80A21876592
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:30:22 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F83C6888A;
 Wed, 18 Dec 2019 11:30:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 uril@redhat.com
Subject: [PATCH] usbredir: Prevent recursion in usbredir_write
Date: Wed, 18 Dec 2019 11:30:12 +0000
Message-Id: <20191218113012.13331-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: BA51mO9ANTmo5WrFb6PA3Q-1
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
---
 hw/usb/redirect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index e0f5ca6f81..97f2c3a7da 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -113,6 +113,7 @@ struct USBRedirDevice {
     /* Properties */
     CharBackend cs;
     bool enable_streams;
+    bool in_write;
     uint8_t debug;
     int32_t bootindex;
     char *filter_str;
@@ -290,6 +291,13 @@ static int usbredir_write(void *priv, uint8_t *data, i=
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
@@ -300,6 +308,7 @@ static int usbredir_write(void *priv, uint8_t *data, in=
t count)
             r =3D 0;
         }
     }
+    dev->in_write =3D false;
     return r;
 }
=20
--=20
2.23.0


