Received: from eggs.gnu.org ([2001:4830:134:3::10]:59613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1evmdL-0001Zb-Rr
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1evmdH-0004hS-UV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
	id 1evmdH-0004fv-Iw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w2DGIXTD076606
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 16:18:33 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp2130.oracle.com with ESMTP id 2gph200e13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 16:18:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w2DGDdk3023217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 16:13:39 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w2DGDdCb004126
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 16:13:39 GMT
References: <20180312105941.15439-1-kraxel@redhat.com>
	<20180312105941.15439-2-kraxel@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <59d527f3-1ef6-1e4b-8daa-c0ebcd89cb9b@oracle.com>
Date: Tue, 13 Mar 2018 11:13:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180312105941.15439-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/1] vga: fix region calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 3/12/2018 5:59 AM, Gerd Hoffmann wrote:
> Typically the scanline length and the line offset are identical.  But
> in case they are not our calculation for region_end is incorrect.  Using
> line_offset is fine for all scanlines, except the last one where we have
> to use the actual scanline length.
> 
> Fixes: CVE-2018-7550

This doesn't appear to be the correct CVE number.

https://nvd.nist.gov/vuln/detail/CVE-2018-7550

..please confirm..

Thanks,

-Mark

> Reported-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
> Tested-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Message-id: 20180309143704.13420-1-kraxel@redhat.com
> ---
>   hw/display/vga.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 28f298b342..72181330b8 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1483,6 +1483,8 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>   
>       region_start = (s->start_addr * 4);
>       region_end = region_start + (ram_addr_t)s->line_offset * height;
> +    region_end += width * s->get_bpp(s) / 8; /* scanline length */
> +    region_end -= s->line_offset;
>       if (region_end > s->vbe_size) {
>           /* wraps around (can happen with cirrus vbe modes) */
>           region_start = 0;
> 
