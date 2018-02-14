Received: from eggs.gnu.org ([2001:4830:134:3::10]:41052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1em25S-0005Qd-Fw
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1em25Q-00073p-Uh
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:47:22 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:41204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1em25Q-00073S-Nj
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:47:20 -0500
Received: by mail-oi0-x232.google.com with SMTP id l71so1852482oig.8
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:47:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180205133228.25082-1-anatoly.trosinenko@gmail.com>
References: <20180205133228.25082-1-anatoly.trosinenko@gmail.com>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Wed, 14 Feb 2018 21:47:19 +0300
Message-ID: <CAE5jQCewU3WcjA=CKA_33tSJzvV5Ov_ATNi17soCUHSH6fPAGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sdl: restore optimized redraw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Anatoly Trosinenko <anatoly.trosinenko@gmail.com>

Ping.
Patchwork link: http://patchwork.ozlabs.org/patch/869283/

2018-02-05 16:32 GMT+03:00 Anatoly Trosinenko <anatoly.trosinenko@gmail.com=
>
:

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
> ---
> I managed to reproduce some flicker when using SDL 2D UI (and #if 1)
> and it disappeared after this patch. I don't know the original
> testcase, though. Hope I correctly calculated the offset. :)
>
> Meanwhile, is it correct to calculate surface_data_offset before assert,
> is everything always initialized enough at this point even if assert fail=
s?
>
>  ui/sdl2-2d.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
> index 8ab68d67b9..1f34817bae 100644
> --- a/ui/sdl2-2d.c
> +++ b/ui/sdl2-2d.c
> @@ -36,6 +36,8 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
>      struct sdl2_console *scon =3D container_of(dcl, struct sdl2_console,
> dcl);
>      DisplaySurface *surf =3D qemu_console_surface(dcl->con);
>      SDL_Rect rect;
> +    size_t surface_data_offset =3D surface_bytes_per_pixel(surf) * x +
> +                                 surface_stride(surf) * y;
>
>      assert(!scon->opengl);
>
> @@ -46,27 +48,16 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
>          return;
>      }
>
> -    /*
> -     * SDL2 seems to do some double-buffering, and trying to only
> -     * update the changed areas results in only one of the two buffers
> -     * being updated.  Which flickers alot.  So lets not try to be
> -     * clever do a full update every time ...
> -     */
> -#if 0
>      rect.x =3D x;
>      rect.y =3D y;
>      rect.w =3D w;
>      rect.h =3D h;
> -#else
> -    rect.x =3D 0;
> -    rect.y =3D 0;
> -    rect.w =3D surface_width(surf);
> -    rect.h =3D surface_height(surf);
> -#endif
> -
> -    SDL_UpdateTexture(scon->texture, NULL, surface_data(surf),
> +
> +    SDL_UpdateTexture(scon->texture, &rect,
> +                      surface_data(surf) + surface_data_offset,
>                        surface_stride(surf));
> -    SDL_RenderCopy(scon->real_renderer, scon->texture, &rect, &rect);
> +    SDL_RenderClear(scon->real_renderer);
> +    SDL_RenderCopy(scon->real_renderer, scon->texture, NULL, NULL);
>      SDL_RenderPresent(scon->real_renderer);
>  }
>
> --
> 2.14.1
>
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=90=D0=BD=D0=B0=D1=82=D0=BE=D0=BB=D0=B8=D0=B9 =D0=A2=D1=80=D0=BE=D1=81=
=D0=B8=D0=BD=D0=B5=D0=BD=D0=BA=D0=BE
e-mail: anatoly.trosinenko@gmail.com
