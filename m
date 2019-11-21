Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A1C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8B92073F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGjev51d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8B92073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjac-0003F6-AU
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iXjVk-0007AV-Gd
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iXjVj-0007Um-FL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:16:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50741
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iXjVj-0007US-C0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574331386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lW8xVmzL8vBpdRtXK5fUmBzaQjt66qwLX1IMvtgTnWA=;
 b=BGjev51dIQFISCf5J1T50YusDKrMdZyn1hqawSGMrF5KrlqYxPIlZjPuaMKlmEFz0bwNn+
 08v9TUHgH2uIT9GnsBrmgAu9mPJqfXkxvA8tTy3eYaEAA8e4Y0mF8y5wxIUAOFUOacGZtX
 at/PMyyXFweBwKCyrhHRWWLRPUmbu60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-FekPJS7ONGivcOPnP3jFKw-1; Thu, 21 Nov 2019 05:16:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89953801FCF;
 Thu, 21 Nov 2019 10:16:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CE705DAB0;
 Thu, 21 Nov 2019 10:16:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8B5061747D; Thu, 21 Nov 2019 11:16:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] audio: fix audio recording
Date: Thu, 21 Nov 2019 11:16:16 +0100
Message-Id: <20191121101618.29289-2-kraxel@redhat.com>
In-Reply-To: <20191121101618.29289-1-kraxel@redhat.com>
References: <20191121101618.29289-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FekPJS7ONGivcOPnP3jFKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

With current code audio recording with all audio backends
except PulseAudio and DirectSound is broken. The generic audio
recording buffer management forgot to update the current read
position after a read.

Fixes: ff095e5231 "audio: api for mixeng code free backends"

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Reviewed-by: Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 <DirtY.iCE.hu@gmail.com>
Message-id: 2fc947cf-7b42-de68-3f11-cbcf1c096be9@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/audio.c b/audio/audio.c
index 7fc3aa9d1637..56fae5504710 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1390,6 +1390,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, size=
_t *size)
         size_t read =3D hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emul,
                                         read_len);
         hw->pending_emul +=3D read;
+        hw->pos_emul =3D (hw->pos_emul + read) % hw->size_emul;
         if (read < read_len) {
             break;
         }
--=20
2.18.1


