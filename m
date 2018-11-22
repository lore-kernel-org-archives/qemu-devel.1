Received: from eggs.gnu.org ([2001:4830:134:3::10]:51075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPp5d-0006FX-4l
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPp5Z-0005oZ-TR
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:32:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gPp5Z-0005nn-OF
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:32:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E41EB811DA
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 13:32:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Nov 2018 14:32:07 +0100
Message-Id: <20181122133207.29928-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] audio/hda: fix guest triggerable assert
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

Guest writes to a readonly register trigger the assert in
intel_hda_reg_write().  Add a check and just ignore them.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1628433
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/intel-hda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 23a2cf6484..066532713c 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -929,6 +929,10 @@ static void intel_hda_reg_write(IntelHDAState *d, const IntelHDAReg *reg, uint32
     if (!reg) {
         return;
     }
+    if (!reg->wmask) {
+        /* read-only register */
+        return;
+    }
 
     if (d->debug) {
         time_t now = time(NULL);
-- 
2.9.3
