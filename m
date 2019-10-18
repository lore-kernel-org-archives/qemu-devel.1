Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B52CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167FE21925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167FE21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMx4-0001rN-GY
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMtW-0006FC-6J
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtV-000738-3y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtT-00071H-82
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90C3310C0946;
 Fri, 18 Oct 2019 07:41:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48E5F5C1B2;
 Fri, 18 Oct 2019 07:41:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 72A2E9AB9; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/13] audio: basic support for multichannel audio
Date: Fri, 18 Oct 2019 09:41:40 +0200
Message-Id: <20191018074144.24071-10-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
References: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 18 Oct 2019 07:41:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kővágó@redhat.com, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Which currently only means removing some checks.  Old code won't require
more than two channels, but new code will need it.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 7e53be1f97e939ed3bb729ef39e76b775643118a.1570996490.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/alsaaudio.c | 7 -------
 audio/audio.c     | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index eddf013a537c..f37ce1ce8570 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -493,13 +493,6 @@ static int alsa_open(bool in, struct alsa_params_req=
 *req,
         goto err;
     }
=20
-    if (nchannels !=3D 1 && nchannels !=3D 2) {
-        alsa_logerr2 (err, typ,
-                      "Can not handle obtained number of channels %d\n",
-                      nchannels);
-        goto err;
-    }
-
     if (apdo->buffer_length) {
         int dir =3D 0;
         unsigned int btime =3D apdo->buffer_length;
diff --git a/audio/audio.c b/audio/audio.c
index c00f4deddd3d..7fc3aa9d1637 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -242,7 +242,7 @@ static int audio_validate_settings (struct audsetting=
s *as)
 {
     int invalid;
=20
-    invalid =3D as->nchannels !=3D 1 && as->nchannels !=3D 2;
+    invalid =3D as->nchannels < 1;
     invalid |=3D as->endianness !=3D 0 && as->endianness !=3D 1;
=20
     switch (as->fmt) {
--=20
2.18.1


