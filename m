Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F1AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0992070A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="y+n9YbtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0992070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9Jq-0001pB-Pb
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jA9Iy-0001FY-JH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jA9Ix-0002Kw-0t
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:30:04 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:35654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jA9Iw-00029E-E5
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:30:02 -0500
Received: by mail-yw1-xc43.google.com with SMTP id d79so564755ywd.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 01:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+ksCe5Jc98L0pmo/e3S2bX3rGcdZERk2XP+iiIuC6co=;
 b=y+n9YbtN+cSmKlNbqm01F45kErh3Ztk3Xipgd2fdS3u609oNOU5WYxHPHXumS+ywxT
 aOB+1hKOpjsd16nWTAImU2edNEq7G3/kcuMADfMmeWeyknc42/gJZQ8kLoLYHpZ15jV9
 lYGYNM6s/MhgdeTRrQbB385beR9pWM3jWhQRNvJZx3rdSxxOX8xDq7/x71tb3TyK/1Hk
 0qpGJK1GmBgPU2EU+XUJmwPWcEpFBmWdxerVtxwBRMSeZSuRsk/05VY4Om3HiKeI+qgM
 TsFthoDRLrYG05lM8+9VM2OAvvN1bg94YhZLYNPVg3+6nUxv7HmCtawTvQYC3h6kR9Wi
 c8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+ksCe5Jc98L0pmo/e3S2bX3rGcdZERk2XP+iiIuC6co=;
 b=EQam1sOZcKde2BBiVo1NtQ1Zj/iX6ggAdUywq+icjrYgfCgQDcsnetNfL7Xa226+fH
 3Oz3OxPz5hLEBTfzwJ8jf/up1W64Pjs3dfwW3hDyqQasZTYk4fks6IvCXCBB+YLnh0Bp
 /sUoZzHXbg5iv8tv06TzFAiMpldwVrg/vKN46T+aRwLvqzm6G8cHSteQsvf9JwTwhX88
 MoRkJvZ5NiGohnM5k0P8zETC5TcBYPM2Cevq+EsmmWFk6cG264jATF8XaqTxBkh9nKCC
 6FQeomzAMEW2bINhKame8djxN2RP+3TlFv5aRyKT8HB//gnYfVJbCoyHdaKU11eciq6M
 OjUg==
X-Gm-Message-State: ANhLgQ12L3nNKk5hl9rkpNCpEMqoYS3tyQNEVShxuCbCZ1Q/IMnYSHg0
 En/A/LCEQlHRL3FbEZwYnUJr8j/WoJIMdBYMqPmTjQ==
X-Google-Smtp-Source: ADFU+vt49/9zmx0LRA+xjQ7bz4gGKiAGvUta5paSpBHIsUBwo6z595mpAKA+V/vh8eeMbit8tKs46QvLpx9ipILnnjs=
X-Received: by 2002:a81:449:: with SMTP id 70mr3091774ywe.133.1583487001408;
 Fri, 06 Mar 2020 01:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <20200226174809.9675-2-yuri.benditovich@daynix.com>
 <20200305082023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200305082023-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 6 Mar 2020 11:29:50 +0200
Message-ID: <CAOEp5Oc+dTzJHzof9suUbXEgBnYoa4bh87K-ALWMzw_MzYf4Mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio-net: introduce RSS RX steering feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000039c85705a02c4c84"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000039c85705a02c4c84
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 5, 2020 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Feb 26, 2020 at 07:48:07PM +0200, Yuri Benditovich wrote:
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  include/standard-headers/linux/virtio_net.h | 37 +++++++++++++++++++--
> >  1 file changed, 35 insertions(+), 2 deletions(-)
>
>
> It will take a bit until next merge window when the linux
> headers will be updated.
> Until that happens you can just put these defines where
> they are used.
>

We also extend the configuration virtio_net_config structure and its
field 'supported_hash_types' uses these defines. Please advise.


>
> > diff --git a/include/standard-headers/linux/virtio_net.h
> b/include/standard-headers/linux/virtio_net.h
> > index 260c3681d7..3bc100afe3 100644
> > --- a/include/standard-headers/linux/virtio_net.h
> > +++ b/include/standard-headers/linux/virtio_net.h
> > @@ -57,6 +57,7 @@
> >                                        * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> >
> > +#define VIRTIO_NET_F_RSS       60    /* Supports RSS RX steering */
> >  #define VIRTIO_NET_F_STANDBY   62    /* Act as standby for another
> device
> >                                        * with the same MAC.
> >                                        */
> > @@ -69,6 +70,16 @@
> >  #define VIRTIO_NET_S_LINK_UP 1       /* Link is up */
> >  #define VIRTIO_NET_S_ANNOUNCE        2       /* Announcement is needed
> */
> >
> > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4              (1 << 0)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4             (1 << 1)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4             (1 << 2)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6              (1 << 3)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6             (1 << 4)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6             (1 << 5)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX             (1 << 6)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX            (1 << 7)
> > +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX            (1 << 8)
> > +
> >  struct virtio_net_config {
> >       /* The config defining mac address (if VIRTIO_NET_F_MAC) */
> >       uint8_t mac[ETH_ALEN];
> > @@ -92,6 +103,14 @@ struct virtio_net_config {
> >        * Any other value stands for unknown.
> >        */
> >       uint8_t duplex;
> > +
> > +     /* maximal size of RSS key */
> > +     uint8_t rss_max_key_size;
> > +     /* maximal number of indirection table entries */
> > +     uint16_t rss_max_indirection_table_length;
> > +     /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> > +     uint32_t supported_hash_types;
> > +
> >  } QEMU_PACKED;
> >
> >  /*
> > @@ -237,15 +256,29 @@ struct virtio_net_ctrl_mac {
> >   * Accordingly, driver should not transmit new packets  on virtqueues
> other than
> >   * specified.
> >   */
> > +#define VIRTIO_NET_CTRL_MQ   4
> > + #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
> > + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> > +
> > +/* for VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET */
> >  struct virtio_net_ctrl_mq {
> >       __virtio16 virtqueue_pairs;
> >  };
> >
> > -#define VIRTIO_NET_CTRL_MQ   4
> > - #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
> >   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> >
> > +/* for VIRTIO_NET_CTRL_MQ_RSS_CONFIG */
> > +struct virtio_net_rss_config {
> > +    uint32_t hash_types;
> > +    uint16_t indirection_table_mask;
> > +    uint16_t unclassified_queue;
> > +    uint16_t indirection_table[1/* + indirection_table_mask*/];
> > +    uint16_t max_tx_vq;
> > +    uint8_t hash_key_length;
> > +    uint8_t hash_key_data[/*hash_key_length*/];
> > +};
> > +
> >  /*
> >   * Control network offloads
> >   *
> > --
> > 2.17.1
>
>

--00000000000039c85705a02c4c84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 5, 2020 at 3:21 PM Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Fe=
b 26, 2020 at 07:48:07PM +0200, Yuri Benditovich wrote:<br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/standard-headers/linux/virtio_net.h | 37 +++++++++++++++=
++++--<br>
&gt;=C2=A0 1 file changed, 35 insertions(+), 2 deletions(-)<br>
<br>
<br>
It will take a bit until next merge window when the linux<br>
headers will be updated.<br>
Until that happens you can just put these defines where<br>
they are used.<br></blockquote><div><br></div><div>We also extend the confi=
guration virtio_net_config structure and its</div><div>field &#39;supported=
_hash_types&#39; uses these defines. Please advise.</div><div>=C2=A0<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/include/standard-headers/linux/virtio_net.h b/include/sta=
ndard-headers/linux/virtio_net.h<br>
&gt; index 260c3681d7..3bc100afe3 100644<br>
&gt; --- a/include/standard-headers/linux/virtio_net.h<br>
&gt; +++ b/include/standard-headers/linux/virtio_net.h<br>
&gt; @@ -57,6 +57,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Ste=
ering */<br>
&gt;=C2=A0 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* Set MAC address */<br>
&gt;=C2=A0 <br>
&gt; +#define VIRTIO_NET_F_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A060=C2=A0 =C2=A0 /*=
 Supports RSS RX steering */<br>
&gt;=C2=A0 #define VIRTIO_NET_F_STANDBY=C2=A0 =C2=A062=C2=A0 =C2=A0 /* Act =
as standby for another device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * wit=
h the same MAC.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br=
>
&gt; @@ -69,6 +70,16 @@<br>
&gt;=C2=A0 #define VIRTIO_NET_S_LINK_UP 1=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Link=
 is up */<br>
&gt;=C2=A0 #define VIRTIO_NET_S_ANNOUNCE=C2=A0 =C2=A0 =C2=A0 =C2=A0 2=C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* Announcement is needed */<br>
&gt;=C2=A0 <br>
&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0)<br>
&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 &lt;&lt; 1)<br>
&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 &lt;&lt; 2)<br>
&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3)<br>
&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 &lt;&lt; 4)<br>
&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 &lt;&lt; 5)<br>
&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 &lt;&lt; 6)<br>
&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (1 &lt;&lt; 7)<br>
&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (1 &lt;&lt; 8)<br>
&gt; +<br>
&gt;=C2=A0 struct virtio_net_config {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The config defining mac address (if VIRTI=
O_NET_F_MAC) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t mac[ETH_ALEN];<br>
&gt; @@ -92,6 +103,14 @@ struct virtio_net_config {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Any other value stands for unknown.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t duplex;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* maximal size of RSS key */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint8_t rss_max_key_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* maximal number of indirection table entries */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint16_t rss_max_indirection_table_length;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* bitmask of supported VIRTIO_NET_RSS_HASH_ type=
s */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t supported_hash_types;<br>
&gt; +<br>
&gt;=C2=A0 } QEMU_PACKED;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*<br>
&gt; @@ -237,15 +256,29 @@ struct virtio_net_ctrl_mac {<br>
&gt;=C2=A0 =C2=A0* Accordingly, driver should not transmit new packets=C2=
=A0 on virtqueues other than<br>
&gt;=C2=A0 =C2=A0* specified.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; +#define VIRTIO_NET_CTRL_MQ=C2=A0 =C2=A04<br>
&gt; + #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
<br>
&gt; + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1<br>
&gt; +<br>
&gt; +/* for VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET */<br>
&gt;=C2=A0 struct virtio_net_ctrl_mq {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__virtio16 virtqueue_pairs;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; -#define VIRTIO_NET_CTRL_MQ=C2=A0 =C2=A04<br>
&gt; - #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
<br>
&gt;=C2=A0 =C2=A0#define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 1<br>
&gt;=C2=A0 =C2=A0#define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x8000<br>
&gt;=C2=A0 <br>
&gt; +/* for VIRTIO_NET_CTRL_MQ_RSS_CONFIG */<br>
&gt; +struct virtio_net_rss_config {<br>
&gt; +=C2=A0 =C2=A0 uint32_t hash_types;<br>
&gt; +=C2=A0 =C2=A0 uint16_t indirection_table_mask;<br>
&gt; +=C2=A0 =C2=A0 uint16_t unclassified_queue;<br>
&gt; +=C2=A0 =C2=A0 uint16_t indirection_table[1/* + indirection_table_mask=
*/];<br>
&gt; +=C2=A0 =C2=A0 uint16_t max_tx_vq;<br>
&gt; +=C2=A0 =C2=A0 uint8_t hash_key_length;<br>
&gt; +=C2=A0 =C2=A0 uint8_t hash_key_data[/*hash_key_length*/];<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Control network offloads<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; -- <br>
&gt; 2.17.1<br>
<br>
</blockquote></div></div>

--00000000000039c85705a02c4c84--

