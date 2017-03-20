Received: from eggs.gnu.org ([2001:4830:134:3::10]:41438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qv-0001v9-99
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qo-000575-Hf
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qo-00055b-7p
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8WSd127999
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:41 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ambn29b5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:41 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:40 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:20 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-57-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 56/81] cirrus: fix oob access issue
 (CVE-2017-2615)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Li Qiang <liqiang6-s@360.cn>, P J P <ppandit@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Li Qiang <liqiang6-s@360.cn>

When doing bitblt copy in backward mode, we should minus the
blt width first just like the adding in the forward mode. This
can avoid the oob access of the front of vga's vram.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>

{ kraxel: with backward blits (negative pitch) addr is the topmost
          address, so check it as-is against vram size ]

Cc: qemu-stable@nongnu.org
Cc: P J P <ppandit@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
Fixes: d3532a0db02296e687711b8cdc7791924efccea0 (CVE-2014-8106)
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1485938101-26602-1-git-send-email-kraxel@redhat.com
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
(cherry picked from commit 62d4c6bd5263bb8413a06c80144fc678df6dfb64)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/display/cirrus_vga.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 379910d..629a5c8 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -277,10 +277,9 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
     }
     if (pitch < 0) {
         int64_t min = addr
-            + ((int64_t)s->cirrus_blt_height-1) * pitch;
-        int32_t max = addr
-            + s->cirrus_blt_width;
-        if (min < 0 || max > s->vga.vram_size) {
+            + ((int64_t)s->cirrus_blt_height - 1) * pitch
+            - s->cirrus_blt_width;
+        if (min < -1 || addr >= s->vga.vram_size) {
             return true;
         }
     } else {
-- 
2.7.4
