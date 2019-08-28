Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80F6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 11:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A791B2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 11:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A791B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2wZs-0006gs-OZ
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 07:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i2wWJ-0003cl-Cq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 07:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i2wWI-000605-Ag
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 07:53:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i2wWI-0005z8-5U
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 07:53:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 408A583F3D;
 Wed, 28 Aug 2019 11:53:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F7CF60C80;
 Wed, 28 Aug 2019 11:53:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8565E31E84; Wed, 28 Aug 2019 13:53:32 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:53:31 +0200
Message-Id: <20190828115332.28760-2-kraxel@redhat.com>
In-Reply-To: <20190828115332.28760-1-kraxel@redhat.com>
References: <20190828115332.28760-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 28 Aug 2019 11:53:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/2] audio: fix invalid malloc size in
 audio_create_pdos
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
Cc: libvir-list@redhat.com, Kővágó@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

The code used sizeof(AudiodevAlsaPerDirectionOptions) instead of the
appropriate per direction options for the audio backend.  If the size of
the actual audiodev's per direction options are larger than alsa's, it
could cause a buffer overflow.

However, alsa has three fields in per direction options: a string, an
uint32 and a bool.  Oss has the same fields, coreaudio has a single
uint32, paaudio has a string and an uint32, all other backends only use
the common options, so currently no per direction options struct should
be larger than alsa's.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-Id: <7808bc816ba7da8b8de8a214713444d85f7af3c6.1566847960.git.Dirt=
Y.iCE.hu@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 7d715332c993..ae335dbebb1e 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1685,7 +1685,7 @@ void audio_create_pdos(Audiodev *dev)
         }                                                           \
         if (!dev->u.driver.has_out) {                               \
             dev->u.driver.out =3D g_malloc0(                          \
-                sizeof(AudiodevAlsaPerDirectionOptions));           \
+                sizeof(Audiodev##pdo_name##PerDirectionOptions));   \
             dev->u.driver.has_out =3D true;                           \
         }                                                           \
         break
--=20
2.18.1


