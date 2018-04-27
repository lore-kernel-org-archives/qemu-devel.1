Received: from eggs.gnu.org ([2001:4830:134:3::10]:51780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC37R-0004mk-8m
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC37Q-0000yA-A2
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:08:57 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC37Q-0000xu-5I
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:08:56 -0400
Received: by mail-oi0-x244.google.com with SMTP id c203-v6so1510447oib.7
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:08:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180216115410.27287-5-kraxel@redhat.com>
References: <20180216115410.27287-1-kraxel@redhat.com>
	<20180216115410.27287-5-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 14:08:32 +0100
Message-ID: <CAFEAcA8sTZuM5jBfJyJuuL_gPLcFYKUNJjYAKVRWpzO7Qw5-9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 4/9] sdl: restore optimized redraw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anatoly Trosinenko <anatoly.trosinenko@gmail.com>

On 16 February 2018 at 11:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
>
> The documentation on SDL_RenderPresent function states that
> "the backbuffer should be considered invalidated after each present",
> so copy the entire texture on each redraw.
>
> On the other hand, SDL_UpdateTexture function is described as
> "fairly slow function", so restrict it to just the changed pixels.
>
> Also added SDL_RenderClear call, as suggested in the documentation
> page on SDL_RenderPresent.
>
> Signed-off-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
> Message-id: 20180205133228.25082-1-anatoly.trosinenko@gmail.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/sdl2-2d.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
> index 8ab68d67b9..1f34817bae 100644
> --- a/ui/sdl2-2d.c
> +++ b/ui/sdl2-2d.c
> @@ -36,6 +36,8 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
>      struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
>      DisplaySurface *surf = qemu_console_surface(dcl->con);
>      SDL_Rect rect;
> +    size_t surface_data_offset = surface_bytes_per_pixel(surf) * x +
> +                                 surface_stride(surf) * y;
>
>      assert(!scon->opengl);
>

Hi. Coverity points out (CID 1390598) that this change adds
a use of 'surf' before the "if (!surf) { return; }" check.
I suspect the calculation of surface_data_offset should be
done lower in the function, after all the early-exit checks.

thanks
-- PMM
