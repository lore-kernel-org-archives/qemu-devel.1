Received: from eggs.gnu.org ([209.51.188.92]:57292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw5CL-0004jk-Cm
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw5CE-0003Zg-67
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:12:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gw5C8-0003WR-Lm
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:12:22 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-11-git-send-email-wexu@redhat.com>
	<af2abdf0-3f96-6e97-d5c0-5ab2211222e1@redhat.com>
	<20190219110003.GE15343@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <73de72fc-07b2-8a70-f2d6-edfa26b1e989@redhat.com>
Date: Tue, 19 Feb 2019 21:12:05 +0800
MIME-Version: 1.0
In-Reply-To: <20190219110003.GE15343@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/11] virtio: migration support for
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: qemu-devel@nongnu.org, tiwei.bie@intel.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com


On 2019/2/19 =E4=B8=8B=E5=8D=887:00, Wei Xu wrote:
> On Tue, Feb 19, 2019 at 03:30:41PM +0800, Jason Wang wrote:
>> On 2019/2/14 =E4=B8=8B=E5=8D=8812:26,wexu@redhat.com  wrote:
>>> From: Wei Xu<wexu@redhat.com>
>>>
>>> Both userspace and vhost-net/user are supported with this patch.
>>>
>>> A new subsection is introduced for packed ring, only 'last_avail_idx'
>>> and 'last_avail_wrap_counter' are saved/loaded presumably based on
>>> all the others relevant data(inuse, used/avail index and wrap count
>>> should be the same.
>> This is probably only true for net device, see comment in virtio_load(=
):
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Some devices migrate VirtQueueElements that have been popped
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * from the avail ring but not yet returned to the used ring.
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * Since max ring size < UINT16_MAX it's safe to use modulo
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * UINT16_MAX + 1 subtraction.
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vd=
ev->vq[i].inuse =3D (uint16_t)(vdev->vq[i].last_avail_idx -
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev->vq[i].used_idx);
>>
>>
>> So you need to migrate used_idx and used_wrap_counter since we don't h=
ave
>> used idx.
> This is trying to align with vhost-net/user as we discussed, since all =
we
> have done is to support  virtio-net device for packed ring,


Well, what you did probably work for virtio-net. But again, virtio-net=20
is not the only device we want to support.


>   maybe we can
> consider supporting other devices after we have got it verified.
>

Please don't and fix the issue, packed virtqueue is a generic layout=20
changes that should work for all kinds of virtio devices. It should be=20
specially optimized for net, but it doesn't mean it was only designed=20
for net.

Thanks
