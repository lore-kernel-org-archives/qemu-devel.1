Received: from eggs.gnu.org ([2001:4830:134:3::10]:54823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIgvJ-00033b-1U
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIgvF-0001Rm-W5
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:51:53 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:40445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIgvF-0001Qx-Rd
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:51:49 -0400
Received: by mail-qt0-x241.google.com with SMTP id h2-v6so2207123qtp.7
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 13:51:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180515185814.1374-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <158facb6-5139-4feb-edab-7bfebd52b122@amsat.org>
Date: Tue, 15 May 2018 17:51:41 -0300
MIME-Version: 1.0
In-Reply-To: <20180515185814.1374-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] sdl: Move use of surface pointer below
 check for whether it is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, patches@linaro.org

On 05/15/2018 03:58 PM, Peter Maydell wrote:
> In commit 2ab858c6c38ee1 we added a use of the 'surf' variable
> in sdl2_2d_update() that was unfortunately placed above the
> early-exit-if-NULL check. Move it to where it ought to be.
> 
> Fixes: Coverity CID 1390598
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  ui/sdl2-2d.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
> index 1f34817bae..85484407be 100644
> --- a/ui/sdl2-2d.c
> +++ b/ui/sdl2-2d.c
> @@ -36,9 +36,7 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
>      struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
>      DisplaySurface *surf = qemu_console_surface(dcl->con);
>      SDL_Rect rect;
> -    size_t surface_data_offset = surface_bytes_per_pixel(surf) * x +
> -                                 surface_stride(surf) * y;
> -
> +    size_t surface_data_offset;
>      assert(!scon->opengl);
>  
>      if (!surf) {
> @@ -48,6 +46,8 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
>          return;
>      }
>  
> +    surface_data_offset = surface_bytes_per_pixel(surf) * x +
> +                          surface_stride(surf) * y;
>      rect.x = x;
>      rect.y = y;
>      rect.w = w;
> 
