Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 02:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85A9206B6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 02:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOFYCQhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85A9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrBeQ-0007mo-4w
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 22:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jrBdr-0007M4-Iq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 22:41:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jrBdo-0005ru-Sp
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 22:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593744087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WVRhBo900EyrgNREuLh0mRosY73v09yxBshshJTVbp4=;
 b=hOFYCQhV2mMND7SK7U/+TQ8IlY62Hjnc5YAW+zOjfUTpknQPDjimZ3cv4c+/x3MJHgQJLZ
 IF3uhlj8C6QIikEgjlSO2iHvxEa7oFmvg6EHwazWhOjXp8vfdp9KhndxWdhlHli0Uywtcq
 TIUnB8ppjjLWJrgzULKcUcC/UsyWxzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-aY709FJLP4O0gSCF2znJMA-1; Thu, 02 Jul 2020 22:41:23 -0400
X-MC-Unique: aY709FJLP4O0gSCF2znJMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56472107ACCA;
 Fri,  3 Jul 2020 02:41:22 +0000 (UTC)
Received: from [10.72.13.231] (ovpn-13-231.pek2.redhat.com [10.72.13.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9CF75C1D0;
 Fri,  3 Jul 2020 02:41:20 +0000 (UTC)
Subject: Re: Question about virtio-net: implement RX RSS processing
To: Vincent Li <vincent.mc.li@gmail.com>, qemu-devel@nongnu.org
References: <alpine.OSX.2.21.2007020914350.260@sea-ml-00029224.olympus.f5net.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6657ac45-383a-4654-d5d4-be76a8fcfdfa@redhat.com>
Date: Fri, 3 Jul 2020 10:41:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.OSX.2.21.2007020914350.260@sea-ml-00029224.olympus.f5net.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 22:41:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/3 上午1:07, Vincent Li wrote:
> Hi,
>
> I noticed the [PULL V2 02/33] virtio-net: implement RX RSS processing
> https://marc.info/?l=qemu-devel&m=159248675403246&w=2 and cloned
> https://github.com/jasowang/qemu.git tags/net-pull-request for testing the
> RX RSS feature, but I am not clear how to test this feature and see if it
> meets my needs.


Yuri may know more but I think the only driver that supports RSS is 
Windows driver currently.


>
> I am running F-Stack Nginx applications
> https://github.com/F-Stack/f-stack/tree/dev/app/nginx-1.16.1 in KVM guest,
> F-Stack is FreeBSD TCP/IP stack ported to support DPDK, and F-Stack set
> RSS mode as code below
> https://github.com/F-Stack/f-stack/blob/dev/lib/ff_dpdk_if.c#L605
>
>       /* Set RSS mode */
>       uint64_t default_rss_hf = ETH_RSS_PROTO_MASK;
>       port_conf.rxmode.mq_mode = ETH_MQ_RX_RSS;
>       port_conf.rx_adv_conf.rss_conf.rss_hf = default_rss_hf;
>       if (dev_info.hash_key_size == 52) {
>           port_conf.rx_adv_conf.rss_conf.rss_key = default_rsskey_52bytes;
>           port_conf.rx_adv_conf.rss_conf.rss_key_len = 52;
>           use_rsskey_52bytes = 1;
>       } else {
>           port_conf.rx_adv_conf.rss_conf.rss_key = default_rsskey_40bytes;
>           port_conf.rx_adv_conf.rss_conf.rss_key_len = 40;
>       }
>       port_conf.rx_adv_conf.rss_conf.rss_hf &= dev_info.flow_type_rss_offloads;
>       if (port_conf.rx_adv_conf.rss_conf.rss_hf != ETH_RSS_PROTO_MASK) {
>           printf("Port %u modified RSS hash function based on hardware support,"
>           "requested:%#"PRIx64" configured:%#"PRIx64"\n",
>           port_id, default_rss_hf, port_conf.rx_adv_conf.rss_conf.rss_hf);
>       }
>
> But  DPDK virtio PMD does not support RSS as below commit shows:
>
> commit 13b3137f3b7c8f866947a9b34e06a8aec0d084f7
> Author: Dilshod Urazov
> Date:   Wed Oct 9 13:32:07 2019 +0100
>
>      net/virtio: reject unsupported Rx multi-queue modes
>      
>      This driver supports none of DCB, RSS or VMDQ modes, therefore must
>      check and return error if configured incorrectly.
>      
>      Virtio can distribute Rx packets across multi-queue, but there is
>      no controls (algorithm, redirection table, hash function) except
>      number of Rx queues and ETH_MQ_RX_NONE is the best fit meaning
>      no method is enforced on how to route packets to MQs.
>      
>      Fixes: c1f86306a026 ("virtio: add new driver")
>      Cc: stable@dpdk.org
>      
>      Signed-off-by: Dilshod Urazov
>      Signed-off-by: Andrew Rybchenko
>      Reviewed-by: Maxime Coquelin
>
> diff --git a/drivers/net/virtio/virtio_ethdev.c
>             b/drivers/net/virtio/virtio_ethdev.c
> index 0a2ed2e50..76bd40a3e 100644
> --- a/drivers/net/virtio/virtio_ethdev.c
> +++ b/drivers/net/virtio/virtio_ethdev.c
> @@ -2066,6 +2066,13 @@ virtio_dev_configure(struct rte_eth_dev *dev)
>          PMD_INIT_LOG(DEBUG, "configure");
>          req_features = VIRTIO_PMD_DEFAULT_GUEST_FEATURES;
>   
> +       if (rxmode->mq_mode != ETH_MQ_RX_NONE) {
> +               PMD_DRV_LOG(ERR,
> +                       "Unsupported Rx multi queue mode %d",
> +                       rxmode->mq_mode);
> +               return -EINVAL;
> +       }
> +
>          if (dev->data->dev_conf.intr_conf.rxq) {
>                  ret = virtio_init_device(dev, hw->req_guest_features);
>                  if (ret < 0)
>
>
>
> So the problem is I can't run F-Stack Applications in KVM/Qemu guest with
> multi queue/vCPU/RSS  support, this problem seems apply to DPDK TCP
> applications require multi queue/RSS support in KVM/Qemu guest, for
> example mTCP https://github.com/mtcp-stack/mtcp I tested has similar
> problem.
>
> I am not clear on the picture of how everything work together for  this
> virtio-net RSS feature.
>
> I have read following blogs
>
> https://www.redhat.com/en/blog/introduction-virtio-networking-and-vhost-net
> https://www.redhat.com/en/blog/how-vhost-user-came-being-virtio-networking-and-dpdk
>
> Someone told me that in order for DPDK frond end virtio PMD in guest support RSS, the backend
> also needs to support RSS, including vhost-net and vhost-user, it should
> have nothing to do with this Qemu virtio-net RSS, is that correct?  if
> correct, I have following questions:
>
> 1, What is the use case for this Qemu virtio-net RSS?


It's just RSS as what other device can provide for steering or balancing.


> 2, How to test the use case?


Need use windows guest.


> 3, Are there any plan to improve vhost-net/vhost-user, DPDK virtio PMD to support RSS?


For vhost-net, Sameeh posted a eBPF based solution RFC[1], we need some 
one to carry on the work. It doesn't request any extension to vhost-net 
thanks to the steering eBPF support in tuntap.

For vhost-user, we need probably extend vhost-user protocols first.

You're welcome to contribute patches.

[1] https://patchwork.kernel.org/cover/10581921/

Thanks


>
> For 3,  I think this is important for KVM/Qemu/OVS-DPDK/Vhost-net environment for DPDK TCP/UDP applications.
>
> Note I have no problem running F-Stack or mTCP applications in VMware ESXi
> guest environment with multi queue/vCPU/RSS requirement since DPDK vmxnet3
> PMD support RSS and I assume VMware ESXi backend support RSS, so it looks VMware has
> advantage over this.
>
> Thank you for your patience to read this email
>
> Regards,
>
> Vincent
>


