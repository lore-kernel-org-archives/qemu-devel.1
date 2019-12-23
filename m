Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2EEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3D4206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzFWe7gP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3D4206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijRaw-0003nL-Hm
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 12:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ijRaC-0003M0-L7
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:33:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ijRa9-0003Da-Of
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:33:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ijRa9-0003CV-6W
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577122404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opgjwRtickfdijUOpE58Dh8UuRUoO/s7wHN+GpNZAHM=;
 b=KzFWe7gPUWVYsuzsufxeDeSYqfTObnEbGo/rJNZZioqdGeGy90jnyLOF4Ll7fYIGVQmF/E
 6zc3Xpo+pGg4pueshFA7ySlJqfzCwiGtyMY5XQ3MozDL7uI132XsNlZQPhoGIu6qawSm40
 817Q2B3A/1cCTJB96ha+U3MIpqFTwnc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-ArFvirIjMDO7sbhMQ871NA-1; Mon, 23 Dec 2019 12:33:22 -0500
Received: by mail-wr1-f72.google.com with SMTP id f15so2822248wrr.2
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 09:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=opgjwRtickfdijUOpE58Dh8UuRUoO/s7wHN+GpNZAHM=;
 b=Y4CwHfcNtn75I45+yNphW5x9/GBaNy9NK3+Zh0eJqHOzZvHdFWBOFkx0NOg1DTj6PK
 Cyc5fFTduPrmt6cqKs2/rR0zFOhzmJY3MdXVUeZScXpHzKM08paKfQowQqu1FZdKPwhE
 EWQxFUu506qte63dJ8LoBG0H9YY+PWBrJ8LqBYkEKvbl7V5ZsIAI4NOGPBP7P3W9BFtV
 FQzBlNTHGNjtnxjIXV/NguMTNl5vAtgIlgsxn8+XKHw2htKbE+IgXt9NGUg7Uy8vWaqc
 KN4JIwaSDSL16yYuXlFkYqNgY0ticAAkFsLB83lN96Y1Q2ID9lh3wXaafMOKG2AxnIKr
 RAbg==
X-Gm-Message-State: APjAAAWCowpmEJ2UizeeuHaQLk6f7npP3Scui1/iLbXP58u63C5L2Gq6
 +LVQUO0NI07JoSiyJGF0Lu5jTOt5xxhBSVWq/SrsrbuYFZIx8ncgN95uh8Mf9scfEFVwbCCUPWI
 yJkG9/w6g0BTUcIs=
X-Received: by 2002:a5d:4984:: with SMTP id r4mr29757112wrq.137.1577122400989; 
 Mon, 23 Dec 2019 09:33:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqy51q8k8AS9NmNw7UbvW99bqsqYnSk5D25JOEsHWeIqUW1GjpjExCMN8idgIZCkCSYg+/NFuQ==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr29757096wrq.137.1577122400705; 
 Mon, 23 Dec 2019 09:33:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id j12sm21366366wrt.55.2019.12.23.09.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2019 09:33:20 -0800 (PST)
Subject: Re: [PATCH] virtio: add the queue number check
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191223082813.28930-1-yang.zhong@intel.com>
 <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
 <20191223091856.GA8433@yangzhon-Virtual>
 <e13a5fcc-b861-1847-58a8-e3d6445f84b0@redhat.com>
 <20191223092508-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <187f02d9-1677-d232-a44a-ed7b1e5f6ee5@redhat.com>
Date: Mon, 23 Dec 2019 18:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191223092508-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-MC-Unique: ArFvirIjMDO7sbhMQ871NA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/12/19 15:25, Michael S. Tsirkin wrote:
> On Mon, Dec 23, 2019 at 12:02:18PM +0100, Paolo Bonzini wrote:
>> On 23/12/19 10:18, Yang Zhong wrote:
>>>   In this time, the queue number in the front-end block driver is 2, but
>>>   the queue number in qemu side is still 4. So the guest virtio_blk
>>>   driver will failed to create vq with backend.
>>
>> Where?
>>
>>>   There is no "set back"
>>>   mechnism for block driver to inform backend this new queue number.
>>>   So, i added this check in qemu side.
>>
>> Perhaps the guest kernel should still create the virtqueues, and just
>> not use them.  In any case, now that you have explained it, it is
>> certainly a guest bug.
> 
> Paolo do you understand where the bug is?

No, I asked above where does the virtio_blk driver fail to create the
virtqueues.  But it shouldn't; it is legal for the guest not to
configure all virtqueues, and QEMU knows to ignore the extra ones.  For
example, firmware can ignore virtio-scsi request queues above the first,
or ignore the virtio-scsi control and event queues (see
src/hw/virtio-scsi.c in SeaBIOS, it only calls vp_find_vq with index 2).

In particular this is the reason why request queues for virtio-scsi are
numbered 2 and above, rather than starting from zero: this way, the
guest can just pretend that unnecessary queues do not exist, and still
keep the virtqueue numbers consecutive.

> E.g. I see this in vhost user block:
> 
>     /* Kick right away to begin processing requests already in vring */
>     for (i = 0; i < s->dev.nvqs; i++) {
>         VirtQueue *kick_vq = virtio_get_queue(vdev, i);
> 
>         if (!virtio_queue_get_desc_addr(vdev, i)) {
>             continue;
>         }
>         event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
>     }
> 
> which is an (admittedly hacky) want to skip VQs which
> were not configured by guest ....

Right, this is an example of QEMU ignoring extra virtqueues.

Paolo

> 
> 
>>>   Since the current virtio-blk and vhost-user-blk device always
>>>   defaultly use 1 queue, it's hard to find this issue.
>>>
>>>   I checked the guest kernel driver, virtio-scsi and virtio-blk all
>>>   have same check in their driver probe:
>>>
>>>   num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
>>>  
>>>   It's possible the guest driver has different queue number with qemu
>>>   side.
>>>
>>>   I also want to fix this issue from guest driver side, but currently there 
>>>   is no better solution to fix this issue.
>>>
>>>   By the way, i did not try scsi with this corner case, and only check
>>>   driver and qemu code to find same issue. thanks! 
>>>
>>>   Yang
>>>
>>>> Paolo
>>>>
>>>>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>>>>> ---
>>>>>  hw/block/vhost-user-blk.c | 11 +++++++++++
>>>>>  hw/block/virtio-blk.c     | 11 ++++++++++-
>>>>>  hw/scsi/virtio-scsi.c     | 12 ++++++++++++
>>>>>  3 files changed, 33 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>>>>> index 63da9bb619..250e72abe4 100644
>>>>> --- a/hw/block/vhost-user-blk.c
>>>>> +++ b/hw/block/vhost-user-blk.c
>>>>> @@ -23,6 +23,8 @@
>>>>>  #include "qom/object.h"
>>>>>  #include "hw/qdev-core.h"
>>>>>  #include "hw/qdev-properties.h"
>>>>> +#include "qemu/option.h"
>>>>> +#include "qemu/config-file.h"
>>>>>  #include "hw/virtio/vhost.h"
>>>>>  #include "hw/virtio/vhost-user-blk.h"
>>>>>  #include "hw/virtio/virtio.h"
>>>>> @@ -391,6 +393,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>>>      VHostUserBlk *s = VHOST_USER_BLK(vdev);
>>>>>      Error *err = NULL;
>>>>> +    unsigned cpus;
>>>>>      int i, ret;
>>>>>  
>>>>>      if (!s->chardev.chr) {
>>>>> @@ -403,6 +406,14 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>>>>          return;
>>>>>      }
>>>>>  
>>>>> +    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
>>>>> +                               "cpus", 0);
>>>>> +    if (s->num_queues > cpus ) {
>>>>> +        error_setg(errp, "vhost-user-blk: the queue number should be equal "
>>>>> +                "or less than vcpu number");
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>>      if (!s->queue_size) {
>>>>>          error_setg(errp, "vhost-user-blk: queue size must be non-zero");
>>>>>          return;
>>>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>>>> index d62e6377c2..b2f4d01148 100644
>>>>> --- a/hw/block/virtio-blk.c
>>>>> +++ b/hw/block/virtio-blk.c
>>>>> @@ -18,6 +18,8 @@
>>>>>  #include "qemu/error-report.h"
>>>>>  #include "qemu/main-loop.h"
>>>>>  #include "trace.h"
>>>>> +#include "qemu/option.h"
>>>>> +#include "qemu/config-file.h"
>>>>>  #include "hw/block/block.h"
>>>>>  #include "hw/qdev-properties.h"
>>>>>  #include "sysemu/blockdev.h"
>>>>> @@ -1119,7 +1121,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>>>>>      VirtIOBlock *s = VIRTIO_BLK(dev);
>>>>>      VirtIOBlkConf *conf = &s->conf;
>>>>>      Error *err = NULL;
>>>>> -    unsigned i;
>>>>> +    unsigned i,cpus;
>>>>>  
>>>>>      if (!conf->conf.blk) {
>>>>>          error_setg(errp, "drive property not set");
>>>>> @@ -1133,6 +1135,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>>>>>          error_setg(errp, "num-queues property must be larger than 0");
>>>>>          return;
>>>>>      }
>>>>> +    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
>>>>> +                               "cpus", 0);
>>>>> +    if (conf->num_queues > cpus ) {
>>>>> +        error_setg(errp, "virtio-blk: the queue number should be equal "
>>>>> +                "or less than vcpu number");
>>>>> +        return;
>>>>> +    }
>>>>>      if (!is_power_of_2(conf->queue_size) ||
>>>>>          conf->queue_size > VIRTQUEUE_MAX_SIZE) {
>>>>>          error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
>>>>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>>>>> index e8b2b64d09..8e3e44f6b9 100644
>>>>> --- a/hw/scsi/virtio-scsi.c
>>>>> +++ b/hw/scsi/virtio-scsi.c
>>>>> @@ -21,6 +21,8 @@
>>>>>  #include "qemu/error-report.h"
>>>>>  #include "qemu/iov.h"
>>>>>  #include "qemu/module.h"
>>>>> +#include "qemu/option.h"
>>>>> +#include "qemu/config-file.h"
>>>>>  #include "sysemu/block-backend.h"
>>>>>  #include "hw/qdev-properties.h"
>>>>>  #include "hw/scsi/scsi.h"
>>>>> @@ -880,6 +882,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
>>>>>  {
>>>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>>>      VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(dev);
>>>>> +    unsigned cpus;
>>>>>      int i;
>>>>>  
>>>>>      virtio_init(vdev, "virtio-scsi", VIRTIO_ID_SCSI,
>>>>> @@ -893,6 +896,15 @@ void virtio_scsi_common_realize(DeviceState *dev,
>>>>>          virtio_cleanup(vdev);
>>>>>          return;
>>>>>      }
>>>>> +
>>>>> +    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
>>>>> +                               "cpus", 0);
>>>>> +    if (s->conf.num_queues > cpus ) {
>>>>> +        error_setg(errp, "virtio-scsi: the queue number should be equal "
>>>>> +                "or less than vcpu number");
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>>      s->cmd_vqs = g_new0(VirtQueue *, s->conf.num_queues);
>>>>>      s->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
>>>>>      s->cdb_size = VIRTIO_SCSI_CDB_DEFAULT_SIZE;
>>>>>
>>>
> 


