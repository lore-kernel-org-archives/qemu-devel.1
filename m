Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD498C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7167D20684
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="J6/z8rkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7167D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9xh2-0000J8-Ex
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 16:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j9xfz-00087R-IO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j9xfx-0002iY-FW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:05:03 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:38895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1j9xfx-0002hL-12
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:05:01 -0500
Received: by mail-yw1-xc43.google.com with SMTP id 10so127077ywv.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 13:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kZNktOCoZlSn/8Lvjv87Lr9GljeQT190qPZ7CTf/374=;
 b=J6/z8rkHEsVx494Q0O+O9S3nw2yYZWfF/+5n6Sjy5DJ8wadzptSqLizhAtMjjNccd/
 1PRiEwsO2Xt+WyWRHNhtT0/BzKc6Ra7kTPF9skeRwf2hduq9eeyYr4ROiVyMH5mnBkjy
 TUup5DNY6eUEMG7VsczMA72srlsxOQet/TOsitoudC4SvHu+Ixe+csLfUSrB48gh6nSH
 N/qrLDTY0hehclnR8haE2A4twmOIPdWA9cOtzgjFy6rroJrZGMA3LxLv1JrNf3PTCGGt
 +Ch/Y+BF5YKRZcpTlwtJ9zdM52Ou8L1rijf3590ueKASOCXqu6DQW9o1yucur0iCUE8Z
 rbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kZNktOCoZlSn/8Lvjv87Lr9GljeQT190qPZ7CTf/374=;
 b=uG+mSDWY0Js6fJlA77KVOlQE4JnJAb4LZW4UgKC9JpbXtC/PAC9VN/2oaUIKIC3wyG
 wQrPx5bymfs5Dd1ZNbBjfACQ3WN9OHjh7eGn7Zfdc+lMogSQibYPxedl2NmthNQybE0a
 +RXx+BevisqI/doOwAzO7zJCUNeFqcZlLP8AKnVnO56ri3uu8xzY9SzPKxkK3Gm9p2iy
 0fljaDSLR3HLIUiCH+YxoNzmT7LaIjBb55wqWrgrnmICIA0LxJp56gCpjJeTDXJWBqRq
 nX13QSejrVGXsvBi0Ky4qejZhGZFVSXcFzfRwnEPP9kw4gS9ttlwEYvJ4RFy2myXeUUV
 hliA==
X-Gm-Message-State: ANhLgQ2DC59wsTVTHBDJvl/YxtFtfZkTzGxi5tCsZRuv3WPiMP942kVc
 D1OtGK+smD5hi/yMQJtFVUkzKnHyR+f4eA89Cq8TIA==
X-Google-Smtp-Source: ADFU+vv8nUQ+6tylG1azewwdaVdBKPAmzNRpPuzICtH/hJaeSlVyDWOmX5SEHZMGZs2Hj0QeZK5BGIBxorBD2IwOgI8=
X-Received: by 2002:a0d:f305:: with SMTP id c5mr422861ywf.292.1583442300168;
 Thu, 05 Mar 2020 13:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <20200226174809.9675-4-yuri.benditovich@daynix.com>
 <20200305081857-mutt-send-email-mst@kernel.org>
 <CAOEp5OcQ1L31f60FPjL-Exsa3vxbnn575WU0fpMNFSo=pizOag@mail.gmail.com>
 <20200305150035-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200305150035-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 5 Mar 2020 23:04:48 +0200
Message-ID: <CAOEp5OcRFLjDaX_hSL=V3JwfCNb1JpmKxhT2tbc314U10YpDWg@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-net: implement RX RSS processing
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d2fec005a021e344"
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

--000000000000d2fec005a021e344
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 5, 2020 at 10:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Mar 05, 2020 at 09:54:31PM +0200, Yuri Benditovich wrote:
> > On Thu, Mar 5, 2020 at 3:20 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > >
> > > On Wed, Feb 26, 2020 at 07:48:09PM +0200, Yuri Benditovich wrote:
> > > > If VIRTIO_NET_F_RSS negotiated and RSS is enabled, process
> > > > incoming packets, calculate packet's hash and place the
> > > > packet into respective RX virtqueue.
> > > >
> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > ---
> > > >  hw/net/virtio-net.c            | 86
> +++++++++++++++++++++++++++++++++-
> > > >  include/hw/virtio/virtio-net.h |  1 +
> > > >  2 files changed, 85 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > index c5d21675a9..adf7b88d7a 100644
> > > > --- a/hw/net/virtio-net.c
> > > > +++ b/hw/net/virtio-net.c
> > > > @@ -42,6 +42,7 @@
> > > >  #include "trace.h"
> > > >  #include "monitor/qdev.h"
> > > >  #include "hw/pci/pci.h"
> > > > +#include "net_rx_pkt.h"
> > > >
> > > >  #define VIRTIO_NET_VM_VERSION    11
> > > >
> > > > @@ -1515,8 +1516,78 @@ static int receive_filter(VirtIONet *n, const
> uint8_t *buf, int size)
> > > >      return 0;
> > > >  }
> > > >
> > > > +static uint8_t virtio_net_get_hash_type(bool isip4,
> > > > +                                        bool isip6,
> > > > +                                        bool isudp,
> > > > +                                        bool istcp,
> > > > +                                        uint32_t types)
> > > > +{
> > > > +    uint32_t mask;
> > > > +    if (isip4) {
> > > > +        if (istcp && (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4)) {
> > > > +            return NetPktRssIpV4Tcp;
> > > > +        }
> > > > +        if (isudp && (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4)) {
> > > > +            return NetPktRssIpV4Udp;
> > > > +        }
> > > > +        if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
> > > > +            return NetPktRssIpV4;
> > > > +        }
> > > > +    } else if (isip6) {
> > > > +        mask = VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
> > > > +        if (istcp && (types & mask)) {
> > > > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_TCP_EX) ?
> > > > +                NetPktRssIpV6TcpEx : NetPktRssIpV6Tcp;
> > > > +        }
> > > > +        mask = VIRTIO_NET_RSS_HASH_TYPE_UDP_EX |
> VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
> > > > +        if (isudp && (types & mask)) {
> > > > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_UDP_EX) ?
> > > > +                NetPktRssIpV6UdpEx : NetPktRssIpV6Udp;
> > > > +        }
> > > > +        mask = VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> > > > +        if (types & mask) {
> > > > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_IP_EX) ?
> > > > +                NetPktRssIpV6Ex : NetPktRssIpV6;
> > >
> > >
> > > BTW we really need to fix up hw/net/net_rx_pkt.h to match qemu
> > > coding style.
> > > Could you do it pls?
> > >
> >
> > Can you please point on exact style problem in net_rx_pkt.h?
>
> Two issues that I noticed:
>
> - Use of "struct" instead of a typedef with struct names.
> - Mixed case for enum values instead of upper case.
>
>
I will discuss it with the maintainer of net_rx_pkt.
Note that struct without typedef especially allowed by qemu coding style
doc.
Note also that the doc rather requires camel case for enums and both
uppercase and camel case are widely used in the code.


>
>
> > > > +        }
> > > > +    }
> > > > +    return 0xff;
> > > > +}
> > > > +
> > > > +static int virtio_net_process_rss(NetClientState *nc, const uint8_t
> *buf,
> > > > +                                  size_t size)
> > > > +{
> > > > +    VirtIONet *n = qemu_get_nic_opaque(nc);
> > > > +    unsigned int index = nc->queue_index, new_index;
> > > > +    struct NetRxPkt *pkt = n->rss_data.pkt;
> > > > +    uint8_t net_hash_type;
> > > > +    uint32_t hash;
> > > > +    bool isip4, isip6, isudp, istcp;
> > > > +    net_rx_pkt_set_protocols(pkt, buf + n->host_hdr_len,
> > > > +                             size - n->host_hdr_len);
> > > > +    net_rx_pkt_get_protocols(pkt, &isip4, &isip6, &isudp, &istcp);
> > > > +    if (isip4 && (net_rx_pkt_get_ip4_info(pkt)->fragment)) {
> > > > +        istcp = isudp = false;
> > > > +    }
> > > > +    if (isip6 && (net_rx_pkt_get_ip6_info(pkt)->fragment)) {
> > > > +        istcp = isudp = false;
> > > > +    }
> > > > +    net_hash_type = virtio_net_get_hash_type(isip4, isip6, isudp,
> istcp,
> > > > +
>  n->rss_data.hash_types);
> > > > +    if (net_hash_type > NetPktRssIpV6UdpEx) {
> > > > +        return n->rss_data.default_queue;
> > > > +    }
> > > > +
> > > > +    hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type,
> n->rss_data.key);
> > > > +    new_index = hash & (n->rss_data.indirections_len - 1);
> > > > +    new_index = n->rss_data.indirections[new_index];
> > > > +    if (index == new_index) {
> > > > +        return -1;
> > > > +    }
> > > > +    return new_index;
> > > > +}
> > > > +
> > > >  static ssize_t virtio_net_receive_rcu(NetClientState *nc, const
> uint8_t *buf,
> > > > -                                      size_t size)
> > > > +                                      size_t size, bool no_rss)
> > > >  {
> > > >      VirtIONet *n = qemu_get_nic_opaque(nc);
> > > >      VirtIONetQueue *q = virtio_net_get_subqueue(nc);
> > > > @@ -1530,6 +1601,14 @@ static ssize_t
> virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> > > >          return -1;
> > > >      }
> > > >
> > > > +    if (!no_rss && n->rss_data.enabled) {
> > > > +        int index = virtio_net_process_rss(nc, buf, size);
> > > > +        if (index >= 0) {
> > > > +            NetClientState *nc2 = qemu_get_subqueue(n->nic, index);
> > > > +            return virtio_net_receive_rcu(nc2, buf, size, true);
> > > > +        }
> > > > +    }
> > > > +
> > > >      /* hdr_len refers to the header we supply to the guest */
> > > >      if (!virtio_net_has_buffers(q, size + n->guest_hdr_len -
> n->host_hdr_len)) {
> > > >          return 0;
> > > > @@ -1624,7 +1703,7 @@ static ssize_t
> virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
> > > >  {
> > > >      RCU_READ_LOCK_GUARD();
> > > >
> > > > -    return virtio_net_receive_rcu(nc, buf, size);
> > > > +    return virtio_net_receive_rcu(nc, buf, size, false);
> > > >  }
> > > >
> > > >  static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
> > > > @@ -3200,6 +3279,8 @@ static void
> virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > >
> > > >      QTAILQ_INIT(&n->rsc_chains);
> > > >      n->qdev = dev;
> > > > +
> > > > +    net_rx_pkt_init(&n->rss_data.pkt, false);
> > > >  }
> > > >
> > > >  static void virtio_net_device_unrealize(DeviceState *dev, Error
> **errp)
> > > > @@ -3236,6 +3317,7 @@ static void
> virtio_net_device_unrealize(DeviceState *dev, Error **errp)
> > > >      g_free(n->vqs);
> > > >      qemu_del_nic(n->nic);
> > > >      virtio_net_rsc_cleanup(n);
> > > > +    net_rx_pkt_uninit(n->rss_data.pkt);
> > > >      virtio_cleanup(vdev);
> > > >  }
> > > >
> > > > diff --git a/include/hw/virtio/virtio-net.h
> b/include/hw/virtio/virtio-net.h
> > > > index cf16f5192e..45670dd054 100644
> > > > --- a/include/hw/virtio/virtio-net.h
> > > > +++ b/include/hw/virtio/virtio-net.h
> > > > @@ -209,6 +209,7 @@ struct VirtIONet {
> > > >          uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
> > > >          uint16_t indirections_len;
> > > >          uint16_t default_queue;
> > > > +        struct NetRxPkt *pkt;
> > > >      } rss_data;
> > > >  };
> > > >
> > > > --
> > > > 2.17.1
> > >
>
>

--000000000000d2fec005a021e344
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 5, 2020 at 10:02 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, M=
ar 05, 2020 at 09:54:31PM +0200, Yuri Benditovich wrote:<br>
&gt; On Thu, Mar 5, 2020 at 3:20 PM Michael S. Tsirkin &lt;<a href=3D"mailt=
o:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Feb 26, 2020 at 07:48:09PM +0200, Yuri Benditovich wrote:=
<br>
&gt; &gt; &gt; If VIRTIO_NET_F_RSS negotiated and RSS is enabled, process<b=
r>
&gt; &gt; &gt; incoming packets, calculate packet&#39;s hash and place the<=
br>
&gt; &gt; &gt; packet into respective RX virtqueue.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.b=
enditovich@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt=
;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 86 +++++++++++++++++++++++++++++++++-<br>
&gt; &gt; &gt;=C2=A0 include/hw/virtio/virtio-net.h |=C2=A0 1 +<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 85 insertions(+), 2 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; &gt; &gt; index c5d21675a9..adf7b88d7a 100644<br>
&gt; &gt; &gt; --- a/hw/net/virtio-net.c<br>
&gt; &gt; &gt; +++ b/hw/net/virtio-net.c<br>
&gt; &gt; &gt; @@ -42,6 +42,7 @@<br>
&gt; &gt; &gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;monitor/qdev.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;hw/pci/pci.h&quot;<br>
&gt; &gt; &gt; +#include &quot;net_rx_pkt.h&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #define VIRTIO_NET_VM_VERSION=C2=A0 =C2=A0 11<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1515,8 +1516,78 @@ static int receive_filter(VirtIONet *=
n, const uint8_t *buf, int size)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +static uint8_t virtio_net_get_hash_type(bool isip4,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bool isip6,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bool isudp,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bool istcp,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint32_t types)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t mask;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (isip4) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (istcp &amp;&amp; (types &am=
p; VIRTIO_NET_RSS_HASH_TYPE_TCPv4)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NetPktRssI=
pV4Tcp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isudp &amp;&amp; (types &am=
p; VIRTIO_NET_RSS_HASH_TYPE_UDPv4)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NetPktRssI=
pV4Udp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (types &amp; VIRTIO_NET_RSS_=
HASH_TYPE_IPv4) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NetPktRssI=
pV4;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 } else if (isip6) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D VIRTIO_NET_RSS_HASH_TY=
PE_TCP_EX | VIRTIO_NET_RSS_HASH_TYPE_TCPv6;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (istcp &amp;&amp; (types &am=
p; mask)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (types &am=
p; VIRTIO_NET_RSS_HASH_TYPE_TCP_EX) ?<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Net=
PktRssIpV6TcpEx : NetPktRssIpV6Tcp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D VIRTIO_NET_RSS_HASH_TY=
PE_UDP_EX | VIRTIO_NET_RSS_HASH_TYPE_UDPv6;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isudp &amp;&amp; (types &am=
p; mask)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (types &am=
p; VIRTIO_NET_RSS_HASH_TYPE_UDP_EX) ?<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Net=
PktRssIpV6UdpEx : NetPktRssIpV6Udp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D VIRTIO_NET_RSS_HASH_TY=
PE_IP_EX | VIRTIO_NET_RSS_HASH_TYPE_IPv6;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (types &amp; mask) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (types &am=
p; VIRTIO_NET_RSS_HASH_TYPE_IP_EX) ?<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Net=
PktRssIpV6Ex : NetPktRssIpV6;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; BTW we really need to fix up hw/net/net_rx_pkt.h to match qemu<br=
>
&gt; &gt; coding style.<br>
&gt; &gt; Could you do it pls?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Can you please point on exact style problem in net_rx_pkt.h?<br>
<br>
Two issues that I noticed:<br>
<br>
- Use of &quot;struct&quot; instead of a typedef with struct names.<br>
- Mixed case for enum values instead of upper case.<br>
<br></blockquote><div><br></div><div>I will discuss it with the maintainer =
of net_rx_pkt.</div><div>Note that struct without typedef especially allowe=
d by qemu coding style doc.</div><div>Note also that the doc rather require=
s camel case for enums and both uppercase and camel case are widely used in=
 the code.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return 0xff;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static int virtio_net_process_rss(NetClientState *nc, const=
 uint8_t *buf,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size)<br=
>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 VirtIONet *n =3D qemu_get_nic_opaque(nc);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 unsigned int index =3D nc-&gt;queue_index, ne=
w_index;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 struct NetRxPkt *pkt =3D n-&gt;rss_data.pkt;<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint8_t net_hash_type;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint32_t hash;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 bool isip4, isip6, isudp, istcp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 net_rx_pkt_set_protocols(pkt, buf + n-&gt;hos=
t_hdr_len,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size - n-&gt;host_hdr_len);<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 net_rx_pkt_get_protocols(pkt, &amp;isip4, &am=
p;isip6, &amp;isudp, &amp;istcp);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (isip4 &amp;&amp; (net_rx_pkt_get_ip4_info=
(pkt)-&gt;fragment)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 istcp =3D isudp =3D false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (isip6 &amp;&amp; (net_rx_pkt_get_ip6_info=
(pkt)-&gt;fragment)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 istcp =3D isudp =3D false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 net_hash_type =3D virtio_net_get_hash_type(is=
ip4, isip6, isudp, istcp,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0n-&gt;rss_data.hash_types);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (net_hash_type &gt; NetPktRssIpV6UdpEx) {<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return n-&gt;rss_data.default_q=
ueue;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 hash =3D net_rx_pkt_calc_rss_hash(pkt, net_ha=
sh_type, n-&gt;rss_data.key);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 new_index =3D hash &amp; (n-&gt;rss_data.indi=
rections_len - 1);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 new_index =3D n-&gt;rss_data.indirections[new=
_index];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (index =3D=3D new_index) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return new_index;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 static ssize_t virtio_net_receive_rcu(NetClientState *=
nc, const uint8_t *buf,<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
ize_t size)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
ize_t size, bool no_rss)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D qemu_get_nic_opaque(nc)=
;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtIONetQueue *q =3D virtio_net_get_sub=
queue(nc);<br>
&gt; &gt; &gt; @@ -1530,6 +1601,14 @@ static ssize_t virtio_net_receive_rcu=
(NetClientState *nc, const uint8_t *buf,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!no_rss &amp;&amp; n-&gt;rss_data.enabled=
) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int index =3D virtio_net_proces=
s_rss(nc, buf, size);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (index &gt;=3D 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NetClientState *n=
c2 =3D qemu_get_subqueue(n-&gt;nic, index);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return virtio_net=
_receive_rcu(nc2, buf, size, true);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* hdr_len refers to the header we suppl=
y to the guest */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!virtio_net_has_buffers(q, size + n-=
&gt;guest_hdr_len - n-&gt;host_hdr_len)) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; @@ -1624,7 +1703,7 @@ static ssize_t virtio_net_do_receive(N=
etClientState *nc, const uint8_t *buf,<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 RCU_READ_LOCK_GUARD();<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 return virtio_net_receive_rcu(nc, buf, size);=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return virtio_net_receive_rcu(nc, buf, size, =
false);<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 static void virtio_net_rsc_extract_unit4(VirtioNetRscC=
hain *chain,<br>
&gt; &gt; &gt; @@ -3200,6 +3279,8 @@ static void virtio_net_device_realize(=
DeviceState *dev, Error **errp)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 QTAILQ_INIT(&amp;n-&gt;rsc_chains);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;qdev =3D dev;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 net_rx_pkt_init(&amp;n-&gt;rss_data.pkt, fals=
e);<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 static void virtio_net_device_unrealize(DeviceState *d=
ev, Error **errp)<br>
&gt; &gt; &gt; @@ -3236,6 +3317,7 @@ static void virtio_net_device_unrealiz=
e(DeviceState *dev, Error **errp)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_free(n-&gt;vqs);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 qemu_del_nic(n-&gt;nic);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 virtio_net_rsc_cleanup(n);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 net_rx_pkt_uninit(n-&gt;rss_data.pkt);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 virtio_cleanup(vdev);<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/include/hw/virtio/virtio-net.h b/include/hw/vir=
tio/virtio-net.h<br>
&gt; &gt; &gt; index cf16f5192e..45670dd054 100644<br>
&gt; &gt; &gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt; &gt; &gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt; &gt; &gt; @@ -209,6 +209,7 @@ struct VirtIONet {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t indirections[VIRT=
IO_NET_RSS_MAX_TABLE_LEN];<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t indirections_len;=
<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t default_queue;<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct NetRxPkt *pkt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 } rss_data;<br>
&gt; &gt; &gt;=C2=A0 };<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.17.1<br>
&gt; &gt;<br>
<br>
</blockquote></div></div>

--000000000000d2fec005a021e344--

