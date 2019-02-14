Received: from eggs.gnu.org ([209.51.188.92]:55754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guKeH-0006pe-Cv
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guKY3-00054G-4l
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:11:45 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:34251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guKXy-00051L-PC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:11:39 -0500
Date: Thu, 14 Feb 2019 18:11:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190214102816.3393-4-peter.maydell@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1902141811120.64316@zero.eik.bme.hu>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 3/7] ui/cocoa: Factor out initial menu
 creation
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
> Factor out the long code sequence in main() which creates
> the initial set of menus. This will make later patches
> which move initialization code around a bit clearer.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> ui/cocoa.m | 78 ++++++++++++++++++++++++++++--------------------------
> 1 file changed, 41 insertions(+), 37 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 9d23732ff9..0b1cd31543 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -1461,43 +1461,8 @@ - (void)adjustSpeed:(id)sender
>
> @end
>
> -
> -int main (int argc, const char * argv[]) {
> -
> -    gArgc = argc;
> -    gArgv = (char **)argv;
> -    int i;
> -
> -    /* In case we don't need to display a window, let's not do that */
> -    for (i = 1; i < argc; i++) {
> -        const char *opt = argv[i];
> -
> -        if (opt[0] == '-') {
> -            /* Treat --foo the same as -foo.  */
> -            if (opt[1] == '-') {
> -                opt++;
> -            }
> -            if (!strcmp(opt, "-h") || !strcmp(opt, "-help") ||
> -                !strcmp(opt, "-vnc") ||
> -                !strcmp(opt, "-nographic") ||
> -                !strcmp(opt, "-version") ||
> -                !strcmp(opt, "-curses") ||
> -                !strcmp(opt, "-display") ||
> -                !strcmp(opt, "-qtest")) {
> -                return qemu_main(gArgc, gArgv, *_NSGetEnviron());
> -            }
> -        }
> -    }
> -
> -    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
> -
> -    // Pull this console process up to being a fully-fledged graphical
> -    // app with a menubar and Dock icon
> -    ProcessSerialNumber psn = { 0, kCurrentProcess };
> -    TransformProcessType(&psn, kProcessTransformToForegroundApplication);
> -
> -    [NSApplication sharedApplication];
> -
> +static void create_initial_menus(void)
> +{
>     // Add menus
>     NSMenu      *menu;
>     NSMenuItem  *menuItem;
> @@ -1581,6 +1546,45 @@ int main (int argc, const char * argv[]) {
>     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Window" action:nil keyEquivalent:@""] autorelease];
>     [menuItem setSubmenu:menu];
>     [[NSApp mainMenu] addItem:menuItem];
> +}
> +
> +int main (int argc, const char * argv[]) {
> +
> +    gArgc = argc;
> +    gArgv = (char **)argv;
> +    int i;
> +
> +    /* In case we don't need to display a window, let's not do that */
> +    for (i = 1; i < argc; i++) {
> +        const char *opt = argv[i];
> +
> +        if (opt[0] == '-') {
> +            /* Treat --foo the same as -foo.  */
> +            if (opt[1] == '-') {
> +                opt++;
> +            }
> +            if (!strcmp(opt, "-h") || !strcmp(opt, "-help") ||
> +                !strcmp(opt, "-vnc") ||
> +                !strcmp(opt, "-nographic") ||
> +                !strcmp(opt, "-version") ||
> +                !strcmp(opt, "-curses") ||
> +                !strcmp(opt, "-display") ||
> +                !strcmp(opt, "-qtest")) {
> +                return qemu_main(gArgc, gArgv, *_NSGetEnviron());
> +            }
> +        }
> +    }
> +
> +    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
> +
> +    // Pull this console process up to being a fully-fledged graphical
> +    // app with a menubar and Dock icon
> +    ProcessSerialNumber psn = { 0, kCurrentProcess };
> +    TransformProcessType(&psn, kProcessTransformToForegroundApplication);
> +
> +    [NSApplication sharedApplication];
> +
> +    create_initial_menus();
>
>     // Create an Application controller
>     QemuCocoaAppController *appController = [[QemuCocoaAppController alloc] init];
>
