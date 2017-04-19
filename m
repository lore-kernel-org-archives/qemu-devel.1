Received: from eggs.gnu.org ([2001:4830:134:3::10]:58271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0vpA-0005eW-IU
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0vp9-0002DA-P6
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:03:36 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d0vp9-0002Cw-Hk
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:03:35 -0400
Received: by mail-wr0-x229.google.com with SMTP id l28so22584091wre.0
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 13:03:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91Cbo+CQbRMmS-1b32Hf=kgWb22N3htmiuyORW7y-of7Raw@mail.gmail.com>
References: <CAJy91CZpAiZ6adPmbAESrYqDgtK37CEgw4SAk97jCNduADy6Tw@mail.gmail.com>
	<CAFEAcA-V3BNcrhhnap+Hn8spfZPd0=Dv2v0P5myGwqU2e5t0Eg@mail.gmail.com>
	<CAJy91Ca2FTvBzd2OqQZyEJBtCAxxosdcAFP1RMgGCQe2PJXEJA@mail.gmail.com>
	<CAFEAcA-f1P4OW+DwLRn1AZQCzoiWNX_8Rhq0oduppMOSLWo9Ww@mail.gmail.com>
	<CAJy91CY=s2H0VYYuDUrs=HYTEKjKZHpU1MXrhStxGxxWg=hfEg@mail.gmail.com>
	<CAFEAcA9mfnUF-ZtU+kGpSj2LqVxPi=0GLB4Jk9zLnhhfq_Su4A@mail.gmail.com>
	<CAJy91CaB3kA0vNRGs52S=OweSfSXnkO71AHOa2XpUYNJTnZHDQ@mail.gmail.com>
	<CAFEAcA81o245N_zoSUtJ0SVupZyRE9cnfr15hmu+ReMuDj9iyQ@mail.gmail.com>
	<CAJy91Cbo+CQbRMmS-1b32Hf=kgWb22N3htmiuyORW7y-of7Raw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Apr 2017 21:03:13 +0100
Message-ID: <CAFEAcA-07u6=pCcK-HsqBttwXemZ-c4QCjwc1V76S2r8obsRwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Hight Processor time of Socket communciation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 April 2017 at 14:34, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> But from the source code, I found the main characteristic of virtio-serial
> is that,
> virtio-serial can create multiple serial ports and each port has a pair of
> control virt-queues and
> a pair of guest input/output virt-queues.

Its main characteristic is that the data transfer is over
the standard virtio channel (ie a ring buffer in guest
memory). That's why it's fast.

> Its "have_data" callback function enables multi-byte data transfer from
> guest.
> And it is not in a tranditional device emulation format.
> I mean that no exact IO region is emulated for it.

It's a PCI device, it has registers the same way PCI
devices do. (Or for virtio-mmio, it has MMIO registers
like other MMIO devices).

> Without Linux kernel driver, I don't know how to manipulate it.

You can look at the virtio spec if you want to do direct
work with virtio devices. Programming one isn't any
more complicated than any other high-data-transfer
device (like a modern ethernet card, for instance).

> For the time being, I enable the guest app to send data to
> the pl011's data register directly via a pointer, as you see that in the
> code above.
>
> This is why I am thinking if adding a transmit buffer in pl011 for guest
> writing
> is a feasible alternative.

Well, anything like this is never going to be of interest
to QEMU upstream, because PL011s don't work like that.
Virtio is our answer to "what is the most efficient way
to transfer data from a guest to a host in a virtual
machine", so we don't need to reinvent that wheel.
The chances are that ad-hoc modifications to the PL011
will end up being slower than virtio.

thanks
-- PMM
