Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D8C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E55A2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsZaS9o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E55A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkdd-0001Ci-6C
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkUv-0005BZ-Rj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkTy-0003wK-En
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57994
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTkTx-0003qQ-0Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PvDLqvzBI0CfTZenu/nOV53MsSThnMnnkIRJz4NuciA=;
 b=AsZaS9o+7X2B/iZWCES2kDIO3F2v+BlehawIZedqFBSEQqWmgFhclen/H/xEKDNesiVkNs
 izz+jRTA7YvzQHmjKUDlz2e/V4UwP1C3wmPlqy05b/u1QsBEmLtisokqKCKYBG2OtWgzVD
 cRTAsHDqPP84L93Iwq9gL1eGxbS1CAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-jG6iz1dxMl2wxN3VjVRSKw-1; Wed, 29 Apr 2020 07:02:21 -0400
X-MC-Unique: jG6iz1dxMl2wxN3VjVRSKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33D5E107ACF9
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:02:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3C39282C8;
 Wed, 29 Apr 2020 11:02:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 579139DA2; Wed, 29 Apr 2020 13:02:15 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/12] audio: deprecate -soundhw sb16
Date: Wed, 29 Apr 2020 13:02:11 +0200
Message-Id: <20200429110214.29037-10-kraxel@redhat.com>
In-Reply-To: <20200429110214.29037-1-kraxel@redhat.com>
References: <20200429110214.29037-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to deprecated_register_soundhw().
Remove the now obsolete init function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/sb16.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index df6f755a37f8..2d9e50f99b5d 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1415,12 +1415,6 @@ static void sb16_realizefn (DeviceState *dev, Error =
**errp)
     AUD_register_card ("sb16", &s->card);
 }
=20
-static int SB16_init (ISABus *bus)
-{
-    isa_create_simple (bus, TYPE_SB16);
-    return 0;
-}
-
 static Property sb16_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(SB16State, card),
     DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
@@ -1453,7 +1447,8 @@ static const TypeInfo sb16_info =3D {
 static void sb16_register_types (void)
 {
     type_register_static (&sb16_info);
-    isa_register_soundhw("sb16", "Creative Sound Blaster 16", SB16_init);
+    deprecated_register_soundhw("sb16", "Creative Sound Blaster 16",
+                                1, TYPE_SB16);
 }
=20
 type_init (sb16_register_types)
--=20
2.18.2


