Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C9CC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F0D206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/0hwGqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F0D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLZd-0002Jr-Gc
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYLYw-0001oJ-Ru
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:26:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYLYw-0006qk-58
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589253990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjGoG6HYvQ7Xh17Dbq7k08Yb0uGrDYXsb6463Yi0c6Q=;
 b=i/0hwGqbF2DKHpBcHZ2N13AkFs00zG1M+fjuGW/0BNQ6YNTHly3RW1pb2BV3H3lcrQCitC
 hf5MPeIVUWOZhcNAmxYnGKvV5Lfr7WmEBzoUx6VdEjx/Rjjpfz77Jfw10u2EP6f4VcC07c
 jHN/cx83bgMEI4mxziGUGHIKcKGFCOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-pw9mWlpGMzWNt224hs8YsA-1; Mon, 11 May 2020 23:26:28 -0400
X-MC-Unique: pw9mWlpGMzWNt224hs8YsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7367D8014D7;
 Tue, 12 May 2020 03:26:26 +0000 (UTC)
Received: from [10.72.13.96] (ovpn-13-96.pek2.redhat.com [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 823375C1B5;
 Tue, 12 May 2020 03:26:13 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] vhost: check vring address before calling unmap
To: Dima Stepanov <dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <2d4952df2cc246f7421b4b9023a581b22210fc41.1588252862.git.dimastep@yandex-team.ru>
 <4a03e4aa-3a21-d678-be98-13268343b674@redhat.com>
 <20200511091117.GB27319@dimastep-nix>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aea84690-3809-bf8f-a918-08fc74394a19@redhat.com>
Date: Tue, 12 May 2020 11:26:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511091117.GB27319@dimastep-nix>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, arei.gonglei@huawei.com, raphael.norwitz@nutanix.com,
 fengli@smartx.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/11 下午5:11, Dima Stepanov wrote:
> On Mon, May 11, 2020 at 11:05:58AM +0800, Jason Wang wrote:
>> On 2020/4/30 下午9:36, Dima Stepanov wrote:
>>> Since disconnect can happen at any time during initialization not all
>>> vring buffers (for instance used vring) can be intialized successfully.
>>> If the buffer was not initialized then vhost_memory_unmap call will lead
>>> to SIGSEGV. Add checks for the vring address value before calling unmap.
>>> Also add assert() in the vhost_memory_unmap() routine.
>>>
>>> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
>>> ---
>>>   hw/virtio/vhost.c | 27 +++++++++++++++++++++------
>>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index ddbdc53..3ee50c4 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -314,6 +314,8 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
>>>                                  hwaddr len, int is_write,
>>>                                  hwaddr access_len)
>>>   {
>>> +    assert(buffer);
>>> +
>>>       if (!vhost_dev_has_iommu(dev)) {
>>>           cpu_physical_memory_unmap(buffer, len, is_write, access_len);
>>>       }
>>> @@ -1132,12 +1134,25 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
>>>                                                   vhost_vq_index);
>>>       }
>>> -    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
>>> -                       1, virtio_queue_get_used_size(vdev, idx));
>>> -    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
>>> -                       0, virtio_queue_get_avail_size(vdev, idx));
>>> -    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
>>> -                       0, virtio_queue_get_desc_size(vdev, idx));
>>> +    /*
>>> +     * Since the vhost-user disconnect can happen during initialization
>>> +     * check if vring was initialized, before making unmap.
>>> +     */
>>> +    if (vq->used) {
>>> +        vhost_memory_unmap(dev, vq->used,
>>> +                           virtio_queue_get_used_size(vdev, idx),
>>> +                           1, virtio_queue_get_used_size(vdev, idx));
>>> +    }
>>> +    if (vq->avail) {
>>> +        vhost_memory_unmap(dev, vq->avail,
>>> +                           virtio_queue_get_avail_size(vdev, idx),
>>> +                           0, virtio_queue_get_avail_size(vdev, idx));
>>> +    }
>>> +    if (vq->desc) {
>>> +        vhost_memory_unmap(dev, vq->desc,
>>> +                           virtio_queue_get_desc_size(vdev, idx),
>>> +                           0, virtio_queue_get_desc_size(vdev, idx));
>>> +    }
>>
>> Any reason not checking hdev->started instead? vhost_dev_start() will set it
>> to true if virtqueues were correctly mapped.
>>
>> Thanks
> Well i see it a little bit different:
>   - vhost_dev_start() sets hdev->started to true before starting
>     virtqueues
>   - vhost_virtqueue_start() maps all the memory
> If we hit the vhost disconnect at the start of the
> vhost_virtqueue_start(), for instance for this call:
>    r = dev->vhost_ops->vhost_set_vring_base(dev, &state);
> Then we will call vhost_user_blk_disconnect:
>    vhost_user_blk_disconnect()->
>      vhost_user_blk_stop()->
>        vhost_dev_stop()->
>          vhost_virtqueue_stop()
> As a result we will come in this routine with the hdev->started still
> set to true, but if used/avail/desc fields still uninitialized and set
> to 0.


I may miss something, but consider both vhost_dev_start() and 
vhost_user_blk_disconnect() were serialized in main loop. Can this 
really happen?

Thanks


>
>>
>>>   }
>>>   static void vhost_eventfd_add(MemoryListener *listener,


