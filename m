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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD63C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6532071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFJmNxgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6532071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJb0-0000Rw-Sy
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwJVA-0007I6-MD
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:05:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34393
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwJV8-0005uD-NE
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594965942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u13KSSj8DMN1VZuU1tnx2IE6TiDfbcI5cNTd5BwL1mA=;
 b=LFJmNxgCaHt2XBiDW8JcdlDm3gCxrco3Ds3ISbQf3roF3SrvrBYtIL65j73wqfItClKQX5
 9lnjG2mWPPRcnpwMncMulu7Iu+GRpWBLLirv8gWgbFcD3vmnEOsIEkYkTxsSEAQJh4XhSR
 ktFfKSdFhI7tY+HKADdkh+IwSkLIZOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-m2M7x2ifNT6l2LhysyCFKw-1; Fri, 17 Jul 2020 02:05:39 -0400
X-MC-Unique: m2M7x2ifNT6l2LhysyCFKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21E7A8015F7;
 Fri, 17 Jul 2020 06:05:38 +0000 (UTC)
Received: from [10.72.12.157] (ovpn-12-157.pek2.redhat.com [10.72.12.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9589E72AE8;
 Fri, 17 Jul 2020 06:05:15 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] hw/net: Added basic IPv6 software fragmentation
To: andrew@daynix.com, qemu-devel@nongnu.org
References: <20200716035325.1406919-1-andrew@daynix.com>
 <20200716035325.1406919-2-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a7764ed2-0fdb-39bd-55ba-eb308ea4b36e@redhat.com>
Date: Fri, 17 Jul 2020 14:05:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716035325.1406919-2-andrew@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> The basic IPv6 fragmentation - adding 'frag' extension to
> the packet, overall shares some logic with IPv4. It works,
> but there are still issues with a combination of
> extensions - in the future, it would require refactoring
> work to implement workflow with IPv6 and extension.
> "Jumbo option" isn't added yet, until
> qemu supports packets greater than 64K.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>


Queued for 5.2

Thanks


> ---
>   hw/net/net_tx_pkt.c |  7 ++--
>   include/net/eth.h   | 14 +++++--
>   net/eth.c           | 99 ++++++++++++++++++++++++++++++++++++++++++---
>   3 files changed, 109 insertions(+), 11 deletions(-)
>
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 9560e4a49e..74044c6618 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -589,10 +589,11 @@ static bool net_tx_pkt_do_sw_fragmentation(struct NetTxPkt *pkt,
>   
>           more_frags = (fragment_offset + fragment_len < pkt->payload_len);
>   
> -        eth_setup_ip4_fragmentation(l2_iov_base, l2_iov_len, l3_iov_base,
> -            l3_iov_len, fragment_len, fragment_offset, more_frags);
> +        eth_setup_ip_fragmentation(l2_iov_base, l2_iov_len, l3_iov_base,
> +            &l3_iov_len, ETH_MAX_IP_DGRAM_LEN,
> +            fragment_len, fragment_offset, more_frags);
>   
> -        eth_fix_ip4_checksum(l3_iov_base, l3_iov_len);
> +        fragment[NET_TX_PKT_FRAGMENT_L3_HDR_POS].iov_len = l3_iov_len;
>   
>           net_tx_pkt_sendv(pkt, nc, fragment, dst_idx);
>   
> diff --git a/include/net/eth.h b/include/net/eth.h
> index 0671be6916..05c75ac9fc 100644
> --- a/include/net/eth.h
> +++ b/include/net/eth.h
> @@ -139,6 +139,14 @@ struct ip6_ext_hdr_routing {
>       uint8_t     rsvd[4];
>   };
>   
> +struct ip6_ext_hdr_fragment {
> +    uint8_t     nxt;
> +    uint8_t     res0;
> +    uint16_t    off;
> +    uint32_t    id;
> +};
> +
> +
>   struct ip6_option_hdr {
>   #define IP6_OPT_PAD1   (0x00)
>   #define IP6_OPT_HOME   (0xC9)
> @@ -399,9 +407,9 @@ void eth_get_protocols(const struct iovec *iov, int iovcnt,
>                          eth_ip4_hdr_info *ip4hdr_info,
>                          eth_l4_hdr_info  *l4hdr_info);
>   
> -void eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
> -                                 void *l3hdr, size_t l3hdr_len,
> -                                 size_t l3payload_len,
> +void eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,
> +                                 void *l3hdr, size_t *l3hdr_len,
> +                                 size_t l3hdr_max_len, size_t l3payload_len,
>                                    size_t frag_offset, bool more_frags);
>   
>   void
> diff --git a/net/eth.c b/net/eth.c
> index 0c1d413ee2..067111526d 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -314,10 +314,65 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
>       return 0;
>   }
>   
> +static bool eth_is_ip6_extension_header_type(uint8_t hdr_type);
> +
> +static void *eth_ip6_find_ext(struct ip6_header *ip6, uint8_t ext_type)
> +{
> +    uint8_t curr_ext_hdr_type = ip6->ip6_nxt;
> +    struct ip6_ext_hdr *ext_hdr = (struct ip6_ext_hdr *)(ip6 + 1);
> +    for (; eth_is_ip6_extension_header_type(curr_ext_hdr_type);) {
> +        if (curr_ext_hdr_type == ext_type) {
> +            return ext_hdr;
> +        }
> +        curr_ext_hdr_type = ext_hdr->ip6r_nxt;
> +        ext_hdr = (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
> +                + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
> +    }
> +
> +    return NULL;
> +}
> +
> +/*
> + * To add an extension - there is should be
> + * enough memory 'behind' the ip6 header.
> + */
> +static void *eth_ip6_add_ext_nonsafe(struct ip6_header *ip6, uint8_t ext_type)
> +{
> +    uint8_t curr_ext_hdr_type = ip6->ip6_nxt;
> +    struct ip6_ext_hdr *ext_hdr = (struct ip6_ext_hdr *)(ip6 + 1);
> +    struct ip6_ext_hdr *ext_hdr_prev = NULL;
> +
> +    if (!eth_is_ip6_extension_header_type(curr_ext_hdr_type)) {
> +        ext_hdr->ip6r_nxt = ip6->ip6_nxt;
> +        ip6->ip6_nxt = ext_type;
> +        return ext_hdr;
> +    }
> +
> +    ext_hdr_prev = ext_hdr;
> +    curr_ext_hdr_type = ext_hdr->ip6r_nxt;
> +    ext_hdr = (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
> +            + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
> +
> +    for (; eth_is_ip6_extension_header_type(curr_ext_hdr_type);) {
> +        ext_hdr_prev = ext_hdr;
> +        curr_ext_hdr_type = ext_hdr->ip6r_nxt;
> +        ext_hdr = (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
> +                + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
> +    }
> +
> +    ext_hdr->ip6r_nxt = ext_hdr_prev->ip6r_nxt;
> +    ext_hdr_prev->ip6r_nxt = ext_type;
> +
> +    return ext_hdr;
> +}
> +
> +/* When IP6_FRAGMENT added, first 'id' would be 0x71656d75 */
> +static const uint32_t s_first_fragment_identificator = 0x71656d75; /* 'qemu' */
> +
>   void
> -eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
> -                            void *l3hdr, size_t l3hdr_len,
> -                            size_t l3payload_len,
> +eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,
> +                            void *l3hdr, size_t *l3hdr_len,
> +                            size_t l3hdr_max_len, size_t l3payload_len,
>                               size_t frag_offset, bool more_frags)
>   {
>       const struct iovec l2vec = {
> @@ -325,7 +380,9 @@ eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
>           .iov_len = l2hdr_len
>       };
>   
> -    if (eth_get_l3_proto(&l2vec, 1, l2hdr_len) == ETH_P_IP) {
> +    uint16_t l3_proto = eth_get_l3_proto(&l2vec, 1, l2hdr_len);
> +
> +    if (l3_proto == ETH_P_IP) {
>           uint16_t orig_flags;
>           struct ip_header *iphdr = (struct ip_header *) l3hdr;
>           uint16_t frag_off_units = frag_offset / IP_FRAG_UNIT_SIZE;
> @@ -337,7 +394,39 @@ eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
>           orig_flags = be16_to_cpu(iphdr->ip_off) & ~(IP_OFFMASK|IP_MF);
>           new_ip_off = frag_off_units | orig_flags  | (more_frags ? IP_MF : 0);
>           iphdr->ip_off = cpu_to_be16(new_ip_off);
> -        iphdr->ip_len = cpu_to_be16(l3payload_len + l3hdr_len);
> +        iphdr->ip_len = cpu_to_be16(l3payload_len + *l3hdr_len);
> +
> +        eth_fix_ip4_checksum(l3hdr, *l3hdr_len);
> +    } else if (l3_proto == ETH_P_IPV6) {
> +        struct ip6_header *ip6 = (struct ip6_header *) l3hdr;
> +
> +        struct ip6_ext_hdr_fragment *frag_ext = NULL;
> +
> +        /* Find frag extension */
> +        frag_ext = eth_ip6_find_ext(ip6, IP6_FRAGMENT);
> +        if (frag_ext == NULL) {
> +            /* No frag extension? Add one */
> +            if (*l3hdr_len + sizeof(*frag_ext) > l3hdr_max_len) {
> +                /*
> +                 * TODO:
> +                 * For now, qemu's L3 buffer allocated with NetTxPkt
> +                 * and have enough memory(buffer allocated with 65K bytes
> +                 * ETH_MAX_IP_DGRAM_LEN = 0xFFFF)
> +                 * for additional extensions.
> +                 */
> +                return; /* TODO: request to reallocate l3hdr */
> +            }
> +            frag_ext = eth_ip6_add_ext_nonsafe(ip6, IP6_FRAGMENT);
> +            *l3hdr_len += sizeof(*frag_ext);
> +            static uint32_t s_id = s_first_fragment_identificator;
> +            frag_ext->id = cpu_to_be32(s_id);
> +            ++s_id;
> +        }
> +
> +        frag_ext->off = cpu_to_be16((frag_offset / IP_FRAG_UNIT_SIZE) << 3
> +                | (uint16_t)!!more_frags);
> +
> +        ip6->ip6_plen = cpu_to_be16(l3payload_len + *l3hdr_len - sizeof(*ip6));
>       }
>   }
>   


