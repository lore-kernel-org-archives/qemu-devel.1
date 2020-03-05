Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23462C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D3C2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="KI7zS8xS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D3C2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9waj-0001um-5Q
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j9wZx-0001Sv-V4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j9wZw-0006Xi-LL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:54:45 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:44282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1j9wZw-0006Wu-4j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:54:44 -0500
Received: by mail-yw1-xc41.google.com with SMTP id t141so6808757ywc.11
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mBOjhlCdI6P8HwaqP93p8j4PZUbvHY5NpGg9Jua2VVE=;
 b=KI7zS8xS5ZcM51Flmi4pMakngwgg/Dgt3//32GFe5uJFzj8saEw8BqZVFka5C9xgBg
 H3J1dUDex2puepNN8kiXoprVGQXJaqOadvmQ3UVd6reeeQVFmRx6owHiy4WYyMZSBpgj
 S7J7IuznW2Mozw96pPxQd/kBX8Er2SK5K3KYClU8Tpcq5kIGhdV9oCJs1UdBGJuzE6Pk
 1AWITCbhw22o6Q8Ih5TqFv6LIVF4HfM9uREP5ip2JUdmBWWagW2Hl+qk4LA0klo7/RdC
 JDAIv4RF5LO76KlKwUAa7ZHLsm7EO9kiHWgBg9Qn2SvfrR9Q0nXI34EJaoGzv1zjYYUO
 kT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mBOjhlCdI6P8HwaqP93p8j4PZUbvHY5NpGg9Jua2VVE=;
 b=DpL/Zx6tBFrwv/7+lNXSJwXHoBvEOkFUUeafpiRnf9REcQ2Is/r3BEqfHCfpmA0GgE
 H7aLm9f43q3XHXAw4EggsxI7aSzO2CFDlW/BRmXX5jhj9vXEJhCY7hpsjCKcv30IO7WL
 vybZrLOuodyKApI+/xVlU9xzJ7HUidZeg7wuQJ3EO2Y5zJrzVPc7A+a/Sx4wXQTsTQBX
 V4A7N/jwUMrhT9cPRnOM5mAR1jEzH+Z8Inhh4xw7coUj0EGdj9ic/l2Y8Qgl3suyKLcR
 ISIUtilgQ6zwLU+iEf034jXhDuYlPr/LtZmPp5c2OuJukrxMRTReMNE7SsrqVafSG4Ri
 jQwA==
X-Gm-Message-State: ANhLgQ1Z94diQ02OdjBYKJmtPeygdXRvJCpLojPztT1TI77E7Y4zcJUb
 IgcQmRfZ3kLXDl/8C5ZyKIgrWtrlrqZtw+VqSWcHxg==
X-Google-Smtp-Source: ADFU+vuuIoVktw9udFMBOzg8ml7qK9oRLgvcblVCNdWXFz8y1Sq/o0NBAa0cIpmNPEA82RCXrTV5tvRF4BgS1fOcU1U=
X-Received: by 2002:a05:6902:6b0:: with SMTP id
 j16mr9633940ybt.370.1583438082940; 
 Thu, 05 Mar 2020 11:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <20200226174809.9675-4-yuri.benditovich@daynix.com>
 <20200305081857-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200305081857-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 5 Mar 2020 21:54:31 +0200
Message-ID: <CAOEp5OcQ1L31f60FPjL-Exsa3vxbnn575WU0fpMNFSo=pizOag@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-net: implement RX RSS processing
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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

On Thu, Mar 5, 2020 at 3:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 26, 2020 at 07:48:09PM +0200, Yuri Benditovich wrote:
> > If VIRTIO_NET_F_RSS negotiated and RSS is enabled, process
> > incoming packets, calculate packet's hash and place the
> > packet into respective RX virtqueue.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >  hw/net/virtio-net.c            | 86 +++++++++++++++++++++++++++++++++-
> >  include/hw/virtio/virtio-net.h |  1 +
> >  2 files changed, 85 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index c5d21675a9..adf7b88d7a 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -42,6 +42,7 @@
> >  #include "trace.h"
> >  #include "monitor/qdev.h"
> >  #include "hw/pci/pci.h"
> > +#include "net_rx_pkt.h"
> >
> >  #define VIRTIO_NET_VM_VERSION    11
> >
> > @@ -1515,8 +1516,78 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
> >      return 0;
> >  }
> >
> > +static uint8_t virtio_net_get_hash_type(bool isip4,
> > +                                        bool isip6,
> > +                                        bool isudp,
> > +                                        bool istcp,
> > +                                        uint32_t types)
> > +{
> > +    uint32_t mask;
> > +    if (isip4) {
> > +        if (istcp && (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4)) {
> > +            return NetPktRssIpV4Tcp;
> > +        }
> > +        if (isudp && (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4)) {
> > +            return NetPktRssIpV4Udp;
> > +        }
> > +        if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
> > +            return NetPktRssIpV4;
> > +        }
> > +    } else if (isip6) {
> > +        mask = VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
> > +        if (istcp && (types & mask)) {
> > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_TCP_EX) ?
> > +                NetPktRssIpV6TcpEx : NetPktRssIpV6Tcp;
> > +        }
> > +        mask = VIRTIO_NET_RSS_HASH_TYPE_UDP_EX | VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
> > +        if (isudp && (types & mask)) {
> > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_UDP_EX) ?
> > +                NetPktRssIpV6UdpEx : NetPktRssIpV6Udp;
> > +        }
> > +        mask = VIRTIO_NET_RSS_HASH_TYPE_IP_EX | VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> > +        if (types & mask) {
> > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_IP_EX) ?
> > +                NetPktRssIpV6Ex : NetPktRssIpV6;
>
>
> BTW we really need to fix up hw/net/net_rx_pkt.h to match qemu
> coding style.
> Could you do it pls?
>

Can you please point on exact style problem in net_rx_pkt.h?

> > +        }
> > +    }
> > +    return 0xff;
> > +}
> > +
> > +static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
> > +                                  size_t size)
> > +{
> > +    VirtIONet *n = qemu_get_nic_opaque(nc);
> > +    unsigned int index = nc->queue_index, new_index;
> > +    struct NetRxPkt *pkt = n->rss_data.pkt;
> > +    uint8_t net_hash_type;
> > +    uint32_t hash;
> > +    bool isip4, isip6, isudp, istcp;
> > +    net_rx_pkt_set_protocols(pkt, buf + n->host_hdr_len,
> > +                             size - n->host_hdr_len);
> > +    net_rx_pkt_get_protocols(pkt, &isip4, &isip6, &isudp, &istcp);
> > +    if (isip4 && (net_rx_pkt_get_ip4_info(pkt)->fragment)) {
> > +        istcp = isudp = false;
> > +    }
> > +    if (isip6 && (net_rx_pkt_get_ip6_info(pkt)->fragment)) {
> > +        istcp = isudp = false;
> > +    }
> > +    net_hash_type = virtio_net_get_hash_type(isip4, isip6, isudp, istcp,
> > +                                             n->rss_data.hash_types);
> > +    if (net_hash_type > NetPktRssIpV6UdpEx) {
> > +        return n->rss_data.default_queue;
> > +    }
> > +
> > +    hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
> > +    new_index = hash & (n->rss_data.indirections_len - 1);
> > +    new_index = n->rss_data.indirections[new_index];
> > +    if (index == new_index) {
> > +        return -1;
> > +    }
> > +    return new_index;
> > +}
> > +
> >  static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> > -                                      size_t size)
> > +                                      size_t size, bool no_rss)
> >  {
> >      VirtIONet *n = qemu_get_nic_opaque(nc);
> >      VirtIONetQueue *q = virtio_net_get_subqueue(nc);
> > @@ -1530,6 +1601,14 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
> >          return -1;
> >      }
> >
> > +    if (!no_rss && n->rss_data.enabled) {
> > +        int index = virtio_net_process_rss(nc, buf, size);
> > +        if (index >= 0) {
> > +            NetClientState *nc2 = qemu_get_subqueue(n->nic, index);
> > +            return virtio_net_receive_rcu(nc2, buf, size, true);
> > +        }
> > +    }
> > +
> >      /* hdr_len refers to the header we supply to the guest */
> >      if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
> >          return 0;
> > @@ -1624,7 +1703,7 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
> >  {
> >      RCU_READ_LOCK_GUARD();
> >
> > -    return virtio_net_receive_rcu(nc, buf, size);
> > +    return virtio_net_receive_rcu(nc, buf, size, false);
> >  }
> >
> >  static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
> > @@ -3200,6 +3279,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> >
> >      QTAILQ_INIT(&n->rsc_chains);
> >      n->qdev = dev;
> > +
> > +    net_rx_pkt_init(&n->rss_data.pkt, false);
> >  }
> >
> >  static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
> > @@ -3236,6 +3317,7 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
> >      g_free(n->vqs);
> >      qemu_del_nic(n->nic);
> >      virtio_net_rsc_cleanup(n);
> > +    net_rx_pkt_uninit(n->rss_data.pkt);
> >      virtio_cleanup(vdev);
> >  }
> >
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> > index cf16f5192e..45670dd054 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -209,6 +209,7 @@ struct VirtIONet {
> >          uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
> >          uint16_t indirections_len;
> >          uint16_t default_queue;
> > +        struct NetRxPkt *pkt;
> >      } rss_data;
> >  };
> >
> > --
> > 2.17.1
>

