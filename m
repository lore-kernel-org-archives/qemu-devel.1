Received: from eggs.gnu.org ([2001:4830:134:3::10]:58650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cTgDB-0006Ss-PB
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cTgD6-0004lb-T2
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:42:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cTgD6-0004jS-Mf
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 21:42:52 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0D658553F
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 02:42:52 +0000 (UTC)
References: <1484625660-3312-1-git-send-email-jasowang@redhat.com>
	<20170117164326-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <38dfab22-412f-94a5-4b01-351edf627027@redhat.com>
Date: Wed, 18 Jan 2017 10:42:48 +0800
MIME-Version: 1.0
In-Reply-To: <20170117164326-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: force VIRTIO_F_IOMMU_PLATFORM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org



On 2017=E5=B9=B401=E6=9C=8817=E6=97=A5 22:44, Michael S. Tsirkin wrote:
> On Tue, Jan 17, 2017 at 12:01:00PM +0800, Jason Wang wrote:
>> We allow vhost to clear VIRITO_F_IOMMU_PLATFORM which is wrong since
>> VIRTIO_F_IOMMU_PLATFORM is mandatory for security. Fixing this by
>> enforce it after vdc->get_features().
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/virtio/virtio-bus.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>> index d31cc00..a886011 100644
>> --- a/hw/virtio/virtio-bus.c
>> +++ b/hw/virtio/virtio-bus.c
>> @@ -47,6 +47,7 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, E=
rror **errp)
>>       VirtioBusState *bus =3D VIRTIO_BUS(qbus);
>>       VirtioBusClass *klass =3D VIRTIO_BUS_GET_CLASS(bus);
>>       VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>> +    bool has_iommu =3D virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_P=
LATFORM);
>>  =20
>>       DPRINTF("%s: plug device.\n", qbus->name);
>>  =20
>> @@ -63,8 +64,8 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, E=
rror **errp)
>>           klass->device_plugged(qbus->parent, errp);
>>       }
>>  =20
>> -    if (klass->get_dma_as !=3D NULL &&
>> -        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
>> +    if (klass->get_dma_as !=3D NULL && has_iommu) {
>> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATF=
ORM);
>>           vdev->dma_as =3D klass->get_dma_as(qbus->parent);
>>       } else {
>>           vdev->dma_as =3D &address_space_memory;
> I suspect that's not enough, we must also fail or disable vhost
> (depending on the options), otherwise things won't work.

Looks like with the patch, VIRTIO_F_IOMMU_PLATFORM will be passed to=20
vhost_set_features(). So if vhost backend does not support it, it will=20
fall back to userspace (This may not work for vhost-user, but it's a bug=20
existed even before this patch).

Thanks
