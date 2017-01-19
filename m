Received: from eggs.gnu.org ([2001:4830:134:3::10]:33537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUCkb-0006CS-RJ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUCka-0008Ew-KS
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:27:37 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:34108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cUCka-0008DZ-Bo
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:27:36 -0500
Received: by mail-ot0-x231.google.com with SMTP id f9so31743610otd.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 05:27:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484816807.15364.26.camel@redhat.com>
References: <1484749850-87206-1-git-send-email-phil@philjordan.eu>
	<1484816807.15364.26.camel@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Thu, 19 Jan 2017 14:27:13 +0100
Message-ID: <CAAibmn2VCrjEtdfDvDi932F0px+cTZwL+9WEDnBz7kan_EUcow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/usb/dev-hid: add a Mac guest
 compatibility option to usb-tablet
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

Thanks for looking into this, Gerd.

On 19 January 2017 at 10:06, Gerd Hoffmann <kraxel@redhat.com> wrote:

> Waded through the specs.  Setting bInterfaceProtocol to 0x00 should be
> done anyway.  Only boot protocol devices (which the tablet isn't) should
> set this to 1 (kbd) or 2 (mouse).  No need to hide that behind a macos
> option, we can do that for everybody.
>

OK, that shortens the patch considerably!


> The other one is more tricky.  Declaring the device as "mouse" is
> clearly wrong according to the specs.  There is no explicit "tablet"
> device.  "pointing" comes closest.
>


> Does the issue still show up with bInterfaceProtocol being fixed?
>

I just tested it with macOS 10.12, and yes, unfortunately it does. Or
rather, the cursor now zips off (I think) the bottom right corner of the
screen as soon as you try to move it for the first time, never to be seen
again. I don't know if the "mouse" usage is strictly correct for a tablet;
the spec does appear somewhat ambiguous on this - none of the examples it
gives for "pointer" usage seem to match Qemu's usb-tablet. It would appear
that OSX/macOS follows the following sentence from chapter 2's overview:

"For example, a gaming device driver might look for Joystick and Game Pad
usages, while a system mouse driver might look for Mouse, Digitizer Tablet
and Touch Screen usages."

Note that "Pointer" usage is not listed for the system mouse driver; I'm
not sure Digitizer Tablet and Touch Screen are any more accurate though,
considering we have more mouse-like button events.

I do know for certain that VMWare also uses 0x02 for its absolute pointing
device. WinXP, Win7, and Win10 certainly appear to have no problem with
mac_compat from my patch enabled. I haven't checked other windowing systems
yet.

(So far I've been hacking around this issue with a special guest driver,
https://github.com/pmj/QemuUSBTablet-OSX but having a workaround in
mainline Qemu would be much more convenient, particularly as it'll work
during OS install etc.)

Any thoughts on how to proceed?

Thanks,
Phil
