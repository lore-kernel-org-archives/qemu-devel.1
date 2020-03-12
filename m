Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0910DC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBAA206B1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="PBOYWmz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBAA206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCHsS-0001sw-Sw
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 03:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jCHrp-0000vm-Ih
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jCHrn-0006bk-KI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:02:53 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:45673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jCHrn-0006aD-1s
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:02:51 -0400
Received: by mail-yw1-xc42.google.com with SMTP id d206so4583409ywa.12
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3laEDOyMhu/gzthMQuYTGVAu3RTfPHM4tsrgBOVYwPA=;
 b=PBOYWmz0bYW1hBTZq1ex+agOoWdhI1Qi4wMfLpmwEBcX5bBNsmzaqurK5AOfe04LdT
 z1Rx7pjfbGzU41z7c6qu9TRmJE3sZ8xCp5XeXmPWHJQ7Ox+APmyv0AZjsSUaLgfItu2t
 Om0nH9zAyaEZJkxeKc7hOcu8t+RIESbp0PNT2yM7JcP/WlGWp9oPZht/nAMMe5yffL/j
 ZSVn/mg5CayY3UYSGzMX8nAaEtDmiTK4OTGAOZH2t5AVUnbX78+L4WbnMxAwo41ejAGW
 BugiE5zEn6n04sxDPKbRA97/BbmgLAQnkhLTpMlqN0N81TmUY4EYSjgtqE+ezHa7P0eY
 g3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3laEDOyMhu/gzthMQuYTGVAu3RTfPHM4tsrgBOVYwPA=;
 b=gmw4PutzlHcrpk5fJq5JHVTodwy+ET94rzCQnXjVNGw1nYmO9KO+th4e82nFnnkXy4
 C6h6156p5lG6hDyShgwGHUj3ovk9sOf4TOGxjoJFF4+qa0PqzY3gOjHYWxGnl0xxF/jU
 iK+AHBSeOmwgj+HO7YqSKpKmjehNz0+FjRN1AS6w8+mAt05xqWSEmKbUYGOzRrJx+dyE
 1bkj/+KGqysmxPs3mBDGkU9zdJUZiU+m9Gu6uSYAMvRv1+xpCGiC2iy4Ct5zGmiYb5go
 5/eVcwP1nsi0D16/ExBvusi5Nd3HbaIXIVvf0vmva4SQoIDAiFSTjG+hyVBUTx3mFZ/W
 shEg==
X-Gm-Message-State: ANhLgQ26akZSJS+fh5Z7q9k4HL8wBozMFvTq5AUXltqdcOQ3lcL2tHaJ
 67Z6zb3jaXVVmjveZ/fKROfTRtZp4MszywcBnPl3Hg==
X-Google-Smtp-Source: ADFU+vvgEJnoSP/oL3V2KZjd3vA9uvn0g+FUlmvXowQyOzBzyp4lXMEUZMEnWqiPW3KVq1NsR4ZnRwrXfWP2yxXsQUg=
X-Received: by 2002:a5b:a8e:: with SMTP id h14mr7070102ybq.48.1583996568014;
 Thu, 12 Mar 2020 00:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-2-yuri.benditovich@daynix.com>
 <20200311094553-mutt-send-email-mst@kernel.org>
 <CAOEp5OdgDB5u-SeZO3y4iCTjFy6hpNfPA-ADaBbnvx=MHD_dTw@mail.gmail.com>
 <20200311161819-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200311161819-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 12 Mar 2020 09:02:38 +0200
Message-ID: <CAOEp5OcrWewBYNT8TT6r1oFc=diq-HoGfe-zXwXPNSP0RguFkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] virtio-net: introduce RSS and hash report features
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c328e605a0a2f0da"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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

--000000000000c328e605a0a2f0da
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 11, 2020 at 10:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Mar 11, 2020 at 03:57:58PM +0200, Yuri Benditovich wrote:
> >
> >
> > On Wed, Mar 11, 2020 at 3:47 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Wed, Mar 11, 2020 at 02:35:13PM +0200, Yuri Benditovich wrote:
> >     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> >     > ---
> >     >  hw/net/virtio-net.c | 95
> +++++++++++++++++++++++++++++++++++++++++++++
> >     >  1 file changed, 95 insertions(+)
> >     >
> >     > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >     > index 3627bb1717..9545b0e84f 100644
> >     > --- a/hw/net/virtio-net.c
> >     > +++ b/hw/net/virtio-net.c
> >     > @@ -71,6 +71,101 @@
> >     >  #define VIRTIO_NET_IP6_ADDR_SIZE   32      /* ipv6 saddr + daddr
> */
> >     >  #define VIRTIO_NET_MAX_IP6_PAYLOAD VIRTIO_NET_MAX_TCP_PAYLOAD
> >     >
> >     > +/* TODO: remove after virtio-net header update */
> >     > +#if !defined(VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> >     > +#define VIRTIO_NET_F_HASH_REPORT    57  /* Supports hash report */
> >     > +#define VIRTIO_NET_F_RSS            60  /* Supports RSS RX
> steering */
> >     > +
> >     > +/* supported/enabled hash types */
> >     > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> >     > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> >     > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> >     > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> >     > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> >     > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> >     > +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> >     > +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> >     > +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> >     > +
> >     > +#define __le16 uint16_t
> >     > +#define __le32 uint32_t
> >     > +#define __u8   uint8_t
> >     > +#define __u16  uint16_t
> >     > +#define __u32  uint32_t
> >
> >     Let's just use uint16_t etc directly please.
> >
> >     > +struct virtio_net_config_with_rss {
> >     > +    /* The config defining mac address (if VIRTIO_NET_F_MAC) */
> >     > +    __u8 mac[ETH_ALEN];
> >     > +    /* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
> >     > +    __u16 status;
> >     > +    /*
> >     > +     * Maximum number of each of transmit and receive queues;
> >     > +     * see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
> >     > +     * Legal values are between 1 and 0x8000
> >     > +     */
> >     > +    __u16 max_virtqueue_pairs;
> >     > +    /* Default maximum transmit unit advice */
> >     > +    __u16 mtu;
> >     > +    /*
> >     > +     * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
> >     > +     * Any other value stands for unknown.
> >     > +     */
> >     > +    __u32 speed;
> >     > +    /*
> >     > +     * 0x00 - half duplex
> >     > +     * 0x01 - full duplex
> >     > +     * Any other value stands for unknown.
> >     > +     */
> >     > +    __u8 duplex;
> >     > +    /* maximum size of RSS key */
> >     > +    __u8 rss_max_key_size;
> >     > +    /* maximum number of indirection table entries */
> >     > +    __le16 rss_max_indirection_table_length;
> >     > +    /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> >     > +    __le32 supported_hash_types;
> >     > +} __attribute__((packed));
> >     > +
> >     > +#define virtio_net_config virtio_net_config_with_rss
> >
> >     Do we have to? Let's just tweak code to do the right thing...
> >
> >
> > Are we going to update the virtio_net some time?
> > If yes, IMO makes sense to do less tweaking in the middle of the code.
> > Then, upon update of virtio_net.h - easily remove all these defines that
> were
> > added in virtio-net.c
>
> We'll update it in a month or two. But I'd be reluctant to merge hacks
> since people tend to copy-paste code ...
>

I agree that merging hacks is very bad practice.
Which change is more looks like a hack: redefine the struct to its _real_
layout or change the type of the struct in 5 places?



>
> >
> >
> >     > +
> >     > +struct virtio_net_hdr_v1_hash {
> >     > +    struct virtio_net_hdr_v1 hdr;
> >     > +    __le32 hash_value;
> >     > +#define VIRTIO_NET_HASH_REPORT_NONE            0
> >     > +#define VIRTIO_NET_HASH_REPORT_IPv4            1
> >     > +#define VIRTIO_NET_HASH_REPORT_TCPv4           2
> >     > +#define VIRTIO_NET_HASH_REPORT_UDPv4           3
> >     > +#define VIRTIO_NET_HASH_REPORT_IPv6            4
> >     > +#define VIRTIO_NET_HASH_REPORT_TCPv6           5
> >     > +#define VIRTIO_NET_HASH_REPORT_UDPv6           6
> >     > +#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> >     > +#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> >     > +#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >     > +    __le16 hash_report;
> >     > +    __le16 padding;
> >     > +};
> >     > +
> >     > +/*
> >     > + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect
> as
> >     > + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally
> configures
> >     > + * the receive steering to use a hash calculated for incoming
> packet
> >     > + * to decide on receive virtqueue to place the packet. The command
> >     > + * also provides parameters to calculate a hash and receive
> virtqueue.
> >     > + */
> >     > +struct virtio_net_rss_config {
> >     > +    __le32 hash_types;
> >     > +    __le16 indirection_table_mask;
> >     > +    __le16 unclassified_queue;
> >     > +    __le16 indirection_table[1/* + indirection_table_mask */];
> >     > +    __le16 max_tx_vq;
> >     > +    __u8 hash_key_length;
> >     > +    __u8 hash_key_data[/* hash_key_length */];
> >     > +};
> >     > +
> >     > +#define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> >     > +#define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
> >     > +
> >     > +#endif
> >     > +
> >     >  /* Purge coalesced packets timer interval, This value affects the
> >     performance
> >     >     a lot, and should be tuned carefully, '300000'(300us) is the
> >     recommended
> >     >     value to pass the WHQL test, '50000' can gain 2x netperf
> throughput
> >     with
> >     > --
> >     > 2.17.1
> >
> >
>
>

--000000000000c328e605a0a2f0da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 11, 2020 at 10:19 PM Mich=
ael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, =
Mar 11, 2020 at 03:57:58PM +0200, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Mar 11, 2020 at 3:47 PM Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Wed, Mar 11, 2020 at 02:35:13PM +0200, Yuri Bend=
itovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D=
"mailto:yuri.benditovich@daynix.com" target=3D"_blank">yuri.benditovich@day=
nix.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 hw/net/virtio-net.c | 95 +++++++++++++++=
++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 95 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virt=
io-net.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 3627bb1717..9545b0e84f 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/hw/net/virtio-net.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/hw/net/virtio-net.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -71,6 +71,101 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 #define VIRTIO_NET_IP6_ADDR_SIZE=C2=A0 =
=C2=A032=C2=A0 =C2=A0 =C2=A0 /* ipv6 saddr + daddr */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 #define VIRTIO_NET_MAX_IP6_PAYLOAD VIRTI=
O_NET_MAX_TCP_PAYLOAD<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +/* TODO: remove after virtio-net header updat=
e */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#if !defined(VIRTIO_NET_RSS_HASH_TYPE_IPv4)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_F_HASH_REPORT=C2=A0 =C2=A0=
 57=C2=A0 /* Supports hash report */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_F_RSS=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 60=C2=A0 /* Supports RSS RX steering */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +/* supported/enabled hash types */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 4)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 5)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 6)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 7)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 8)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define __le16 uint16_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define __le32 uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define __u8=C2=A0 =C2=A0uint8_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define __u16=C2=A0 uint16_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define __u32=C2=A0 uint32_t<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Let&#39;s just use uint16_t etc directly please.<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +struct virtio_net_config_with_rss {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /* The config defining mac addr=
ess (if VIRTIO_NET_F_MAC) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __u8 mac[ETH_ALEN];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /* See VIRTIO_NET_F_STATUS and =
VIRTIO_NET_S_* above */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __u16 status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* Maximum number of each =
of transmit and receive queues;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* see VIRTIO_NET_F_MQ and=
 VIRTIO_NET_CTRL_MQ.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* Legal values are betwee=
n 1 and 0x8000<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __u16 max_virtqueue_pairs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /* Default maximum transmit uni=
t advice */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __u16 mtu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* speed, in units of 1Mb.=
 All values 0 to INT_MAX are legal.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* Any other value stands =
for unknown.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __u32 speed;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* 0x00 - half duplex<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* 0x01 - full duplex<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0* Any other value stands =
for unknown.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __u8 duplex;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /* maximum size of RSS key */<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __u8 rss_max_key_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /* maximum number of indirectio=
n table entries */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le16 rss_max_indirection_tabl=
e_length;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 /* bitmask of supported VIRTIO_=
NET_RSS_HASH_ types */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le32 supported_hash_types;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +} __attribute__((packed));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define virtio_net_config virtio_net_config_w=
ith_rss<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Do we have to? Let&#39;s just tweak code to do the =
right thing...<br>
&gt; <br>
&gt; <br>
&gt; Are we going to update the virtio_net some time?<br>
&gt; If yes, IMO makes sense to do less tweaking in the middle of the code.=
<br>
&gt; Then, upon update of virtio_net.h - easily remove all these defines th=
at were<br>
&gt; added in virtio-net.c=C2=A0<br>
<br>
We&#39;ll update it in a month or two. But I&#39;d be reluctant to merge ha=
cks<br>
since people tend to copy-paste code ...<br></blockquote><div><br></div><di=
v>I agree that merging hacks is very bad practice.</div><div>Which change i=
s more looks like a hack: redefine the struct to its _real_ layout or chang=
e the type of the struct in 5 places?</div><div><br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +struct virtio_net_hdr_v1_hash {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 struct virtio_net_hdr_v1 hdr;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le32 hash_value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_NONE=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_IPv4=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_TCPv4=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_UDPv4=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_IPv6=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_TCPv6=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_UDPv6=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_IPv6_EX=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A07<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_TCPv6_EX=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_HASH_REPORT_UDPv6_EX=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 9<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le16 hash_report;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le16 padding;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG =
has the same effect as<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and a=
dditionally configures<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * the receive steering to use a hash calcula=
ted for incoming packet<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * to decide on receive virtqueue to place th=
e packet. The command<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * also provides parameters to calculate a ha=
sh and receive virtqueue.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +struct virtio_net_rss_config {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le32 hash_types;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le16 indirection_table_mask;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le16 unclassified_queue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le16 indirection_table[1/* + =
indirection_table_mask */];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __le16 max_tx_vq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __u8 hash_key_length;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 __u8 hash_key_data[/* hash_key_=
length */];<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_CTRL_MQ_RSS_CONFIG=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define VIRTIO_NET_CTRL_MQ_HASH_CONFIG=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 /* Purge coalesced packets timer interva=
l, This value affects the<br>
&gt;=C2=A0 =C2=A0 =C2=A0performance<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0a lot, and should be tuned =
carefully, &#39;300000&#39;(300us) is the<br>
&gt;=C2=A0 =C2=A0 =C2=A0recommended<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0value to pass the WHQL test=
, &#39;50000&#39; can gain 2x netperf throughput<br>
&gt;=C2=A0 =C2=A0 =C2=A0with<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2.17.1<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000c328e605a0a2f0da--

