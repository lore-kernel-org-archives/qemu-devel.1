Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4321C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF51B2467B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF51B2467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii21G-0007uA-PW
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 15:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1ii20R-0007T8-OW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1ii20Q-0002uM-Gp
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:02:43 -0500
Received: from mailout07.t-online.de ([194.25.134.83]:43240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1ii20Q-0002l0-9L
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:02:42 -0500
Received: from fwd17.aul.t-online.de (fwd17.aul.t-online.de [172.20.27.64])
 by mailout07.t-online.de (Postfix) with SMTP id 0494D424FF80;
 Thu, 19 Dec 2019 21:02:40 +0100 (CET)
Received: from [192.168.211.200]
 (ZZRWJ-ZBghl4kMXOpLip6IQ485LcTk0fXQ4pIegyr19fKWnM8Q74G5VZ5xn+AbhQIW@[46.86.55.2])
 by fwd17.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ii20N-1kl7J20; Thu, 19 Dec 2019 21:02:39 +0100
Subject: [PATCH 1/5] hda-codec: fix playback rate control
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Message-ID: <494a02d8-c4de-958a-6fd6-c6df95943293@t-online.de>
Date: Thu, 19 Dec 2019 21:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: de-DE
X-ID: ZZRWJ-ZBghl4kMXOpLip6IQ485LcTk0fXQ4pIegyr19fKWnM8Q74G5VZ5xn+AbhQIW
X-TOI-MSGID: 0662df15-6a1c-4f08-87c5-9098d0c10c74
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.83
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
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 1930616b98 "audio: make mixeng optional" the
function hda_audio_output_cb can no longer assume the function
parameter avail contains the free buffer size. With the playback
mixing-engine turned off this leads to a broken playback rate
control and playback buffer drops in regular intervals.

This patch moves down the rate calculation, so the correct
buffer fill level is used for the calculation.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 hw/audio/hda-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index f17e8d8dce..768ba31e79 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -338,8 +338,6 @@ static void hda_audio_output_cb(void *opaque, int ava=
il)
         return;
     }
=20
-    hda_timer_sync_adjust(st, (wpos - rpos) - to_transfer - (B_SIZE >> 1=
));
-
     while (to_transfer) {
         uint32_t start =3D (uint32_t) (rpos & B_MASK);
         uint32_t chunk =3D (uint32_t) MIN(B_SIZE - start, to_transfer);
@@ -351,6 +349,8 @@ static void hda_audio_output_cb(void *opaque, int ava=
il)
             break;
         }
     }
+
+    hda_timer_sync_adjust(st, (wpos - rpos) - (B_SIZE >> 1));
 }
=20
 static void hda_audio_compat_input_cb(void *opaque, int avail)
--=20
2.16.4


