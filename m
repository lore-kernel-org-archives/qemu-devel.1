Received: from eggs.gnu.org ([2001:4830:134:3::10]:35113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWDzr-0002yF-HE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 22:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWDzm-0005b0-K9
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 22:11:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cWDzm-0005aw-EU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 22:11:38 -0500
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-20-git-send-email-peterx@redhat.com>
	<cddf837c-24ca-b6f2-67cf-256e6b1e0bec@redhat.com>
	<20170124073152.GA16400@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <662d5e53-0e62-741f-ba71-32630b91ffd4@redhat.com>
Date: Wed, 25 Jan 2017 11:11:30 +0800
MIME-Version: 1.0
In-Reply-To: <20170124073152.GA16400@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 19/20] intel_iommu: unmap existing
 pages before replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com



On 2017=E5=B9=B401=E6=9C=8824=E6=97=A5 15:31, Peter Xu wrote:
> On Mon, Jan 23, 2017 at 06:40:12PM +0800, Jason Wang wrote:
>> On 2017=E5=B9=B401=E6=9C=8820=E6=97=A5 21:08, Peter Xu wrote:
>>>   static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
>>>   {
>>>       memory_region_notify_one((IOMMUNotifier *)private, entry);
>>> @@ -2711,13 +2768,16 @@ static void vtd_iommu_replay(MemoryRegion *mr=
, IOMMUNotifier *n)
>>>       if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D=
 0) {
>>>           /*
>>> -         * Scanned a valid context entry, walk over the pages and
>>> -         * notify when needed.
>>> +         * Scanned a valid context entry, we first make sure to remo=
ve
>>> +         * all existing mappings in old domain, by sending UNMAP to
>>> +         * all the notifiers. Then, we walk over the pages and notif=
y
>>> +         * with existing mapped new entries in the new domain.
>>>            */
>> A question is what if the context cache was invalidated but the device=
 were
>> not moved to a new domain. Then the code here does not do anything I
>> believe?
> Yes, it'll unmap all the stuffs and remap them all. I think that's my
> intention, and can we really avoid this?
>
>> I think we should move vtd_address_space_unmap() in the context
>> entry invalidation processing.
> IMHO we need this "whole umap" thing not only for context entry
> invalidation, but all the places that need this replay, no? For
> example, when we receive domain flush.
>
> Thanks,
>
> -- peterx
>

Consider the case that we move device from domain A to no domain. Looks=20
like current code did nothing since it can not get a valid context entry=20
during replay?

Thanks
