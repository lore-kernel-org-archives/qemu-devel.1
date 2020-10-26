Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6278FC388F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 03:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE862207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 03:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZijKHnfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE862207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWt3v-0004R1-PD
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 23:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kWt3E-0003ql-9r
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 23:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kWt3B-0007mn-Lf
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 23:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603682400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ToSuX7RjEXYgkToi8mgHi9/GtrfaZztNxrJ+ziQT4o=;
 b=ZijKHnfnhF62qtO/INvffksL9O9E+H5FL33NixdMhYNMgfTi/wrqaTu7abzFxT060LZ82h
 8HJWOKQ+u7/0CmGzcyZNFMk6rqrLxK1aVr4S24zz0VKss3vFbuwPrG9nP6HyAU1Sn7GQ1o
 CZAoxvnkU4QY/05OVwMP2FvwwbC30/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-GNlPuESxO-mF79GG-xYByQ-1; Sun, 25 Oct 2020 23:19:57 -0400
X-MC-Unique: GNlPuESxO-mF79GG-xYByQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89334805F17;
 Mon, 26 Oct 2020 03:19:56 +0000 (UTC)
Received: from [10.72.13.201] (ovpn-13-201.pek2.redhat.com [10.72.13.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 197925578F;
 Mon, 26 Oct 2020 03:19:51 +0000 (UTC)
Subject: Re: [PATCH v2] virtio-net: Add check for mac address while peer is
 vdpa
From: Jason Wang <jasowang@redhat.com>
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
References: <20201023091559.4858-1-lulu@redhat.com>
 <462e6df3-8a34-9cfb-0696-49481aba4d46@redhat.com>
Message-ID: <1bd85488-7186-d869-9bc2-2536d23c1e78@redhat.com>
Date: Mon, 26 Oct 2020 11:19:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <462e6df3-8a34-9cfb-0696-49481aba4d46@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 23:20:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/26 上午10:43, Jason Wang wrote:
>
> On 2020/10/23 下午5:15, Cindy Lu wrote:
>> Sometime vdpa get an all 0 mac address from the hardware, this will 
>> cause the traffic down
>> So we add the check for this part.
>> if we get an 0 mac address we will use the default mac address instead
>>
>> Signed-off-by: Cindy Lu <lulu@redhat.com>
>> ---
>>   hw/net/virtio-net.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 9179013ac4..f1648fc47d 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -126,6 +126,7 @@ static void virtio_net_get_config(VirtIODevice 
>> *vdev, uint8_t *config)
>>       VirtIONet *n = VIRTIO_NET(vdev);
>>       struct virtio_net_config netcfg;
>>       NetClientState *nc = qemu_get_queue(n->nic);
>> +    static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
>>         int ret = 0;
>>       memset(&netcfg, 0 , sizeof(struct virtio_net_config));
>> @@ -151,7 +152,11 @@ static void virtio_net_get_config(VirtIODevice 
>> *vdev, uint8_t *config)
>>           ret = vhost_net_get_config(get_vhost_net(nc->peer), 
>> (uint8_t *)&netcfg,
>>                                      n->config_size);
>>           if (ret != -1) {
>> -            memcpy(config, &netcfg, n->config_size);
>> +            if (memcmp(&netcfg.mac, &zero, sizeof(zero)) != 0) {
>> +                memcpy(config, &netcfg, n->config_size);
>> +        } else {
>> +                error_report("Get an all zero mac address from 
>> hardware");
>> +            }
>>           }
>>       }
>>   }
>
>
> Applied.
>
> Thanks
>
>

Speak too fast. Some questions:

1) Any reason that you do such check or get_config() instead of doing it 
once in device initalization
2) the indentation looks wrong
3) There's no need for an error here since we can workaround it

Thanks


