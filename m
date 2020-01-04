Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE3CC32767
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E99C215A4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E99C215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1infU3-0002ao-V5
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 04:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1infT0-0001dw-IK
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1infSz-0006cv-HY
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:30 -0500
Received: from mailout11.t-online.de ([194.25.134.85]:37216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1infSz-0006X7-AW
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:29 -0500
Received: from fwd02.aul.t-online.de (fwd02.aul.t-online.de [172.20.26.148])
 by mailout11.t-online.de (Postfix) with SMTP id C0DB74219D70;
 Sat,  4 Jan 2020 10:11:27 +0100 (CET)
Received: from linpower.localnet
 (S35q5cZeZhEXu1VJsEw1KA85QBzJrQwS6BBDazoNoZ+TH9RtsE7vs2KQhJXHcsKQjb@[46.86.52.107])
 by fwd02.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1infSs-2OuX440; Sat, 4 Jan 2020 10:11:22 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 1F83420278D; Sat,  4 Jan 2020 10:11:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 1/5] hda-codec: fix playback rate control
Date: Sat,  4 Jan 2020 10:11:18 +0100
Message-Id: <20200104091122.13971-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <07d61da6-51fb-8599-ea27-dae828fbdb3c@t-online.de>
References: <07d61da6-51fb-8599-ea27-dae828fbdb3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: S35q5cZeZhEXu1VJsEw1KA85QBzJrQwS6BBDazoNoZ+TH9RtsE7vs2KQhJXHcsKQjb
X-TOI-MSGID: 093d079c-19aa-4f43-ae6b-b23b89f952ef
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.85
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


