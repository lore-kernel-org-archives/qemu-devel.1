Received: from eggs.gnu.org ([2001:4830:134:3::10]:56690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAXhl-0005Dz-Ua
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAXhk-0007Nx-G4
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:19:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAXhk-0007NT-6G
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:19:40 -0400
Date: Tue, 16 May 2017 04:19:27 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1282321742.7961608.1494922767010.JavaMail.zimbra@redhat.com>
In-Reply-To: <5c410c0e-f0b0-a049-84ed-7e31eb4e1dab@suse.de>
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
	<58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
	<b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
	<154b3902-d891-f77a-3d59-09d80596ddff@suse.de>
	<58ADBA0302000062000D3EA6@prv-mh.provo.novell.com>
	<1fcf2e94-fc86-4bd7-07a0-8ab2dc72429f@suse.de>
	<da24d7e2-e81c-8a1c-c277-c8e1b08fc3f7@redhat.com>
	<5c410c0e-f0b0-a049-84ed-7e31eb4e1dab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSN77yaIFJlOiBbUkZDXSB2aXJ0aW8tZmM6?=
 =?utf-8?q?_draft_idea_of_virtual_fibre_channel_HBA?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.de>
Cc: Lin Ma <lma@suse.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zhiqiang Zhou <ZZhou@suse.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com


> Maybe a union with an overall size of 256 byte (to hold the iSCSI iqn
> string), which for FC carries the WWPN and the WWNN?

That depends on how you would like to do controller passthrough in
general.  iSCSI doesn't have the 64-bit target ID, and doesn't have
(AFAIK) hot-plug/hot-unplug support, so it's less important than FC.

> > 2) If the initiator ID is the moral equivalent of a MAC address,
> > shouldn't it be the host that provides the initiator ID to the host in
> > the virtio-scsi config space?  (From your proposal, I'd guess it's the
> > latter, but maybe I am not reading correctly).
> 
> That would be dependent on the emulation. For emulated SCSI disk I guess
> we need to specify it in the commandline somewhere, but for scsi
> passthrough we could grab it from the underlying device.

Wait, that would be the target ID.  The initiator ID would be the NPIV
vport's WWNN/WWPN.  It could be specified on the QEMU command line, or
it could be tied to some file descriptor (created and initialized by
libvirt, which has CAP_SYS_ADMIN, and then passed to QEMU; similar to
tap file descriptors).

> >> b) stop exposing the devices attached to that NPIV host to the guest
> > 
> > What do you mean exactly?
> > 
> That's one of the longer term plans I have.
> When doing NPIV currently all devices from the NPIV host appear on the
> host. Including all partitions, LVM devices and what not. [...]
> If we make the (guest) initiator ID identical to the NPIV WWPN we can
> tag the _host_ to not expose any partitions on any LUNs, making the
> above quite easy.

Yes, definitely.

> > At this point, I can think of several ways  to do this, one being SG_IO
> > in QEMU while the other are more exoteric.
> > 
> > 1) use virtio-scsi with userspace passthrough (current solution).
> 
> With option (1) and the target/initiator ID extensions we should be able
> to get basic NPIV support to work, and would even be able to handle
> reservations in a sane manner.

Agreed, but I'm not anymore that sure that the advantages outweigh the
disadvantages.  Also, let's add no FC-NVMe support to the disadvantages.

> > 2) the exact opposite: use the recently added "mediated device
> > passthrough" (mdev) framework to present a "fake" PCI device to the
> > guest.
> 
> (2) sounds interesting, but I'd have to have a look into the code to
> figure out if it could easily be done.

Not that easy, but it's the bread and butter of the hardware manufacturers.
If we want them to do it alone, (2) is the way.  Both nVidia and Intel are
using it.

> > 3) handle passthrough with a kernel driver.  Under this model, the guest
> > uses the virtio device, but the passthrough of commands and TMFs is
> > performed by the host driver.
> > 
> > We can then choose whether to do it with virtio-scsi or with a new
> > virtio-fc.
>
> (3) would be feasible, as it would effectively mean 'just' to update the
> current NPIV mechanism. However, this would essentially lock us in for
> FC; any other types (think NVMe) will require yet another solution.

An FC-NVMe driver could also expose the same vhost interface, couldn't it?
FC-NVMe doesn't have to share the Linux code; but sharing the virtio standard
and the userspace ABI would be great.

In fact, the main advantage of virtio-fc would be that (if we define it properly)
it could be reused for FC-NVMe instead of having to extend e.g. virtio-blk.
For example virtio-scsi has request, to-device payload, response, from-device
payload.  virtio-fc's request format could be the initiator and target port
identifiers, followed by FCP_CMD, to-device payload, FCP_RSP, from-device
payload.

> > 4) same as (3), but in userspace with a "macvtap" like layer (e.g.,
> > socket+bind creates an NPIV vport).  This layer can work on some kind of
> > FCP encapsulation, not the raw thing, and virtio-fc could be designed
> > according to a similar format for simplicity.
>
> (4) would require raw FCP frame access, which is one thing we do _not_
> have. Each card (except for the pure FCoE ones like bnx2fc, fnic, and
> fcoe) only allows access to pre-formatted I/O commands. And has it's own
> mechanism for generatind sequence IDs etc. So anything requiring raw FCP
> access is basically out of the game.

Not raw.  It could even be defined at the exchange level (plus some special
things for discovery and login services).  But I agree that (4) is a bit
pie-in-the-sky.

> Overall, I would vote to specify a new virtio scsi format _first_,
> keeping in mind all of these options.
> (1), (3), and (4) all require an update anyway :-)
> 
> The big advantage I see with (1) is that it can be added with just some
> code changes to qemu and virtio-scsi. Every other option require some
> vendor buy-in, which inevitably leads to more discussions, delays, and
> more complex interaction (changes to qemu, virtio, _and_ the affected HBAs).

I agree.  But if we have to reinvent everything in a couple years for
NVMe over fabrics, maybe it's not worth it.

> While we're at it: We also need a 'timeout' field to the virtion request
> structure. I even posted an RFC for it :-)

Yup, I've seen it. :)

Paolo
