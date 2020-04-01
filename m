Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4381CC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E41206EB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E41206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJidT-0002z3-8O
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 15:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jJib9-0000RW-2c
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jJib7-0002R8-On
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:00:22 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:47022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jJib7-0002Pp-HQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:00:21 -0400
Received: from fwd05.aul.t-online.de (fwd05.aul.t-online.de [172.20.27.149])
 by mailout11.t-online.de (Postfix) with SMTP id 8A14A421358D;
 Wed,  1 Apr 2020 21:00:19 +0200 (CEST)
Received: from linpower.localnet
 (rALmjkZE8hMODYjB4Ths8Dg1ROJWkeEYp2UEijwuIQ1eGy98fhyBR3sTOGZcZXmQN-@[93.236.147.242])
 by fwd05.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jJib4-3IemmW0; Wed, 1 Apr 2020 21:00:18 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 58307200467; Wed,  1 Apr 2020 21:00:17 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/3] dsoundaudio: fix never-ending playback loop
Date: Wed,  1 Apr 2020 21:00:15 +0200
Message-Id: <20200401190017.5081-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <19cd6a5a-97b7-b684-f026-11d82e34dab9@t-online.de>
References: <19cd6a5a-97b7-b684-f026-11d82e34dab9@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: rALmjkZE8hMODYjB4Ths8Dg1ROJWkeEYp2UEijwuIQ1eGy98fhyBR3sTOGZcZXmQN-
X-TOI-MSGID: 7d63d7ff-393a-48e6-b261-cf42a18260c8
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

Currently the DirectSound backend fails to stop audio playback
in dsound_enable_out(). The call to IDirectSoundBuffer_GetStatus()
in dsound_get_status_out() returns a status word with the flag
DSERR_BUFFERLOST set (probably because of a buffer underrun).
The function dsound_get_status_out() correctly calls
dsound_restore_out() and returns an error. This is wrong. If
dsound_restore_out() succeeds the program should continue without
an error.

To reproduce the bug start qemu on a Windows host with
-soundhw pcspk -audiodev dsound,id=3Daudio0. On the guest
FreeDOS 1.2 command line enter beep. The image Day 1 - F-Bird
from the QEMU Advent Calendar 2018 shows the bug as well.

Fixes: 2762955f72 "dsoundaudio: remove *_retries kludges"
Buglink: https://bugs.launchpad.net/qemu/+bug/1699628
Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/dsoundaudio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index bd57082a8d..af70dd128e 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -280,8 +280,10 @@ static int dsound_get_status_out (LPDIRECTSOUNDBUFFE=
R dsb, DWORD *statusp,
     }
=20
     if (*statusp & DSERR_BUFFERLOST) {
-        dsound_restore_out(dsb, s);
-        return -1;
+        if (dsound_restore_out(dsb, s)) {
+            return -1;
+        }
+        *statusp &=3D ~DSERR_BUFFERLOST;
     }
=20
     return 0;
--=20
2.16.4


