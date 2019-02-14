Received: from eggs.gnu.org ([209.51.188.92]:57630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guKhx-0001fG-1y
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guKhv-0005Z8-VC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:21:56 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:58503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guKhv-0005Ux-H4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:21:55 -0500
Date: Thu, 14 Feb 2019 18:21:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190214102816.3393-7-peter.maydell@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1902141821360.64316@zero.eik.bme.hu>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-7-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 6/7] ui/cocoa: Subclass NSApplication so
 we can implement sendEvent
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
> When we switch away from our custom event handling, we still want to
> be able to have first go at any events our application receives,
> because in full-screen mode we want to send key events to the guest,
> even if they would be menu item activation events. There are several
> ways we could do that, but one simple approach is to subclass
> NSApplication so we can implement a custom sendEvent method.
> Do that, but for the moment have our sendEvent just invoke the
> superclass method.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> New patch in v2
> ---
> ui/cocoa.m | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 5a84e1aea7..184fbd877d 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -1478,6 +1478,17 @@ - (void)adjustSpeed:(id)sender
>
> @end
>
> +@interface QemuApplication : NSApplication
> +@end
> +
> +@implementation QemuApplication
> +- (void)sendEvent:(NSEvent *)event
> +{
> +    COCOA_DEBUG("QemuApplication: sendEvent\n");
> +    [super sendEvent: event];
> +}
> +@end
> +
> static void create_initial_menus(void)
> {
>     // Add menus
> @@ -1691,7 +1702,7 @@ int main (int argc, const char * argv[]) {
>     ProcessSerialNumber psn = { 0, kCurrentProcess };
>     TransformProcessType(&psn, kProcessTransformToForegroundApplication);
>
> -    [NSApplication sharedApplication];
> +    [QemuApplication sharedApplication];
>
>     create_initial_menus();
>
>
