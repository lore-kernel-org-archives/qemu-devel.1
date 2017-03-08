Received: from eggs.gnu.org ([2001:4830:134:3::10]:49571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYFp-0005lF-HH
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYFm-00037w-Fk
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:51:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clYFm-00037s-6d
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:51:30 -0500
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<20170307111618.43ffbd13.cornelia.huck@de.ibm.com>
	<cb84b888-4917-162d-31a5-f708f4783444@redhat.com>
	<20170308101922.730b1579.cornelia.huck@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <64df071f-27b0-9ee6-0b76-d8fa7a9cc8ec@redhat.com>
Date: Wed, 8 Mar 2017 17:51:22 +0800
MIME-Version: 1.0
In-Reply-To: <20170308101922.730b1579.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com



On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 17:19, Cornelia Huck wrote:
> On Wed, 8 Mar 2017 11:18:27 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:16, Cornelia Huck wrote:
>>> On Tue,  7 Mar 2017 16:47:58 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>
>>>> We don't destroy region cache during reset which can make the maps
>>>> of previous driver leaked to a buggy or malicious driver that don't
>>>> set vring address before starting to use the device. Fix this by
>>>> destroy the region cache during reset and validate it before trying =
to
>>>> use them. While at it, also validate address_space_cache_init() duri=
ng
>>>> virtio_init_region_cache() to make sure we have a correct region
>>>> cache.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>    hw/virtio/virtio.c | 88 +++++++++++++++++++++++++++++++++++++++++=
+++++--------
>>>>    1 file changed, 76 insertions(+), 12 deletions(-)
>>>> @@ -190,6 +211,10 @@ static inline uint16_t vring_avail_flags(VirtQu=
eue *vq)
>>>>    {
>>>>        VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vrin=
g.caches);
>>>>        hwaddr pa =3D offsetof(VRingAvail, flags);
>>>> +    if (!caches) {
>>>> +        virtio_error(vq->vdev, "Cannot map avail flags");
>>> I'm not sure that virtio_error is the right thing here; ending up in
>>> this function with !caches indicates an error in our logic.
>> Probably not, this can be triggered by buggy guest.
> I would think that even a buggy guest should not be able to trigger
> accesses to vring structures that have not yet been set up. What am I
> missing?

I think this may happen if a driver start the device without setting the=20
vring address. In this case, region caches cache the mapping of previous=20
driver. But maybe I was wrong.

>
>>> An assert
>>> might be better (and I hope we can sort out all of those errors expos=
ed
>>> by the introduction of region caches for 2.9...)
>> I thought we should avoid assert as much as possible in this case. But
>> if you and maintainer want an assert, it's also fine.
> My personal rule-of-thumb:
> - If it is something that can be triggered by the guest, or it is
> something that is easily recovered, set the device to broken.
> - If it is something that indicates that we messed up our internal
> logic, use an assert.
>
> I think arriving here with !caches indicates the second case; but if
> there is a way for a guest to trigger this, setting the device to
> broken would certainly be better.

Yes, broken seems better.

Thanks
