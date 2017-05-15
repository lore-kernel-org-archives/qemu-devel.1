Received: from eggs.gnu.org ([2001:4830:134:3::10]:43047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dAJgW-0002oJ-Iu
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dAJgT-0007mu-CD
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:21:28 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dAJgT-0007li-1y
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:21:25 -0400
Received: by mail-wm0-x241.google.com with SMTP id d127so30078110wmf.1
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 10:21:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
	<20170215153306.GF16064@stefanha-x1.localdomain>
	<58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
	<b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
	<154b3902-d891-f77a-3d59-09d80596ddff@suse.de>
	<58ADBA0302000062000D3EA6@prv-mh.provo.novell.com>
	<1fcf2e94-fc86-4bd7-07a0-8ab2dc72429f@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da24d7e2-e81c-8a1c-c277-c8e1b08fc3f7@redhat.com>
Date: Mon, 15 May 2017 19:21:20 +0200
MIME-Version: 1.0
In-Reply-To: <1fcf2e94-fc86-4bd7-07a0-8ab2dc72429f@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Hannes Reinecke <hare@suse.de>, Lin Ma <lma@suse.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, mst@redhat.com, stefanha@redhat.com, Zhiqiang Zhou <ZZhou@suse.com>

Thread necromancy after doing my homework and studying a bunch of specs...

>>> I'd propose to update
>>>
>>> struct virtio_scsi_config
>>> with a field 'u8 initiator_id[8]'
>>>
>>> and
>>>
>>> struct virtio_scsi_req_cmd
>>> with a field 'u8 target_id[8]'
>>>
>>> and do away with the weird LUN remapping qemu has nowadays.
>> Does it mean we dont need to provide '-drive' and '-device scsi-hd'
>> option in qemu command line? so the guest can get its own LUNs
>> through fc switch, right?
>
> No, you still would need that (at least initially).
> But with the modifications above we can add tooling around qemu to
> establish the correct (host) device mappings.
> Without it we
> a) have no idea from the host side which devices should be attached to
> any given guest
> b) have no idea from the guest side what the initiator and target IDs
> are; which will get _really_ tricky if someone decides to use persistent
> reservations from within the guest...
> 
> For handling NPIV proper we would need to update qemu
> a) locate the NPIV host based on the initiator ID from the guest

1) How would the initiator ID (8 bytes) relate to the WWNN/WWPN (2*8
bytes) on the host?  Likewise for the target ID which, as I understand
it, matches the rport's WWNN/WWPN in Linux's FC transport.

2) If the initiator ID is the moral equivalent of a MAC address,
shouldn't it be the host that provides the initiator ID to the host in
the virtio-scsi config space?  (From your proposal, I'd guess it's the
latter, but maybe I am not reading correctly).

3) An initiator ID in virtio-scsi config space is orthogonal to an
initiator IDs in the request.  The former is host->guest, the latter is
guest->host and can be useful to support virtual (nested) NPIV.

> b) stop exposing the devices attached to that NPIV host to the guest

What do you mean exactly?

> c) establish a 'rescan' routine to capture any state changes (LUN
> remapping etc) of the NPIV host.

You'd also need "target add" and "target removed" events.  At this
point, this looks a lot less virtio-scsi and a lot more like virtio-fc
(with a 'cooked' FCP-based format of its own).

At this point, I can think of several ways  to do this, one being SG_IO
in QEMU while the other are more exoteric.

1) use virtio-scsi with userspace passthrough (current solution).

Advantages:
- guests can be stopped/restarted across hosts with different HBAs
- completely oblivious to host HBA driver
- no new guest drivers are needed (well, almost due to above issues)
- out-of-the-box support for live migration, albeit with hacks required
such as Hyper-V's two WWNN/WWPN pairs

Disadvantages:
- no full FCP support
- guest devices exposed as /dev nodes to the host


2) the exact opposite: use the recently added "mediated device
passthrough" (mdev) framework to present a "fake" PCI device to the
guest.  mdev is currently used for vGPU and will also be used by s390
for CCW passthrough.  It lets the host driver take care of device
emulation, and the result is similar to an SR-IOV virtual function but
without requiring SR-IOV in the host.  The PCI device would presumably
reuse in the guest the same driver as the host.

Advantages:
- no new guest drivers are needed
- solution confined entirely within the host driver
- each driver can use its own native 'cooked' format for FC frames

Disadvantages:
- specific to each HBA driver
- guests cannot be stopped/restarted across hosts with different HBAs
- it's still device passthrough, so live migration is a mess (and would
require guest-specific code in QEMU)


3) handle passthrough with a kernel driver.  Under this model, the guest
uses the virtio device, but the passthrough of commands and TMFs is
performed by the host driver.  The host driver grows the option to
present an NPIV vport through a vhost interface (*not* the same thing as
LIO's vhost-scsi target, but a similar API with a different /dev node or
even one node per scsi_host).

We can then choose whether to do it with virtio-scsi or with a new
virtio-fc.

Advantages:
- guests can be stopped/restarted across hosts with different HBAs
- no need to do the "two WWNN/WWPN pairs" hack for live migration,
unlike e.g. Hyper-V
- a bit Rube Goldberg, but the vhost interface can be consumed by any
userspace program, not just by virtual machines

Disadvantages:
- requires a new generalized vhost-scsi (or vhost-fc) layer
- not sure about support for live migration (what to do about in-flight
commands?)

I don't know the Linux code well enough to know if it would require code
specific to each HBA driver.  Maybe just some refactoring.


4) same as (3), but in userspace with a "macvtap" like layer (e.g.,
socket+bind creates an NPIV vport).  This layer can work on some kind of
FCP encapsulation, not the raw thing, and virtio-fc could be designed
according to a similar format for simplicity.

Advantages:
- less dependencies on kernel code
- simplest for live migration
- most flexible for userspace usage

Disadvantages:
- possibly two packs of cats to herd (SCSI + networking)?
- haven't thought much about it, so I'm not sure about the feasibility

Again, I don't know the Linux code well enough to know if it would
require code specific to each HBA driver.


If we can get the hardware manufacturers (and the SCSI maintainers...)
on board, (3) would probably be pretty easy to achieve, even accounting
for the extra complication of writing a virtio-fc specification.  Really
just one hardware manufacturer, the others would follow suit.

(2) would probably be what the manufacturers like best, but it would be
worse for lock in.  Or... they would like it best *because* it would be
worse for lock in.

The main disadvantage of (2)/(3) against (1) is more complex testing.  I
guess we can add a vhost-fc target for testing to LIO, so as not to
require an FC card for guest development.  And if it is still a problem
'cause configfs requires root, we can add a fake FC target in QEMU.

Any opinions?  Does the above even make sense?

Paolo
