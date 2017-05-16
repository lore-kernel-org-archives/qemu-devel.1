Received: from eggs.gnu.org ([2001:4830:134:3::10]:35540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1dAW4R-0008CP-Gl
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1dAW4M-0002RA-Gb
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:34:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:55915 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1dAW4M-0002PH-5t
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:34:54 -0400
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
	<20170215153306.GF16064@stefanha-x1.localdomain>
	<58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
	<b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
	<154b3902-d891-f77a-3d59-09d80596ddff@suse.de>
	<58ADBA0302000062000D3EA6@prv-mh.provo.novell.com>
	<1fcf2e94-fc86-4bd7-07a0-8ab2dc72429f@suse.de>
	<da24d7e2-e81c-8a1c-c277-c8e1b08fc3f7@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5c410c0e-f0b0-a049-84ed-7e31eb4e1dab@suse.de>
Date: Tue, 16 May 2017 08:34:44 +0200
MIME-Version: 1.0
In-Reply-To: <da24d7e2-e81c-8a1c-c277-c8e1b08fc3f7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Paolo Bonzini <pbonzini@redhat.com>, Lin Ma <lma@suse.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, mst@redhat.com, stefanha@redhat.com, Zhiqiang Zhou <ZZhou@suse.com>

On 05/15/2017 07:21 PM, Paolo Bonzini wrote:
> Thread necromancy after doing my homework and studying a bunch of specs=
...
>=20
>>>> I'd propose to update
>>>>
>>>> struct virtio_scsi_config
>>>> with a field 'u8 initiator_id[8]'
>>>>
>>>> and
>>>>
>>>> struct virtio_scsi_req_cmd
>>>> with a field 'u8 target_id[8]'
>>>>
>>>> and do away with the weird LUN remapping qemu has nowadays.
>>> Does it mean we dont need to provide '-drive' and '-device scsi-hd'
>>> option in qemu command line? so the guest can get its own LUNs
>>> through fc switch, right?
>>
>> No, you still would need that (at least initially).
>> But with the modifications above we can add tooling around qemu to
>> establish the correct (host) device mappings.
>> Without it we
>> a) have no idea from the host side which devices should be attached to
>> any given guest
>> b) have no idea from the guest side what the initiator and target IDs
>> are; which will get _really_ tricky if someone decides to use persiste=
nt
>> reservations from within the guest...
>>
>> For handling NPIV proper we would need to update qemu
>> a) locate the NPIV host based on the initiator ID from the guest
>=20
> 1) How would the initiator ID (8 bytes) relate to the WWNN/WWPN (2*8
> bytes) on the host?  Likewise for the target ID which, as I understand
> it, matches the rport's WWNN/WWPN in Linux's FC transport.
>=20
Actually, there's no need to keep WWNN and WWPN separate. The original
idea was to have a WWNN (world-wide node name) to refer to the system,
and the WWPN (world-wide port name) to refer to the FC port.
But as most FC cards are standalone each card will have a unique WWNN,
and a unique WWPN per port.
So if the card only has one port, it'll have one WWNN and one WWPN.
And in basically all instances the one is derived from the other.
Plus SAM only knows about a single initiator identifier; it's a FC
pecularity that it has _two_.

So indeed, it might be better to keep it in a broader sense.

Maybe a union with an overall size of 256 byte (to hold the iSCSI iqn
string), which for FC carries the WWPN and the WWNN?


> 2) If the initiator ID is the moral equivalent of a MAC address,
> shouldn't it be the host that provides the initiator ID to the host in
> the virtio-scsi config space?  (From your proposal, I'd guess it's the
> latter, but maybe I am not reading correctly).
>=20
That would be dependent on the emulation. For emulated SCSI disk I guess
we need to specify it in the commandline somewhere, but for scsi
passthrough we could grab it from the underlying device.

> 3) An initiator ID in virtio-scsi config space is orthogonal to an
> initiator IDs in the request.  The former is host->guest, the latter is
> guest->host and can be useful to support virtual (nested) NPIV.
>=20
I don't think so. My idea is to have the initiator ID tied to the virtio
queue, so it wouldn't really matter _who_ sets the ID.
On the host we would use the (guest) initiator ID to establish the
connection between the virtio queue and the underlying device, be it a
qemu block device or a 'real' host block device.


>> b) stop exposing the devices attached to that NPIV host to the guest
>=20
> What do you mean exactly?
>=20
That's one of the longer term plans I have.
When doing NPIV currently all devices from the NPIV host appear on the
host. Including all partitions, LVM devices and what not.
This can lead to unwanted side-effects (systemd helpfully enable the
swap device on a partition for the host, when the actual block device is
being passed through to a guest ...). So ideally I would _not_ parse any
partitition or metadata on those devices. But that requires an a-priory
knowledge like "That device whose number I don't know and whose identity
is unknown but which I'm sure will appear shortly is going to be
forwarded to a guest."
If we make the (guest) initiator ID identical to the NPIV WWPN we can
tag the _host_ to not expose any partitions on any LUNs, making the
above quite easy.

>> c) establish a 'rescan' routine to capture any state changes (LUN
>> remapping etc) of the NPIV host.
>=20
> You'd also need "target add" and "target removed" events.  At this
> point, this looks a lot less virtio-scsi and a lot more like virtio-fc
> (with a 'cooked' FCP-based format of its own).
>=20
Yeah, that's a long shot indeed.

> At this point, I can think of several ways  to do this, one being SG_IO
> in QEMU while the other are more exoteric.
>=20
> 1) use virtio-scsi with userspace passthrough (current solution).
>=20
> Advantages:
> - guests can be stopped/restarted across hosts with different HBAs
> - completely oblivious to host HBA driver
> - no new guest drivers are needed (well, almost due to above issues)
> - out-of-the-box support for live migration, albeit with hacks required
> such as Hyper-V's two WWNN/WWPN pairs
>=20
> Disadvantages:
> - no full FCP support
> - guest devices exposed as /dev nodes to the host
>=20
>=20
> 2) the exact opposite: use the recently added "mediated device
> passthrough" (mdev) framework to present a "fake" PCI device to the
> guest.  mdev is currently used for vGPU and will also be used by s390
> for CCW passthrough.  It lets the host driver take care of device
> emulation, and the result is similar to an SR-IOV virtual function but
> without requiring SR-IOV in the host.  The PCI device would presumably
> reuse in the guest the same driver as the host.
>=20
> Advantages:
> - no new guest drivers are needed
> - solution confined entirely within the host driver
> - each driver can use its own native 'cooked' format for FC frames
>=20
> Disadvantages:
> - specific to each HBA driver
> - guests cannot be stopped/restarted across hosts with different HBAs
> - it's still device passthrough, so live migration is a mess (and would
> require guest-specific code in QEMU)
>=20
>=20
> 3) handle passthrough with a kernel driver.  Under this model, the gues=
t
> uses the virtio device, but the passthrough of commands and TMFs is
> performed by the host driver.  The host driver grows the option to
> present an NPIV vport through a vhost interface (*not* the same thing a=
s
> LIO's vhost-scsi target, but a similar API with a different /dev node o=
r
> even one node per scsi_host).
>=20
> We can then choose whether to do it with virtio-scsi or with a new
> virtio-fc.
>=20
> Advantages:
> - guests can be stopped/restarted across hosts with different HBAs
> - no need to do the "two WWNN/WWPN pairs" hack for live migration,
> unlike e.g. Hyper-V
> - a bit Rube Goldberg, but the vhost interface can be consumed by any
> userspace program, not just by virtual machines
>=20
> Disadvantages:
> - requires a new generalized vhost-scsi (or vhost-fc) layer
> - not sure about support for live migration (what to do about in-flight
> commands?)
>=20
> I don't know the Linux code well enough to know if it would require cod=
e
> specific to each HBA driver.  Maybe just some refactoring.
>=20
>=20
> 4) same as (3), but in userspace with a "macvtap" like layer (e.g.,
> socket+bind creates an NPIV vport).  This layer can work on some kind o=
f
> FCP encapsulation, not the raw thing, and virtio-fc could be designed
> according to a similar format for simplicity.
>=20
> Advantages:
> - less dependencies on kernel code
> - simplest for live migration
> - most flexible for userspace usage
>=20
> Disadvantages:
> - possibly two packs of cats to herd (SCSI + networking)?
> - haven't thought much about it, so I'm not sure about the feasibility
>=20
> Again, I don't know the Linux code well enough to know if it would
> require code specific to each HBA driver.
>=20
>=20
> If we can get the hardware manufacturers (and the SCSI maintainers...)
> on board, (3) would probably be pretty easy to achieve, even accounting
> for the extra complication of writing a virtio-fc specification.  Reall=
y
> just one hardware manufacturer, the others would follow suit.
>=20
With option (1) and the target/initiator ID extensions we should be able
to get basic NPIV support to work, and would even be able to handle
reservations in a sane manner.

(4) would require raw FCP frame access, which is one thing we do _not_
have. Each card (except for the pure FCoE ones like bnx2fc, fnic, and
fcoe) only allows access to pre-formatted I/O commands. And has it's own
mechanism for generatind sequence IDs etc. So anything requiring raw FCP
access is basically out of the game.

(3) would be feasible, as it would effectively mean 'just' to update the
current NPIV mechanism. However, this would essentially lock us in for
FC; any other types (think NVMe) will require yet another solution.

(2) sounds interesting, but I'd have to have a look into the code to
figure out if it could easily be done.

> (2) would probably be what the manufacturers like best, but it would be
> worse for lock in.  Or... they would like it best *because* it would be
> worse for lock in.
>=20
> The main disadvantage of (2)/(3) against (1) is more complex testing.  =
I
> guess we can add a vhost-fc target for testing to LIO, so as not to
> require an FC card for guest development.  And if it is still a problem
> 'cause configfs requires root, we can add a fake FC target in QEMU.
>=20
Overall, I would vote to specify a new virtio scsi format _first_,
keeping in mind all of these options.
(1), (3), and (4) all require an update anyway :-)

The big advantage I see with (1) is that it can be added with just some
code changes to qemu and virtio-scsi. Every other option require some
vendor buy-in, which inevitably leads to more discussions, delays, and
more complex interaction (changes to qemu, virtio, _and_ the affected HBA=
s).

While we're at it: We also need a 'timeout' field to the virtion request
structure. I even posted an RFC for it :-)

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
