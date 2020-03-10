Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11825C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C82320727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="f400WaS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C82320727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbzG-0005Xx-Ht
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBbyP-0004uu-KC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBbyO-0006zQ-AN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:18:53 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:33470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jBbyN-0006rr-V0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:18:52 -0400
Received: by mail-yw1-xc42.google.com with SMTP id j186so13147240ywe.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DQ+Ezx+0gy/mLJbBzP38vOaqQJNHWm0H2BcNWkNBAVI=;
 b=f400WaS/3rpJInj8cYqTwXjELKAYyG2RGADKVcb/f7YqxzbtZWmVWwTdH+v1pe2MAo
 m+TNBS4Nm86MEzLuxDZUE6RaoqCWP95/9MBamRBeBdL63R+xa7LTphLMiLzPd+IIqSq8
 oDAJUITZrsZVbZc173HHdPeYOnH3lT9dCLMWB5zt88xANTWhnn/LHnsyOh/lyP5xvRmy
 UP9t9Y3CFq88boJYKQLYfes4vG7AkTqUsKrysl3nGpr4ybs5C5G9fsciTZxFl5tqrjKk
 SG9DoNeLUtv/88+M9twiI2UztNqZdkGUYCcAnLtmHgBbO1VjH/SEDwynC1TErjd4S33y
 YKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DQ+Ezx+0gy/mLJbBzP38vOaqQJNHWm0H2BcNWkNBAVI=;
 b=QlP4r0x95BkOghpj2wwHpVIrjtIt97n09zJsOJwWv38anhAzGtV/vO9rOpBdv3rfpQ
 TIigZ9hUjW/zIgc0tkxfwJdszieeJmYhHWTbmVqhITbCylAQklW18USr321cnmJKV4q0
 5ryz8P1B1X1z0e13ET9ESL++c74eh0V0NVTsatA2Q5yFqWj/7rbz5yHIN++ntQe0Fujz
 VNDciNbA0Dm589N7yBoK7tO3qCq71QLokuWQGyWVIZf6KiWX9cKBKH9fHmW3Hkw0XTzX
 NHBOQq+7T4rqgJNIa0fNUkzU1d+00NRJ8E6nv77mULXeog66mWbxQxCK/ZGCJT/HjrzD
 FIzQ==
X-Gm-Message-State: ANhLgQ09htAfnsTzrQspVI0p+gXmg7EFqiPh63rJByy3kqaVLeQRvf7z
 v+wK/mDXV3nvm8jucqgc9VROYjLerXoctgIQ9AiyRQ==
X-Google-Smtp-Source: ADFU+vv6zNZB+AC61CSzDU0BP/FSn6PxiAL0OWgiwuuenrKiH/EYi68zmWyZjqoQjDK4ysBWc5cB/lfkmMVRsmX3jsk=
X-Received: by 2002:a05:6902:6b0:: with SMTP id
 j16mr22860651ybt.370.1583835530546; 
 Tue, 10 Mar 2020 03:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
 <20200309083438.2389-4-yuri.benditovich@daynix.com>
 <4dc38e82-ed58-9835-5e27-f893b9580152@redhat.com>
In-Reply-To: <4dc38e82-ed58-9835-5e27-f893b9580152@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 10 Mar 2020 12:18:38 +0200
Message-ID: <CAOEp5OeEQn39StVHQHycC1s+DoX6iOnRAuKwc4OuFHdEkUUYDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] virtio-net: implement RX RSS processing
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 5:10 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/3/9 =E4=B8=8B=E5=8D=884:34, Yuri Benditovich wrote:
> > If VIRTIO_NET_F_RSS negotiated and RSS is enabled, process
> > incoming packets, calculate packet's hash and place the
> > packet into respective RX virtqueue.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >   hw/net/virtio-net.c            | 86 +++++++++++++++++++++++++++++++++=
-
> >   include/hw/virtio/virtio-net.h |  1 +
> >   2 files changed, 85 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 27071eccd2..abc41fdb16 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -42,6 +42,7 @@
> >   #include "trace.h"
> >   #include "monitor/qdev.h"
> >   #include "hw/pci/pci.h"
> > +#include "net_rx_pkt.h"
> >
> >   #define VIRTIO_NET_VM_VERSION    11
> >
> > @@ -1610,8 +1611,78 @@ static int receive_filter(VirtIONet *n, const ui=
nt8_t *buf, int size)
> >       return 0;
> >   }
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
> > +        mask =3D VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | VIRTIO_NET_RSS_HASH=
_TYPE_TCPv6;
> > +        if (istcp && (types & mask)) {
> > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_TCP_EX) ?
> > +                NetPktRssIpV6TcpEx : NetPktRssIpV6Tcp;
> > +        }
> > +        mask =3D VIRTIO_NET_RSS_HASH_TYPE_UDP_EX | VIRTIO_NET_RSS_HASH=
_TYPE_UDPv6;
> > +        if (isudp && (types & mask)) {
> > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_UDP_EX) ?
> > +                NetPktRssIpV6UdpEx : NetPktRssIpV6Udp;
> > +        }
> > +        mask =3D VIRTIO_NET_RSS_HASH_TYPE_IP_EX | VIRTIO_NET_RSS_HASH_=
TYPE_IPv6;
> > +        if (types & mask) {
> > +            return (types & VIRTIO_NET_RSS_HASH_TYPE_IP_EX) ?
> > +                NetPktRssIpV6Ex : NetPktRssIpV6;
> > +        }
> > +    }
> > +    return 0xff;
> > +}
> > +
> > +static int virtio_net_process_rss(NetClientState *nc, const uint8_t *b=
uf,
> > +                                  size_t size)
> > +{
> > +    VirtIONet *n =3D qemu_get_nic_opaque(nc);
> > +    unsigned int index =3D nc->queue_index, new_index;
> > +    struct NetRxPkt *pkt =3D n->rss_data.pkt;
> > +    uint8_t net_hash_type;
> > +    uint32_t hash;
> > +    bool isip4, isip6, isudp, istcp;
> > +    net_rx_pkt_set_protocols(pkt, buf + n->host_hdr_len,
> > +                             size - n->host_hdr_len);
> > +    net_rx_pkt_get_protocols(pkt, &isip4, &isip6, &isudp, &istcp);
> > +    if (isip4 && (net_rx_pkt_get_ip4_info(pkt)->fragment)) {
> > +        istcp =3D isudp =3D false;
> > +    }
> > +    if (isip6 && (net_rx_pkt_get_ip6_info(pkt)->fragment)) {
> > +        istcp =3D isudp =3D false;
> > +    }
> > +    net_hash_type =3D virtio_net_get_hash_type(isip4, isip6, isudp, is=
tcp,
> > +                                             n->rss_data.hash_types);
> > +    if (net_hash_type > NetPktRssIpV6UdpEx) {
> > +        return n->rss_data.default_queue;
> > +    }
> > +
> > +    hash =3D net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.=
key);
> > +    new_index =3D hash & (n->rss_data.indirections_len - 1);
> > +    new_index =3D n->rss_data.indirections[new_index];
> > +    if (index =3D=3D new_index) {
> > +        return -1;
> > +    }
> > +    return new_index;
> > +}
> > +
> >   static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8=
_t *buf,
> > -                                      size_t size)
> > +                                      size_t size, bool no_rss)
> >   {
> >       VirtIONet *n =3D qemu_get_nic_opaque(nc);
> >       VirtIONetQueue *q =3D virtio_net_get_subqueue(nc);
> > @@ -1625,6 +1696,14 @@ static ssize_t virtio_net_receive_rcu(NetClientS=
tate *nc, const uint8_t *buf,
> >           return -1;
> >       }
> >
> > +    if (!no_rss && n->rss_data.enabled) {
> > +        int index =3D virtio_net_process_rss(nc, buf, size);
> > +        if (index >=3D 0) {
> > +            NetClientState *nc2 =3D qemu_get_subqueue(n->nic, index);
> > +            return virtio_net_receive_rcu(nc2, buf, size, true);
> > +        }
> > +    }
>
>
> In the long run, we need to implement steering ops and allow device
> model to implement their own policy instead of doing hack like this.
>

Are you talking about support for RSS in tap driver or about something
different?

> Thanks
>
>
> > +
> >       /* hdr_len refers to the header we supply to the guest */
> >       if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_=
hdr_len)) {
> >           return 0;
> > @@ -1719,7 +1798,7 @@ static ssize_t virtio_net_do_receive(NetClientSta=
te *nc, const uint8_t *buf,
> >   {
> >       RCU_READ_LOCK_GUARD();
> >
> > -    return virtio_net_receive_rcu(nc, buf, size);
> > +    return virtio_net_receive_rcu(nc, buf, size, false);
> >   }
> >
> >   static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
> > @@ -3295,6 +3374,8 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
> >
> >       QTAILQ_INIT(&n->rsc_chains);
> >       n->qdev =3D dev;
> > +
> > +    net_rx_pkt_init(&n->rss_data.pkt, false);
> >   }
> >
> >   static void virtio_net_device_unrealize(DeviceState *dev, Error **err=
p)
> > @@ -3331,6 +3412,7 @@ static void virtio_net_device_unrealize(DeviceSta=
te *dev, Error **errp)
> >       g_free(n->vqs);
> >       qemu_del_nic(n->nic);
> >       virtio_net_rsc_cleanup(n);
> > +    net_rx_pkt_uninit(n->rss_data.pkt);
> >       virtio_cleanup(vdev);
> >   }
> >
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> > index cf16f5192e..45670dd054 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -209,6 +209,7 @@ struct VirtIONet {
> >           uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
> >           uint16_t indirections_len;
> >           uint16_t default_queue;
> > +        struct NetRxPkt *pkt;
> >       } rss_data;
> >   };
> >
>

