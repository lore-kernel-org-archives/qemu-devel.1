Received: from eggs.gnu.org ([2001:4830:134:3::10]:47750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jamespharvey20@gmail.com>) id 1gYeSc-0005Xs-7h
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 17:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jamespharvey20@gmail.com>) id 1gYeSb-000269-0w
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 17:00:30 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jamespharvey20@gmail.com>)
	id 1gYeSa-00025z-RT
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 17:00:28 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so8703395oia.4
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 14:00:28 -0800 (PST)
MIME-Version: 1.0
References: <CA+X5Wn6-3RHWt7QAeud-53nio9gT+9mo4M_PN6-m561CyQFNmQ@mail.gmail.com>
	<be820e03-c95b-2a30-bccc-73e21ed21bfe@lesniak-it.de>
In-Reply-To: <be820e03-c95b-2a30-bccc-73e21ed21bfe@lesniak-it.de>
From: james harvey <jamespharvey20@gmail.com>
Date: Sun, 16 Dec 2018 17:00:17 -0500
Message-ID: <CA+X5Wn6y73SNYLai8ezqOsPHGGOeMCn7sy4WxywZey_KNYcZXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] hw/input/ps2.c : BTN_SIDE and BTN_EXTRA not
 forwarded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabian Lesniak <fabian@lesniak-it.de>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, Eric Blake <eblake@redhat.com>

I didn't make it very clear that my Arch Linux guest didn't had tablet
emulation.  On it, evtest only shows "ImExPS/2 Generic Explorer
Mouse".  On its monitor, "info mice" shows:

* Mouse #2: QEMU PS/2 Mouse

On the Windows 7 guest, you're right:

  Mouse #2: QEMU PS/2 Mouse
* Mouse #3: QEMU HID Tablet (absolute)

After restarting qemu without the tablet option it only shows:

* Mouse #2: QEMU PS/2 Mouse

But, the SIDE and EXTRA buttons still don't work, with Device Manager
using "Microsoft PS/2 Mouse".

Not knowing enough to know if the SPICE Guest Tools or QEMU guest
agent could be affecting things, I uninstalled those from the Windows
7 guest, so the mouse is grabbed by the client.  The extra buttons
still don't work.  In the Arch guest, I uninstalled spice-vdagent,
which also didn't help.

I ran across "-device virtio-mouse-pci", so tried adding that to my
Arch guest, and it does become used over the PS/2, but the SIDE and
EXTRA events still aren't working.  In the guest, evtest shows "QEMU
Virtio Mouse" and shows these buttons as supported events, and
hw/input/virtio-input-hid.c maps the SIDE and EXTRA buttons, so I'm
thinking it would be expected for it to work this way as well.  Since
it isn't, I'm thinking that might indicate the problem is a step
closer to the physical hardware, from
hw/input/{ps2,virtio-input-hid}.c.

What is it that should send the events to the hw/input code?  Could it
be that remote-viewer isn't listening to the physical hardware events
for these buttons?  Or, is there an area within QEMU that should be
receiving the events?  Or could this be a spice issue?  I'm not sure
how these different parts interact for mouse events, or how to break
down where this is happening.

Also trying through libvirt rather than qemu directly, and using the
virt-manager interface acts the same way.  I'm guessing that's using
remote-viewer, just embedded in the libvirt window, but I'm not
positive on that.

On Sun, Dec 16, 2018 at 1:48 PM Fabian Lesniak <fabian@lesniak-it.de> wrote:
>
> Probably the PS/2 mouse is not used at all because the HID Tablet takes
> precedence. By entering "info mice" on the monitor console you can see
> which mouse is currently used. If you disable or uninstall the HID
> Tablet, the PS/2 mouse should take over.
>
> "IMEX" is short for Intelli Mouse Explorer.
>
> Am 16.12.18 um 06:40 schrieb james harvey:
> > Running qemu 3.1.0.  virt-viewer 7.0.  spice, spice-gtk, and
> > spice-protocol all git versions from the past week or so.
> >
> > I have a Logitech G600 mouse.  The scroll wheel can be pushed left or right.
> >
> > On Arch Linux host, "evtest" shows these as event codes 275 (BTN_SIDE)
> > and 276 (BTN_EXTRA.)  In host, they work as expected, by default as
> > back and forward in supporting programs such as web browsers.
> >
> > On Arch Linux guest, "evtest" shows these events as supported for the
> > "ImExPS/2 Generic Explorer Mouse", but it doesn't show those events as
> > happening when I push the scroll wheel left or right.  Other events
> > work fine.
> >
> > On Windows 7 guest, there's no effect from pushing the scroll wheel
> > left or right, either.
> >
> > I'm happy to help debug where the event forwarding is breaking down,
> > but have no idea how to do that.
> >
> >
> > Patch v1 for these buttons from Nov 24, 2016:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg415246.html
> >
> > Patch v2 from Nov 28, 2016:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg415690.html
> >
> > Patch v3 from Dec 6, 2016:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg417007.html
> >
> >
> > The v1 notes say: 'Note that the guest has to switch the ps2 mouse
> > into IMEX mode, otherwise events of the extra buttons are ignored. For
> > example on a Windows guest one needs to manually select the "Microsoft
> > PS/2 Mouse" driver.'
> >
> > I'll admit I'm not sure what IMEX mode is.  QEMU is providing the PS/2
> > mouse emulation by default, and I don't see a way to give qemu options
> > for it.
> >
> > Regardless, following this note's instructions for "IMEX mode", in
> > Windows 7 guest, changing the driver from the default "Microsoft -
> > PS/2 Compatible Mouse" to "Microsoft - Microsoft PS/2 Mouse" and
> > rebooting guest has no effect.  The extra buttons still don't work.
> >
> > Windows 7 Device Manager does show 2 "Mice and other pointing
> > devices".  First is "HID-compliant mouse"
> > (HID\VID_0627&PID_0001&REV_0000) which shows it's USB, so I'm guessing
> > that's the absolute movement EvTouch USB Graphics Tablet.  Second is
> > the PS/2 - currently set to "Microsoft PS/2 Mouse" (ACPI\PNP0F13).
