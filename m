Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8871C2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 02:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A100020936
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 02:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoUfKw/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A100020936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMjPs-0001Sy-Ny
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 22:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jMjPE-0000sv-F0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 22:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jMjPC-0007AA-5n
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 22:28:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jMjPC-00078f-1Z
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 22:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586485709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/2kjQl9xc9EJHaqeRFDW38zT6egICV8eD6sLfEQV7o=;
 b=FoUfKw/fOeUyBeCDsFgF+LCyJInwVXMaJrpY1MW2nVx0li00mtYZsx++fHjYC+g4IwL7PS
 qMDG52lKxTscJ6sTDalgW4fwSCKhhotWLWl3mkPXDydeMIeJHQFVuRZkzH+Au65GR4jiqy
 F3f6To2tib2uHUCiH26Mi3ZQQt8tXww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-UA2ss31RN-KixFQIr42mRg-1; Thu, 09 Apr 2020 22:28:26 -0400
X-MC-Unique: UA2ss31RN-KixFQIr42mRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73E7D1412;
 Fri, 10 Apr 2020 02:28:25 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE5CB396;
 Fri, 10 Apr 2020 02:28:23 +0000 (UTC)
Subject: Re: [PATCH] Fixed IPv6 payload lenght without jumbo option
To: Andrew Melnichenko <andrew@daynix.com>
References: <20200405191940.866972-1-andrew@daynix.com>
 <e756b1b3-2346-822c-974c-79c40970c09d@redhat.com>
 <CABcq3pFMaRSj6TD8NQMbeqFXe8zqUVJQcuv9bTD=Qi8SfiYuQg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5160b387-3068-cdd8-e47c-5c449319b05e@redhat.com>
Date: Fri, 10 Apr 2020 10:28:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABcq3pFMaRSj6TD8NQMbeqFXe8zqUVJQcuv9bTD=Qi8SfiYuQg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: dmitry.fleytman@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/9 =E4=B8=8B=E5=8D=889:35, Andrew Melnichenko wrote:
> > Do we support ipv6 segmentation then?
> No, but - if the backend supports big frames there is an issue that=20
> IPv6 plen doesn't have valid value.
> Actually, It's a good idea to add IPv6 fragmentation - I would do it=20
> later.


Right, another question.

E.g for virtio-net, we will do the following check:

 =C2=A0=C2=A0=C2=A0 if (!peer_has_vnet_hdr(n)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&features,=
 VIRTIO_NET_F_CSUM);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&features,=
 VIRTIO_NET_F_HOST_TSO4);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&features,=
 VIRTIO_NET_F_HOST_TSO6);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&features,=
 VIRTIO_NET_F_HOST_ECN);

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&features,=
 VIRTIO_NET_F_GUEST_CSUM);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&features,=
 VIRTIO_NET_F_GUEST_TSO4);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&features,=
 VIRTIO_NET_F_GUEST_TSO6);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&features,=
 VIRTIO_NET_F_GUEST_ECN);
 =C2=A0=C2=A0=C2=A0 }

I think we should do something similar in e1000e. But I can only see=20
disable_vnet parameter but not a checking of the ability of its peer.

1) when peer has vnet hdr, it supports receiving GSO packets, we don't=20
need software segmentation.
2) when peer does not have vnet hdr, we need to use software path=20
segmentation.

This means we need:

1) check peer_has_vnet_hdr() and disable_vnet in net_pkt_send() before=20
calling net_tx_pkt_sendv() and fallback to software segmentation
2) fix the ipv6 payload len
3) add the ipv6 software segmentation support

It would be better if we can fix all of these issue in one series.

Thanks


>
>
> On Thu, Apr 9, 2020 at 6:15 AM Jason Wang <jasowang@redhat.com=20
> <mailto:jasowang@redhat.com>> wrote:
>
>
>     On 2020/4/6 =E4=B8=8A=E5=8D=883:19, andrew@daynix.com <mailto:andrew@=
daynix.com>
>     wrote:
>     > From: Andrew Melnychenko <andrew@daynix.com
>     <mailto:andrew@daynix.com>>
>     >
>     > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1708065
>     > e1000e driver doesn't sets 'plen' field for IPv6 for big packets
>     > if TSO is enabled. Jumbo option isn't added yet, until
>     > qemu supports packets greater than 64K.
>     >
>     > Signed-off-by: Andrew Melnychenko <andrew@daynix.com
>     <mailto:andrew@daynix.com>>
>     > ---
>     >=C2=A0 =C2=A0hw/net/e1000e_core.c |=C2=A0 1 +
>     >=C2=A0 =C2=A0hw/net/net_tx_pkt.c=C2=A0 | 31 ++++++++++++++++++++++++=
+++++++
>     >=C2=A0 =C2=A0hw/net/net_tx_pkt.h=C2=A0 |=C2=A0 7 +++++++
>     >=C2=A0 =C2=A0include/net/eth.h=C2=A0 =C2=A0 |=C2=A0 1 +
>     >=C2=A0 =C2=A04 files changed, 40 insertions(+)
>     >
>     > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>     > index d5676871fa..a1ec55598b 100644
>     > --- a/hw/net/e1000e_core.c
>     > +++ b/hw/net/e1000e_core.c
>     > @@ -656,6 +656,7 @@ e1000e_tx_pkt_send(E1000ECore *core, struct
>     e1000e_tx *tx, int queue_index)
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0NetClientState *queue =3D qemu_get_subque=
ue(core->owner_nic,
>     target_queue);
>     >
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0e1000e_setup_tx_offloads(core, tx);
>     > +=C2=A0 =C2=A0 net_tx_pkt_fix_ip6_payload_len(tx->tx_pkt);
>
>
>     A question here:
>
>     I don't see any code that set ip6_plen during
>     net_tx_pkt_do_sw_fragmentation(). This is described in 7.3.6.2.1 and
>     7.3.6.2.2 in the datasheet.
>
>     And:
>
>     1) eth_setup_ip4_fragmentation() only deal with ipv4
>
>     2) eth_fix_ip4_checksum() assumes a ipv4 header
>
>     Do we support ipv6 segmentation then?
>
>     Thanks
>
>
>     >
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0net_tx_pkt_dump(tx->tx_pkt);
>     >
>     > diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
>     > index 162f802dd7..b05d554ac3 100644
>     > --- a/hw/net/net_tx_pkt.c
>     > +++ b/hw/net/net_tx_pkt.c
>     > @@ -635,3 +635,34 @@ bool net_tx_pkt_send_loopback(struct
>     NetTxPkt *pkt, NetClientState *nc)
>     >
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0return res;
>     >=C2=A0 =C2=A0}
>     > +
>     > +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)
>     > +{
>     > +=C2=A0 =C2=A0 /*
>     > +=C2=A0 =C2=A0 =C2=A0* If ipv6 payload length field is 0 - then the=
re should be
>     Hop-by-Hop
>     > +=C2=A0 =C2=A0 =C2=A0* option for packets greater than 65,535.
>     > +=C2=A0 =C2=A0 =C2=A0* For packets with payload less than 65,535: f=
ix 'plen' field.
>     > +=C2=A0 =C2=A0 =C2=A0* For now, qemu drops every packet with size g=
reater 64K
>     > +=C2=A0 =C2=A0 =C2=A0* (see net_tx_pkt_send()) so, there is no reas=
on to add
>     jumbo option to ip6
>     > +=C2=A0 =C2=A0 =C2=A0* hop-by-hop extension if it's missed
>     > +=C2=A0 =C2=A0 =C2=A0*/
>     > +
>     > +=C2=A0 =C2=A0 struct iovec *l2 =3D &pkt->vec[NET_TX_PKT_L2HDR_FRAG=
];
>     > +=C2=A0 =C2=A0 if (eth_get_l3_proto(l2, 1, l2->iov_len) =3D=3D ETH_=
P_IPV6) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ip6_header *ip6 =3D (struct ip6=
_header *) pkt->l3_hdr;
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: if qemu would support >6=
4K packets - add jumbo
>     option check
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* something like that:
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 'if (ip6->ip6_plen =3D=3D 0 &&=
 !has_jumbo_option(ip6)) {'
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ip6->ip6_plen =3D=3D 0) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pkt->payload_len <=
=3D ETH_MAX_IP_DGRAM_LEN) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip6->ip6_p=
len =3D htons(pkt->payload_len);
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: if qemu wo=
uld support >64K packets
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* add jumbo option=
 for packets greater then 65,535
>     bytes
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     > +=C2=A0 =C2=A0 }
>     > +}
>     > diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
>     > index 212ecc62fc..912d56ef13 100644
>     > --- a/hw/net/net_tx_pkt.h
>     > +++ b/hw/net/net_tx_pkt.h
>     > @@ -187,4 +187,11 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);
>     >=C2=A0 =C2=A0*/
>     >=C2=A0 =C2=A0bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);
>     >
>     > +/**
>     > + * Fix IPv6 'plen' field.
>     > + *
>     > + * @pkt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet
>     > + */
>     > +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);
>     > +
>     >=C2=A0 =C2=A0#endif
>     > diff --git a/include/net/eth.h b/include/net/eth.h
>     > index 7f45c678e7..0671be6916 100644
>     > --- a/include/net/eth.h
>     > +++ b/include/net/eth.h
>     > @@ -186,6 +186,7 @@ struct tcp_hdr {
>     >
>     >=C2=A0 =C2=A0#define ip6_nxt=C2=A0 =C2=A0 =C2=A0 ip6_ctlun.ip6_un1.i=
p6_un1_nxt
>     >=C2=A0 =C2=A0#define ip6_ecn_acc=C2=A0 ip6_ctlun.ip6_un3.ip6_un3_ecn
>     > +#define ip6_plen=C2=A0 =C2=A0 =C2=A0ip6_ctlun.ip6_un1.ip6_un1_plen
>     >
>     >=C2=A0 =C2=A0#define PKT_GET_ETH_HDR(p)=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0((struct eth_header *)(p))
>


