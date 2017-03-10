Received: from eggs.gnu.org ([2001:4830:134:3::10]:36143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cmIEU-0005Z4-6v
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cmIER-0002oy-0d
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:57:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cmIEQ-0002oq-OI
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:57:10 -0500
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<20170307111618.43ffbd13.cornelia.huck@de.ibm.com>
	<cb84b888-4917-162d-31a5-f708f4783444@redhat.com>
	<20170308101922.730b1579.cornelia.huck@de.ibm.com>
	<64df071f-27b0-9ee6-0b76-d8fa7a9cc8ec@redhat.com>
	<20170308111214.591b49fe.cornelia.huck@de.ibm.com>
	<a8f854b2-bbd3-1665-0b09-2abcad928b9d@redhat.com>
	<20170309120734.390a7cda.cornelia.huck@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bc2035e9-57a6-93e0-3f6f-46c25172d4d8@redhat.com>
Date: Fri, 10 Mar 2017 18:57:05 +0800
MIME-Version: 1.0
In-Reply-To: <20170309120734.390a7cda.cornelia.huck@de.ibm.com>
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com



On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 19:07, Cornelia Huck wrote:
> On Thu, 9 Mar 2017 10:19:47 +0800
> Jason Wang<jasowang@redhat.com>  wrote:
>
>> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 18:12, Cornelia Huck wrote:
>>> On Wed, 8 Mar 2017 17:51:22 +0800
>>> Jason Wang<jasowang@redhat.com>  wrote:
>>>
>>>> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 17:19, Cornelia Huck wrote:
>>>>> On Wed, 8 Mar 2017 11:18:27 +0800
>>>>> Jason Wang<jasowang@redhat.com>  wrote:
>>>>>
>>>>>> On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:16, Cornelia Huck wrote:
>>>>>>> On Tue,  7 Mar 2017 16:47:58 +0800
>>>>>>> Jason Wang<jasowang@redhat.com>  wrote:
>>>>>>>
>>>>>>>> We don't destroy region cache during reset which can make the ma=
ps
>>>>>>>> of previous driver leaked to a buggy or malicious driver that do=
n't
>>>>>>>> set vring address before starting to use the device. Fix this by
>>>>>>>> destroy the region cache during reset and validate it before try=
ing to
>>>>>>>> use them. While at it, also validate address_space_cache_init() =
during
>>>>>>>> virtio_init_region_cache() to make sure we have a correct region
>>>>>>>> cache.
>>>>>>>>
>>>>>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>>>>>> ---
>>>>>>>>      hw/virtio/virtio.c | 88 +++++++++++++++++++++++++++++++++++=
+++++++++++--------
>>>>>>>>      1 file changed, 76 insertions(+), 12 deletions(-)
>>>>>>>> @@ -190,6 +211,10 @@ static inline uint16_t vring_avail_flags(Vi=
rtQueue *vq)
>>>>>>>>      {
>>>>>>>>          VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq=
->vring.caches);
>>>>>>>>          hwaddr pa =3D offsetof(VRingAvail, flags);
>>>>>>>> +    if (!caches) {
>>>>>>>> +        virtio_error(vq->vdev, "Cannot map avail flags");
>>>>>>> I'm not sure that virtio_error is the right thing here; ending up=
 in
>>>>>>> this function with !caches indicates an error in our logic.
>>>>>> Probably not, this can be triggered by buggy guest.
>>>>> I would think that even a buggy guest should not be able to trigger
>>>>> accesses to vring structures that have not yet been set up. What am=
 I
>>>>> missing?
>>>> I think this may happen if a driver start the device without setting=
 the
>>>> vring address. In this case, region caches cache the mapping of prev=
ious
>>>> driver. But maybe I was wrong.
>>> So the sequence would be:
>>>
>>> - Driver #1 sets up the device, then abandons it without cleaning up
>>> via reset
>> If driver #1 reset the device in this case, the caches would be NULL.
> Hm, how? Without your patch, the queue addresses are reset to 0 in that
> case but the cache is not cleaned up.
>

Yes, but with this patch, caches will be set to NULL during reset. So=20
the following vq access without seting queue pfn may hit NULL.

Thanks
