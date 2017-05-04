Received: from eggs.gnu.org ([2001:4830:134:3::10]:54935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d6FZf-0001XG-GI
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d6FZc-0004Bc-2r
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:09:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d6FZb-0004A2-Qk
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:09:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2D8D201FB
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 12:09:29 +0000 (UTC)
References: <1493888311-30839-1-git-send-email-thuth@redhat.com>
	<87vapgg7vh.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b5440248-708b-780c-791c-451cfdadfef4@redhat.com>
Date: Thu, 4 May 2017 14:09:16 +0200
MIME-Version: 1.0
In-Reply-To: <87vapgg7vh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On 04.05.2017 13:48, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> The preferred way of adding USB devices is via "-device" and
>> "device_add" nowadays, so let's get rid of "-usbdevice" and
>> "usb_add" in the documentation.
>=20
> Yes, please!
>=20
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  qemu-doc.texi | 75 ++++++++++++++++++++++++--------------------------=
---------
>>  1 file changed, 31 insertions(+), 44 deletions(-)
>>
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index 794ab4a..d119e67 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -182,7 +182,7 @@ Gravis Ultrasound GF1 sound card
>>  @item
>>  CS4231A compatible sound card
>>  @item
>> -PCI UHCI USB controller and a virtual USB hub.
>> +PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1 hub=
.
>=20
> Do we need to say "USB-1.1 hub", or would "USB hub" do?

AFAIK we're only providing USB-1.1 hubs, and at least for me, this
already caused some confusion in the past (when I was expecting an
USB-2.0 hub on a EHCI controller), that's why I've added the 1.1 here.
But if Gerd prefers "USB hub" only, I can also remove that again.

>>  @end itemize
>> =20
>>  SMP is supported with up to 255 CPUs.
>> @@ -1357,10 +1357,10 @@ monitor (@pxref{pcsys_keys}).
>>  @node pcsys_usb
>>  @section USB emulation
>> =20
>> -QEMU emulates a PCI UHCI USB controller. You can virtually plug
>> -virtual USB devices or real host USB devices (experimental, works onl=
y
>> -on Linux hosts).  QEMU will automatically create and connect virtual =
USB hubs
>> -as necessary to connect multiple USB devices.
>> +QEMU can emulate a PCI UHCI, OHCI, EHCI or XHCI USB controller. You c=
an
>> +virtually plug virtual USB devices or real host USB devices (experime=
ntal,
>=20
> Outside this patch's stated scope, but here goes anyway (same for most
> of my other comments): "virtually plug virtual" sounds odd.  Do we need
> "virtually"?

Agreed, I think we can drop it.

>>  @menu
>>  * usb_devices::
>> @@ -1369,60 +1369,47 @@ as necessary to connect multiple USB devices.
>>  @node usb_devices
>>  @subsection Connecting USB devices
>> =20
>> -USB devices can be connected with the @option{-usbdevice} commandline=
 option
>> -or the @code{usb_add} monitor command.  Available devices are:
>> +USB devices can be connected with the @option{-device usb-...} comman=
dline
>=20
> While there, s/commandline/command line/.

OK.

>> -@item wacom-tablet
>> +@item usb-wacom-tablet
>>  Virtual Wacom PenPartner tablet.  This device is similar to the @code=
{tablet}
>>  above but it can be used with the tslib library because in addition t=
o touch
>>  coordinates it reports touch pressure.
>> -@item keyboard
>> +@item usb-kbd
>>  Standard USB keyboard.  Will override the PS/2 keyboard (if present).
>> -@item serial:[vendorid=3D@var{vendor_id}][,product_id=3D@var{product_=
id}]:@var{dev}
>> +@item usb-serial,chardev=3D@var{dev}
>>  Serial converter. This emulates an FTDI FT232BM chip connected to hos=
t character
>> -device @var{dev}. The available character devices are the same as for=
 the
>> -@code{-serial} option. The @code{vendorid} and @code{productid} optio=
ns can be
>> -used to override the default 0403:6001. For instance,
>> -@example
>> -usb_add serial:productid=3DFA00:tcp:192.168.0.2:4444
>> -@end example
>> -will connect to tcp port 4444 of ip 192.168.0.2, and plug that to the=
 virtual
>> -serial converter, faking a Matrix Orbital LCD Display (USB ID 0403:FA=
00).
>=20
> I wonder why you drop rather than update documentation on vendorid and
> productid... aha!
>=20
>     $ qemu-system-x86_64 -nodefaults -S -usb -usbdevice serial:vendorid=
=3D403,productid=3D6001:null
>     Unexpected error in object_property_find() at /work/armbru/qemu/qom=
/object.c:1008:
>     upstream-qemu: -usbdevice serial:vendorid=3D403,productid=3D6001:nu=
ll: Property '.vendorid' not found
>     Aborted (core dumped)
>=20
> Someone broke the feature.  Unless it's recent breakage, we can bury it=
,
> I guess.  Gerd?

I've sent a patch for this already today:

https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00786.html

> If we bury it, then docs/qdev-device-use.txt needs an update, too.
>=20
>> -@item braille
>> +device @var{dev}.
>> +@item usb-braille
>>  Braille device.  This will use BrlAPI to display the braille output o=
n a real
>>  or fake device.
>> -@item net:@var{options}
>> -Network adapter that supports CDC ethernet and RNDIS protocols.  @var=
{options}
>> -specifies NIC options as with @code{-net nic,}@var{options} (see desc=
ription).
>> +@item net[,netdev=3D@var{id}]
>=20
> Do you mean usb-net?

Oh, right, of course!

>> +Network adapter that supports CDC ethernet and RNDIS protocols.  @var=
{id}
>> +specifies a netdev ID as with @code{-netdev xxx,id=3D}@var{id}.
>=20
> "a netdev defined with"?

That's better, yes.

>>  For instance, user-mode networking can be used with
>>  @example
>> -qemu-system-i386 [...OPTIONS...] -net user,vlan=3D0 -usbdevice net:vl=
an=3D0
>> -@end example
>> -Currently this cannot be used in machines that support PCI NICs.
>> -@item bt[:@var{hci-type}]
>> -Bluetooth dongle whose type is specified in the same format as with
>> -the @option{-bt hci} option, @pxref{bt-hcis,,allowed HCI types}.  If
>> -no type is given, the HCI logic corresponds to @code{-bt hci,vlan=3D0=
}.
>> -This USB device implements the USB Transport Layer of HCI.  Example
>> -usage:
>> -@example
>> -@command{qemu-system-i386} [...@var{OPTIONS}...] @option{-usbdevice} =
bt:hci,vlan=3D3 @option{-bt} device:keyboard,vlan=3D3
>> +qemu-system-i386 [...OPTIONS...] -netdev user,id=3Did0 -device usb-ne=
t,netdev=3Did0
>=20
> Suggest to use net0 instead of id0 here.

Ok.

>>  @end example
>> +@item usb-bt-dongle
>> +Bluetooth dongle which implements the USB Transport Layer of HCI.
>> +It is connected to HCI scatternet 0 by default (corresponds to
>> +@code{-bt hci,vlan=3D0}).
>=20
> The Bluetooth documentation you replace is confusing.  Ignorant
> question: is -device ... as expressive as -usbdevice bt:...?

I don't really have a clue about bluetooth in QEMU, too, but from what
I've seen so far, it does not sound as expressive as the old syntax.

> docs/qdev-device-use.txt needs an update for this one.

Ok.

>>  @end table
>=20
> Covers exactly the same USB devices as before.  Doesn't cover newer
> devices that aren't available with legacy -usbdevice: usb-audio,
> usb-bot, usb-ccid, usb-hub, usb-mtp, usb-redir, usb-uas.
>=20
> In case you don't want to cover them in this patch, what about adding a
> hint that there are more?

Ok, will do.

>>  @node host_usb_devices
>> @@ -1460,11 +1447,11 @@ hubs, it won't work).
>> =20
>>  @item Add the device in QEMU by using:
>>  @example
>> -usb_add host:1234:5678
>> +device_add usb-host,vendorid=3D0x1234,productid=3D0x5678
>>  @end example
>> =20
>> -Normally the guest OS should report that a new USB device is
>> -plugged. You can use the option @option{-usbdevice} to do the same.
>> +Normally the guest OS should report that a new USB device is plugged.
>> +You can use the option @option{-device usb-host,...} to do the same.
>> =20
>>  @item Now you can try to use the host USB device in QEMU.

 Thomas
