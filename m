Received: from eggs.gnu.org ([2001:4830:134:3::10]:53654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByv3-0007EK-T5
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByv1-0004ol-Bp
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByv0-0004jY-Tr
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:12:07 -0400
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-9-git-send-email-wexu@redhat.com>
	<f9b19079-65fa-4d21-63ba-00f79095bc4f@redhat.com>
	<20181015082050.GG27871@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0f271561-f7fc-dc0c-e999-ad32f7580c98@redhat.com>
Date: Mon, 15 Oct 2018 17:11:53 +0800
MIME-Version: 1.0
In-Reply-To: <20181015082050.GG27871@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 08/12] virtio: event suppression support
 for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: maxime.coquelin@redhat.com, jfreimann@redhat.com, qemu-devel@nongnu.org, tiwei.bie@intel.com



On 2018=E5=B9=B410=E6=9C=8815=E6=97=A5 16:20, Wei Xu wrote:
>>> +static void virtio_queue_set_notification_packed(VirtQueue *vq, int =
enable)
>>> +{
>>> +    VRingPackedDescEvent e;
>>> +    VRingMemoryRegionCaches *caches;
>>> +
>>> +    rcu_read_lock();
>>> +    caches  =3D vring_get_region_caches(vq);
>>> +    vring_packed_event_read(vq->vdev, &caches->device, &e);
>>> +
>>> +    if (!enable) {
>>> +        e.flags =3D RING_EVENT_FLAGS_DISABLE;
>>> +        goto out;
>>> +    }
>>> +
>>> +    e.flags =3D RING_EVENT_FLAGS_ENABLE;
>>> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) =
{
>>> +        uint16_t off_wrap =3D vq->event_idx | vq->event_wrap_counter=
 << 15;
>> Btw, why not just use shadow_avail_idx here?
> It is nice to do that but an issue here is that it is 'shadow_avail_idx=
' for
> Rx but 'used_idx' for Tx when setting up for a kick, haven't figured ou=
t a
> clear fix because it helps easier migration part work, any idea?
>
> Wei
>

I'm not sure I get the point here. Why need to care about used_idx when=20
enabling guest kick?

Thanks
