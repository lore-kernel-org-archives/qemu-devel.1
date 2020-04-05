Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A3FC2BA19
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A22206F5
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A22206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jL057-000747-M2
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 03:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jL02z-0004rN-UD
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jL02y-0001I3-5a
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:50:25 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:46672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jL02x-0001HS-Vt
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:50:24 -0400
Received: from fwd06.aul.t-online.de (fwd06.aul.t-online.de [172.20.26.150])
 by mailout02.t-online.de (Postfix) with SMTP id 693B941D1EC4;
 Sun,  5 Apr 2020 09:50:23 +0200 (CEST)
Received: from linpower.localnet
 (EwKzx8ZOZhTlbJzMXcWO21ZKNq9EqU63dWk9DSinWKrfwVQg47qgkUFVUIvMKLqwUi@[93.236.147.242])
 by fwd06.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jL02x-4TRWOu0; Sun, 5 Apr 2020 09:50:23 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 9124D200622; Sun,  5 Apr 2020 09:50:17 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/3] dsoundaudio: dsound_get_buffer_in should honor *size
Date: Sun,  5 Apr 2020 09:50:17 +0200
Message-Id: <20200405075017.9901-3-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <f28b8915-d9df-8de3-7298-cc4c74f0a8d1@t-online.de>
References: <f28b8915-d9df-8de3-7298-cc4c74f0a8d1@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: EwKzx8ZOZhTlbJzMXcWO21ZKNq9EqU63dWk9DSinWKrfwVQg47qgkUFVUIvMKLqwUi
X-TOI-MSGID: a0fdab05-3a5b-41cd-9b51-0e05a15a05a2
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.17
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch prevents an underflow of variable samples in function
audio_pcm_hw_run_in(). See commit 599eac4e5a "audio:
audio_generic_get_buffer_in should honor *size". This time the
while loop in audio_pcm_hw_run_in() will terminate nevertheless,
because it seems the recording stream in Windows is always rate
limited.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/audio.c       | 12 +++++-------
 audio/dsoundaudio.c |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 9ac9a20c41..7a9e680355 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1491,15 +1491,13 @@ size_t audio_generic_write(HWVoiceOut *hw, void *=
buf, size_t size)
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
-}
+    memcpy(buf, src, size);
+    hw->pcm_ops->put_buffer_in(hw, src, size);
=20
+    return size;
+}
=20
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
                              bool msg, Audiodev *dev)
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index a08d519cae..4cdf19ab67 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -540,7 +540,7 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size=
_t *size)
     }
=20
     req_size =3D audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
-    req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
+    req_size =3D MIN(*size, MIN(req_size, hw->size_emul - hw->pos_emul))=
;
=20
     if (req_size =3D=3D 0) {
         *size =3D 0;
--=20
2.16.4


