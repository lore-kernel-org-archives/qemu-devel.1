Received: from eggs.gnu.org ([209.51.188.92]:37046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guRST-0005Do-Ts
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guRSJ-0007oG-Uk
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:34:18 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guRSI-0007YI-A6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:34:15 -0500
Date: Fri, 15 Feb 2019 01:34:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190214102816.3393-5-peter.maydell@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1902150133550.41761@zero.eik.bme.hu>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 4/7] ui/cocoa: Move console/device menu
 creation code up in file
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

> Move the console/device menu creation code functions
> further up in the source file, next to the code which
> creates the initial menus. We're going to want to
> change the location we call these functions from in
> the next patch.
>
> This commit is a pure code move with no other changes.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> ui/cocoa.m | 184 ++++++++++++++++++++++++++---------------------------
> 1 file changed, 92 insertions(+), 92 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 0b1cd31543..2d943b6e2a 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -1548,6 +1548,98 @@ static void create_initial_menus(void)
>     [[NSApp mainMenu] addItem:menuItem];
> }
>
> +/* Returns a name for a given console */
> +static NSString * getConsoleName(QemuConsole * console)
> +{
> +    return [NSString stringWithFormat: @"%s", qemu_console_get_label(console)];
> +}
> +
> +/* Add an entry to the View menu for each console */
> +static void add_console_menu_entries(void)
> +{
> +    NSMenu *menu;
> +    NSMenuItem *menuItem;
> +    int index = 0;
> +
> +    menu = [[[NSApp mainMenu] itemWithTitle:@"View"] submenu];
> +
> +    [menu addItem:[NSMenuItem separatorItem]];
> +
> +    while (qemu_console_lookup_by_index(index) != NULL) {
> +        menuItem = [[[NSMenuItem alloc] initWithTitle: getConsoleName(qemu_console_lookup_by_index(index))
> +                                               action: @selector(displayConsole:) keyEquivalent: @""] autorelease];
> +        [menuItem setTag: index];
> +        [menu addItem: menuItem];
> +        index++;
> +    }
> +}
> +
> +/* Make menu items for all removable devices.
> + * Each device is given an 'Eject' and 'Change' menu item.
> + */
> +static void addRemovableDevicesMenuItems(void)
> +{
> +    NSMenu *menu;
> +    NSMenuItem *menuItem;
> +    BlockInfoList *currentDevice, *pointerToFree;
> +    NSString *deviceName;
> +
> +    currentDevice = qmp_query_block(NULL);
> +    pointerToFree = currentDevice;
> +    if(currentDevice == NULL) {
> +        NSBeep();
> +        QEMU_Alert(@"Failed to query for block devices!");
> +        return;
> +    }
> +
> +    menu = [[[NSApp mainMenu] itemWithTitle:@"Machine"] submenu];
> +
> +    // Add a separator between related groups of menu items
> +    [menu addItem:[NSMenuItem separatorItem]];
> +
> +    // Set the attributes to the "Removable Media" menu item
> +    NSString *titleString = @"Removable Media";
> +    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:titleString];
> +    NSColor *newColor = [NSColor blackColor];
> +    NSFontManager *fontManager = [NSFontManager sharedFontManager];
> +    NSFont *font = [fontManager fontWithFamily:@"Helvetica"
> +                                          traits:NSBoldFontMask|NSItalicFontMask
> +                                          weight:0
> +                                            size:14];
> +    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [titleString length])];
> +    [attString addAttribute:NSForegroundColorAttributeName value:newColor range:NSMakeRange(0, [titleString length])];
> +    [attString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt: 1] range:NSMakeRange(0, [titleString length])];
> +
> +    // Add the "Removable Media" menu item
> +    menuItem = [NSMenuItem new];
> +    [menuItem setAttributedTitle: attString];
> +    [menuItem setEnabled: NO];
> +    [menu addItem: menuItem];
> +
> +    /* Loop through all the block devices in the emulator */
> +    while (currentDevice) {
> +        deviceName = [[NSString stringWithFormat: @"%s", currentDevice->value->device] retain];
> +
> +        if(currentDevice->value->removable) {
> +            menuItem = [[NSMenuItem alloc] initWithTitle: [NSString stringWithFormat: @"Change %s...", currentDevice->value->device]
> +                                                  action: @selector(changeDeviceMedia:)
> +                                           keyEquivalent: @""];
> +            [menu addItem: menuItem];
> +            [menuItem setRepresentedObject: deviceName];
> +            [menuItem autorelease];
> +
> +            menuItem = [[NSMenuItem alloc] initWithTitle: [NSString stringWithFormat: @"Eject %s", currentDevice->value->device]
> +                                                  action: @selector(ejectDeviceMedia:)
> +                                           keyEquivalent: @""];
> +            [menu addItem: menuItem];
> +            [menuItem setRepresentedObject: deviceName];
> +            [menuItem autorelease];
> +        }
> +        currentDevice = currentDevice->next;
> +    }
> +    qapi_free_BlockInfoList(pointerToFree);
> +}
> +
> int main (int argc, const char * argv[]) {
>
>     gArgc = argc;
> @@ -1676,98 +1768,6 @@ static void cocoa_cleanup(void)
>     .dpy_refresh = cocoa_refresh,
> };
>
> -/* Returns a name for a given console */
> -static NSString * getConsoleName(QemuConsole * console)
> -{
> -    return [NSString stringWithFormat: @"%s", qemu_console_get_label(console)];
> -}
> -
> -/* Add an entry to the View menu for each console */
> -static void add_console_menu_entries(void)
> -{
> -    NSMenu *menu;
> -    NSMenuItem *menuItem;
> -    int index = 0;
> -
> -    menu = [[[NSApp mainMenu] itemWithTitle:@"View"] submenu];
> -
> -    [menu addItem:[NSMenuItem separatorItem]];
> -
> -    while (qemu_console_lookup_by_index(index) != NULL) {
> -        menuItem = [[[NSMenuItem alloc] initWithTitle: getConsoleName(qemu_console_lookup_by_index(index))
> -                                               action: @selector(displayConsole:) keyEquivalent: @""] autorelease];
> -        [menuItem setTag: index];
> -        [menu addItem: menuItem];
> -        index++;
> -    }
> -}
> -
> -/* Make menu items for all removable devices.
> - * Each device is given an 'Eject' and 'Change' menu item.
> - */
> -static void addRemovableDevicesMenuItems(void)
> -{
> -    NSMenu *menu;
> -    NSMenuItem *menuItem;
> -    BlockInfoList *currentDevice, *pointerToFree;
> -    NSString *deviceName;
> -
> -    currentDevice = qmp_query_block(NULL);
> -    pointerToFree = currentDevice;
> -    if(currentDevice == NULL) {
> -        NSBeep();
> -        QEMU_Alert(@"Failed to query for block devices!");
> -        return;
> -    }
> -
> -    menu = [[[NSApp mainMenu] itemWithTitle:@"Machine"] submenu];
> -
> -    // Add a separator between related groups of menu items
> -    [menu addItem:[NSMenuItem separatorItem]];
> -
> -    // Set the attributes to the "Removable Media" menu item
> -    NSString *titleString = @"Removable Media";
> -    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:titleString];
> -    NSColor *newColor = [NSColor blackColor];
> -    NSFontManager *fontManager = [NSFontManager sharedFontManager];
> -    NSFont *font = [fontManager fontWithFamily:@"Helvetica"
> -                                          traits:NSBoldFontMask|NSItalicFontMask
> -                                          weight:0
> -                                            size:14];
> -    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [titleString length])];
> -    [attString addAttribute:NSForegroundColorAttributeName value:newColor range:NSMakeRange(0, [titleString length])];
> -    [attString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt: 1] range:NSMakeRange(0, [titleString length])];
> -
> -    // Add the "Removable Media" menu item
> -    menuItem = [NSMenuItem new];
> -    [menuItem setAttributedTitle: attString];
> -    [menuItem setEnabled: NO];
> -    [menu addItem: menuItem];
> -
> -    /* Loop through all the block devices in the emulator */
> -    while (currentDevice) {
> -        deviceName = [[NSString stringWithFormat: @"%s", currentDevice->value->device] retain];
> -
> -        if(currentDevice->value->removable) {
> -            menuItem = [[NSMenuItem alloc] initWithTitle: [NSString stringWithFormat: @"Change %s...", currentDevice->value->device]
> -                                                  action: @selector(changeDeviceMedia:)
> -                                           keyEquivalent: @""];
> -            [menu addItem: menuItem];
> -            [menuItem setRepresentedObject: deviceName];
> -            [menuItem autorelease];
> -
> -            menuItem = [[NSMenuItem alloc] initWithTitle: [NSString stringWithFormat: @"Eject %s", currentDevice->value->device]
> -                                                  action: @selector(ejectDeviceMedia:)
> -                                           keyEquivalent: @""];
> -            [menu addItem: menuItem];
> -            [menuItem setRepresentedObject: deviceName];
> -            [menuItem autorelease];
> -        }
> -        currentDevice = currentDevice->next;
> -    }
> -    qapi_free_BlockInfoList(pointerToFree);
> -}
> -
> static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
> {
>     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
>
