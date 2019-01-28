Received: from eggs.gnu.org ([209.51.188.92]:48102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1go6DU-0005sG-GU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1go6DS-0001XM-Ga
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:40:44 -0500
Date: Mon, 28 Jan 2019 13:40:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190128124027.776wwcqrckalvr7x@sirius.home.kraxel.org>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
Subject: Re: [Qemu-devel] [libvirt] Configuring pflash devices for OVMF
 firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

  Hi,

> > Issue (1) isn't too hard: we add the device to the dynamic sysbus device
> > white-list, move a sysbus_mmio_map() from pflash_cfi01_realize() into
> > pflash_cfi01_realize().  The latter requires a new device property to
> > configure the base address.  I got a working prototype.  Since this
> > makes the device model's name and properties ABI, review would be
> > advisable.
> 
> Flash devices exist on the board at specific addresses, so they
> should in general be created by the board model. Creating them
> by the user on the command line is a mess because then the
> user has to know the right base address. And then the board
> code needs to do something for "if the user didn't create this
> then we need to do it", because the flash device should exist
> in the model whether the user cared about its contents or not.

The tricky part is the access control here.  On physical hardware you
typically have one flash rom, say 16M below 4G (on x86).

Our pflash device doesn't allow to define multiple regions, so we use
multiple pflash devices instead, each with different access permissions
(code vs. vars).  Because of that they are more dynamic than they are on
phyiscal hardware, x86 sizes them according to the size of the firmware
images (arm is easier here, we have fixed size and location no matter
how big the firmware images are).

So I think the options we have are:
  (a) leave pflash as-is, which pretty much implies physaddr and size
      must be user-configurable.
  (b) add support for multiple regions to pflash, so one can attach
      multiple blockdev at different offsets to a single pflash device.

cheers,
  Gerd
