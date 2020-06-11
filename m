Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD79C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 03:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC73206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 03:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTL63c3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC73206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjDXy-0003Zv-Kf
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 23:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jjDXL-0003A5-BB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 23:05:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40818
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jjDXJ-0000Tt-LT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 23:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591844747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7AIw2fiyk7/k1benMaqZ9evm5ERCQVsfSsvu9O/d5g=;
 b=OTL63c3gERYY2+fbt9u2qOq97Vv8/0PNPbs6DK8S5OYJdDfKuRLjVDgidiLF5MJ+WMRa26
 wbtWcJeFmrk/lGJYySjZlvgt43PSPA1wihaqRx6ypf+O/hM7GEiQOXYtCvLsxGkPC8jxzA
 qloVrWq+WwQc8xipJzWRnjQOv7cjYG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-qPD9_IcGP_ysy92aAZYx7w-1; Wed, 10 Jun 2020 23:05:45 -0400
X-MC-Unique: qPD9_IcGP_ysy92aAZYx7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13C89107ACCD
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 03:05:45 +0000 (UTC)
Received: from [10.72.12.125] (ovpn-12-125.pek2.redhat.com [10.72.12.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C71F5C1B0;
 Thu, 11 Jun 2020 03:05:37 +0000 (UTC)
Subject: Re: [PATCH V2] virtio-pci: fix queue_enable write
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200610054351.15811-1-jasowang@redhat.com>
 <20200610085726.jerorykxbycoesyu@steredhat>
 <20200610054248-mutt-send-email-mst@kernel.org>
 <20200610095224.2q4ivledb42ubsz4@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <03fafc96-cefc-a086-b82f-cd87730d9d98@redhat.com>
Date: Thu, 11 Jun 2020 11:05:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610095224.2q4ivledb42ubsz4@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 23:05:47
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/10 下午5:52, Stefano Garzarella wrote:
> On Wed, Jun 10, 2020 at 05:42:54AM -0400, Michael S. Tsirkin wrote:
>> On Wed, Jun 10, 2020 at 10:57:26AM +0200, Stefano Garzarella wrote:
>>> On Wed, Jun 10, 2020 at 01:43:51PM +0800, Jason Wang wrote:
>>>> Spec said: The driver uses this to selectively prevent the device from
>>>> executing requests from this virtqueue. 1 - enabled; 0 - disabled.
>>>>
>>>> Though write 0 to queue_enable is forbidden by the spec, we should not
>>>> assume that the value is 1.
>>>>
>>>> Fix this by ignore the write value other than 1.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>> Changes from V1:
>>>> - fix typo
>>>> - warn wrong value through virtio_error
>>>> ---
>>>>   hw/virtio/virtio-pci.c | 12 ++++++++----
>>>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>>>> index d028c17c24..7bc8c1c056 100644
>>>> --- a/hw/virtio/virtio-pci.c
>>>> +++ b/hw/virtio/virtio-pci.c
>>>> @@ -1273,16 +1273,20 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>>>>           virtio_queue_set_vector(vdev, vdev->queue_sel, val);
>>>>           break;
>>>>       case VIRTIO_PCI_COMMON_Q_ENABLE:
>>>> -        virtio_queue_set_num(vdev, vdev->queue_sel,
>>>> -                             proxy->vqs[vdev->queue_sel].num);
>>>> -        virtio_queue_set_rings(vdev, vdev->queue_sel,
>>>> +        if (val == 1) {
>>> Does it have to be 1 or can it be any value other than 0?
>>>
>>> Thanks,
>>> Stefano
>> spec says 1
> I was confused by "The driver MUST NOT write a 0 to queue_enable.",
> interpreting it as "can write anything other than 0".


Yes, the spec is unclear about what happens if we write a value other 
than 0 or 1.

Maybe we should clarify that only 1 is allowed. Or writing value other 
than 1 may cause unexpected result.


>
> But as Jason also wrote in the commit message, the driver should write
> 1 to enable, so
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


Thanks


>
> Thanks,
> Stefano
>


