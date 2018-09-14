Received: from eggs.gnu.org ([2001:4830:134:3::10]:60142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0lDu-0005FK-4d
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0lDq-00036u-W0
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1g0lDq-00035r-NP
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:21:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DE293002737
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 10:21:09 +0000 (UTC)
Date: Fri, 14 Sep 2018 11:20:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180914102057.GA3082@work-vm>
References: <20180914095645.24612-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914095645.24612-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] usb: assign unique serial numbers to hid
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> Windows guests have trouble dealing with usb devices having identical
> serial numbers.  So, assign unique serial numbers to usb hid devices.
> All other usb devices have this already.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

OK, so that's part of https://bugs.launchpad.net/qemu/+bug/1096714
> ---
>  hw/usb/dev-hid.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
> index 62d18290dc..7ad6fb33a9 100644
> --- a/hw/usb/dev-hid.c
> +++ b/hw/usb/dev-hid.c
> @@ -61,7 +61,9 @@ enum {
>      STR_PRODUCT_MOUSE,
>      STR_PRODUCT_TABLET,
>      STR_PRODUCT_KEYBOARD,
> -    STR_SERIALNUMBER,
> +    STR_SERIAL_MOUSE,
> +    STR_SERIAL_TABLET,
> +    STR_SERIAL_KEYBOARD,
>      STR_CONFIG_MOUSE,
>      STR_CONFIG_TABLET,
>      STR_CONFIG_KEYBOARD,
> @@ -72,7 +74,9 @@ static const USBDescStrings desc_strings = {
>      [STR_PRODUCT_MOUSE]    = "QEMU USB Mouse",
>      [STR_PRODUCT_TABLET]   = "QEMU USB Tablet",
>      [STR_PRODUCT_KEYBOARD] = "QEMU USB Keyboard",
> -    [STR_SERIALNUMBER]     = "42", /* == remote wakeup works */
> +    [STR_SERIAL_MOUSE]     = "89126",
> +    [STR_SERIAL_TABLET]    = "28754",
> +    [STR_SERIAL_KEYBOARD]  = "68284",

Is there any significance to the magical numbers?

Will this change trigger a serial number change across migrate
or will the current serial be carried across?

Dave

>      [STR_CONFIG_MOUSE]     = "HID Mouse",
>      [STR_CONFIG_TABLET]    = "HID Tablet",
>      [STR_CONFIG_KEYBOARD]  = "HID Keyboard",
> @@ -375,7 +379,7 @@ static const USBDesc desc_mouse = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_MOUSE,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_MOUSE,
>      },
>      .full = &desc_device_mouse,
>      .str  = desc_strings,
> @@ -389,7 +393,7 @@ static const USBDesc desc_mouse2 = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_MOUSE,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_MOUSE,
>      },
>      .full = &desc_device_mouse,
>      .high = &desc_device_mouse2,
> @@ -404,7 +408,7 @@ static const USBDesc desc_tablet = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_TABLET,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_TABLET,
>      },
>      .full = &desc_device_tablet,
>      .str  = desc_strings,
> @@ -418,7 +422,7 @@ static const USBDesc desc_tablet2 = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_TABLET,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_TABLET,
>      },
>      .full = &desc_device_tablet,
>      .high = &desc_device_tablet2,
> @@ -433,7 +437,7 @@ static const USBDesc desc_keyboard = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_KEYBOARD,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_TABLET,
>      },
>      .full = &desc_device_keyboard,
>      .str  = desc_strings,
> @@ -447,7 +451,7 @@ static const USBDesc desc_keyboard2 = {
>          .bcdDevice         = 0,
>          .iManufacturer     = STR_MANUFACTURER,
>          .iProduct          = STR_PRODUCT_KEYBOARD,
> -        .iSerialNumber     = STR_SERIALNUMBER,
> +        .iSerialNumber     = STR_SERIAL_TABLET,
>      },
>      .full = &desc_device_keyboard,
>      .high = &desc_device_keyboard2,
> @@ -718,9 +722,7 @@ static void usb_hid_initfn(USBDevice *dev, int kind,
>          return;
>      }
>  
> -    if (dev->serial) {
> -        usb_desc_set_string(dev, STR_SERIALNUMBER, dev->serial);
> -    }
> +    usb_desc_create_serial(dev);
>      usb_desc_init(dev);
>      us->intr = usb_ep_get(dev, USB_TOKEN_IN, 1);
>      hid_init(&us->hid, kind, usb_hid_changed);
> -- 
> 2.9.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
