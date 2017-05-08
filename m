Received: from eggs.gnu.org ([2001:4830:134:3::10]:45225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7gff-0003cK-Fg
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7gfc-0005vk-8R
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:17:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d7gfb-0005us-VU
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:17:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05DB0C049DFD
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 11:17:39 +0000 (UTC)
References: <1493977087-26668-1-git-send-email-thuth@redhat.com>
	<87k25vikmx.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a15380db-8826-3f92-2f32-8bf8c6cbae4e@redhat.com>
Date: Mon, 8 May 2017 13:17:32 +0200
MIME-Version: 1.0
In-Reply-To: <87k25vikmx.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Update to use the new way of
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

On 05.05.2017 13:54, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> The preferred way of adding USB devices is via "-device" and
>> "device_add" nowadays, so let's start to get rid of "-usbdevice"
>> and "usb_add" in the documentation. While we're at it, also
>> add the new USB devices there which have been added to QEMU
>> during the last years.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2:
>>  - Addressed review feedback from Markus
>>  - Added the new USB devices that are only available via "-device"
>>  - Update qdev-device-use.txt about "vendorid" and "productid"
>>
>>  docs/qdev-device-use.txt |  5 +--
>>  qemu-doc.texi            | 92 +++++++++++++++++++++++++++------------=
---------
>>  2 files changed, 55 insertions(+), 42 deletions(-)
>>
>> diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
>> index b059405..2c1331b 100644
>> --- a/docs/qdev-device-use.txt
>> +++ b/docs/qdev-device-use.txt
>> @@ -182,8 +182,9 @@ The appropriate DEVNAME depends on the machine typ=
e.  For type "pc":
>> =20
>>    This lets you control I/O ports and IRQs.
>> =20
>> -* -usbdevice serial:vendorid=3DVID,productid=3DPRID becomes
>> -  -device usb-serial,vendorid=3DVID,productid=3DPRID
>> +* -usbdevice serial:[vendorid=3DVID,productid=3DPRID]:chardev becomes
>> +  -device usb-serial,chardev=3Ddev.  The possibility to set a vendor
>> +  and product ID has been removed since QEMU version 0.14.0.
>=20
> If we intend to fix -usbdevice serial:VID,PRID, the hunk should be
> dropped.
>=20
> If we don't intend to fix it, I'd simple delete the old crap that
> doesn't work anymore:
>=20
>    * -usbdevice serial::chardev becomes -device usb-serial,chardev=3Dde=
v.
>=20
> As far as I can tell, we don't intend to fix it.

OK, we certainly not going to fix that legacy stuff, so I'll simply
remove vendorid/productid here.

>>  * -usbdevice braille doesn't support LEGACY-CHARDEV syntax.  It alway=
s
>>    uses "braille".  With -device, this useful default is gone, so you
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index 794ab4a..b446ac4 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -182,7 +182,7 @@ Gravis Ultrasound GF1 sound card
>>  @item
>>  CS4231A compatible sound card
>>  @item
>> -PCI UHCI USB controller and a virtual USB hub.
>> +PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1 hub=
.
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
>> +plug virtual USB devices or real host USB devices (only works with ce=
rtain
>> +host operating systems). QEMU will automatically create and connect v=
irtual
>> +USB hubs as necessary to connect multiple USB devices.
>> =20
>>  @menu
>>  * usb_devices::
>> @@ -1369,53 +1369,65 @@ as necessary to connect multiple USB devices.
>>  @node usb_devices
>>  @subsection Connecting USB devices
>> =20
>> -USB devices can be connected with the @option{-usbdevice} commandline=
 option
>> -or the @code{usb_add} monitor command.  Available devices are:
>> +USB devices can be connected with the @option{-device usb-...} comman=
d line
>> +option or the @code{device_add} monitor command. Available devices ar=
e:
>> =20
>>  @table @code
>> -@item mouse
>> +@item usb-mouse
>>  Virtual Mouse.  This will override the PS/2 mouse emulation when acti=
vated.
>> -@item tablet
>> +@item usb-tablet
>>  Pointer device that uses absolute coordinates (like a touchscreen).
>>  This means QEMU is able to report the mouse position without having
>>  to grab the mouse.  Also overrides the PS/2 mouse emulation when acti=
vated.
>> -@item disk:@var{file}
>> -Mass storage device based on @var{file} (@pxref{disk_images})
>> -@item host:@var{bus.addr}
>> -Pass through the host device identified by @var{bus.addr}
>> -(Linux only)
>> -@item host:@var{vendor_id:product_id}
>> -Pass through the host device identified by @var{vendor_id:product_id}
>> -(Linux only)
>> -@item wacom-tablet
>> +@item usb-storage,drive=3D@var{drive_id}
>> +Mass storage device (@pxref{disk_images})
>=20
> Most items explain the properties they mention.  This one doesn't.
> Perhaps:
>=20
>    Mass storage device backed by @var{drive_id} (@pxref{disk_images}).
>=20
>> +@item usb-uas
>> +USB attached SCSI device, see
>> +@url{http://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/usb-st=
orage.txt,usb-storage.txt}
>=20
> 404
>=20
> {http://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/usb-storage.=
txt}
> works for me.

You have to look at the generated HTML instead of the markup language:
The ",usb-storage.txt" simply means that "usb-storage.txt" should be
used in the text, but the hyperlink should of course be used as link
target instead.

>> +for details
>> +@item usb-bot
>> +Bulk-only transport storage device, see
>> +@url{http://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/usb-st=
orage.txt,usb-storage.txt}
>=20
> Likewise.
>=20
>> +for details here, too
>> +@item usb-mtp,x-root=3D@var{dir}
>> +Media transfer protocol device
>=20
> Suggest to either explain x-root, or omit it.

The parameter is required, not optional, so I guess I should rather
explain it (though it is a "x-" parameter)...

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
>> +@item usb-net[,netdev=3D@var{id}]
>> +Network adapter that supports CDC ethernet and RNDIS protocols.  @var=
{id}
>> +specifies a netdev defined with @code{-netdev xxx,id=3D}@var{id}.
>=20
> Semantically, the @var{id} is within the @code{}.  Does writing it that
> way work?

Yes, that works, too, so I'll change that.

> The xxx isn't so hot.  @code{-netdev id=3D@var{id},@dots{}} might work.
> Use your judgement.

@dots looks nice, I'll use that instead.

[...]
>> @@ -1460,11 +1472,11 @@ hubs, it won't work).
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
>=20
> With at least and qdev-device-use.txt streamlined and the links fixed
> (assuming they need fixing):
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!

 Thomas
