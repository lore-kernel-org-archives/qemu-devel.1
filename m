Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2615AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D328D206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="dxWyuF5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D328D206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMpi8-0005SV-1L
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 05:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@daynix.com>) id 1jMphJ-00053M-EB
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@daynix.com>) id 1jMphH-0006Sr-AK
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:11:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <andrew@daynix.com>) id 1jMphG-0006SN-SU
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:11:35 -0400
Received: by mail-wm1-x343.google.com with SMTP id x4so1864178wmj.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YaQW89CrBNi2GL6CjKXClHpZt+h92wumux98ytnSGpk=;
 b=dxWyuF5qjBMs5YmSvgkhB30+YXznN/1n3mPz/M/k5rIBAYVLQqEVbpYuBo13fRD5kI
 SW4pUh3lMU+Efm/xk5UfqsM9yPznPH4qFq9FdU6Mrpr1r90nl6TAbrXkwwyVkfvxCF/R
 FSwza62Bh00ZzbhUNWynKkt+DgKA+cUbnPVY1mEHzPaQuvHbHW5W0DiJBKkV8XtaXYGL
 lTRZKyJse4BCzICeBoI7WWpV8he08GuALIYju1U7yJi8LqAc5sWT8gqCK/dme7swr4rv
 ei+eP/vrbjvKZTxEzirR7btDjYV8bZGIG0q7AZ5vhgFV2bIevKGYKN5y8ztCxPakqRjh
 16kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YaQW89CrBNi2GL6CjKXClHpZt+h92wumux98ytnSGpk=;
 b=XO636mtC9u0lJKykk9ZwzKpSHQC20f+99ZXTK8u/w4eklTozdV6HREdYGtTRNHx3Hn
 kNE5B12WasRYc1DH1QlbPqnXELGmYQQDl/YQ/y+ukbxBOqlGN28fD8a23GxFG5TuI3WL
 ix2XVqI5T/AN5L9JxsoJXGw/Qf7EXJ8kGGcgz7GNnuaE49w5gkH//OD8WL+RP4rNBY4Y
 Of0vgEGDy4YzD9pkZAqJ+VdvrN0b0sFmCPSfoInM3NOTI2qLv8NUwJt1rMz5IogqGd79
 iSL4e3OW7oOVjun8dS1WP+jt+1uD5lzSRPnx2Qh7K1kSq42YxkIeanCyZaWB0oxMvDbf
 QDuA==
X-Gm-Message-State: AGi0Puar1+3t94nzLH+wkhASzK6w+4cz5441NgGNUbIei5ukpFGwh7uE
 YivZOZnFJl4ByjyAsbVyaJ/F6TRxmYZwCtqIvHid+Q==
X-Google-Smtp-Source: APiQypImmH8KblsY3ddt7/zfPbmIJLve4+tyMnAdQY0DhEXPpiGlHZma/lRYK7kPQBEW92BRzCNYYTGIOPF6YyThptM=
X-Received: by 2002:a7b:c402:: with SMTP id k2mr4351531wmi.21.1586509893738;
 Fri, 10 Apr 2020 02:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200405191940.866972-1-andrew@daynix.com>
 <e756b1b3-2346-822c-974c-79c40970c09d@redhat.com>
 <CABcq3pFMaRSj6TD8NQMbeqFXe8zqUVJQcuv9bTD=Qi8SfiYuQg@mail.gmail.com>
 <5160b387-3068-cdd8-e47c-5c449319b05e@redhat.com>
In-Reply-To: <5160b387-3068-cdd8-e47c-5c449319b05e@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Fri, 10 Apr 2020 12:38:36 +0300
Message-ID: <CABcq3pEbac8F2bq+2bGnygf0MnaAjMe9L226txuhFVQAmLtJDg@mail.gmail.com>
Subject: Re: [PATCH] Fixed IPv6 payload lenght without jumbo option
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a638ab05a2ec1e46"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

--000000000000a638ab05a2ec1e46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, later - I'll prepare a new patch with length fix, segmentation and
checks.
For now, the current patch can be discarded.

On Fri, Apr 10, 2020 at 5:28 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/4/9 =E4=B8=8B=E5=8D=889:35, Andrew Melnichenko wrote:
> > > Do we support ipv6 segmentation then?
> > No, but - if the backend supports big frames there is an issue that
> > IPv6 plen doesn't have valid value.
> > Actually, It's a good idea to add IPv6 fragmentation - I would do it
> > later.
>
>
> Right, another question.
>
> E.g for virtio-net, we will do the following check:
>
>      if (!peer_has_vnet_hdr(n)) {
>          virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
>          virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
>          virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
>          virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
>
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
>      }
>
> I think we should do something similar in e1000e. But I can only see
> disable_vnet parameter but not a checking of the ability of its peer.
>
> 1) when peer has vnet hdr, it supports receiving GSO packets, we don't
> need software segmentation.
> 2) when peer does not have vnet hdr, we need to use software path
> segmentation.
>
> This means we need:
>
> 1) check peer_has_vnet_hdr() and disable_vnet in net_pkt_send() before
> calling net_tx_pkt_sendv() and fallback to software segmentation
> 2) fix the ipv6 payload len
> 3) add the ipv6 software segmentation support
>
> It would be better if we can fix all of these issue in one series.
>
> Thanks
>
>
> >
> >
> > On Thu, Apr 9, 2020 at 6:15 AM Jason Wang <jasowang@redhat.com
> > <mailto:jasowang@redhat.com>> wrote:
> >
> >
> >     On 2020/4/6 =E4=B8=8A=E5=8D=883:19, andrew@daynix.com <mailto:andre=
w@daynix.com>
> >     wrote:
> >     > From: Andrew Melnychenko <andrew@daynix.com
> >     <mailto:andrew@daynix.com>>
> >     >
> >     > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1708065
> >     > e1000e driver doesn't sets 'plen' field for IPv6 for big packets
> >     > if TSO is enabled. Jumbo option isn't added yet, until
> >     > qemu supports packets greater than 64K.
> >     >
> >     > Signed-off-by: Andrew Melnychenko <andrew@daynix.com
> >     <mailto:andrew@daynix.com>>
> >     > ---
> >     >   hw/net/e1000e_core.c |  1 +
> >     >   hw/net/net_tx_pkt.c  | 31 +++++++++++++++++++++++++++++++
> >     >   hw/net/net_tx_pkt.h  |  7 +++++++
> >     >   include/net/eth.h    |  1 +
> >     >   4 files changed, 40 insertions(+)
> >     >
> >     > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> >     > index d5676871fa..a1ec55598b 100644
> >     > --- a/hw/net/e1000e_core.c
> >     > +++ b/hw/net/e1000e_core.c
> >     > @@ -656,6 +656,7 @@ e1000e_tx_pkt_send(E1000ECore *core, struct
> >     e1000e_tx *tx, int queue_index)
> >     >       NetClientState *queue =3D qemu_get_subqueue(core->owner_nic=
,
> >     target_queue);
> >     >
> >     >       e1000e_setup_tx_offloads(core, tx);
> >     > +    net_tx_pkt_fix_ip6_payload_len(tx->tx_pkt);
> >
> >
> >     A question here:
> >
> >     I don't see any code that set ip6_plen during
> >     net_tx_pkt_do_sw_fragmentation(). This is described in 7.3.6.2.1 an=
d
> >     7.3.6.2.2 in the datasheet.
> >
> >     And:
> >
> >     1) eth_setup_ip4_fragmentation() only deal with ipv4
> >
> >     2) eth_fix_ip4_checksum() assumes a ipv4 header
> >
> >     Do we support ipv6 segmentation then?
> >
> >     Thanks
> >
> >
> >     >
> >     >       net_tx_pkt_dump(tx->tx_pkt);
> >     >
> >     > diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> >     > index 162f802dd7..b05d554ac3 100644
> >     > --- a/hw/net/net_tx_pkt.c
> >     > +++ b/hw/net/net_tx_pkt.c
> >     > @@ -635,3 +635,34 @@ bool net_tx_pkt_send_loopback(struct
> >     NetTxPkt *pkt, NetClientState *nc)
> >     >
> >     >       return res;
> >     >   }
> >     > +
> >     > +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)
> >     > +{
> >     > +    /*
> >     > +     * If ipv6 payload length field is 0 - then there should be
> >     Hop-by-Hop
> >     > +     * option for packets greater than 65,535.
> >     > +     * For packets with payload less than 65,535: fix 'plen'
> field.
> >     > +     * For now, qemu drops every packet with size greater 64K
> >     > +     * (see net_tx_pkt_send()) so, there is no reason to add
> >     jumbo option to ip6
> >     > +     * hop-by-hop extension if it's missed
> >     > +     */
> >     > +
> >     > +    struct iovec *l2 =3D &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
> >     > +    if (eth_get_l3_proto(l2, 1, l2->iov_len) =3D=3D ETH_P_IPV6) =
{
> >     > +        struct ip6_header *ip6 =3D (struct ip6_header *)
> pkt->l3_hdr;
> >     > +        /*
> >     > +         * TODO: if qemu would support >64K packets - add jumbo
> >     option check
> >     > +         * something like that:
> >     > +         * 'if (ip6->ip6_plen =3D=3D 0 && !has_jumbo_option(ip6)=
) {'
> >     > +         */
> >     > +        if (ip6->ip6_plen =3D=3D 0) {
> >     > +            if (pkt->payload_len <=3D ETH_MAX_IP_DGRAM_LEN) {
> >     > +                ip6->ip6_plen =3D htons(pkt->payload_len);
> >     > +            }
> >     > +            /*
> >     > +             * TODO: if qemu would support >64K packets
> >     > +             * add jumbo option for packets greater then 65,535
> >     bytes
> >     > +             */
> >     > +        }
> >     > +    }
> >     > +}
> >     > diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
> >     > index 212ecc62fc..912d56ef13 100644
> >     > --- a/hw/net/net_tx_pkt.h
> >     > +++ b/hw/net/net_tx_pkt.h
> >     > @@ -187,4 +187,11 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);
> >     >   */
> >     >   bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);
> >     >
> >     > +/**
> >     > + * Fix IPv6 'plen' field.
> >     > + *
> >     > + * @pkt            packet
> >     > + */
> >     > +void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);
> >     > +
> >     >   #endif
> >     > diff --git a/include/net/eth.h b/include/net/eth.h
> >     > index 7f45c678e7..0671be6916 100644
> >     > --- a/include/net/eth.h
> >     > +++ b/include/net/eth.h
> >     > @@ -186,6 +186,7 @@ struct tcp_hdr {
> >     >
> >     >   #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
> >     >   #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
> >     > +#define ip6_plen     ip6_ctlun.ip6_un1.ip6_un1_plen
> >     >
> >     >   #define PKT_GET_ETH_HDR(p)        \
> >     >       ((struct eth_header *)(p))
> >
>
>

--000000000000a638ab05a2ec1e46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ok, later - I&#39;ll prepare a new patch with length =
fix, segmentation and checks.</div><div>For now, the current patch can be <=
span class=3D"gmail-tlid-translation gmail-translation" lang=3D"en"><span t=
itle=3D"" class=3D"gmail-">discarded.</span></span></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 10, 20=
20 at 5:28 AM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowan=
g@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><br>
On 2020/4/9 =E4=B8=8B=E5=8D=889:35, Andrew Melnichenko wrote:<br>
&gt; &gt; Do we support ipv6 segmentation then?<br>
&gt; No, but - if the backend supports big frames there is an issue that <b=
r>
&gt; IPv6 plen doesn&#39;t have valid value.<br>
&gt; Actually, It&#39;s a good idea to add IPv6 fragmentation - I would do =
it <br>
&gt; later.<br>
<br>
<br>
Right, another question.<br>
<br>
E.g for virtio-net, we will do the following check:<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0 if (!peer_has_vnet_hdr(n)) {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&amp;=
features, VIRTIO_NET_F_CSUM);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&amp;=
features, VIRTIO_NET_F_HOST_TSO4);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&amp;=
features, VIRTIO_NET_F_HOST_TSO6);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&amp;=
features, VIRTIO_NET_F_HOST_ECN);<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&amp;=
features, VIRTIO_NET_F_GUEST_CSUM);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&amp;=
features, VIRTIO_NET_F_GUEST_TSO4);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&amp;=
features, VIRTIO_NET_F_GUEST_TSO6);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_clear_feature(&amp;=
features, VIRTIO_NET_F_GUEST_ECN);<br>
=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
<br>
I think we should do something similar in e1000e. But I can only see <br>
disable_vnet parameter but not a checking of the ability of its peer.<br>
<br>
1) when peer has vnet hdr, it supports receiving GSO packets, we don&#39;t =
<br>
need software segmentation.<br>
2) when peer does not have vnet hdr, we need to use software path <br>
segmentation.<br>
<br>
This means we need:<br>
<br>
1) check peer_has_vnet_hdr() and disable_vnet in net_pkt_send() before <br>
calling net_tx_pkt_sendv() and fallback to software segmentation<br>
2) fix the ipv6 payload len<br>
3) add the ipv6 software segmentation support<br>
<br>
It would be better if we can fix all of these issue in one series.<br>
<br>
Thanks<br>
<br>
<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Apr 9, 2020 at 6:15 AM Jason Wang &lt;<a href=3D"mailto:jasowa=
ng@redhat.com" target=3D"_blank">jasowang@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">ja=
sowang@redhat.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2020/4/6 =E4=B8=8A=E5=8D=883:19, <a href=3D"mail=
to:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a> &lt;mailto:<a=
 href=3D"mailto:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a>&=
gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; From: Andrew Melnychenko &lt;<a href=3D"mailto=
:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:andrew@daynix.com" tar=
get=3D"_blank">andrew@daynix.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Buglink: <a href=3D"https://bugzilla.redhat.co=
m/show_bug.cgi?id=3D1708065" rel=3D"noreferrer" target=3D"_blank">https://b=
ugzilla.redhat.com/show_bug.cgi?id=3D1708065</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; e1000e driver doesn&#39;t sets &#39;plen&#39; =
field for IPv6 for big packets<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; if TSO is enabled. Jumbo option isn&#39;t adde=
d yet, until<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; qemu supports packets greater than 64K.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=
=3D"mailto:andrew@daynix.com" target=3D"_blank">andrew@daynix.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:andrew@daynix.com" tar=
get=3D"_blank">andrew@daynix.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/net/e1000e_core.c |=C2=A0 1 +<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/net/net_tx_pkt.c=C2=A0 | 31 +++=
++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0hw/net/net_tx_pkt.h=C2=A0 |=C2=A0 =
7 +++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0include/net/eth.h=C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A04 files changed, 40 insertions(+)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/net/e1000e_core.c b/hw/net/e10=
00e_core.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index d5676871fa..a1ec55598b 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/net/e1000e_core.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/net/e1000e_core.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -656,6 +656,7 @@ e1000e_tx_pkt_send(E1000EC=
ore *core, struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0e1000e_tx *tx, int queue_index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NetClientState *queu=
e =3D qemu_get_subqueue(core-&gt;owner_nic,<br>
&gt;=C2=A0 =C2=A0 =C2=A0target_queue);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0e1000e_setup_tx_offl=
oads(core, tx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 net_tx_pkt_fix_ip6_payload_len(=
tx-&gt;tx_pkt);<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0A question here:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t see any code that set ip6_plen during<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0net_tx_pkt_do_sw_fragmentation(). This is described=
 in 7.3.6.2.1 and<br>
&gt;=C2=A0 =C2=A0 =C2=A07.3.6.2.2 in the datasheet.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0And:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A01) eth_setup_ip4_fragmentation() only deal with ipv=
4<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A02) eth_fix_ip4_checksum() assumes a ipv4 header<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Do we support ipv6 segmentation then?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0net_tx_pkt_dump(tx-&=
gt;tx_pkt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_=
tx_pkt.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 162f802dd7..b05d554ac3 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/net/net_tx_pkt.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/net/net_tx_pkt.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -635,3 +635,34 @@ bool net_tx_pkt_send_loop=
back(struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0NetTxPkt *pkt, NetClientState *nc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +void net_tx_pkt_fix_ip6_payload_len(struct Ne=
tTxPkt *pkt)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* If ipv6 payload length =
field is 0 - then there should be<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hop-by-Hop<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* option for packets grea=
ter than 65,535.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* For packets with payloa=
d less than 65,535: fix &#39;plen&#39; field.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* For now, qemu drops eve=
ry packet with size greater 64K<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* (see net_tx_pkt_send())=
 so, there is no reason to add<br>
&gt;=C2=A0 =C2=A0 =C2=A0jumbo option to ip6<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* hop-by-hop extension if=
 it&#39;s missed<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 struct iovec *l2 =3D &amp;pkt-&=
gt;vec[NET_TX_PKT_L2HDR_FRAG];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 if (eth_get_l3_proto(l2, 1, l2-=
&gt;iov_len) =3D=3D ETH_P_IPV6) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ip6_header=
 *ip6 =3D (struct ip6_header *) pkt-&gt;l3_hdr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: if =
qemu would support &gt;64K packets - add jumbo<br>
&gt;=C2=A0 =C2=A0 =C2=A0option check<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* something=
 like that:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* &#39;if (=
ip6-&gt;ip6_plen =3D=3D 0 &amp;&amp; !has_jumbo_option(ip6)) {&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ip6-&gt;ip6_p=
len =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(pkt-&gt;payload_len &lt;=3D ETH_MAX_IP_DGRAM_LEN) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ip6-&gt;ip6_plen =3D htons(pkt-&gt;payload_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* TODO: if qemu would support &gt;64K packets<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* add jumbo option for packets greater then 65,535<br>
&gt;=C2=A0 =C2=A0 =C2=A0bytes<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_=
tx_pkt.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 212ecc62fc..912d56ef13 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/net/net_tx_pkt.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/net/net_tx_pkt.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -187,4 +187,11 @@ bool net_tx_pkt_parse(str=
uct NetTxPkt *pkt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0bool net_tx_pkt_has_fragments(stru=
ct NetTxPkt *pkt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +/**<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * Fix IPv6 &#39;plen&#39; field.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * @pkt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 packet<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +void net_tx_pkt_fix_ip6_payload_len(struct Ne=
tTxPkt *pkt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/include/net/eth.h b/include/net/e=
th.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 7f45c678e7..0671be6916 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/include/net/eth.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/include/net/eth.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -186,6 +186,7 @@ struct tcp_hdr {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0#define ip6_nxt=C2=A0 =C2=A0 =C2=
=A0 ip6_ctlun.ip6_un1.ip6_un1_nxt<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0#define ip6_ecn_acc=C2=A0 ip6_ctlu=
n.ip6_un3.ip6_un3_ecn<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define ip6_plen=C2=A0 =C2=A0 =C2=A0ip6_ctlun=
.ip6_un1.ip6_un1_plen<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0#define PKT_GET_ETH_HDR(p)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0((struct eth_header =
*)(p))<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000a638ab05a2ec1e46--

