Received: from eggs.gnu.org ([2001:4830:134:3::10]:52548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cVyGM-0001l6-SO
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cVyGM-0005Zi-0m
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:23:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cVyGL-0005ZK-Qn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:23:41 -0500
References: <58871f9b.d635240a.4cda6.5322@mx.google.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <237b1da5-532d-afd6-84ad-6adc5bd97291@redhat.com>
Date: Tue, 24 Jan 2017 11:23:38 +0100
MIME-Version: 1.0
In-Reply-To: <58871f9b.d635240a.4cda6.5322@mx.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org, ghoffman@redhat.com
Cc: liqiang6-s@360.cn

On 01/24/17 10:34, Li Qiang wrote:
> From: Li Qiang <liqiang6-s@360.cn>
> 
> When doing bitblt copy in backward mode, minus the blt width first
> to avoid an oob access issue.
> 
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/display/cirrus_vga.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 379910d..7ddd289 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -277,7 +277,8 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
>      }
>      if (pitch < 0) {
>          int64_t min = addr
> -            + ((int64_t)s->cirrus_blt_height-1) * pitch;
> +            + ((int64_t)s->cirrus_blt_height-1) * pitch
> +            - s->cirrus_blt_width;
>          int32_t max = addr
>              + s->cirrus_blt_width;
>          if (min < 0 || max > s->vga.vram_size) {
> 

I believe this is incorrect. In this case (AFAIR), "addr" points to the
left-most pixel (= lowest address) of the bottom line (= highest
address). This is why "max" is calculated the way it is -- to get the
max address, just move to the right side of the same bottom line.

Which then also means, in order to get the top left corner, you just
need to subtract an integral multiple of the stride (you are already on
the left side). Since the pitch is negative here, that means adding an
integral multiple of the pitch.

Finally, for a single-line blt, the bottom line is the only line, in
which case we pitch multiplier should be (1 - 1) == 0.

I think the code is correct as-is.

Thanks
Laszlo
