Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A39AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46921206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCFpNcTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46921206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjSs-00052z-Ey
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jsjSE-0004a0-DT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:59:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jsjSB-0005lC-In
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594112389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQNnxYUwWcFhsVJAO9piNGnCmERMhTsQvjpoKirFL00=;
 b=OCFpNcTCNAQ72DILdKWW+tb/GYr3H6ZuOLwoJSWOInXL6G3Qet/4TE9aBYWJ1YoebVxcOk
 lDxjYxVpCsy5dPs45OlDspaXjjkIrCDBil2assxXpZmtGK6w2ybRJdlJ0x1YoAhh7W2ZTa
 bGdAcPccEZN8P2x+FU/dp0XQ6g9faLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-QY43pLxnMoal4J2p8DKIpQ-1; Tue, 07 Jul 2020 04:59:45 -0400
X-MC-Unique: QY43pLxnMoal4J2p8DKIpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF4C61940921;
 Tue,  7 Jul 2020 08:59:44 +0000 (UTC)
Received: from [10.72.13.254] (ovpn-13-254.pek2.redhat.com [10.72.13.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86E015C662;
 Tue,  7 Jul 2020 08:59:43 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] hw/net: Added CSO for IPv6
To: andrew@daynix.com, qemu-devel@nongnu.org
References: <20200629011800.374914-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d8d5cc6c-0009-bb04-4057-9b45523cc251@redhat.com>
Date: Tue, 7 Jul 2020 16:59:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629011800.374914-1-andrew@daynix.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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


On 2020/6/29 上午9:17, andrew@daynix.com wrote:
> From: Andrew <andrew@daynix.com>
>
> Added fix for checksum offload for IPv6 if a backend doesn't
> have a virtual header.
> This patch is a part of IPv6 fragmentation.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>


Applied.

Thanks


> ---
>   hw/net/net_tx_pkt.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 162f802dd7..331c73cfc0 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -468,8 +468,8 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt *pkt)
>       /* num of iovec without vhdr */
>       uint32_t iov_len = pkt->payload_frags + NET_TX_PKT_PL_START_FRAG - 1;
>       uint16_t csl;
> -    struct ip_header *iphdr;
>       size_t csum_offset = pkt->virt_hdr.csum_start + pkt->virt_hdr.csum_offset;
> +    uint16_t l3_proto = eth_get_l3_proto(iov, 1, iov->iov_len);
>   
>       /* Put zero to checksum field */
>       iov_from_buf(iov, iov_len, csum_offset, &csum, sizeof csum);
> @@ -477,9 +477,18 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt *pkt)
>       /* Calculate L4 TCP/UDP checksum */
>       csl = pkt->payload_len;
>   
> +    csum_cntr = 0;
> +    cso = 0;
>       /* add pseudo header to csum */
> -    iphdr = pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base;
> -    csum_cntr = eth_calc_ip4_pseudo_hdr_csum(iphdr, csl, &cso);
> +    if (l3_proto == ETH_P_IP) {
> +        csum_cntr = eth_calc_ip4_pseudo_hdr_csum(
> +                pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base,
> +                csl, &cso);
> +    } else if (l3_proto == ETH_P_IPV6) {
> +        csum_cntr = eth_calc_ip6_pseudo_hdr_csum(
> +                pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base,
> +                csl, pkt->l4proto, &cso);
> +    }
>   
>       /* data checksum */
>       csum_cntr +=


