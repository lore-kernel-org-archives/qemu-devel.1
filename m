Received: from eggsout.gnu.org ([209.51.188.92]:51707 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfo5q-0005QK-Jt
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 10:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfo5o-0005l6-4S
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 10:42:33 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:35423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfo5n-0005kE-Va
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 10:42:32 -0500
Received: by mail-oi1-x231.google.com with SMTP id v6so32685024oif.2
	for <qemu-devel@nongnu.org>; Sat, 05 Jan 2019 07:42:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHyh4xhv5ZDfZv842U=adQN7hQFr=16BKEgZcEUZOLjFo3P+Jw@mail.gmail.com>
In-Reply-To: <CAHyh4xhv5ZDfZv842U=adQN7hQFr=16BKEgZcEUZOLjFo3P+Jw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Jan 2019 15:42:18 +0000
Message-ID: <CAFEAcA_GCPp7ga7OGkZQopOSY_u+mwJ=vve5a9a4uU217butcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Why one virtio-pci device has two different
 DeviceState?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On Fri, 4 Jan 2019 at 20:23, Jintack Lim <jintack@cs.columbia.edu> wrote:
> I was wondering why one virtio-pci device has two different
> DeviceState? - one directly from VirtIOPCIProxy and the other from
> VirtIO<dev type> such as VirtIONet. As an example, they are denoted as
> qdev and vdev respectively in virtio_net_pci_realize().

It's been a while since I looked at this, but there are two
basic issues underlying the weird way virtio devices are
set up:
 (1) PCI is not the only "transport" -- the VirtIONet etc
     are shared with other transports like MMIO or the S390 ones
 (2) retaining back-compatibility matters a lot here: we need
     command lines to still work, and also the migration data
     stream needs to stay compatible
Some of the way the devices are reflects the way we started
with a design where there was only a single device (eg the
pci virtio-net device) and then refactored it to support
multiple transports while retaining back compatibility.

> I thought that just one DeviceState is enough for any device in QEMU.
> Maybe I'm missing something fundamental here.

This isn't generally true, it's just that a lot of
our devices are of the simple straightforward kind
where that's true. It's also possible for an
implementation of a device to be as a combination
of other devices, which is what we have here.
virtio-pci-net is-a PCIDevice (which in turn is-a Device),
but it has-a VirtIONet device (which is-a Device) as
part of its implementation.
(It's also possible to manually create the pci
transport and the virtio-net backend separately
and connect them together without the virtio-pci-net
device at all. That's more often used with non-pci
transports but it works for pci too.)

You can also see a similar thing with a lot of the
"container" SoC objects like TYPE_ASPEED_SOC, which
is a subclass of DeviceState, but is implemented
using a dozen different objects all of which are
themselves DeviceState subclasses.

thanks
-- PMM
