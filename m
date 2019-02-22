Received: from eggs.gnu.org ([209.51.188.92]:55877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxIUS-00063m-IR
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxIUR-0002ws-NZ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:36:16 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:39000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gxIUR-0002Xv-79
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:36:15 -0500
Date: Sat, 23 Feb 2019 00:35:54 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190222213554.vqohje2xyx6fixev@SPB-NB-133.local>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-8-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190214102816.3393-8-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] ui/cocoa: Perform UI operations
 only on the main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, BALATON Zoltan <balaton@eik.bme.hu>

On Thu, Feb 14, 2019 at 10:28:16AM +0000, Peter Maydell wrote:
> The OSX Mojave release is more picky about enforcing the Cocoa API
> restriction that only the main thread may perform UI calls. To
> accommodate this we need to restructure the Cocoa code:
>  * the special OSX main() creates a second thread and uses
>    that to call the vl.c qemu_main(); the original main
>    thread goes into the OSX event loop
>  * the refresh, switch and update callbacks asynchronously
>    tell the main thread to do the necessary work
>  * the refresh callback no longer does the "get events from the
>    UI event queue and handle them" loop, since we now use
>    the stock OSX event loop. Instead our NSApplication sendEvent
>    method will either deal with them or pass them on to OSX
> 
> All these things have to be changed in one commit, to avoid
> breaking bisection.
> 
> Note that since we use dispatch_get_main_queue(), this bumps
> our minimum version requirement to OSX 10.10 Yosemite (released
> in 2014, unsupported by Apple since 2017).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2 changes: call handleEvent from sendEvent
> ---
>  ui/cocoa.m | 191 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 113 insertions(+), 78 deletions(-)
> 
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 184fbd877d..201a294ed4 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -129,6 +129,9 @@
>  NSTextField *pauseLabel;
>  NSArray * supportedImageFileTypes;
>  
> +QemuSemaphore display_init_sem;
> +QemuSemaphore app_started_sem;
> +

They might have file scope.

> @@ -535,13 +539,16 @@ - (void) switchSurface:(pixman_image_t *)image
>      }
>  
>      // update screenBuffer
> -    if (dataProviderRef)
> +    if (dataProviderRef) {
>          CGDataProviderRelease(dataProviderRef);
> +        pixman_image_unref(pixman_image);
> +    }

pixman_image also needs to be unreferenced in dealloc.

> @@ -1485,7 +1482,9 @@ @implementation QemuApplication
>  - (void)sendEvent:(NSEvent *)event
>  {
>      COCOA_DEBUG("QemuApplication: sendEvent\n");
> -    [super sendEvent: event];
> +    if (!cocoaView || ![cocoaView handleEvent:event]) {
> +        [super sendEvent: event];
> +    }
>  }
>  @end
>  

if (!cocoaView || ![cocoaView handleEvent:event]) {

can be written as

if (![cocoaView handleEvent:event]) {

It's valid to send a message to nil and it will return 0/false/NO.

Thank you for working on the patch series. It definitely improves UI event
handling.

Besides the pixman_image leak,

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Roman
