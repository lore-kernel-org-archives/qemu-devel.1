Received: from eggs.gnu.org ([2001:4830:134:3::10]:56893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSNn-0005a1-RB
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSNn-0005rp-7g
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:30:59 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yaroslav.isakov@gmail.com>)
	id 1gaSNn-0005qy-02
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:30:59 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so6616684wrs.10
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:30:58 -0800 (PST)
Received: from localhost ([91.201.22.4]) by smtp.gmail.com with ESMTPSA id
	t70sm16304930wmd.36.2018.12.21.12.57.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 21 Dec 2018 12:57:12 -0800 (PST)
Message-Id: <fca88dd3e21b29a12d6f00e65eebdd146024302f.1545425136.git.yaroslav.isakov@gmail.com>
In-Reply-To: <cover.1545425136.git.yaroslav.isakov@gmail.com>
References: <cover.1545425136.git.yaroslav.isakov@gmail.com>
From: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date: Fri, 21 Dec 2018 01:25:14 +0100
Subject: [Qemu-devel] [PATCH 3/3] If raw DB values are known,
 use them in paaudio
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
 audio/paaudio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 4c100bc318..d25df102ab 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -724,8 +724,13 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
             va_end (ap);
 
             v.channels = 2;
-            v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
-            v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
+            if (sw->vol.db_known) {
+                v.values[0] = pa_sw_volume_from_dB(sw->vol.l_db);
+                v.values[1] = pa_sw_volume_from_dB(sw->vol.r_db);
+            } else {
+                v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
+                v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
+            }
 
             pa_threaded_mainloop_lock (g->mainloop);
 
-- 
2.18.1
