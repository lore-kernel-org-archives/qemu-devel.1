Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63F8C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C8721556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyLY1H2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C8721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6spk-0001Bl-Pb
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j6shn-0003IZ-Ht
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j6shm-0005mT-C8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:10:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j6shm-0005lN-69
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ArWvs5AjeOwO3WdWkI/UEiLVxN1Wdw2Khcv2oBM7ZxI=;
 b=LyLY1H2VMx4rVHfXV9gyQ77Q5WQFLAp/sRFqYp6G6hPRlWsnVoj0Kr4my0OPJvhqwuYM2Q
 Hc10sWr3LPWhm3Km9AHnJv4KoLxzHsbpe15o6kjxrNvPXj7kYMHBFW1sjWjnXIvwtyj1Gl
 tPG9iruGozC+4XgPlSn8Woh3rrfCCdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Qpj8ktF9N_-r0okQfIM4wA-1; Wed, 26 Feb 2020 04:10:07 -0500
X-MC-Unique: Qpj8ktF9N_-r0okQfIM4wA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E7F8800D48;
 Wed, 26 Feb 2020 09:10:07 +0000 (UTC)
Received: from [10.72.13.217] (ovpn-13-217.pek2.redhat.com [10.72.13.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F4C3100164D;
 Wed, 26 Feb 2020 09:09:58 +0000 (UTC)
Subject: Re: [PATCH] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200226070647.8103-1-jasowang@redhat.com>
 <20200226020836-mutt-send-email-mst@kernel.org>
 <344493874.10686339.1582701636434.JavaMail.zimbra@redhat.com>
 <20200226030945-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2a4415ff-c4b8-3982-5ab2-f1729b9f951c@redhat.com>
Date: Wed, 26 Feb 2020 17:09:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200226030945-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pasic@linux.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/26 =E4=B8=8B=E5=8D=884:12, Michael S. Tsirkin wrote:
> On Wed, Feb 26, 2020 at 02:20:36AM -0500, Jason Wang wrote:
>>
>> ----- Original Message -----
>>> On Wed, Feb 26, 2020 at 03:06:47PM +0800, Jason Wang wrote:
>>>> We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
>>>> platform without IOMMU support. This can lead unnecessary IOTLB
>>>> transactions which will damage the performance.
>>>>
>>>> Fixing this by check whether the device is backed by IOMMU and disable
>>>> device IOTLB.
>>>>
>>>> Reported-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>   hw/virtio/vhost.c | 12 +++++++++++-
>>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>> index 9edfadc81d..6e12c3d2de 100644
>>>> --- a/hw/virtio/vhost.c
>>>> +++ b/hw/virtio/vhost.c
>>>> @@ -290,7 +290,14 @@ static int vhost_dev_has_iommu(struct vhost_dev *=
dev)
>>>>   {
>>>>       VirtIODevice *vdev =3D dev->vdev;
>>>>  =20
>>>> -    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
>>>> +    /*
>>>> +     * For vhost, VIRTIO_F_IOMMU_PLATFORM means the backend support
>>>> +     * incremental memory mapping API via IOTLB API. For platform tha=
t
>>>> +     * does not have IOMMU, there's no need to enable this feature
>>>> +     * which may cause unnecessary IOTLB miss/update trnasactions.
>>>> +     */
>>>> +    return vdev->dma_as !=3D &address_space_memory &&
>>>> +           virtio_has_feature(dev->acked_features,
>>>> VIRTIO_F_IOMMU_PLATFORM);
>>>>   }
>>>>  =20
>>>>   static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
>>> Why check acked_features and not host features here?
>>> I'd worry that if we do it like this, userspace driver
>>> within guest can clear the feature and make device access
>>> memory directly.
>> Right, host_features should be more than enough.
>>
>>>> @@ -765,6 +772,9 @@ static int vhost_dev_set_features(struct vhost_dev
>>>> *dev,
>>>>       if (enable_log) {
>>>>           features |=3D 0x1ULL << VHOST_F_LOG_ALL;
>>>>       }
>>>> +    if (dev->vdev->dma_as =3D=3D &address_space_memory) {
>>>> +        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
>>>> +    }
>>>
>>> That's a guest visible change. Which seems at best unnecessary.
>>>
>> I don't get how this can be visible from guest? It works as F_LOG_ALL.
>>
>> Thanks
> Oh you are right.
> So just call vhost_dev_has_iommu here too?


That should work.

Thanks


>
>>>>       r =3D dev->vhost_ops->vhost_set_features(dev, features);
>>>>       if (r < 0) {
>>>>           VHOST_OPS_DEBUG("vhost_set_features failed");
>>>> --
>>>> 2.19.1
>>>
>


