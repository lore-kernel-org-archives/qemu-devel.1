Received: from eggs.gnu.org ([209.51.188.92]:56781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guKfK-00089C-Uj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guKfJ-00037v-Vj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:19:14 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:52641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guKfJ-00033L-K7
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:19:13 -0500
Date: Thu, 14 Feb 2019 18:19:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190214102816.3393-3-peter.maydell@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1902141818520.64316@zero.eik.bme.hu>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 2/7] ui/cocoa: Use the pixman image
 directly in switchSurface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>

On Thu, 14 Feb 2019, Peter Maydell wrote:
> Currently the switchSurface method takes a DisplaySurface. We want
> to change our DisplayChangeListener's dpy_gfx_switch callback
> to do this work asynchronously on a different thread. The caller
> of the switch callback will free the old DisplaySurface
> immediately the callback returns, so to ensure that the
> other thread doesn't access freed data we need to switch
> to using the underlying pixman image instead. The pixman
> image is reference counted, so we will be able to take
> a reference to it to avoid it vanishing too early.
>
> In this commit we only change the switchSurface method
> to take a pixman image, and keep the flow of control
> synchronous for now.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> ui/cocoa.m | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 2931c751fd..9d23732ff9 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -315,7 +315,7 @@ @interface QemuCocoaView : NSView
>     BOOL isAbsoluteEnabled;
>     BOOL isMouseDeassociated;
> }
> -- (void) switchSurface:(DisplaySurface *)surface;
> +- (void) switchSurface:(pixman_image_t *)image;
> - (void) grabMouse;
> - (void) ungrabMouse;
> - (void) toggleFullScreen:(id)sender;
> @@ -495,12 +495,13 @@ - (void) setContentDimensions
>     }
> }
>
> -- (void) switchSurface:(DisplaySurface *)surface
> +- (void) switchSurface:(pixman_image_t *)image
> {
>     COCOA_DEBUG("QemuCocoaView: switchSurface\n");
>
> -    int w = surface_width(surface);
> -    int h = surface_height(surface);
> +    int w = pixman_image_get_width(image);
> +    int h = pixman_image_get_height(image);
> +    pixman_format_code_t image_format = pixman_image_get_format(image);
>     /* cdx == 0 means this is our very first surface, in which case we need
>      * to recalculate the content dimensions even if it happens to be the size
>      * of the initial empty window.
> @@ -522,10 +523,10 @@ - (void) switchSurface:(DisplaySurface *)surface
>         CGDataProviderRelease(dataProviderRef);
>
>     //sync host window color space with guests
> -    screen.bitsPerPixel = surface_bits_per_pixel(surface);
> -    screen.bitsPerComponent = surface_bytes_per_pixel(surface) * 2;
> +    screen.bitsPerPixel = PIXMAN_FORMAT_BPP(image_format);
> +    screen.bitsPerComponent = DIV_ROUND_UP(screen.bitsPerPixel, 8) * 2;
>
> -    dataProviderRef = CGDataProviderCreateWithData(NULL, surface_data(surface), w * 4 * h, NULL);
> +    dataProviderRef = CGDataProviderCreateWithData(NULL, pixman_image_get_data(image), w * 4 * h, NULL);
>
>     // update windows
>     if (isFullscreen) {
> @@ -1625,7 +1626,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
>     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
>
>     COCOA_DEBUG("qemu_cocoa: cocoa_switch\n");
> -    [cocoaView switchSurface:surface];
> +    [cocoaView switchSurface:surface->image];
>     [pool release];
> }
>
>
