Received: from eggs.gnu.org ([2001:4830:134:3::10]:43291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJl-00033q-Na
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJk-0005Am-8R
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d8pJk-00059k-33
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E20A8049B
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 14:43:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 11 May 2017 16:43:39 +0200
Message-Id: <20170511144339.13027-5-kraxel@redhat.com>
In-Reply-To: <20170511144339.13027-1-kraxel@redhat.com>
References: <20170511144339.13027-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] vga: fix display update region calculation
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

vga display update mis-calculated the region for the dirty bitmap
snapshot in case the scanlines are padded.  This can triggere an
assert in cpu_physical_memory_snapshot_get_dirty().

Fixes: fec5e8c92becad223df9d972770522f64aafdb72
Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: =E6=9D=8E=E5=BC=BA <liqiang6-s@360.cn>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170509104839.19415-1-kraxel@redhat.com
---
 hw/display/vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index b2516c8d21..dcc95f88e2 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1630,7 +1630,7 @@ static void vga_draw_graphic(VGACommonState *s, int=
 full_update)
     if (!full_update) {
         vga_sync_dirty_bitmap(s);
         snap =3D memory_region_snapshot_and_clear_dirty(&s->vram, addr1,
-                                                      bwidth * height,
+                                                      line_offset * heig=
ht,
                                                       DIRTY_MEMORY_VGA);
     }
=20
--=20
2.9.3
