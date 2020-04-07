Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BC2C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B17F206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkDWoDkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B17F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkTU-00071N-Ky
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jLkQz-0002IK-Jf
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jLkQy-0000aU-It
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60230
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jLkQy-0000Zi-D0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586251336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MScHmYDiUSa4Iqbzbrlr05FKQfpiha1WluPabMnn3LQ=;
 b=dkDWoDkn+101UksN6Pp6D+sYa+95CGowZkNpKbj7G0etjPiZIkyYPY/CiOFnIyHHoOXl9e
 BbUWlcAzTRgEzCe34Lza4S7/ozOcBzfg65MfYE/8MibvhHJOGgB5WCtut6jo/X10c9COE6
 DaN0Wuy2PeVzmpYIrRAxHhXXdfglVis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-jvTXjx1kPxSlJY7o6sX45g-1; Tue, 07 Apr 2020 05:22:12 -0400
X-MC-Unique: jvTXjx1kPxSlJY7o6sX45g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34DF313FB;
 Tue,  7 Apr 2020 09:22:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29A495C28E;
 Tue,  7 Apr 2020 09:22:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1FD8317516; Tue,  7 Apr 2020 11:22:07 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] dsoundaudio: dsound_get_buffer_in should honor *size
Date: Tue,  7 Apr 2020 11:22:05 +0200
Message-Id: <20200407092207.6079-4-kraxel@redhat.com>
In-Reply-To: <20200407092207.6079-1-kraxel@redhat.com>
References: <20200407092207.6079-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

This patch prevents an underflow of variable samples in function
audio_pcm_hw_run_in(). See commit 599eac4e5a "audio:
audio_generic_get_buffer_in should honor *size". This time the
while loop in audio_pcm_hw_run_in() will terminate nevertheless,
because it seems the recording stream in Windows is always rate
limited.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-id: 20200405075017.9901-3-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c       | 12 +++++-------
 audio/dsoundaudio.c |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 9ac9a20c41ba..7a9e6803558b 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1491,16 +1491,14 @@ size_t audio_generic_write(HWVoiceOut *hw, void *bu=
f, size_t size)
=20
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
 {
-    size_t src_size, copy_size;
-    void *src =3D hw->pcm_ops->get_buffer_in(hw, &src_size);
-    copy_size =3D MIN(size, src_size);
+    void *src =3D hw->pcm_ops->get_buffer_in(hw, &size);
=20
-    memcpy(buf, src, copy_size);
-    hw->pcm_ops->put_buffer_in(hw, src, copy_size);
-    return copy_size;
+    memcpy(buf, src, size);
+    hw->pcm_ops->put_buffer_in(hw, src, size);
+
+    return size;
 }
=20
-
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
                              bool msg, Audiodev *dev)
 {
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index a08d519cae6a..4cdf19ab6799 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -540,7 +540,7 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t=
 *size)
     }
=20
     req_size =3D audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
-    req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
+    req_size =3D MIN(*size, MIN(req_size, hw->size_emul - hw->pos_emul));
=20
     if (req_size =3D=3D 0) {
         *size =3D 0;
--=20
2.18.2


