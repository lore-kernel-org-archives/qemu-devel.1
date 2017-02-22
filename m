Received: from eggs.gnu.org ([2001:4830:134:3::10]:47069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgWXR-000358-Fe
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgWXO-00074z-BF
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:00:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgWXO-00074Z-62
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:00:54 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A653861D07
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 13:00:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 22 Feb 2017 13:42:31 +0100
Message-Id: <1487767351-9190-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487767351-9190-1-git-send-email-kraxel@redhat.com>
References: <1487767351-9190-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] cirrus: add blit_is_unsafe call to
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

CIRRUS_BLTMODE_MEMSYSSRC blits do NOT check blit destination
and blit width, at all.  Oops.  Fix it.

Security impact: high.

The missing blit destination check allows to write to host memory.
Basically same as CVE-2014-8106 for the other blit variants.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1487679663-3264-1-git-send-email-kraxel@redhat.com
---
 hw/display/cirrus_vga.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 1deb520..b9e7cb1 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -900,6 +900,10 @@ static int cirrus_bitblt_cputovideo(CirrusVGAState * s)
 {
     int w;
 
+    if (blit_is_unsafe(s, true)) {
+        return 0;
+    }
+
     s->cirrus_blt_mode &= ~CIRRUS_BLTMODE_MEMSYSSRC;
     s->cirrus_srcptr = &s->cirrus_bltbuf[0];
     s->cirrus_srcptr_end = &s->cirrus_bltbuf[0];
@@ -925,6 +929,10 @@ static int cirrus_bitblt_cputovideo(CirrusVGAState * s)
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
1.8.3.1
