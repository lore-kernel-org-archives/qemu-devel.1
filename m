Received: from eggs.gnu.org ([2001:4830:134:3::10]:54385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY8U1-00012k-8P
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY8Tz-00048Y-R0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:19:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fY8Tz-00048H-LB
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:19:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B38F40201CE
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 11:19:31 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 27 Jun 2018 13:19:25 +0200
Message-Id: <20180627111925.30292-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] audio/hda: adjust larger gaps faster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/hda-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index fc4945086b..8a8214de74 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -204,6 +204,9 @@ static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
     if (target_pos < -limit) {
         corr = -HDA_TIMER_TICKS;
     }
+    if (target_pos < -(2*limit)) {
+        corr = -(4*HDA_TIMER_TICKS);
+    }
     if (corr == 0) {
         return;
     }
-- 
2.9.3
