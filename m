Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2D1C2D0F0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA6C20719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA6C20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJifa-0004cn-Lu
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 15:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jJibA-0000T4-Fm
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jJib9-0002Rm-1K
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:00:24 -0400
Received: from mailout09.t-online.de ([194.25.134.84]:45750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jJib8-0002R2-PN
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:00:22 -0400
Received: from fwd18.aul.t-online.de (fwd18.aul.t-online.de [172.20.26.244])
 by mailout09.t-online.de (Postfix) with SMTP id 3CAF942D6891;
 Wed,  1 Apr 2020 21:00:21 +0200 (CEST)
Received: from linpower.localnet
 (SgGN78ZYghq0L+ncI2t2vYTLp2j7LeBhONEwkPaRSgrPBB+UYmA+s1hGD4VQXnpgD3@[93.236.147.242])
 by fwd18.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jJib6-06E4fI0; Wed, 1 Apr 2020 21:00:20 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 5A5B620062A; Wed,  1 Apr 2020 21:00:17 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/3] dsoundaudio: fix "Could not lock capture buffer" warning
Date: Wed,  1 Apr 2020 21:00:16 +0200
Message-Id: <20200401190017.5081-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <19cd6a5a-97b7-b684-f026-11d82e34dab9@t-online.de>
References: <19cd6a5a-97b7-b684-f026-11d82e34dab9@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: SgGN78ZYghq0L+ncI2t2vYTLp2j7LeBhONEwkPaRSgrPBB+UYmA+s1hGD4VQXnpgD3
X-TOI-MSGID: c567f1f0-1cd0-4719-b0e6-bf99b2daab19
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.84
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
index af70dd128e..ea1595dcd1 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -544,6 +544,11 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, siz=
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


