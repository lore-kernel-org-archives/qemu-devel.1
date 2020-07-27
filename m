Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13533C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD5D2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnwPMr8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD5D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k00Je-0000Av-N2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k00H4-0005bt-N4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:22:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k00H0-0004jC-3U
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595845341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXUoc73tFVeWY96IQhCmu3WbzbPbhMePM1FSz1Ifw2Q=;
 b=QnwPMr8VVzMB2q7lROlfOltDiLwXpjTXD145bSfbLmKTEku4gAIgrMq5DA7H9NZAdmNisH
 ezYS/jKxbpB5ltQTxYD1BSEO0UwHPcyq3p9+TntCDTw08B5ypWuMqyLU6KFqLbeE8QYQtG
 x1gUNPD+ngmoS4Go983Tt1eHJ2jqxNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-LVlLX7A8NUa7xR7h3JflOA-1; Mon, 27 Jul 2020 06:22:19 -0400
X-MC-Unique: LVlLX7A8NUa7xR7h3JflOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44AE1101C8A9
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 10:22:18 +0000 (UTC)
Received: from [10.72.12.200] (ovpn-12-200.pek2.redhat.com [10.72.12.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A02CE5FC30;
 Mon, 27 Jul 2020 10:22:13 +0000 (UTC)
Subject: Re: [PATCH] virtio-net: check the existence of peer before accesing
 its config
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200727074328.2279-1-jasowang@redhat.com>
 <20200727053954-mutt-send-email-mst@kernel.org>
 <b5a42ac8-b3cf-d52e-298a-d957a9e8cb1d@redhat.com>
 <20200727061623-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aa270a81-0127-e1cb-4f67-c9fff3539f2b@redhat.com>
Date: Mon, 27 Jul 2020 18:22:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727061623-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/27 下午6:17, Michael S. Tsirkin wrote:
> On Mon, Jul 27, 2020 at 05:49:47PM +0800, Jason Wang wrote:
>> On 2020/7/27 下午5:41, Michael S. Tsirkin wrote:
>>> On Mon, Jul 27, 2020 at 03:43:28PM +0800, Jason Wang wrote:
>>>> We try to get config from peer unconditionally which may lead NULL
>>>> pointer dereference. Add a check before trying to access the config.
>>>>
>>>> Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
>>>> Cc: Cindy Lu <lulu@redhat.com>
>>>> Tested-by: Cornelia Huck <cohuck@redhat.com>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> I am a bit lost here. Isn't this invoked
>>> when guest attempts to read the config?
>>> With no peer, what do we return to guest?
>>
>> With no peer, it just work as in the past (read from the qemu's own emulated
>> config space). With a vDPA as its peer, it tries to read it from vhost-vDPA.
> Are these scenarios where guest would sometimes get one and
> sometimes another? E.g. does it happen on disconnect?
> If yes that might become a problem ...


For disconnecting yes, but I wonder if we need to care about that case 
anyway.

Thanks


>
>>> A code comment might be helpful here.
>>
>> Does something like above help?
>>
>> Thanks
>>
>>
>>>> ---
>>>>    hw/net/virtio-net.c | 22 +++++++++++-----------
>>>>    1 file changed, 11 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>> index 4895af1cbe..935b9ef5c7 100644
>>>> --- a/hw/net/virtio-net.c
>>>> +++ b/hw/net/virtio-net.c
>>>> @@ -125,6 +125,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>>>>    {
>>>>        VirtIONet *n = VIRTIO_NET(vdev);
>>>>        struct virtio_net_config netcfg;
>>>> +    NetClientState *nc = qemu_get_queue(n->nic);
>>>>        int ret = 0;
>>>>        memset(&netcfg, 0 , sizeof(struct virtio_net_config));
>>>> @@ -142,13 +143,12 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>>>>                     VIRTIO_NET_RSS_SUPPORTED_HASHES);
>>>>        memcpy(config, &netcfg, n->config_size);
>>>> -    NetClientState *nc = qemu_get_queue(n->nic);
>>>> -    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>>>> +    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>>>>            ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
>>>> -                             n->config_size);
>>>> -    if (ret != -1) {
>>>> -        memcpy(config, &netcfg, n->config_size);
>>>> -    }
>>>> +                                   n->config_size);
>>>> +        if (ret != -1) {
>>>> +            memcpy(config, &netcfg, n->config_size);
>>>> +        }
>>>>        }
>>>>    }
>>>> @@ -156,6 +156,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
>>>>    {
>>>>        VirtIONet *n = VIRTIO_NET(vdev);
>>>>        struct virtio_net_config netcfg = {};
>>>> +    NetClientState *nc = qemu_get_queue(n->nic);
>>>>        memcpy(&netcfg, config, n->config_size);
>>>> @@ -166,11 +167,10 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
>>>>            qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
>>>>        }
>>>> -    NetClientState *nc = qemu_get_queue(n->nic);
>>>> -    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>>>> -        vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
>>>> -                               0, n->config_size,
>>>> -                        VHOST_SET_CONFIG_TYPE_MASTER);
>>>> +    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>>>> +        vhost_net_set_config(get_vhost_net(nc->peer),
>>>> +                             (uint8_t *)&netcfg, 0, n->config_size,
>>>> +                             VHOST_SET_CONFIG_TYPE_MASTER);
>>>>          }
>>>>    }
>>>> -- 
>>>> 2.20.1


