Received: from eggs.gnu.org ([2001:4830:134:3::10]:34365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1etqcd-0003BI-I4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1etqca-0007qO-CH
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:09:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1etqca-0007pL-66
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:09:52 -0500
Date: Thu, 8 Mar 2018 13:39:40 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20180308073159.1068-1-kraxel@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1803081333420.30534@wniryva>
References: <20180308073159.1068-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] vga: fix region calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>

+-- On Thu, 8 Mar 2018, Gerd Hoffmann wrote --+
| Typically the scanline length and the line offset are identical.
| But case 

But in case ...

| Cc: Ross Lagerwall <ross.lagerwall@citrix.com>

s/Cc:/Reported-by: Ross Lagerwall ...

| Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
| ---
|  hw/display/vga.c | 2 ++
|  1 file changed, 2 insertions(+)
| 
| diff --git a/hw/display/vga.c b/hw/display/vga.c
| index 28f298b342..72181330b8 100644
| --- a/hw/display/vga.c
| +++ b/hw/display/vga.c
| @@ -1483,6 +1483,8 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
|  
|      region_start = (s->start_addr * 4);
|      region_end = region_start + (ram_addr_t)s->line_offset * height;
| +    region_end += width * s->get_bpp(s) / 8; /* scanline length */
| +    region_end -= s->line_offset;
|      if (region_end > s->vbe_size) {
|          /* wraps around (can happen with cirrus vbe modes) */
|          region_start = 0;

It does help to fix a segmentation fault caused by OOB access.

Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
