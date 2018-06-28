Received: from eggs.gnu.org ([2001:4830:134:3::10]:36969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fYTzS-0001R5-QW
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fYTzM-00005K-Qy
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:17:26 -0400
Received: from mail-db5eur03hn0214.outbound.protection.outlook.com
	([104.47.10.214]:65133
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fYTzM-0008Tg-15
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:17:20 -0400
Date: Thu, 28 Jun 2018 13:17:05 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180628101704.GA9389@rkaganb.sw.ru>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
	<20180627122457.GA19714@rkaganb.sw.ru>
	<20180627192958.GA17236@vbusired-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627192958.GA17236@vbusired-vm>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Use of unique identifier for
 pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 02:29:58PM -0500, Venu Busireddy wrote:
> On 2018-06-27 15:24:58 +0300, Roman Kagan wrote:
> > I must have missed something in those threads, but where does this UUID
> > thing come about?  AFAICS this identifier doesn't need to be
> > "universally" unique, nor persistent; it only has to be unique across
> > the VM and stable throughout the VM lifetime.
> 
> The notion of using UUID came up in the thread
> 
>    https://www.spinics.net/lists/netdev/msg499011.html

Yes I saw it and it looks like UUID came out of miscommunication:

>> >> As Stephen said, Hyper-V supports the serial UUID thing from
>> >> day-one.

but I don't see Stephen's message where he claims that.  In reality

> > FWIW Hyper-V uses a 32-bit integer for this purpose, not a UUID as seems
> > to be implied in the thread you refer to.
> 
> Yes, Hyper-V uses a serial number (but I think it is 64-bit value).

It's u32, see

drivers/pci/controller/pci-hyperv.c:struct pci_function_description::ser

and 

drivers/net/hyperv/hyperv_net.h:struct nvsp_4_send_vf_association::serial

> However, what we are doing is similar to that. Instead of 32 bits,
> we are using 128 bits.

UUID is far less convenient to handle than an integer.  But anyway I
think this should rather be transport-specific, see below.

> > I wonder if it makes more sense to drop the concept of failover groups,
> > and just refer to the standby device by device-id, like 
> > 
> >   -device virtio-net-pci,id=foo \
> >   -device pcie-downstream,failover=foo
> 
> Isn't this the same as what this patch series proposes? In your
> suggestion, "foo" is the entity that connects the passthrough device
> and the failover device. In this patch set, that "foo" is the UUID,
> and the options "id" and "failover" are replaced by "uuid". Do you agree?

No it's not the same.

I think this whole "failover group" concept is a misnomer: there can
only be two participating devices, they need a tighter coupling to each
other than just sharing a common identifier exposed to the guest, and
their relationship is strongly asymmetric.

Rather, the two devices

  - need to be of matching types to be able to do failover (like
    a virtio-net-pci and a pcie-downstream, or a hv-net and a
    hv-pci-bridge, etc.)

  - need to communicate status information, adressing Michael's concern
    re. PT visibility: as I wrote
> > The bridge device will [...] defer the visibility of the PT device
> > behind the bridge until the guest acknowledged the support for
> > failover on the PV device.

  - need to communicate a common identifier and have a
    transport-specific scheme to present it to the guest, but this
    common identifier *doesn't* generally have to be

    * of the same type for all transports[*]
    * globally unique
    * persistent
    * provided by / visible to the management layer

Now linking two devices in QEMU by making one of them know the device-id
of the other seems to be the most natural thing.

[*] e.g. for Hyper-V it's u32 (set by the third party); virtio may
define different schemes depending on the kind of PT device, e.g. u64 if
using a PCIe device (and put it in its device serial number cap),
something else otherwise.

Roman.
