Received: from eggs.gnu.org ([2001:4830:134:3::10]:48010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6FFl-0008NA-Kp
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6FFh-0007bg-HN
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6FFh-0007Zc-8I
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:48:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4935A7E9C3
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 11:48:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1493888311-30839-1-git-send-email-thuth@redhat.com>
Date: Thu, 04 May 2017 13:48:50 +0200
In-Reply-To: <1493888311-30839-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 4 May 2017 10:58:31 +0200")
Message-ID: <87vapgg7vh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Update to use the new way of
 attaching USB devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> The preferred way of adding USB devices is via "-device" and
> "device_add" nowadays, so let's get rid of "-usbdevice" and
> "usb_add" in the documentation.

Yes, please!

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi | 75 ++++++++++++++++++++++++-----------------------------------
>  1 file changed, 31 insertions(+), 44 deletions(-)
>
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 794ab4a..d119e67 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -182,7 +182,7 @@ Gravis Ultrasound GF1 sound card
>  @item
>  CS4231A compatible sound card
>  @item
> -PCI UHCI USB controller and a virtual USB hub.
> +PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1 hub.

Do we need to say "USB-1.1 hub", or would "USB hub" do?

>  @end itemize
>  
>  SMP is supported with up to 255 CPUs.
> @@ -1357,10 +1357,10 @@ monitor (@pxref{pcsys_keys}).
>  @node pcsys_usb
>  @section USB emulation
>  
> -QEMU emulates a PCI UHCI USB controller. You can virtually plug
> -virtual USB devices or real host USB devices (experimental, works only
> -on Linux hosts).  QEMU will automatically create and connect virtual USB hubs
> -as necessary to connect multiple USB devices.
> +QEMU can emulate a PCI UHCI, OHCI, EHCI or XHCI USB controller. You can
> +virtually plug virtual USB devices or real host USB devices (experimental,

Outside this patch's stated scope, but here goes anyway (same for most
of my other comments): "virtually plug virtual" sounds odd.  Do we need
"virtually"?

> +only works with certain host operating systems). QEMU will automatically create
> +and connect virtual USB hubs as necessary to connect multiple USB devices.

Extra points for updating "works only on Linux".

Gerd, can we drop "experimental" now?

>  
>  @menu
>  * usb_devices::
> @@ -1369,60 +1369,47 @@ as necessary to connect multiple USB devices.
>  @node usb_devices
>  @subsection Connecting USB devices
>  
> -USB devices can be connected with the @option{-usbdevice} commandline option
> -or the @code{usb_add} monitor command.  Available devices are:
> +USB devices can be connected with the @option{-device usb-...} commandline

While there, s/commandline/command line/.

> +option or the @code{device_add} monitor command. Available devices are:
>  
>  @table @code
> -@item mouse
> +@item usb-mouse
>  Virtual Mouse.  This will override the PS/2 mouse emulation when activated.
> -@item tablet
> +@item usb-tablet
>  Pointer device that uses absolute coordinates (like a touchscreen).
>  This means QEMU is able to report the mouse position without having
>  to grab the mouse.  Also overrides the PS/2 mouse emulation when activated.
> -@item disk:@var{file}
> -Mass storage device based on @var{file} (@pxref{disk_images})
> -@item host:@var{bus.addr}
> -Pass through the host device identified by @var{bus.addr}
> +@item usb-storage,drive=@var{drive_id}
> +Mass storage device (see also @pxref{disk_images})
> +@item usb-host,hostbus=@var{bus},hostaddr=@var{addr}
> +Pass through the host device identified by @var{bus} and @var{addr}
>  (Linux only)
> -@item host:@var{vendor_id:product_id}
> -Pass through the host device identified by @var{vendor_id:product_id}
> +@item usb-host,vendorid=@var{vendor},productid=@var{product}
> +Pass through the host device identified by @var{vendor} and @var{product} ID
>  (Linux only)

Gerd, is this still Linux only?

I figure users almost always use one of these two forms.  However, the
code treats all four of hostbus, hostaddr, vendorid, productid as
optional, and grabs the first device that matches.  Missing parameter
matches anything.  Not sure how precisely we want to document that
here.  Gerd?

> -@item wacom-tablet
> +@item usb-wacom-tablet
>  Virtual Wacom PenPartner tablet.  This device is similar to the @code{tablet}
>  above but it can be used with the tslib library because in addition to touch
>  coordinates it reports touch pressure.
> -@item keyboard
> +@item usb-kbd
>  Standard USB keyboard.  Will override the PS/2 keyboard (if present).
> -@item serial:[vendorid=@var{vendor_id}][,product_id=@var{product_id}]:@var{dev}
> +@item usb-serial,chardev=@var{dev}
>  Serial converter. This emulates an FTDI FT232BM chip connected to host character
> -device @var{dev}. The available character devices are the same as for the
> -@code{-serial} option. The @code{vendorid} and @code{productid} options can be
> -used to override the default 0403:6001. For instance,
> -@example
> -usb_add serial:productid=FA00:tcp:192.168.0.2:4444
> -@end example
> -will connect to tcp port 4444 of ip 192.168.0.2, and plug that to the virtual
> -serial converter, faking a Matrix Orbital LCD Display (USB ID 0403:FA00).

I wonder why you drop rather than update documentation on vendorid and
productid... aha!

    $ qemu-system-x86_64 -nodefaults -S -usb -usbdevice serial:vendorid=403,productid=6001:null
    Unexpected error in object_property_find() at /work/armbru/qemu/qom/object.c:1008:
    upstream-qemu: -usbdevice serial:vendorid=403,productid=6001:null: Property '.vendorid' not found
    Aborted (core dumped)

Someone broke the feature.  Unless it's recent breakage, we can bury it,
I guess.  Gerd?

If we bury it, then docs/qdev-device-use.txt needs an update, too.

> -@item braille
> +device @var{dev}.
> +@item usb-braille
>  Braille device.  This will use BrlAPI to display the braille output on a real
>  or fake device.
> -@item net:@var{options}
> -Network adapter that supports CDC ethernet and RNDIS protocols.  @var{options}
> -specifies NIC options as with @code{-net nic,}@var{options} (see description).
> +@item net[,netdev=@var{id}]

Do you mean usb-net?

> +Network adapter that supports CDC ethernet and RNDIS protocols.  @var{id}
> +specifies a netdev ID as with @code{-netdev xxx,id=}@var{id}.

"a netdev defined with"?

>  For instance, user-mode networking can be used with
>  @example
> -qemu-system-i386 [...OPTIONS...] -net user,vlan=0 -usbdevice net:vlan=0
> -@end example
> -Currently this cannot be used in machines that support PCI NICs.
> -@item bt[:@var{hci-type}]
> -Bluetooth dongle whose type is specified in the same format as with
> -the @option{-bt hci} option, @pxref{bt-hcis,,allowed HCI types}.  If
> -no type is given, the HCI logic corresponds to @code{-bt hci,vlan=0}.
> -This USB device implements the USB Transport Layer of HCI.  Example
> -usage:
> -@example
> -@command{qemu-system-i386} [...@var{OPTIONS}...] @option{-usbdevice} bt:hci,vlan=3 @option{-bt} device:keyboard,vlan=3
> +qemu-system-i386 [...OPTIONS...] -netdev user,id=id0 -device usb-net,netdev=id0

Suggest to use net0 instead of id0 here.

>  @end example
> +@item usb-bt-dongle
> +Bluetooth dongle which implements the USB Transport Layer of HCI.
> +It is connected to HCI scatternet 0 by default (corresponds to
> +@code{-bt hci,vlan=0}).

The Bluetooth documentation you replace is confusing.  Ignorant
question: is -device ... as expressive as -usbdevice bt:...?

docs/qdev-device-use.txt needs an update for this one.

>  @end table

Covers exactly the same USB devices as before.  Doesn't cover newer
devices that aren't available with legacy -usbdevice: usb-audio,
usb-bot, usb-ccid, usb-hub, usb-mtp, usb-redir, usb-uas.

In case you don't want to cover them in this patch, what about adding a
hint that there are more?

>  @node host_usb_devices
> @@ -1460,11 +1447,11 @@ hubs, it won't work).
>  
>  @item Add the device in QEMU by using:
>  @example
> -usb_add host:1234:5678
> +device_add usb-host,vendorid=0x1234,productid=0x5678
>  @end example
>  
> -Normally the guest OS should report that a new USB device is
> -plugged. You can use the option @option{-usbdevice} to do the same.
> +Normally the guest OS should report that a new USB device is plugged.
> +You can use the option @option{-device usb-host,...} to do the same.
>  
>  @item Now you can try to use the host USB device in QEMU.
