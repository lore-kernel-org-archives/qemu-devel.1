Received: from eggs.gnu.org ([2001:4830:134:3::10]:56382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPkvK-0001sC-E1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPkvF-0005BW-DI
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:33:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fPkvF-0005AO-8P
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:33:01 -0400
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
	<1522846444-31725-4-git-send-email-wexu@redhat.com>
	<6a78b53a-0830-74de-5447-63ecab67e5ed@redhat.com>
	<20180603174404.GA28131@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <182fcc5e-5996-24e3-d190-be66b0c9f1bd@redhat.com>
Date: Mon, 4 Jun 2018 16:32:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180603174404.GA28131@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/8] virtio: add empty check for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: jfreimann@redhat.com, qemu-devel@nongnu.org, tiwei.bie@intel.com, mst@redhat.com



On 2018=E5=B9=B406=E6=9C=8804=E6=97=A5 01:44, Wei Xu wrote:
>>> +static int virtio_queue_empty_packed_rcu(VirtQueue *vq)
>>> +{
>>> +    struct VRingDescPacked desc;
>>> +    VRingMemoryRegionCaches *cache;
>>> +
>>> +    if (unlikely(!vq->packed.desc)) {
>>> +        return 1;
>>> +    }
>>> +
>>> +    cache =3D vring_get_region_caches(vq);
>>> +    vring_desc_read_packed(vq->vdev, &desc, &cache->desc_packed, vq-=
>last_avail_idx);
>>> +
>>> +    /* Make sure we see the updated flag */
>>> +    smp_mb();
>> What we need here is to make sure flag is read before all other fields=
,
>> looks like this barrier can't.
> Isn't flag updated yet if it has been read?
>

Consider the case of event index, you need make sure flag is read before=20
off_wrap.

Thanks
