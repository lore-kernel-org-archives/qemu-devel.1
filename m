Received: from eggs.gnu.org ([2001:4830:134:3::10]:35968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpt5W-0003Cc-Em
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpt5T-0000Gu-Ht
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cpt5T-0000GZ-Cb
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:54:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56A2343A3C
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:54:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 09:54:37 +0100
Message-Id: <1490000078-31202-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490000078-31202-1-git-send-email-kraxel@redhat.com>
References: <1490000078-31202-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 2/3] cirrus: fix off-by-one in
 cirrus_bitblt_rop_bkwd_transp_*_16
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

The switch from pointers to addresses (commit
026aeffcb4752054830ba203020ed6eb05bcaba8 and
ffaf857778286ca54e3804432a2369a279e73aa7) added
a off-by-one bug to 16bit backward blits.  Fix.

Reported-by: =E6=9D=8E=E5=BC=BA <liqiang6-s@360.cn>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Li Qiang <liqiang6-s@360.cn>
Message-id: 1489735296-19047-1-git-send-email-kraxel@redhat.com
---
 hw/display/cirrus_vga_rop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/cirrus_vga_rop.h b/hw/display/cirrus_vga_rop.h
index c61a677..0841b9e 100644
--- a/hw/display/cirrus_vga_rop.h
+++ b/hw/display/cirrus_vga_rop.h
@@ -219,7 +219,7 @@ glue(glue(cirrus_bitblt_rop_bkwd_transp_, ROP_NAME),_=
16)(CirrusVGAState *s,
     srcpitch +=3D bltwidth;
     for (y =3D 0; y < bltheight; y++) {
         for (x =3D 0; x < bltwidth; x+=3D2) {
-            ROP_OP_TR_16(s, dstaddr, cirrus_src16(s, srcaddr), transp);
+            ROP_OP_TR_16(s, dstaddr - 1, cirrus_src16(s, srcaddr - 1), t=
ransp);
             dstaddr -=3D 2;
             srcaddr -=3D 2;
         }
--=20
1.8.3.1
