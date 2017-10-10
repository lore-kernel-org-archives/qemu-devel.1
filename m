Received: from eggs.gnu.org ([2001:4830:134:3::10]:45363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1trE-0007Zg-Dw
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1trA-0006DS-Gj
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:42:00 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:53215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1trA-0006D5-9S
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:41:56 -0400
Received: by mail-wm0-x22d.google.com with SMTP id k4so4927088wmc.1
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 05:41:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170913074140.5160-2-kraxel@redhat.com>
References: <20170913074140.5160-1-kraxel@redhat.com>
	<20170913074140.5160-2-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 13:41:34 +0100
Message-ID: <CAFEAcA81zTzhq_X-g=5vnVXG3tU1Y=3ge_CHH45Mj1d0ZaDFdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/6] vga: fix display update region
 calculation (split screen)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>

On 13 September 2017 at 08:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
> vga display update mis-calculated the region for the dirty bitmap
> snapshot in case split screen mode is used.  This can trigger an
> assert in cpu_physical_memory_snapshot_get_dirty().
>
> Impact:  DoS for privileged guest users.
>
> Fixes: CVE-2017-13673
> Fixes: fec5e8c92becad223df9d972770522f64aafdb72
> Cc: P J P <ppandit@redhat.com>
> Reported-by: David Buchanan <d@vidbuchanan.co.uk>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-id: 20170828123307.15392-1-kraxel@redhat.com
> ---
>  hw/display/vga.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 3433102ef3..ad7a46563c 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1628,9 +1628,15 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>      y1 = 0;
>
>      if (!full_update) {
> +        ram_addr_t region_start = addr1;
> +        ram_addr_t region_end = addr1 + line_offset * height;
>          vga_sync_dirty_bitmap(s);
> -        snap = memory_region_snapshot_and_clear_dirty(&s->vram, addr1,
> -                                                      line_offset * height,
> +        if (s->line_compare < height) {
> +            /* split screen mode */
> +            region_start = 0;
> +        }
> +        snap = memory_region_snapshot_and_clear_dirty(&s->vram, region_start,
> +                                                      region_end - region_start,
>                                                        DIRTY_MEMORY_VGA);
>      }

Hi; Coverity complains about this change, that
        ram_addr_t region_end = addr1 + line_offset * height;

is a potential overflow-before-widen because we calculate
line_offset * height as a 32x32 bit multiply and then
assign it to a 64 bit variable, rather than doing a
64 bit multiply. We could shut it up by casting line_offset
to ram_addr_t...

I don't know whether it's actually possible in this case
for the input values to be such that the multiply result
is bigger than 32 bits.

(CID 1381409.)

thanks
-- PMM
