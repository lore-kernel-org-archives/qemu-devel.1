Received: from eggs.gnu.org ([2001:4830:134:3::10]:46884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cgT6Q-0004V4-G7
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cgT6L-0004Nw-Hd
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:20:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:60430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1cgT6L-0004NZ-1Q
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:20:45 -0500
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
	<20170215153306.GF16064@stefanha-x1.localdomain>
	<58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
	<b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
	<154b3902-d891-f77a-3d59-09d80596ddff@suse.de>
	<58ADBA0302000062000D3EA6@prv-mh.provo.novell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1fcf2e94-fc86-4bd7-07a0-8ab2dc72429f@suse.de>
Date: Wed, 22 Feb 2017 10:20:42 +0100
MIME-Version: 1.0
In-Reply-To: <58ADBA0302000062000D3EA6@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
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
To: Lin Ma <lma@suse.com>, Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, mst@redhat.com, stefanha@redhat.com, Zhiqiang Zhou <ZZhou@suse.com>

On 02/22/2017 09:19 AM, Lin Ma wrote:
> Hi Hannes,
>=20
>>>> Hannes Reinecke <hare@suse.de> 2017/2/16 =E6=98=9F=E6=9C=9F=E5=9B=9B=
 =E4=B8=8B=E5=8D=88 5:56 >>>
>>On 02/16/2017 09:39 AM, Paolo Bonzini wrote:
>>>
>>>
>>> On 16/02/2017 08:16, Lin Ma wrote:
>>>>> What are the benefits of having FC access from the guest?
>>>>
>>>> Actually, I havn't dug it too much, Just thought that from
> virtualization's
>>>> perspective, when interact with FC storage, having complete FC acces=
s
>>>> from the guest is the way it should use.
>>>
>>> How much of this requires a completely new spec?  Could we get enough=
 of
>>> the benefit (e.g. the ability to issue rescans or LIPs on the host) b=
y
>>> extending virtio-scsi?
>>>
>> I guess I'd need to chime in with my favourite topic :-)
>>
>> Initially I really would go with extending the virtio-scsi spec, as
>> 'real' virtio-fc suffers from some issues:
>> While it's of course possible to implement a full fc stack in qemu
>> itself, it's not easily possible assign 'real' FC devices to the guest=
.
>> Problem here is that any virtio-fc would basically have to use the
>> standard FC frame format for virtio itself, but all 'real' FC HBAs
>> (excluding FCoE drivers) do _not_ allow access to the actual FC frames=
,
>> but rather present you with a 'cooked' version of them.
>> So if you were attempting to pass FC devices to the guest you would ha=
ve
>> to implement yet-another conversion between raw FC frames and the
>> version the HBA would like.
>> And that doesn't even deal with the real complexity like generating
>> correct OXID/RXIDs etc.
>>=20
>> So initially I would propose to update the virtio spec to include:
>> - Full 64bit LUNs
>> - A 64bit target port ID (well, _actually_ it should be a SCSI-complia=
nt
>>   target port ID, but as this essentially is a free text field I'd
>>   restrict it to something sensible)
>> For full compability we'd also need a (64-bit) initiator ID, but that =
is
>> essentially a property of the virtio queue, so we don't need to transm=
it
>> it with every command; once during queue setup is enough.
>> And if we restrict virtio-scsi to point-to-point topology we can even
>> associate the target port ID with the virtio queue, making
>> implementation even easier.
>> I'm not sure if that is a good idea long-term, as one might want to
>> identify an NPIV host with a virtio device, in which case we're having=
 a
>> 1-M topology and that model won't work anymore.
>>=20
>> To be precise:
>>=20
>> I'd propose to update
>>=20
>> struct virtio_scsi_config
>> with a field 'u8 initiator_id[8]'
>>=20
>> and
>>=20
>> struct virtio_scsi_req_cmd
>> with a field 'u8 target_id[8]'
>>=20
>> and do away with the weird LUN remapping qemu has nowadays.
> Does it mean we dont need to provide '-drive' and '-device scsi-hd'
> option in qemu command line? so the guest can get its own LUNs
> through fc switch, right?
>=20
No, you still would need that (at least initially).
But with the modifications above we can add tooling around qemu to
establish the correct (host) device mappings.
Without it we
a) have no idea from the host side which devices should be attached to
any given guest
b) have no idea from the guest side what the initiator and target IDs
are; which will get _really_ tricky if someone decides to use persistent
reservations from within the guest...

For handling NPIV proper we would need to update qemu
a) locate the NPIV host based on the initiator ID from the guest
b) stop exposing the devices attached to that NPIV host to the guest
c) establish a 'rescan' routine to capture any state changes (LUN
remapping etc) of the NPIV host.

But having the initiator and target IDs in virtio scsi is a mandatory
step before we can attempt anything else.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
