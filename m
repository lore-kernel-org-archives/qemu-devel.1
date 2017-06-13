Received: from eggs.gnu.org ([2001:4830:134:3::10]:38878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKqAQ-0004e0-FI
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKqAP-0006tY-Cb
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:03:50 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKqAP-0006tP-3Z
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:03:49 -0400
Received: by mail-wr0-x233.google.com with SMTP id q97so154952393wrb.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 11:03:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <659939DD-F3BB-4FB9-B242-E0BB624EFED8@gmail.com>
References: <659939DD-F3BB-4FB9-B242-E0BB624EFED8@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 19:03:27 +0100
Message-ID: <CAFEAcA8AX8ySj4NnRjX4yQwjiyKf35z_KJO0kp4Ohd5wdBQRsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa.m: add Speed menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 9 June 2017 at 16:02, Programmingkid <programmingkidx@gmail.com> wrote:
> Programs running inside of QEMU can sometimes use more CPU time than is really
> needed. To solve this problem, we just need to throttle the virtual CPU. This
> feature will stop laptops from burning up.
>
> This patch adds a menu called Speed that has menu items from 100% to 1% that
> represent the speed options. 100% is full speed and 1% is slowest.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---

Thanks for this patch. I have a few minor tweaks to suggest
below, but it mostly looks good.

> v2 changes:
> Fixed missing space with 'if' and 'for' structures.
> Fixed tab damage.
> Use loop to create menu items.
> Changed name of menu items to use percentages.
> Use tags to determine selected menu item.
>
>  ui/cocoa.m | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 26d4a1c..772629e 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -35,6 +35,7 @@
>  #include "sysemu/blockdev.h"
>  #include "qemu-version.h"
>  #include <Carbon/Carbon.h>
> +#include "qom/cpu.h"
>
>  #ifndef MAC_OS_X_VERSION_10_5
>  #define MAC_OS_X_VERSION_10_5 1050
> @@ -828,6 +829,7 @@ QemuCocoaView *cocoaView;
>  - (void)openDocumentation:(NSString *)filename;
>  - (IBAction) do_about_menu_item: (id) sender;
>  - (void)make_about_window;
> +- (void)adjustSpeed:(id)sender;
>  @end
>
>  @implementation QemuCocoaAppController
> @@ -1234,6 +1236,35 @@ QemuCocoaView *cocoaView;
>      [superView addSubview: copyright_label];
>  }
>
> +/* Used by the Speed menu items */
> +- (void)adjustSpeed:(id)sender
> +{
> +    int speed, menu_number, count, item;
> +    NSMenu *menu;
> +    NSArray *itemArray;
> +
> +    // uncheck all the menu items in the Speed menu
> +    menu = [sender menu];
> +    if (menu != nil)
> +    {
> +        count = [[menu itemArray] count];
> +        itemArray = [menu itemArray];
> +        for (item = 0; item < count; item++)  // unselect each item
> +            [[itemArray objectAtIndex: item] setState: NSOffState];

I'm not sure how smart the Cocoa redraw is going to be about
setting a menu state to a value it's already at. Maybe better:

          /* Unselect the currently selected item */
          for (NSMenuItem *item in [menu itemArray]) {
              if (item.state == NSOnState) {
                  [item setState: NSOffState];
                  break;
              }
          }

I just cribbed the "iterate through an NSArray" syntax off
stackoverflow and have only compile tested it, but it should
work on OSX 10.5 and later and it looks much nicer than using
an integer index.

> +    }
> +
> +    // check the menu item
> +    [sender setState: NSOnState];
> +
> +    // get the menu number
> +    menu_number = [sender tag];
> +
> +    /* Calculate the speed */
> +    speed = -1 * menu_number + 100;

This is a bit confusing, because "speed" isn't actually a speed,
it's the % of time that the vcpu should be asleep. "throttle_pct"
is a better name.

I think you also might as well pre-calculate the throttle percentage
and use that as the tag value in the menu, since we never use
the tag value for anything else.

> +    cpu_throttle_set(speed);
> +    COCOA_DEBUG("cpu throttling at %d%c\n", cpu_throttle_get_percentage(), '%');
> +}
> +
>  @end
>
>
> @@ -1316,6 +1347,29 @@ int main (int argc, const char * argv[]) {
>      [menuItem setSubmenu:menu];
>      [[NSApp mainMenu] addItem:menuItem];
>
> +    // Speed menu
> +    menu = [[NSMenu alloc] initWithTitle:@"Speed"];
> +
> +    // The 100% menu item has to be checked at the start
> +    menuItem = [[[NSMenuItem alloc] initWithTitle:@"100%" action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease];
> +    [menuItem setTag: 100];
> +    [menuItem setState: NSOnState];
> +    [menu addItem: menuItem];

You can put the 100% item in the same loop as the others; just have
   if (percentage == 100) {
       [menuItem setState: NSOnState];
   }
in the loop.

> +
> +    // Add the rest of the menu items
> +    int p, percentage;
> +    for (p = 9; p >= 0; p--)
> +    {
> +        percentage = p * 10 > 1 ? p * 10 : 1; // prevent a 0% menu item
> +        menuItem = [[[NSMenuItem alloc]
> +                   initWithTitle: [NSString stringWithFormat: @"%d%c", percentage, '%']

You don't need to use "%c" to get a literal % into the format string;
just use "%%".

action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease];
> +        [menuItem setTag: percentage];
> +        [menu addItem: menuItem];
> +    }
> +    menuItem = [[[NSMenuItem alloc] initWithTitle:@"Speed" action:nil keyEquivalent:@""] autorelease];
> +    [menuItem setSubmenu:menu];
> +    [[NSApp mainMenu] addItem:menuItem];
> +
>      // Window menu
>      menu = [[NSMenu alloc] initWithTitle:@"Window"];
>      [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Minimize" action:@selector(performMiniaturize:) keyEquivalent:@"m"] autorelease]]; // Miniaturize
> --
> 2.7.2

thanks
-- PMM
