Received: from eggs.gnu.org ([2001:4830:134:3::10]:41928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R7-00028a-Ez
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qw-0005IP-FN
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qw-0005Gj-4s
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8X6A128063
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:49 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ambn29ef-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:48 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:48 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:36 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-73-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 72/81] cirrus: add blit_is_unsafe call to
 cirrus_bitblt_cputovideo (CVE-2017-2620)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

CIRRUS_BLTMODE_MEMSYSSRC blits do NOT check blit destination
and blit width, at all.  Oops.  Fix it.

Security impact: high.

The missing blit destination check allows to write to host memory.
Basically same as CVE-2014-8106 for the other blit variants.

Cc: qemu-stable@nongnu.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 92f2b88cea48c6aeba8de568a45f2ed958f3c298)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/display/cirrus_vga.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 629a5c8..6766349 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -873,6 +873,10 @@ static int cirrus_bitblt_cputovideo(CirrusVGAState * s)
 {
     int w;
 
+    if (blit_is_unsafe(s, true)) {
+        return 0;
+    }
+
     s->cirrus_blt_mode &= ~CIRRUS_BLTMODE_MEMSYSSRC;
     s->cirrus_srcptr = &s->cirrus_bltbuf[0];
     s->cirrus_srcptr_end = &s->cirrus_bltbuf[0];
@@ -898,6 +902,10 @@ static int cirrus_bitblt_cputovideo(CirrusVGAState * s)
 	}
         s->cirrus_srccounter = s->cirrus_blt_srcpitch * s->cirrus_blt_height;
     }
+
+    /* the blit_is_unsafe call above should catch this */
+    assert(s->cirrus_blt_srcpitch <= CIRRUS_BLTBUFSIZE);
+
     s->cirrus_srcptr = s->cirrus_bltbuf;
     s->cirrus_srcptr_end = s->cirrus_bltbuf + s->cirrus_blt_srcpitch;
     cirrus_update_memory_access(s);
-- 
2.7.4
