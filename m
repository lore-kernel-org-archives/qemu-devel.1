Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AB5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 02:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E032072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 02:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeOZwRTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E032072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiq6l-0005bF-Ae
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 22:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jiq5g-0004re-Mh
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 22:03:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jiq5f-0002fU-2W
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 22:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591754620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqePHfWQvKgixzUYDjgXaulVSWZv71OepESxBF/m7vk=;
 b=GeOZwRTmlOg5KojpABj3wGuATjqet3jPS+mjEMOkDvZXyoIThQ5sQ83P5avCBCjezbPRtf
 wRxJXImPeAHWCUW6qsLUnxALo72EJyuJB+481x5VqHb+E5O3AdcAB+UZt/8iulPPN+CpvA
 oxurRsOYLuIHP9DoS7kTWJSqg4BanMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-Cu7z4ddhNVOzrQuBBO4ExA-1; Tue, 09 Jun 2020 22:03:39 -0400
X-MC-Unique: Cu7z4ddhNVOzrQuBBO4ExA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46302107ACCA
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 02:03:38 +0000 (UTC)
Received: from [10.72.13.194] (ovpn-13-194.pek2.redhat.com [10.72.13.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA47C5F7D8;
 Wed, 10 Jun 2020 02:03:29 +0000 (UTC)
Subject: Re: [PATCH] virtio-pci: fix queue_enable write
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200529030728.7687-1-jasowang@redhat.com>
 <20200609114213-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a6ad8f9d-8613-16f8-f811-7ef2824c5f35@redhat.com>
Date: Wed, 10 Jun 2020 10:03:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609114213-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/9 下午11:43, Michael S. Tsirkin wrote:
> On Fri, May 29, 2020 at 11:07:28AM +0800, Jason Wang wrote:
>> Spec said: The driver uses this to selectively prevent the device from
>> executing requests from this virtqueue. 1 - enabled; 0 - disabled.
>>
>> Though write 0 to queue_enable is forbidden by the sepc, we should not
> spec?


Chapter 4.1.4.3.2 said:

"

The driver MUST NOT write a 0 to queue_enable.

"


>
>> assume that the value is 1.
>>
>> Fix this by ignoring the write value other than 1.
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Do we want to call virtio_error here so we can figure out something's wrong?


That looks better. Will do.

Thanks


>
>
>
>> ---
>>   hw/virtio/virtio-pci.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index d028c17c24..b3558eeaee 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -1273,16 +1273,18 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>>           virtio_queue_set_vector(vdev, vdev->queue_sel, val);
>>           break;
>>       case VIRTIO_PCI_COMMON_Q_ENABLE:
>> -        virtio_queue_set_num(vdev, vdev->queue_sel,
>> -                             proxy->vqs[vdev->queue_sel].num);
>> -        virtio_queue_set_rings(vdev, vdev->queue_sel,
>> +        if (val == 1) {
>> +            virtio_queue_set_num(vdev, vdev->queue_sel,
>> +                                 proxy->vqs[vdev->queue_sel].num);
>> +            virtio_queue_set_rings(vdev, vdev->queue_sel,
>>                          ((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 32 |
>>                          proxy->vqs[vdev->queue_sel].desc[0],
>>                          ((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << 32 |
>>                          proxy->vqs[vdev->queue_sel].avail[0],
>>                          ((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 32 |
>>                          proxy->vqs[vdev->queue_sel].used[0]);
>> -        proxy->vqs[vdev->queue_sel].enabled = 1;
>> +            proxy->vqs[vdev->queue_sel].enabled = 1;
>> +        }
>>           break;
>>       case VIRTIO_PCI_COMMON_Q_DESCLO:
>>           proxy->vqs[vdev->queue_sel].desc[0] = val;
>> -- 
>> 2.20.1
>


