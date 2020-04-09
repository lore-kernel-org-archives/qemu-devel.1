Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5741C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 03:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57562087E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 03:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrWm1r/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57562087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMNgT-00071N-BY
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 23:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jMNfW-0006bS-Qr
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 23:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jMNfU-0004x3-2B
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 23:15:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34208
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jMNfS-0004vD-Sc
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 23:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586402149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YH08NYBxXydmwAYFpeth79et4ChRtTA7yv/IWL5RpQ=;
 b=HrWm1r/S8hfoBiX+FtVjOuJzzQ81oEaNZUFyFxQsmNSLkiYnuiXGt63UkMN3i3X7UmO/tH
 DzCGuweies1PBywbZkAA8ERjH86qsUwPkNKMYUnf/N6/5cIJc7+96fc5MkMFXt5tp3SBcU
 4kZfHf8fUSMlcB5VyUykMA4xRHtcqhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-cBHlQCCBNZ6CTtkI8oZtsw-1; Wed, 08 Apr 2020 23:15:47 -0400
X-MC-Unique: cBHlQCCBNZ6CTtkI8oZtsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 243408017F5;
 Thu,  9 Apr 2020 03:15:46 +0000 (UTC)
Received: from [10.72.13.188] (ovpn-13-188.pek2.redhat.com [10.72.13.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7323AC0D9E;
 Thu,  9 Apr 2020 03:15:44 +0000 (UTC)
Subject: Re: [PATCH] Fixed IPv6 payload lenght without jumbo option
To: andrew@daynix.com, qemu-devel@nongnu.org
References: <20200405191940.866972-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e756b1b3-2346-822c-974c-79c40970c09d@redhat.com>
Date: Thu, 9 Apr 2020 11:15:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200405191940.866972-1-andrew@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/6 =E4=B8=8A=E5=8D=883:19, andrew@daynix.com wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1708065
> e1000e driver doesn't sets 'plen' field for IPv6 for big packets
> if TSO is enabled. Jumbo option isn't added yet, until
> qemu supports packets greater than 64K.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   hw/net/e1000e_core.c |  1 +
>   hw/net/net_tx_pkt.c  | 31 +++++++++++++++++++++++++++++++
>   hw/net/net_tx_pkt.h  |  7 +++++++
>   include/net/eth.h    |  1 +
>   4 files changed, 40 insertions(+)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index d5676871fa..a1ec55598b 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -656,6 +656,7 @@ e1000e_tx_pkt_send(E1000ECore *core, struct e1000e_tx=
 *tx, int queue_index)
>       NetClientState *queue =3D qemu_get_subqueue(core->owner_nic, target=
_queue);
>  =20
>       e1000e_setup_tx_offloads(core, tx);
> +    net_tx_pkt_fix_ip6_payload_len(tx->tx_pkt);


A question here:

I don't see any code that set ip6_plen during=20
net_tx_pkt_do_sw_fragmentation(). This is described in 7.3.6.2.1 and=20
7.3.6.2.2 in the datasheet.

And:

1) eth_setup_ip4_fragmentation() only deal with ipv4

2) eth_fix_ip4_checksum() assumes a ipv4 header

Do we support ipv6 segmentation then?

Thanks


>  =20
>       net_tx_pkt_dump(tx->tx_pkt);
>  =20
> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> index 162f802dd7..b05d554ac3 100644
> --- a/hw/net/net_tx_pkt.c
> +++ b/hw/net/net_tx_pkt.c
> @@ -635,3 +635,34 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pkt, =
NetClientState *nc)
>  =20
>       return res;
>   }
> +
> +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)
> +{
> +    /*
> +     * If ipv6 payload length field is 0 - then there should be Hop-by-H=
op
> +     * option for packets greater than 65,535.
> +     * For packets with payload less than 65,535: fix 'plen' field.
> +     * For now, qemu drops every packet with size greater 64K
> +     * (see net_tx_pkt_send()) so, there is no reason to add jumbo optio=
n to ip6
> +     * hop-by-hop extension if it's missed
> +     */
> +
> +    struct iovec *l2 =3D &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
> +    if (eth_get_l3_proto(l2, 1, l2->iov_len) =3D=3D ETH_P_IPV6) {
> +        struct ip6_header *ip6 =3D (struct ip6_header *) pkt->l3_hdr;
> +        /*
> +         * TODO: if qemu would support >64K packets - add jumbo option c=
heck
> +         * something like that:
> +         * 'if (ip6->ip6_plen =3D=3D 0 && !has_jumbo_option(ip6)) {'
> +         */
> +        if (ip6->ip6_plen =3D=3D 0) {
> +            if (pkt->payload_len <=3D ETH_MAX_IP_DGRAM_LEN) {
> +                ip6->ip6_plen =3D htons(pkt->payload_len);
> +            }
> +            /*
> +             * TODO: if qemu would support >64K packets
> +             * add jumbo option for packets greater then 65,535 bytes
> +             */
> +        }
> +    }
> +}
> diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
> index 212ecc62fc..912d56ef13 100644
> --- a/hw/net/net_tx_pkt.h
> +++ b/hw/net/net_tx_pkt.h
> @@ -187,4 +187,11 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);
>   */
>   bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);
>  =20
> +/**
> + * Fix IPv6 'plen' field.
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
>  =20
>   #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
>   #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
> +#define ip6_plen     ip6_ctlun.ip6_un1.ip6_un1_plen
>  =20
>   #define PKT_GET_ETH_HDR(p)        \
>       ((struct eth_header *)(p))


