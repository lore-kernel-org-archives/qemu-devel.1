Received: from eggs.gnu.org ([2001:4830:134:3::10]:41709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faK8U-0004gN-0E
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faK8R-0001ry-Cd
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:10:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faK8R-0001rO-5S
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D530BDC1
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 12:10:18 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 14:10:11 +0200
Message-Id: <20180703121013.12126-2-kraxel@redhat.com>
In-Reply-To: <20180703121013.12126-1-kraxel@redhat.com>
References: <20180703121013.12126-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] audio/hda: adjust larger gaps faster
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
Message-id: 20180702145513.11481-1-kraxel@redhat.com
---
 hw/audio/hda-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 31c66d4255..9f630fa37f 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -203,6 +203,9 @@ static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
     if (target_pos < -limit) {
         corr = -HDA_TIMER_TICKS;
     }
+    if (target_pos < -(2 * limit)) {
+        corr = -(4 * HDA_TIMER_TICKS);
+    }
     if (corr == 0) {
         return;
     }
-- 
2.9.3
