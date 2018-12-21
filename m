Received: from eggs.gnu.org ([2001:4830:134:3::10]:52792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSHx-00025w-Qk
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSHs-0001CJ-No
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:24:57 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yaroslav.isakov@gmail.com>)
	id 1gaSHs-0001Bi-Ge
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:24:52 -0500
Received: by mail-wm1-x343.google.com with SMTP id g67so6978207wmd.2
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:24:52 -0800 (PST)
Received: from localhost ([91.201.22.4]) by smtp.gmail.com with ESMTPSA id
	126sm21608501wmx.26.2018.12.21.12.57.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 21 Dec 2018 12:57:05 -0800 (PST)
Message-Id: <af2fca9a040c19198c5aff8752f152a525fd96b7.1545425136.git.yaroslav.isakov@gmail.com>
In-Reply-To: <cover.1545425136.git.yaroslav.isakov@gmail.com>
References: <cover.1545425136.git.yaroslav.isakov@gmail.com>
From: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date: Fri, 21 Dec 2018 21:31:03 +0100
Subject: [Qemu-devel] [PATCH 2/3] Pass raw DB values from hda-codec.c to
 audio driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
---
 hw/audio/hda-codec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 09f9da344b..d160e86d2a 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -437,6 +437,7 @@ static void hda_audio_set_amp(HDAAudioStream *st)
 {
     bool muted;
     uint32_t left, right;
+    double left_db, right_db;
 
     if (st->node == NULL) {
         return;
@@ -446,6 +447,9 @@ static void hda_audio_set_amp(HDAAudioStream *st)
     left  = st->mute_left  ? 0 : st->gain_left;
     right = st->mute_right ? 0 : st->gain_right;
 
+    left_db = ((int64_t)left - QEMU_HDA_AMP_STEPS) * QEMU_HDA_AMP_DB_OF_STEP;
+    right_db = ((int64_t)right - QEMU_HDA_AMP_STEPS) * QEMU_HDA_AMP_DB_OF_STEP;
+
     left = left * 255 / QEMU_HDA_AMP_STEPS;
     right = right * 255 / QEMU_HDA_AMP_STEPS;
 
@@ -454,10 +458,10 @@ static void hda_audio_set_amp(HDAAudioStream *st)
     }
     if (st->output) {
         AUD_set_volume_out(st->voice.out, muted, left, right,
-                           false, 0, 0);
+                           true, left_db, right_db);
     } else {
         AUD_set_volume_in(st->voice.in, muted, left, right,
-                          false, 0, 0);
+                          true, left_db, right_db);
     }
 }
 
-- 
2.18.1
