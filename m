Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F38C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBFB207ED
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjOcjC/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBFB207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahiE-0000Ve-TH
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jahhV-0008P2-9q
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:29:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29292
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jahhT-0001uN-Dd
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589815745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8kjliYAxQyNlRvT49jrP4dJkxEIdK8+ZggRhT/IIC4U=;
 b=HjOcjC/5fuAWj52ABco7hkiRW5I0Bl4pWL5jxaNQXwWtdZ8+ORMasFGpZ9J83YrAHI5B9F
 W3fyWdABngKEtXQ0sxrI2PX8jftZECzzmmLoubsqiuB7+tpL+YOzGPuziNWe/h64+dE7zf
 mmjSo1WdtC5waPSU5/+Kup/Cog8L2gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-sU8no10dORq4Irx2TKJAxQ-1; Mon, 18 May 2020 11:29:02 -0400
X-MC-Unique: sU8no10dORq4Irx2TKJAxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6F43460;
 Mon, 18 May 2020 15:29:00 +0000 (UTC)
Received: from [10.36.115.150] (ovpn-115-150.ams2.redhat.com [10.36.115.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BFD86EA21;
 Mon, 18 May 2020 15:28:56 +0000 (UTC)
Subject: Re: [PATCH v1 1/3] virtio-balloon: fix free page hinting without an
 iothread
To: Alexander Duyck <alexander.duyck@gmail.com>
References: <20200518083704.52646-1-david@redhat.com>
 <20200518083704.52646-2-david@redhat.com>
 <CAKgT0UfBHTxUm7Ka_8NQgT_4P0McsPGqpSTcquN7_ZLJ+i=uRA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <63874c2d-82ee-ed79-d108-aed90f6ee484@redhat.com>
Date: Mon, 18 May 2020 17:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfBHTxUm7Ka_8NQgT_4P0McsPGqpSTcquN7_ZLJ+i=uRA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Wei Wang <wei.w.wang@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.05.20 17:01, Alexander Duyck wrote:
> On Mon, May 18, 2020 at 1:37 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> In case we don't have an iothread, we mark the feature as abscent but
>> still add the queue. 'free_page_bh' remains set to NULL.
>>
>> qemu-system-i386 \
>>         -M microvm \
>>         -nographic \
>>         -device virtio-balloon-device,free-page-hint=true \
>>         -nographic \
>>         -display none \
>>         -monitor none \
>>         -serial none \
>>         -qtest stdio
>>
>> Doing a "write 0xc0000e30 0x24
>> 0x030000000300000003000000030000000300000003000000030000000300000003000000"
>>
>> We will trigger a SEGFAULT. Let's move the check and bail out.
>>
>> While at it, move the static initializations to instance_initialize().
>>
>> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>> Cc: Wei Wang <wei.w.wang@intel.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Cc: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/virtio/virtio-balloon.c | 35 ++++++++++++++++++-----------------
>>  1 file changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index 065cd450f1..dc3b1067ab 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -789,6 +789,13 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>>          return;
>>      }
>>
>> +    if (virtio_has_feature(s->host_features,
>> +        VIRTIO_BALLOON_F_FREE_PAGE_HINT) && !s->iothread) {
>> +        error_setg(errp, "'free-page-hint' requires 'iothread' to be set");
>> +        virtio_cleanup(vdev);
>> +        return;
>> +    }
>> +
>>      s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>>      s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>>      s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
>> @@ -797,24 +804,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>>                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>          s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
>>                                             virtio_balloon_handle_free_page_vq);
>> -        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>> -        s->free_page_report_cmd_id =
>> -                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>> -        s->free_page_report_notify.notify =
>> -                                       virtio_balloon_free_page_report_notify;
>>          precopy_add_notifier(&s->free_page_report_notify);
>> -        if (s->iothread) {
>> -            object_ref(OBJECT(s->iothread));
>> -            s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
>> -                                       virtio_ballloon_get_free_page_hints, s);
>> -            qemu_mutex_init(&s->free_page_lock);
>> -            qemu_cond_init(&s->free_page_cond);
>> -            s->block_iothread = false;
>> -        } else {
>> -            /* Simply disable this feature if the iothread wasn't created. */
>> -            s->host_features &= ~(1 << VIRTIO_BALLOON_F_FREE_PAGE_HINT);
>> -            virtio_error(vdev, "iothread is missing");
>> -        }
>> +
>> +        object_ref(OBJECT(s->iothread));
>> +        s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
>> +                                     virtio_ballloon_get_free_page_hints, s);
>>      }
>>      reset_stats(s);
>>  }
>> @@ -892,6 +886,13 @@ static void virtio_balloon_instance_init(Object *obj)
>>  {
>>      VirtIOBalloon *s = VIRTIO_BALLOON(obj);
>>
>> +    qemu_mutex_init(&s->free_page_lock);
>> +    qemu_cond_init(&s->free_page_cond);
>> +    s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>> +    s->free_page_report_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>> +    s->free_page_report_notify.notify = virtio_balloon_free_page_report_notify;
>> +    s->block_iothread = false;
>> +
>>      object_property_add(obj, "guest-stats", "guest statistics",
>>                          balloon_stats_get_all, NULL, NULL, s);
>>
> 
> So the one nit I have is that I am not sure you need to bother with
> initializing block_iothread since it should already be initialized to
> false/0 shouldn't it? Otherwise this all looks good to me.

Yes, and as "FREE_PAGE_REPORT_S_STOP = 0", that's implicitly set as
well. Both can go IMHO.

> 
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 

Thanks!

-- 
Thanks,

David / dhildenb


