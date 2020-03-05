Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D92C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C622072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXBZ/ued"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C622072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wig-0008Oy-3M
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 15:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j9whx-0007nI-9a
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j9whv-0005if-73
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:03:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j9whu-0005h7-TQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583438577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSxo8W7zHFkcL4LqvFkaX3mASagEACBA7HaYmn2KRPE=;
 b=JXBZ/ued0/me5gXQsoXZyGBq3mTEsZG7G436yBOEv4Hh9sc8eM3q2o29vplgs5o4/5q/kJ
 yr0gu33f43OMm9478Lc/GK8Ueo6dIlxkTwxkWTDbkcvCEaRhuX4g5DBSI9T6caGZ6e48Q3
 Hh6ny82F57llqk5P8Op93rfTJEuGI1w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-YrlGHYrENamDPCKSR1SPZQ-1; Thu, 05 Mar 2020 15:02:56 -0500
X-MC-Unique: YrlGHYrENamDPCKSR1SPZQ-1
Received: by mail-qk1-f199.google.com with SMTP id l27so4631804qkl.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 12:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W7dkbghxkvYmyhKBcOMDJ0pSbunrR4dtnFb/vRE7PNg=;
 b=EfAQXnJw3EqwC4GKVLjwFYUSuHZYFi5KQOuN18AnysO3N1o40sRijlEhQN1pI1UY8+
 V9k5UjXkMfL8Svcy5M3YjTmueVFRffXPAif7j5kCfBMc/22dtrbOvgyQ0+gahMTJJF2W
 JrSEf1KB/Vv+06fWf+veYuChmqv7PliV/9ngeSYi1rJI2sZTomqK8UXN0SWpHoUid/Xc
 6itt0RW90PnUkEM4B6nOT4xGQLTKcEaVRaGwWW9OIitcBxCWMHzayA2ma4rqOg2k0dKz
 SveMW6z416lgz6iznpdu3d3adPhGC80BqzrCP8msoGXeJWQXsCvz8G2qLSvP7tKXZ1fv
 o7Sg==
X-Gm-Message-State: ANhLgQ3QQCUabrrh1Xs0xKRUTfpL+Nznzwhs1tpvOZQns2e6kSRRWcoD
 HqfCmj7ypxFlhORUvkPpruKo/YaXYIXr+KlzofRNq9PiUdQ5tarNcXszzy3VPTmNnEjXKXb7FOM
 gfmGKZrdgzAjinVM=
X-Received: by 2002:ac8:1688:: with SMTP id r8mr406361qtj.144.1583438575490;
 Thu, 05 Mar 2020 12:02:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtFjkxc6deTW2F3m5yV5QKgmBxWj2FJm6xmvEARrmgQUfBjNuXO0mJSuY1j83wJ1j5ImRiPAg==
X-Received: by 2002:ac8:1688:: with SMTP id r8mr406332qtj.144.1583438575085;
 Thu, 05 Mar 2020 12:02:55 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id x9sm2211427qtk.7.2020.03.05.12.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 12:02:54 -0800 (PST)
Date: Thu, 5 Mar 2020 15:02:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 3/3] virtio-net: implement RX RSS processing
Message-ID: <20200305150035-mutt-send-email-mst@kernel.org>
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <20200226174809.9675-4-yuri.benditovich@daynix.com>
 <20200305081857-mutt-send-email-mst@kernel.org>
 <CAOEp5OcQ1L31f60FPjL-Exsa3vxbnn575WU0fpMNFSo=pizOag@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OcQ1L31f60FPjL-Exsa3vxbnn575WU0fpMNFSo=pizOag@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Thu, Mar 05, 2020 at 09:54:31PM +0200, Yuri Benditovich wrote:
> On Thu, Mar 5, 2020 at 3:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Feb 26, 2020 at 07:48:09PM +0200, Yuri Benditovich wrote:
> > > If VIRTIO_NET_F_RSS negotiated and RSS is enabled, process
> > > incoming packets, calculate packet's hash and place the
> > > packet into respective RX virtqueue.
> > >
> > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > ---
> > >  hw/net/virtio-net.c            | 86 ++++++++++++++++++++++++++++++++=
+-
> > >  include/hw/virtio/virtio-net.h |  1 +
> > >  2 files changed, 85 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index c5d21675a9..adf7b88d7a 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -42,6 +42,7 @@
> > >  #include "trace.h"
> > >  #include "monitor/qdev.h"
> > >  #include "hw/pci/pci.h"
> > > +#include "net_rx_pkt.h"
> > >
> > >  #define VIRTIO_NET_VM_VERSION    11
> > >
> > > @@ -1515,8 +1516,78 @@ static int receive_filter(VirtIONet *n, const =
uint8_t *buf, int size)
> > >      return 0;
> > >  }
> > >
> > > +static uint8_t virtio_net_get_hash_type(bool isip4,
> > > +                                        bool isip6,
> > > +                                        bool isudp,
> > > +                                        bool istcp,
> > > +                                        uint32_t types)
> > > +{
> > > +    uint32_t mask;
> > > +    if (isip4) {
> > > +        if (istcp && (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4)) {
> > > +            return NetPktRssIpV4Tcp;
> > > +        }
> > > +        if (isudp && (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4)) {
> > > +            return NetPktRssIpV4Udp;
> > > +        }
> > > +        if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
> > > +            return NetPktRssIpV4;
> > > +        }
> > > +    } else if (isip6) {
> > > +        mask =3D VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | VIRTIO_NET_RSS_HA=
SH_TYPE_TCPv6;
> > > +        if (istcp && (types & mask)) {
> > > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_TCP_EX) ?
> > > +                NetPktRssIpV6TcpEx : NetPktRssIpV6Tcp;
> > > +        }
> > > +        mask =3D VIRTIO_NET_RSS_HASH_TYPE_UDP_EX | VIRTIO_NET_RSS_HA=
SH_TYPE_UDPv6;
> > > +        if (isudp && (types & mask)) {
> > > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_UDP_EX) ?
> > > +                NetPktRssIpV6UdpEx : NetPktRssIpV6Udp;
> > > +        }
> > > +        mask =3D VIRTIO_NET_RSS_HASH_TYPE_IP_EX | VIRTIO_NET_RSS_HAS=
H_TYPE_IPv6;
> > > +        if (types & mask) {
> > > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_IP_EX) ?
> > > +                NetPktRssIpV6Ex : NetPktRssIpV6;
> >
> >
> > BTW we really need to fix up hw/net/net_rx_pkt.h to match qemu
> > coding style.
> > Could you do it pls?
> >
>=20
> Can you please point on exact style problem in net_rx_pkt.h?

Two issues that I noticed:

- Use of "struct" instead of a typedef with struct names.
- Mixed case for enum values instead of upper case.



> > > +        }
> > > +    }
> > > +    return 0xff;
> > > +}
> > > +
> > > +static int virtio_net_process_rss(NetClientState *nc, const uint8_t =
*buf,
> > > +                                  size_t size)
> > > +{
> > > +    VirtIONet *n =3D qemu_get_nic_opaque(nc);
> > > +    unsigned int index =3D nc->queue_index, new_index;
> > > +    struct NetRxPkt *pkt =3D n->rss_data.pkt;
> > > +    uint8_t net_hash_type;
> > > +    uint32_t hash;
> > > +    bool isip4, isip6, isudp, istcp;
> > > +    net_rx_pkt_set_protocols(pkt, buf + n->host_hdr_len,
> > > +                             size - n->host_hdr_len);
> > > +    net_rx_pkt_get_protocols(pkt, &isip4, &isip6, &isudp, &istcp);
> > > +    if (isip4 && (net_rx_pkt_get_ip4_info(pkt)->fragment)) {
> > > +        istcp =3D isudp =3D false;
> > > +    }
> > > +    if (isip6 && (net_rx_pkt_get_ip6_info(pkt)->fragment)) {
> > > +        istcp =3D isudp =3D false;
> > > +    }
> > > +    net_hash_type =3D virtio_net_get_hash_type(isip4, isip6, isudp, =
istcp,
> > > +                                             n->rss_data.hash_types)=
;
> > > +    if (net_hash_type > NetPktRssIpV6UdpEx) {
> > > +        return n->rss_data.default_queue;
> > > +    }
> > > +
> > > +    hash =3D net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_dat=
a.key);
> > > +    new_index =3D hash & (n->rss_data.indirections_len - 1);
> > > +    new_index =3D n->rss_data.indirections[new_index];
> > > +    if (index =3D=3D new_index) {
> > > +        return -1;
> > > +    }
> > > +    return new_index;
> > > +}
> > > +
> > >  static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint=
8_t *buf,
> > > -                                      size_t size)
> > > +                                      size_t size, bool no_rss)
> > >  {
> > >      VirtIONet *n =3D qemu_get_nic_opaque(nc);
> > >      VirtIONetQueue *q =3D virtio_net_get_subqueue(nc);
> > > @@ -1530,6 +1601,14 @@ static ssize_t virtio_net_receive_rcu(NetClien=
tState *nc, const uint8_t *buf,
> > >          return -1;
> > >      }
> > >
> > > +    if (!no_rss && n->rss_data.enabled) {
> > > +        int index =3D virtio_net_process_rss(nc, buf, size);
> > > +        if (index >=3D 0) {
> > > +            NetClientState *nc2 =3D qemu_get_subqueue(n->nic, index)=
;
> > > +            return virtio_net_receive_rcu(nc2, buf, size, true);
> > > +        }
> > > +    }
> > > +
> > >      /* hdr_len refers to the header we supply to the guest */
> > >      if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host=
_hdr_len)) {
> > >          return 0;
> > > @@ -1624,7 +1703,7 @@ static ssize_t virtio_net_do_receive(NetClientS=
tate *nc, const uint8_t *buf,
> > >  {
> > >      RCU_READ_LOCK_GUARD();
> > >
> > > -    return virtio_net_receive_rcu(nc, buf, size);
> > > +    return virtio_net_receive_rcu(nc, buf, size, false);
> > >  }
> > >
> > >  static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
> > > @@ -3200,6 +3279,8 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)
> > >
> > >      QTAILQ_INIT(&n->rsc_chains);
> > >      n->qdev =3D dev;
> > > +
> > > +    net_rx_pkt_init(&n->rss_data.pkt, false);
> > >  }
> > >
> > >  static void virtio_net_device_unrealize(DeviceState *dev, Error **er=
rp)
> > > @@ -3236,6 +3317,7 @@ static void virtio_net_device_unrealize(DeviceS=
tate *dev, Error **errp)
> > >      g_free(n->vqs);
> > >      qemu_del_nic(n->nic);
> > >      virtio_net_rsc_cleanup(n);
> > > +    net_rx_pkt_uninit(n->rss_data.pkt);
> > >      virtio_cleanup(vdev);
> > >  }
> > >
> > > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virti=
o-net.h
> > > index cf16f5192e..45670dd054 100644
> > > --- a/include/hw/virtio/virtio-net.h
> > > +++ b/include/hw/virtio/virtio-net.h
> > > @@ -209,6 +209,7 @@ struct VirtIONet {
> > >          uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
> > >          uint16_t indirections_len;
> > >          uint16_t default_queue;
> > > +        struct NetRxPkt *pkt;
> > >      } rss_data;
> > >  };
> > >
> > > --
> > > 2.17.1
> >


