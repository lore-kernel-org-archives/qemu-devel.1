Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A89C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6C721569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKUfadoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6C721569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugII-0003b9-M6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iudMQ-0004sa-SW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iudMP-0003JS-K3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:21:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iudMP-0003JL-H3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579789289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bVKJ77zZUyNg7pPmcSu/Ffhx0VlXpEBLLjM081mYSI=;
 b=aKUfadoMKJGr95o2GE2jzax91PhD0oxybegP2xkyQ8AjZE4cswrWvuyy2HcaDEPqq94BU7
 ddlHXC62wW3ArDFBjrxxIjPgqOhFelknXRXPjbuM+S9Totm9oYBqfTg/zpDj/6z0KPhHMl
 XM+uIm/vjRksm3zemZDAImgS9orNIME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-_TiYi6LnPwaSdphb7iJKCA-1; Thu, 23 Jan 2020 09:21:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D851800D78;
 Thu, 23 Jan 2020 14:21:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 389E45DA2C;
 Thu, 23 Jan 2020 14:21:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6DE649C74; Thu, 23 Jan 2020 15:21:22 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] Revert "vnc: allow fall back to RAW encoding"
Date: Thu, 23 Jan 2020 15:21:20 +0100
Message-Id: <20200123142122.13839-2-kraxel@redhat.com>
In-Reply-To: <20200123142122.13839-1-kraxel@redhat.com>
References: <20200123142122.13839-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: _TiYi6LnPwaSdphb7iJKCA-1
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

This reverts commit de3f7de7f4e257ce44cdabb90f5f17ee99624557.

Remove VNC optimization to reencode framebuffer update as raw if it's
smaller than the default encoding.

QEMU's implementation was naive and didn't account for the ZLIB z_stream
mutating with each compression.  Because of the mutation, simply
resetting the output buffer's offset wasn't sufficient to "rewind" the
operation.  The mutated z_stream would generate future zlib blocks which
referred to symbols in past blocks which weren't sent.  This would lead
to artifacting.

Considering that ZRLE is never larger than raw and even though ZLIB can
occasionally be fractionally larger than raw, the overhead of
implementing this optimization correctly isn't worth it.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 4100d6e4048c..3e8d1f120710 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -898,8 +898,6 @@ int vnc_raw_send_framebuffer_update(VncState *vs, int x=
, int y, int w, int h)
 int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 {
     int n =3D 0;
-    bool encode_raw =3D false;
-    size_t saved_offs =3D vs->output.offset;
=20
     switch(vs->vnc_encoding) {
         case VNC_ENCODING_ZLIB:
@@ -922,24 +920,10 @@ int vnc_send_framebuffer_update(VncState *vs, int x, =
int y, int w, int h)
             n =3D vnc_zywrle_send_framebuffer_update(vs, x, y, w, h);
             break;
         default:
-            encode_raw =3D true;
+            vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
+            n =3D vnc_raw_send_framebuffer_update(vs, x, y, w, h);
             break;
     }
-
-    /* If the client has the same pixel format as our internal buffer and
-     * a RAW encoding would need less space fall back to RAW encoding to
-     * save bandwidth and processing power in the client. */
-    if (!encode_raw && vs->write_pixels =3D=3D vnc_write_pixels_copy &&
-        12 + h * w * VNC_SERVER_FB_BYTES <=3D (vs->output.offset - saved_o=
ffs)) {
-        vs->output.offset =3D saved_offs;
-        encode_raw =3D true;
-    }
-
-    if (encode_raw) {
-        vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
-        n =3D vnc_raw_send_framebuffer_update(vs, x, y, w, h);
-    }
-
     return n;
 }
=20
--=20
2.18.1


