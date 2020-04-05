Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AA6C2BA19
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0583C20709
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0583C20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jL046-0005lv-6G
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 03:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jL02x-0004pT-6p
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jL02v-0001Gd-IM
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:50:22 -0400
Received: from mailout08.t-online.de ([194.25.134.20]:60980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jL02v-0001Fu-Cg
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:50:21 -0400
Received: from fwd32.aul.t-online.de (fwd32.aul.t-online.de [172.20.26.144])
 by mailout08.t-online.de (Postfix) with SMTP id C13C541B921F;
 Sun,  5 Apr 2020 09:50:20 +0200 (CEST)
Received: from linpower.localnet
 (SrBfFuZdwhYvr51O9eLyuro6+AN6vTh4yGX0rXJBHrL8TEp4KnMl6NdfipfR85xQfv@[93.236.147.242])
 by fwd32.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jL02u-2WcS480; Sun, 5 Apr 2020 09:50:20 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 905A620061E; Sun,  5 Apr 2020 09:50:17 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/3] dsoundaudio: fix "Could not lock capture buffer"
 warning
Date: Sun,  5 Apr 2020 09:50:16 +0200
Message-Id: <20200405075017.9901-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <f28b8915-d9df-8de3-7298-cc4c74f0a8d1@t-online.de>
References: <f28b8915-d9df-8de3-7298-cc4c74f0a8d1@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: SrBfFuZdwhYvr51O9eLyuro6+AN6vTh4yGX0rXJBHrL8TEp4KnMl6NdfipfR85xQfv
X-TOI-MSGID: 6c8f1f2f-5875-47db-888f-453735f739cc
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.20
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

IDirectSoundCaptureBuffer_Lock() fails on Windows when called
with len =3D 0. Return early from dsound_get_buffer_in() in this
case.

To reproduce the warning start a linux guest. In the guest
start Audacity and you will see a lot of "Could not lock
capture buffer" warnings.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/dsoundaudio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 9e621c8899..a08d519cae 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -542,6 +542,11 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, siz=
e_t *size)
     req_size =3D audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
     req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
=20
+    if (req_size =3D=3D 0) {
+        *size =3D 0;
+        return NULL;
+    }
+
     err =3D dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret=
, NULL,
                          &act_size, NULL, false, ds->s);
     if (err) {
--=20
2.16.4


