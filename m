Received: from eggs.gnu.org ([209.51.188.92]:41773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1h1CRY-0002u6-9h
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1h1CRX-0005Yl-5N
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:57:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1h1CRW-0005TU-Rp
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:57:23 -0500
Message-ID: <81d22ed88833ed22a1c3781c3c0c1eafad99b280.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 05 Mar 2019 16:56:43 +0100
In-Reply-To: <20190305143801.lq4gpetubspftkda@sirius.home.kraxel.org>
References: <20181205195704.17605-1-ehabkost@redhat.com>
	<3571700849fab25a1bc69960ca24284f0760fe02.camel@redhat.com>
	<20190305143801.lq4gpetubspftkda@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 0/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Michael
	S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Amit Shah <amit@kernel.org>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Cole Robinson <crobinso@redhat.com>, Daniel Berrange <berrange@redhat.com>

On Tue, 2019-03-05 at 15:38 +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> >   -device virtio-blk-pci-non-transitional \
> >   -device virtio-net-pci-non-transitional \
> >   -device virtio-gpu-pci-non-transitional \
> > 
> > and you wouldn't have to question why you can use the
> > non-transitional variant for pretty much everything, except for the
> > few cases where you can't - for no apparent reason...
> 
> Well, there are no variants, only a single virtio-$foo-pci* device.  So
> you don't have to worry about picking one of the available variants,
> there is no choice in the first place.
> 
> When adding an virtio-gpu-pci-non-transitional variant we'll create
> confusion too, because it wouldn't be a real variant.  We would have two
> 100% identical devices then, and people will probably wonder why they
> exist and what the difference is ...

When looking at a single device, I mostly agree with your assessment;
however, when looking at the overall situation with VirtIO devices,
one might quite reasonably infer the following rules:

  * devices marked as (non-)transitional are going to show up as
    (non-)transitional;

  * unmarked devices might show up as either one, depending on some
    factor which is not immediately obvious.

So if you knew you wanted non-transitional devices you would expect
to just use the non-transitional variant for *all* VirtIO devices,
including virtio-gpu, without necessarily caring whether the unmarked
devices behaves any differently; if you tried to use the transitional
device, you'd get an error message telling you that device doesn't
exist, which is pretty reasonable and easy to research / understand.

With the current situation, once you've tried using non-transitional
virtio-gpu and gotten back an error message, there's quite a bit more
digging required to figure out *why* the device is not there in the
first place.

So I agree neither scenario is exactly perfect, but I still think
adding non-transitional alias devices would overall be more
user-friendly.

> So I can't see how this would be so much better.  We have to document
> the mess no matter what.

We have some documentation in libvirt:

  https://libvirt.org/formatdomain.html#elementsVirtioTransitional

Not that more / improved documentation is ever a bad idea :)

-- 
Andrea Bolognani / Red Hat / Virtualization
