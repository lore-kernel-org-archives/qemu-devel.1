Received: from eggs.gnu.org ([2001:4830:134:3::10]:38062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ceInx-0006uL-Sp
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ceInu-0005Rj-14
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:56:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:59884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ceInt-0005RM-QR
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:56:45 -0500
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
	<20170215153306.GF16064@stefanha-x1.localdomain>
	<58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
	<b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <154b3902-d891-f77a-3d59-09d80596ddff@suse.de>
Date: Thu, 16 Feb 2017 10:56:42 +0100
MIME-Version: 1.0
In-Reply-To: <b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Lin Ma <lma@suse.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Zhiqiang Zhou <ZZhou@suse.com>, Fam Zheng <famz@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

On 02/16/2017 09:39 AM, Paolo Bonzini wrote:
>=20
>=20
> On 16/02/2017 08:16, Lin Ma wrote:
>>> What are the benefits of having FC access from the guest?
>>
>> Actually, I havn't dug it too much, Just thought that from virtualizat=
ion's
>> perspective, when interact with FC storage, having complete FC access
>> from the guest is the way it should use.
>=20
> How much of this requires a completely new spec?  Could we get enough o=
f
> the benefit (e.g. the ability to issue rescans or LIPs on the host) by
> extending virtio-scsi?
>=20
I guess I'd need to chime in with my favourite topic :-)

Initially I really would go with extending the virtio-scsi spec, as
'real' virtio-fc suffers from some issues:
While it's of course possible to implement a full fc stack in qemu
itself, it's not easily possible assign 'real' FC devices to the guest.
Problem here is that any virtio-fc would basically have to use the
standard FC frame format for virtio itself, but all 'real' FC HBAs
(excluding FCoE drivers) do _not_ allow access to the actual FC frames,
but rather present you with a 'cooked' version of them.
So if you were attempting to pass FC devices to the guest you would have
to implement yet-another conversion between raw FC frames and the
version the HBA would like.
And that doesn't even deal with the real complexity like generating
correct OXID/RXIDs etc.

So initially I would propose to update the virtio spec to include:
- Full 64bit LUNs
- A 64bit target port ID (well, _actually_ it should be a SCSI-compliant
  target port ID, but as this essentially is a free text field I'd
  restrict it to something sensible)
For full compability we'd also need a (64-bit) initiator ID, but that is
essentially a property of the virtio queue, so we don't need to transmit
it with every command; once during queue setup is enough.
And if we restrict virtio-scsi to point-to-point topology we can even
associate the target port ID with the virtio queue, making
implementation even easier.
I'm not sure if that is a good idea long-term, as one might want to
identify an NPIV host with a virtio device, in which case we're having a
1-M topology and that model won't work anymore.

To be precise:

I'd propose to update

struct virtio_scsi_config
with a field 'u8 initiator_id[8]'

and

struct virtio_scsi_req_cmd
with a field 'u8 target_id[8]'

and do away with the weird LUN remapping qemu has nowadays.

That should be enough to get proper NPIV passthrough working.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
