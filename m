Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2F6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 03:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEFF2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 03:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpFDxyWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEFF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaWZG-0003b1-Ga
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 23:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jaWYY-0002gv-CN
 for qemu-devel@nongnu.org; Sun, 17 May 2020 23:35:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28526
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jaWYX-0007GQ-LR
 for qemu-devel@nongnu.org; Sun, 17 May 2020 23:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589772908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DN3oL1dkAO7/N4nqh2GQtgO1ZceGeQRDD4mhHKPey4g=;
 b=CpFDxyWelmEcOQHcUvi+6nOPSVM7pmotWoItC8rm248WSRWYqJIn9GvZPY3RK9f4HZLpEY
 Q5juRH2EP9xGUwZ3qN2NFBFfO2ziNbjEc7UgonVohq+BQyqrN41DFMzHEbYND0wOVBGgnj
 nr6tc2deHi6XMjNx3SRXB0ac4SB5Izg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-03uPG1VSPN20OaMLmYruEA-1; Sun, 17 May 2020 23:35:05 -0400
X-MC-Unique: 03uPG1VSPN20OaMLmYruEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A79BA474;
 Mon, 18 May 2020 03:35:04 +0000 (UTC)
Received: from [10.72.13.232] (ovpn-13-232.pek2.redhat.com [10.72.13.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 269562B7BB;
 Mon, 18 May 2020 03:34:57 +0000 (UTC)
Subject: Re: [PATCH] net: use peer when purging queue in
 qemu_flush_or_purge_queue_packets()
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200511040453.23956-1-jasowang@redhat.com>
 <20200511042150.44na6uwgf6mhdngx@mozz.bu.edu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fbe082da-acb2-9a2e-a16f-27928211d5d9@redhat.com>
Date: Mon, 18 May 2020 11:34:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511042150.44na6uwgf6mhdngx@mozz.bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: mst@redhat.com, qemu-stable@nongnu.org, stefanha@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/11 下午12:21, Alexander Bulekov wrote:
> On 200511 1204, Jason Wang wrote:
>> The sender of packet will be checked in the qemu_net_queue_purge() but
>> we use NetClientState not its peer when trying to purge the incoming
>> queue in qemu_flush_or_purge_packets(). This will trigger the assert
>> in virtio_net_reset since we can't pass the sender check.
>>
>> Fix by using the peer.
>>
>> Reported-by: "Alexander Bulekov" <alxndr@bu.edu>
>> Fixes: ca77d85e1dbf9 ("net: complete all queued packets on VM stop")
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Hi Jason,
> With this patch, I can no longer reproduce the crash
>
> Acked-by: Alexander Bulekov <alxndr@bu.edu>
>
> Thanks!


Applied.

Thanks



>
>> ---
>>   net/net.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/net.c b/net/net.c
>> index 38778e831d..9e47cf727d 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -610,7 +610,7 @@ void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge)
>>           qemu_notify_event();
>>       } else if (purge) {
>>           /* Unable to empty the queue, purge remaining packets */
>> -        qemu_net_queue_purge(nc->incoming_queue, nc);
>> +        qemu_net_queue_purge(nc->incoming_queue, nc->peer);
>>       }
>>   }
>>   
>> -- 
>> 2.20.1
>>


