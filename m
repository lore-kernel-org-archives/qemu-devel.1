Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7BCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B4321734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEGv9Wpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B4321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufHa-0000cD-BP
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iudNs-00074l-38
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iudNq-0004eh-Sd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:22:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iudNq-0004dY-Op
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579789378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWPWSWfYKvtz3ECYoPIg8PimFhSZqtJF8y3utyXfJ80=;
 b=OEGv9WpvYGSqfQ+awiG6sH5eP9IO0c85lM0xt+n0ew0FVcoFHExqGxa7fS5vmxzgI5I08v
 upE3+eLHfEoAO+dwD2Sbk1HyQpR4ydu/i/1orVzkW0PhaaQO0NZbk/XxqnYfOhzGod/B/Z
 mHpPm5ObVrTqFR5zYPffqkTiXzf4nqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-sev2OAqlNIOOVoMOIDcMCQ-1; Thu, 23 Jan 2020 09:21:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4D9F8017CC;
 Thu, 23 Jan 2020 14:21:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39A7A80896;
 Thu, 23 Jan 2020 14:21:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 779A49C7F; Thu, 23 Jan 2020 15:21:22 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] vnc: prioritize ZRLE compression over ZLIB
Date: Thu, 23 Jan 2020 15:21:21 +0100
Message-Id: <20200123142122.13839-3-kraxel@redhat.com>
In-Reply-To: <20200123142122.13839-1-kraxel@redhat.com>
References: <20200123142122.13839-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sev2OAqlNIOOVoMOIDcMCQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cameron Esfahani <dirty@apple.com>

In my investigation, ZRLE always compresses better than ZLIB so
prioritize ZRLE over ZLIB, even if the client hints that ZLIB is
preferred.

zlib buffer is always reset in zrle_compress_data(), so using offset to
calculate next_out and avail_out is useless.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
Message-Id: <b5d129895d08a90d0a2a6183b95875bacfa998b8.1579582674.git.dirty@=
apple.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc-enc-zrle.c |  4 ++--
 ui/vnc.c          | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index 17fd28a2e2b0..b4f71e32cfe8 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -98,8 +98,8 @@ static int zrle_compress_data(VncState *vs, int level)
     /* set pointers */
     zstream->next_in =3D vs->zrle->zrle.buffer;
     zstream->avail_in =3D vs->zrle->zrle.offset;
-    zstream->next_out =3D vs->zrle->zlib.buffer + vs->zrle->zlib.offset;
-    zstream->avail_out =3D vs->zrle->zlib.capacity - vs->zrle->zlib.offset=
;
+    zstream->next_out =3D vs->zrle->zlib.buffer;
+    zstream->avail_out =3D vs->zrle->zlib.capacity;
     zstream->data_type =3D Z_BINARY;
=20
     /* start encoding */
diff --git a/ui/vnc.c b/ui/vnc.c
index 3e8d1f120710..1d7138a3a073 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2071,8 +2071,15 @@ static void set_encodings(VncState *vs, int32_t *enc=
odings, size_t n_encodings)
             break;
 #endif
         case VNC_ENCODING_ZLIB:
-            vs->features |=3D VNC_FEATURE_ZLIB_MASK;
-            vs->vnc_encoding =3D enc;
+            /*
+             * VNC_ENCODING_ZRLE compresses better than VNC_ENCODING_ZLIB.
+             * So prioritize ZRLE, even if the client hints that it prefer=
s
+             * ZLIB.
+             */
+            if ((vs->features & VNC_FEATURE_ZRLE_MASK) =3D=3D 0) {
+                vs->features |=3D VNC_FEATURE_ZLIB_MASK;
+                vs->vnc_encoding =3D enc;
+            }
             break;
         case VNC_ENCODING_ZRLE:
             vs->features |=3D VNC_FEATURE_ZRLE_MASK;
--=20
2.18.1


