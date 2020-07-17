Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC57C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777052071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTTogYwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777052071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJeD-00052P-Pw
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwJUO-0005r7-VT
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:04:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48770
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwJUM-0005cr-O9
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594965893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wDiI8gjzfFR2g2TdZ5YgFhUb76DqDX6PF5v7lBGCOOw=;
 b=iTTogYwEZYyxLNgttyMmaGBI0rG4LdwWMyhJ4FRfvbM8MqpbHsVrCGmxoL/SLJ8u9jej5q
 g4/x03JMx5KS9eJbkppZ6BhAxpXrP+jms4/8UPl9duEmGESldGVGsKUK7kIo6+gN1dl5Mt
 KXxWJLN/NbtHbg+3EPJf+X/l92dFwR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-7F4Nsz0OPZWqltkzXVAxjg-1; Fri, 17 Jul 2020 02:04:41 -0400
X-MC-Unique: 7F4Nsz0OPZWqltkzXVAxjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8145100AA25;
 Fri, 17 Jul 2020 06:04:40 +0000 (UTC)
Received: from [10.72.12.157] (ovpn-12-157.pek2.redhat.com [10.72.12.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAFFD6FED1;
 Fri, 17 Jul 2020 06:04:36 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] hw/net: Added plen fix for IPv6
To: andrew@daynix.com, qemu-devel@nongnu.org
References: <20200716035325.1406919-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cfc9b141-20f6-bf69-5819-48ddd3a8dd42@redhat.com>
Date: Fri, 17 Jul 2020 14:04:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716035325.1406919-1-andrew@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:06:45
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
Cc: dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/16 上午11:53, andrew@daynix.com wrote:
> From: Andrew <andrew@daynix.com>
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1708065
> With network backend with 'virtual header' - there was an issue
> in 'plen' field. Overall, during TSO, 'plen' would be changed,
> but with 'vheader' this field should be set to the size of the
> payload itself instead of '0'.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>


Applied.

Thanks


> ---
>   hw/net/net_tx_pkt.c | 23 +++++++++++++++++++++++
>   hw/net/net_tx_pkt.h | 14 ++++++++++++++
>   include/net/eth.h   |  1 +
>   3 files changed, 38 insertions(+)
>
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 331c73cfc0..9560e4a49e 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -626,6 +626,7 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
>   
>       if (pkt->has_virt_hdr ||
>           pkt->virt_hdr.gso_type == VIRTIO_NET_HDR_GSO_NONE) {
> +        net_tx_pkt_fix_ip6_payload_len(pkt);
>           net_tx_pkt_sendv(pkt, nc, pkt->vec,
>               pkt->payload_frags + NET_TX_PKT_PL_START_FRAG);
>           return true;
> @@ -644,3 +645,25 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pkt, NetClientState *nc)
>   
>       return res;
>   }
> +
> +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)
> +{
> +    struct iovec *l2 = &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
> +    if (eth_get_l3_proto(l2, 1, l2->iov_len) == ETH_P_IPV6) {
> +        struct ip6_header *ip6 = (struct ip6_header *) pkt->l3_hdr;
> +        /*
> +         * TODO: if qemu would support >64K packets - add jumbo option check
> +         * something like that:
> +         * 'if (ip6->ip6_plen == 0 && !has_jumbo_option(ip6)) {'
> +         */
> +        if (ip6->ip6_plen == 0) {
> +            if (pkt->payload_len <= ETH_MAX_IP_DGRAM_LEN) {
> +                ip6->ip6_plen = htons(pkt->payload_len);
> +            }
> +            /*
> +             * TODO: if qemu would support >64K packets
> +             * add jumbo option for packets greater then 65,535 bytes
> +             */
> +        }
> +    }
> +}
> diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
> index 212ecc62fc..4ec8bbe9bd 100644
> --- a/hw/net/net_tx_pkt.h
> +++ b/hw/net/net_tx_pkt.h
> @@ -187,4 +187,18 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);
>   */
>   bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);
>   
> +/**
> + * Fix IPv6 'plen' field.
> + * If ipv6 payload length field is 0 - then there should be Hop-by-Hop
> + * option for packets greater than 65,535.
> + * For packets with a payload less than 65,535: fix 'plen' field.
> + * For backends with vheader, we need just one packet with proper
> + * payload size. For now, qemu drops every packet with size greater 64K
> + * (see net_tx_pkt_send()) so, there is no reason to add jumbo option to ip6
> + * hop-by-hop extension if it's missed
> + *
> + * @pkt            packet
> + */
> +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);
> +
>   #endif
> diff --git a/include/net/eth.h b/include/net/eth.h
> index 7f45c678e7..0671be6916 100644
> --- a/include/net/eth.h
> +++ b/include/net/eth.h
> @@ -186,6 +186,7 @@ struct tcp_hdr {
>   
>   #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
>   #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
> +#define ip6_plen     ip6_ctlun.ip6_un1.ip6_un1_plen
>   
>   #define PKT_GET_ETH_HDR(p)        \
>       ((struct eth_header *)(p))


