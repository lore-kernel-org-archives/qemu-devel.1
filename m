Received: from eggs.gnu.org ([2001:4830:134:3::10]:42688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAtT5-0007gT-AM
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAtT0-0008TP-Dt
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:33:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAtT0-0008TJ-46
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:33:54 -0400
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
	<58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
	<b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
	<154b3902-d891-f77a-3d59-09d80596ddff@suse.de>
	<58ADBA0302000062000D3EA6@prv-mh.provo.novell.com>
	<1fcf2e94-fc86-4bd7-07a0-8ab2dc72429f@suse.de>
	<da24d7e2-e81c-8a1c-c277-c8e1b08fc3f7@redhat.com>
	<5c410c0e-f0b0-a049-84ed-7e31eb4e1dab@suse.de>
	<1282321742.7961608.1494922767010.JavaMail.zimbra@redhat.com>
	<efdd2565-025d-b5f8-bcac-32baeaecdc3a@suse.de>
	<92e310cd-f77a-61f3-82a2-aca8ea901dbc@redhat.com>
	<02a2668e-82e3-afd3-c99a-9b08bb85a36b@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2bc3a27e-2ca0-9cc5-ae69-023823e5be81@redhat.com>
Date: Wed, 17 May 2017 09:33:41 +0200
MIME-Version: 1.0
In-Reply-To: <02a2668e-82e3-afd3-c99a-9b08bb85a36b@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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



On 17/05/2017 08:01, Hannes Reinecke wrote:
> On 05/16/2017 06:22 PM, Paolo Bonzini wrote:
>> On 16/05/2017 17:22, Hannes Reinecke wrote:
>>> iSCSI has its 'iqn' string, which is defined to be a 256-byte string.
>>> Hence the number 
>>> And if we're updating virtio anyway, we could as well update it to carry
>>> _all_ possible scsi IDs.
>>
>> Yes, but one iSCSI connection maps to one initiator and target IQN.
>> It's not like FC where each frame can specify its own initiator ID.
>>
> Sure. But updating the format to hold _any_ SCSI Name would allow us to
> reflect the actual initiator port name used by the host.
> So the guest could be

... aware of it for things such as PERSISTENT RESERVE IN?

>>>>> (3) would be feasible, as it would effectively mean 'just' to update the
>>>>> current NPIV mechanism. However, this would essentially lock us in for
>>>>> FC; any other types (think NVMe) will require yet another solution.
>>>> An FC-NVMe driver could also expose the same vhost interface, couldn't it?
>>>> FC-NVMe doesn't have to share the Linux code; but sharing the virtio standard
>>>> and the userspace ABI would be great.
>>>>
>>>> In fact, the main advantage of virtio-fc would be that (if we define it properly)
>>>> it could be reused for FC-NVMe instead of having to extend e.g. virtio-blk.
>>>> For example virtio-scsi has request, to-device payload, response, from-device
>>>> payload.  virtio-fc's request format could be the initiator and target port
>>>> identifiers, followed by FCP_CMD, to-device payload, FCP_RSP, from-device
>>>> payload.
>>>>
>>> As already said: We do _not_ have access to the FCP frames.
>>> So designing a virtio-fc protocol will only work for libfc-based HBAs,
>>> namely fnic, bnx2fc, and fcoe.
>>> Given that the future of FCoE is somewhat unclear I doubt it's a good
>>> idea to restrict ourselves to that.
>>
>> I understand that.  It doesn't have to be a 1:1 match with FCP frames or
>> even IUs; in fact the above minimal example is not (no OXID/RXID and no
>> FCP_XFER_RDY IU are just the first two things that come to mind).
>>
>> The only purpose is to have a *transport* that is (roughly speaking)
>> flexible enough to support future NPIV usecases which will certainly
>> include FC-NVMe.  In other words: I'm inventing my own cooked FCP
>> format, but I might as well base it on FCP itself as much as possible.
>
> Weeelll ... I don't want to go into nit-picking here, but FC-NVMe is
> _NOT_ FCP. In fact, it's a different FC-4 provider with its own set of
> FC-4 commands etc.

Yes, but it reuses the IU format and the overall look of the exchange.
It's not FCP, but it looks and quacks very much like it AFAIU.

>> Likewise, I'm not going to even mention ELS, but we would need _some_
>> kind of protocol to query name servers, receive state change
>> notifications, and get service parameters.  No idea yet how to do that,
>> probably something similar to virtio-scsi control and event queues, but
>> why not make the requests/responses look a little like PLOGI and PRLI?
>>
> And my idea here is to keep virtio-scsi as the basic mode of (command)
> transfer, but add a set of transport management commands which would
> allow us to do things like:
> - port discovery / scan
> - port instantiation / login
> - port reset
> - transport link notification / status check
> - transport reset
> 
> Those could be defined transport independently; and the neat thing is
> they could even be made to work with the current NPIV implementation
> with some tooling.
> And we could define things such that all current transport protocols can
> be mapped onto it.

Okay, got it.  So some kind of virtio-scsi 2.0.  I think we should weigh
the two proposals.  Would yours be useful for anything except NPIV (e.g.
the iSCSI + persistent reservations case)?  What software would use it?
And please speak up loudly if I'm completely mistaken about FC-NVMe!

Thanks,

Paolo
