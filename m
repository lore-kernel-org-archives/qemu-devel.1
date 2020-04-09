Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1924C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E3F2082D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="vBX+zH6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E3F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMWxh-0005aO-CG
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 09:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@daynix.com>) id 1jMWv2-0002FO-44
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@daynix.com>) id 1jMWv0-0002YR-8b
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:08:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <andrew@daynix.com>) id 1jMWuz-0002Xy-Qb
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:08:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id i10so5543326wrv.10
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=31nXiREDwDNysLDOie+698fwuC4z0cISt9Vv2Q9+1c4=;
 b=vBX+zH6/ANZAaAXHCVyTNwaIP02Nr5LOkvSbjmwHj2DdbO/RadBiY/25GytHQixxpP
 3wLpTKApZXzn5exB+lKNF+7x0L4RW1OStH6rvdiTDtPBlRkTcw1+XKOlrZE9Yii9plcR
 0qWer+97WmyAqQQasWuwTnAcK3dTUUratE+s35ZkAgsqc+jidsk3CkYYbZ6L3fMsoerh
 WQzdKHY3wwmQ+Jmq+jDH4+tAEpuheD5EkhxvVC3MfB1LCa4KbKWcT+8q1dlR0itRsAea
 iWof62nNZZTSwgRvx9vBLEGsprx6c7tZDu9Lpvlet3gqXYyph56CD4K2nehhVo/VLVwg
 QSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=31nXiREDwDNysLDOie+698fwuC4z0cISt9Vv2Q9+1c4=;
 b=GkYcd0bdOSzkcHMz21g7tsN+rDpCHhORtg41qwnkZDXMEvDGRV2j6FTczDJ2HyWvIK
 uq0nT4C+q6asopSLaktXy7EUR4ll3ouHrP8fI6o6/KjQTHqKT0Kr946PA8UJA8BUZQ3O
 Ytq2x3/SjvWQKKfT3mzCdOUj9odp3ZMn0Q1UyKQV9kFlFlsxWFkzpIUM42j+aTXh2VBJ
 30JVuy4lqOZD8LJbfwgv7m5Gy9z6xRt+MftM+AsteCUQOhyhEJRuWLTPygLBU0iaRPV+
 uuA1vCpdAnqonWXw02mhi+W3+ljhkgXLRLpfAAYc+KPjANLiOEWc+OGT0ynDfwLc3ANy
 DnEA==
X-Gm-Message-State: AGi0PuZcjHZiOjNCeW8PscqnemyTDdLi0fzol8c7ZNj8eND1tPSoKG92
 8t0ljt7iuNkebNUizpQQAywNyMMMEr0mT1HWwx30jg==
X-Google-Smtp-Source: APiQypJoUghQmtyl9aWSpKAULBnMKiWhuCdK1V9NiV5f+XcYofXH3QjF7LEkmuffXUoTacnpOrBkNbi6DYKqma/2wno=
X-Received: by 2002:a5d:4611:: with SMTP id t17mr14974812wrq.16.1586437707987; 
 Thu, 09 Apr 2020 06:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200405191940.866972-1-andrew@daynix.com>
 <e756b1b3-2346-822c-974c-79c40970c09d@redhat.com>
In-Reply-To: <e756b1b3-2346-822c-974c-79c40970c09d@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Thu, 9 Apr 2020 16:35:29 +0300
Message-ID: <CABcq3pFMaRSj6TD8NQMbeqFXe8zqUVJQcuv9bTD=Qi8SfiYuQg@mail.gmail.com>
Subject: Re: [PATCH] Fixed IPv6 payload lenght without jumbo option
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000b0f9305a2db508f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

--0000000000000b0f9305a2db508f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Do we support ipv6 segmentation then?
No, but - if the backend supports big frames there is an issue that IPv6
plen doesn't have valid value.
Actually, It's a good idea to add IPv6 fragmentation - I would do it later.


On Thu, Apr 9, 2020 at 6:15 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/4/6 =E4=B8=8A=E5=8D=883:19, andrew@daynix.com wrote:
> > From: Andrew Melnychenko <andrew@daynix.com>
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1708065
> > e1000e driver doesn't sets 'plen' field for IPv6 for big packets
> > if TSO is enabled. Jumbo option isn't added yet, until
> > qemu supports packets greater than 64K.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >   hw/net/e1000e_core.c |  1 +
> >   hw/net/net_tx_pkt.c  | 31 +++++++++++++++++++++++++++++++
> >   hw/net/net_tx_pkt.h  |  7 +++++++
> >   include/net/eth.h    |  1 +
> >   4 files changed, 40 insertions(+)
> >
> > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> > index d5676871fa..a1ec55598b 100644
> > --- a/hw/net/e1000e_core.c
> > +++ b/hw/net/e1000e_core.c
> > @@ -656,6 +656,7 @@ e1000e_tx_pkt_send(E1000ECore *core, struct
> e1000e_tx *tx, int queue_index)
> >       NetClientState *queue =3D qemu_get_subqueue(core->owner_nic,
> target_queue);
> >
> >       e1000e_setup_tx_offloads(core, tx);
> > +    net_tx_pkt_fix_ip6_payload_len(tx->tx_pkt);
>
>
> A question here:
>
> I don't see any code that set ip6_plen during
> net_tx_pkt_do_sw_fragmentation(). This is described in 7.3.6.2.1 and
> 7.3.6.2.2 in the datasheet.
>
> And:
>
> 1) eth_setup_ip4_fragmentation() only deal with ipv4
>
> 2) eth_fix_ip4_checksum() assumes a ipv4 header
>
> Do we support ipv6 segmentation then?
>
> Thanks
>
>
> >
> >       net_tx_pkt_dump(tx->tx_pkt);
> >
> > diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> > index 162f802dd7..b05d554ac3 100644
> > --- a/hw/net/net_tx_pkt.c
> > +++ b/hw/net/net_tx_pkt.c
> > @@ -635,3 +635,34 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pkt=
,
> NetClientState *nc)
> >
> >       return res;
> >   }
> > +
> > +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)
> > +{
> > +    /*
> > +     * If ipv6 payload length field is 0 - then there should be
> Hop-by-Hop
> > +     * option for packets greater than 65,535.
> > +     * For packets with payload less than 65,535: fix 'plen' field.
> > +     * For now, qemu drops every packet with size greater 64K
> > +     * (see net_tx_pkt_send()) so, there is no reason to add jumbo
> option to ip6
> > +     * hop-by-hop extension if it's missed
> > +     */
> > +
> > +    struct iovec *l2 =3D &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
> > +    if (eth_get_l3_proto(l2, 1, l2->iov_len) =3D=3D ETH_P_IPV6) {
> > +        struct ip6_header *ip6 =3D (struct ip6_header *) pkt->l3_hdr;
> > +        /*
> > +         * TODO: if qemu would support >64K packets - add jumbo option
> check
> > +         * something like that:
> > +         * 'if (ip6->ip6_plen =3D=3D 0 && !has_jumbo_option(ip6)) {'
> > +         */
> > +        if (ip6->ip6_plen =3D=3D 0) {
> > +            if (pkt->payload_len <=3D ETH_MAX_IP_DGRAM_LEN) {
> > +                ip6->ip6_plen =3D htons(pkt->payload_len);
> > +            }
> > +            /*
> > +             * TODO: if qemu would support >64K packets
> > +             * add jumbo option for packets greater then 65,535 bytes
> > +             */
> > +        }
> > +    }
> > +}
> > diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
> > index 212ecc62fc..912d56ef13 100644
> > --- a/hw/net/net_tx_pkt.h
> > +++ b/hw/net/net_tx_pkt.h
> > @@ -187,4 +187,11 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);
> >   */
> >   bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);
> >
> > +/**
> > + * Fix IPv6 'plen' field.
> > + *
> > + * @pkt            packet
> > + */
> > +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);
> > +
> >   #endif
> > diff --git a/include/net/eth.h b/include/net/eth.h
> > index 7f45c678e7..0671be6916 100644
> > --- a/include/net/eth.h
> > +++ b/include/net/eth.h
> > @@ -186,6 +186,7 @@ struct tcp_hdr {
> >
> >   #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
> >   #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
> > +#define ip6_plen     ip6_ctlun.ip6_un1.ip6_un1_plen
> >
> >   #define PKT_GET_ETH_HDR(p)        \
> >       ((struct eth_header *)(p))
>
>

--0000000000000b0f9305a2db508f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; Do we support ipv6 segmentation then?</div><div>=
No, but - if the backend supports big frames there is an issue that IPv6 pl=
en doesn&#39;t have valid value.</div><div>Actually, It&#39;s a good idea t=
o add IPv6 fragmentation - I would do it later.</div><div><br></div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu,=
 Apr 9, 2020 at 6:15 AM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.co=
m">jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><br>
On 2020/4/6 =E4=B8=8A=E5=8D=883:19, <a href=3D"mailto:andrew@daynix.com" ta=
rget=3D"_blank">andrew@daynix.com</a> wrote:<br>
&gt; From: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.com" targ=
et=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt;<br>
&gt; Buglink: <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1708=
065" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_=
bug.cgi?id=3D1708065</a><br>
&gt; e1000e driver doesn&#39;t sets &#39;plen&#39; field for IPv6 for big p=
ackets<br>
&gt; if TSO is enabled. Jumbo option isn&#39;t added yet, until<br>
&gt; qemu supports packets greater than 64K.<br>
&gt;<br>
&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.=
com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/e1000e_core.c |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0hw/net/net_tx_pkt.c=C2=A0 | 31 +++++++++++++++++++++++++++=
++++<br>
&gt;=C2=A0 =C2=A0hw/net/net_tx_pkt.h=C2=A0 |=C2=A0 7 +++++++<br>
&gt;=C2=A0 =C2=A0include/net/eth.h=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A04 files changed, 40 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c<br>
&gt; index d5676871fa..a1ec55598b 100644<br>
&gt; --- a/hw/net/e1000e_core.c<br>
&gt; +++ b/hw/net/e1000e_core.c<br>
&gt; @@ -656,6 +656,7 @@ e1000e_tx_pkt_send(E1000ECore *core, struct e1000e=
_tx *tx, int queue_index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NetClientState *queue =3D qemu_get_subqueue(=
core-&gt;owner_nic, target_queue);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0e1000e_setup_tx_offloads(core, tx);<br>
&gt; +=C2=A0 =C2=A0 net_tx_pkt_fix_ip6_payload_len(tx-&gt;tx_pkt);<br>
<br>
<br>
A question here:<br>
<br>
I don&#39;t see any code that set ip6_plen during <br>
net_tx_pkt_do_sw_fragmentation(). This is described in 7.3.6.2.1 and <br>
7.3.6.2.2 in the datasheet.<br>
<br>
And:<br>
<br>
1) eth_setup_ip4_fragmentation() only deal with ipv4<br>
<br>
2) eth_fix_ip4_checksum() assumes a ipv4 header<br>
<br>
Do we support ipv6 segmentation then?<br>
<br>
Thanks<br>
<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0net_tx_pkt_dump(tx-&gt;tx_pkt);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c<br>
&gt; index 162f802dd7..b05d554ac3 100644<br>
&gt; --- a/hw/net/net_tx_pkt.c<br>
&gt; +++ b/hw/net/net_tx_pkt.c<br>
&gt; @@ -635,3 +635,34 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pk=
t, NetClientState *nc)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* If ipv6 payload length field is 0 - then there =
should be Hop-by-Hop<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* option for packets greater than 65,535.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* For packets with payload less than 65,535: fix =
&#39;plen&#39; field.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* For now, qemu drops every packet with size grea=
ter 64K<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* (see net_tx_pkt_send()) so, there is no reason =
to add jumbo option to ip6<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* hop-by-hop extension if it&#39;s missed<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 struct iovec *l2 =3D &amp;pkt-&gt;vec[NET_TX_PKT_L2HDR_=
FRAG];<br>
&gt; +=C2=A0 =C2=A0 if (eth_get_l3_proto(l2, 1, l2-&gt;iov_len) =3D=3D ETH_=
P_IPV6) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ip6_header *ip6 =3D (struct ip6_he=
ader *) pkt-&gt;l3_hdr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: if qemu would support &gt;6=
4K packets - add jumbo option check<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* something like that:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* &#39;if (ip6-&gt;ip6_plen =3D=3D =
0 &amp;&amp; !has_jumbo_option(ip6)) {&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ip6-&gt;ip6_plen =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pkt-&gt;payload_len &lt=
;=3D ETH_MAX_IP_DGRAM_LEN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip6-&gt;ip6_p=
len =3D htons(pkt-&gt;payload_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: if qemu would=
 support &gt;64K packets<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* add jumbo option fo=
r packets greater then 65,535 bytes<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h<br>
&gt; index 212ecc62fc..912d56ef13 100644<br>
&gt; --- a/hw/net/net_tx_pkt.h<br>
&gt; +++ b/hw/net/net_tx_pkt.h<br>
&gt; @@ -187,4 +187,11 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * Fix IPv6 &#39;plen&#39; field.<br>
&gt; + *<br>
&gt; + * @pkt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet<br>
&gt; + */<br>
&gt; +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; diff --git a/include/net/eth.h b/include/net/eth.h<br>
&gt; index 7f45c678e7..0671be6916 100644<br>
&gt; --- a/include/net/eth.h<br>
&gt; +++ b/include/net/eth.h<br>
&gt; @@ -186,6 +186,7 @@ struct tcp_hdr {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define ip6_nxt=C2=A0 =C2=A0 =C2=A0 ip6_ctlun.ip6_un1.ip6_=
un1_nxt<br>
&gt;=C2=A0 =C2=A0#define ip6_ecn_acc=C2=A0 ip6_ctlun.ip6_un3.ip6_un3_ecn<br=
>
&gt; +#define ip6_plen=C2=A0 =C2=A0 =C2=A0ip6_ctlun.ip6_un1.ip6_un1_plen<br=
>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define PKT_GET_ETH_HDR(p)=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0((struct eth_header *)(p))<br>
<br>
</blockquote></div>

--0000000000000b0f9305a2db508f--

