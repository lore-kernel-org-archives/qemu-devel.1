Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C78AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7AF207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZztACPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7AF207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabLB-0006i9-IM
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jabIl-0003B4-Eo
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:39:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48093
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jabIk-0006lb-3u
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589791149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgAwX/dTfik7264RoYHqGALuh8ei0/JD9s6T4boHV5w=;
 b=WZztACPhWgBbNdijWqz5CkR4RvFJzazi5E6j4ssb7CZFVA4KB5YJiCW7d2Af0M01YFZlxp
 rGz9zrRnkkQ1ebqa42vkxCQP7NZ3ZVdllZ492Afb5Q61ZEHJRqYgcWbVF/sTbVssu+hVa7
 jFa9/4b4LPYBYMyMFVRRxR5QSy65fF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-iqCjxAcpPg6bZTdRl8D-Gg-1; Mon, 18 May 2020 04:39:05 -0400
X-MC-Unique: iqCjxAcpPg6bZTdRl8D-Gg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9689A800D24;
 Mon, 18 May 2020 08:39:04 +0000 (UTC)
Received: from [10.72.13.232] (ovpn-13-232.pek2.redhat.com [10.72.13.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC0DF100164D;
 Mon, 18 May 2020 08:38:56 +0000 (UTC)
Subject: Re: [PATCH] net: use peer when purging queue in
 qemu_flush_or_purge_queue_packets()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>
References: <20200511040453.23956-1-jasowang@redhat.com>
 <20200511042150.44na6uwgf6mhdngx@mozz.bu.edu>
 <fbe082da-acb2-9a2e-a16f-27928211d5d9@redhat.com>
 <16a4d458-c47d-026c-70fd-1b3f47736d04@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eaa723c7-0b2c-4430-1a0e-8d26479bb96b@redhat.com>
Date: Mon, 18 May 2020 16:38:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <16a4d458-c47d-026c-70fd-1b3f47736d04@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, stefanha@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/18 下午4:00, Philippe Mathieu-Daudé wrote:
> Hi Jason,
>
> On 5/18/20 5:34 AM, Jason Wang wrote:
>> On 2020/5/11 下午12:21, Alexander Bulekov wrote:
>>> On 200511 1204, Jason Wang wrote:
>>>> The sender of packet will be checked in the qemu_net_queue_purge() but
>>>> we use NetClientState not its peer when trying to purge the incoming
>>>> queue in qemu_flush_or_purge_packets(). This will trigger the assert
>>>> in virtio_net_reset since we can't pass the sender check.
>>>>
>>>> Fix by using the peer.
>
> Can you please include the backtrace:
>
> hw/net/virtio-net.c:533: void virtio_net_reset(VirtIODevice *): Assertion
> `!virtio_net_get_subqueue(nc)->async_tx.elem' failed.
> #9 0x55a33fa31b78 in virtio_net_reset hw/net/virtio-net.c:533:13
> #10 0x55a33fc88412 in virtio_reset hw/virtio/virtio.c:1919:9
> #11 0x55a341d82764 in virtio_bus_reset hw/virtio/virtio-bus.c:95:9
> #12 0x55a341dba2de in virtio_pci_reset hw/virtio/virtio-pci.c:1824:5
> #13 0x55a341db3e02 in virtio_pci_common_write 
> hw/virtio/virtio-pci.c:1252:13
> #14 0x55a33f62117b in memory_region_write_accessor memory.c:496:5
> #15 0x55a33f6205e4 in access_with_adjusted_size memory.c:557:18
> #16 0x55a33f61e177 in memory_region_dispatch_write memory.c:1488:16
>
> And link to reproducer:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg701914.html
>
> Thanks,


Done.

Thanks


>
> Phil.
>
> (Alexander, this is an example of why launchpad bug reports are easier 
> to refer in commit history).
>
>>>>
>>>> Reported-by: "Alexander Bulekov" <alxndr@bu.edu>
>>>> Fixes: ca77d85e1dbf9 ("net: complete all queued packets on VM stop")
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> Hi Jason,
>>> With this patch, I can no longer reproduce the crash
>>>
>>> Acked-by: Alexander Bulekov <alxndr@bu.edu>
>>>
>>> Thanks!
>>
>>
>> Applied.
>>
>> Thanks
>>
>>
>>
>>>
>>>> ---
>>>>   net/net.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/net.c b/net/net.c
>>>> index 38778e831d..9e47cf727d 100644
>>>> --- a/net/net.c
>>>> +++ b/net/net.c
>>>> @@ -610,7 +610,7 @@ void 
>>>> qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge)
>>>>           qemu_notify_event();
>>>>       } else if (purge) {
>>>>           /* Unable to empty the queue, purge remaining packets */
>>>> -        qemu_net_queue_purge(nc->incoming_queue, nc);
>>>> +        qemu_net_queue_purge(nc->incoming_queue, nc->peer);
>>>>       }
>>>>   }
>>>> -- 
>>>> 2.20.1
>>>>
>>
>>
>


