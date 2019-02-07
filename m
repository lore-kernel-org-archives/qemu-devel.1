Received: from eggs.gnu.org ([209.51.188.92]:54339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grg1b-0006gE-R4
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grg1U-0005yk-1R
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:31:15 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
Date: Thu, 07 Feb 2019 10:30:46 +0100
In-Reply-To: <87y378n5iy.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 25 Jan 2019 16:03:33 +0100")
Message-ID: <87mun8gd2x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libvir-list@redhat.com, =?utf-8?B?TMOhc3ps?= =?utf-8?B?w7Mgw4lyc2Vr?= <lersek@redhat.com>, "Daniel P. =?utf-8?Q?Berran?= =?utf-8?Q?g=C3=A9?=" <berrange@redhat.com>, Peter Krempa <pkrempa@redhat.com>

The thread got long, let me try to summarize, and elaborate a few
points.

* The problem at hand is configuring firmware residing in flash memory
  (OVMF requires this) without legacy -drive.

* The wider problem is configuring onboard devices.  Our general device
  configuration interface doesn't cover them.  Instead, we have a zoo of
  ad hoc interfaces that are much more limited.  Some of them we'd
  rather deprecate (-drive, -net), but can't until we have a suitable
  replacements.

  I think a board should be a composite object that exposes properties
  of its own and its parts, just like other composite devices, so that
  "create, set properties, realize" just works.  That would extend our
  common device configuration mechanism naturally to onboard devices.

  A PC board's flash memory device would be just another part.  It could
  be something like /machine/q35/cfi.pflash01/ in the QOM tree.  To
  configure it, you'd set its properties, such as
  /machine/q35/cfi.pflash01/drive.

  Note that this requires a way to set an existing device's properties.
  Perhaps qom-set already works.

* While I do believe we should tackle the wider problem, I'd rather not
  sit on the narrow problem until we crack it.  So, what can we do about
  it?

  - Paolo proposed to add block backend properties to the PC machine,
    settable like -machine pflash0=3DBLOCK-BACKEND.

    Possible drawback: if we add /machine/q35/pflash0 to the QOM tree
    now, and later replace it by /machine/q35/cfi.pflash01/drive, we'll
    have to deal with yet another machine type variation.  We'll live.

  - I proposed to sidestep our onboard device configuration problem by
    adding the cfi.pflash01 devices with our existing general device
    configuration interface: -device.  Possible since the onboard
    cfi.pflash01 devices are optional.  Requires a small extension to
    the firmware descriptors, and a bit of extra work in libvirt to
    process that extension.  I think it's workable, but Paolo's idea is
    simpler.

  I can give Paolo's idea a try.  Objections?

* A flash device supporting multiple regions is desirable, because it's
  what physical hardware has.  We currently use multiple flash devices
  instead.  We'll be stuck with them for existing machine types due to
  guest ABI and migration compatibility.

* cfi.pflash01 currently requires users to opt out of "bad, do not use".
  It should require opt in, to guard against accidental new uses of
  "bad".


PS: Big thanks to L=C3=A1szl=C3=B3, whose patient guidance helped me map th=
is part
of the jungle.
