Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28725C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E8624673
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEXqS6xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E8624673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBY9x-0006RX-4d
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 02:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBY9M-00061q-1p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBY9J-0005gY-DS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:13:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBY9G-0005cO-NR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583820825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dB+j06udAgZn10CTCkMbPAE15vjVb+ciTAS7S4LF03M=;
 b=DEXqS6xnn1Jb51PfpfT2KzJMkKZ0z7MUvQMjMehovsIgFA6QKEXMhBaL65GVeXfYHEbhz5
 2UO4armXn53XlnHJscpR/mYrFbwEKIrRg6/SfiLnjC33wPRYskc1/zjCaCbQT772PoWaVm
 3WXbiy2ygR82dj/3sPAxnNzO+v14ZsE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-sWh6MRGqNJGN1QRgVxNhcA-1; Tue, 10 Mar 2020 02:13:43 -0400
X-MC-Unique: sWh6MRGqNJGN1QRgVxNhcA-1
Received: by mail-qt1-f198.google.com with SMTP id p12so8474879qtu.6
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 23:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=26MPrJhJobSI71hRSG9yAS0RtCcMdG466t27PtKZnj8=;
 b=fIBry/wuyqBnqH76i7GRdXVKoIvdAgsn5bYRTACX8kiKYM8kAdS+LWGQNicOa7jqCT
 Hmqaers/RUsE2n+9QSpkzBaFkGwAuIRFkQoQOICsj1jogJZQ9b+iaZF6ocdL2V8SjMec
 1gDi2wixGi/WaVbZD0XBmdhPxHdjTSf1Fh2Oi8ClFrBiEynPQBWVbP004d2K4aJxs3X7
 YviHnwdfBWcX9hFuputjY7KRiAiANMtdTH26NfbLfs3fApTb0hP/kEWesv96J+CnyDvX
 9xOh5cG23/ooOOgCTYpvCoOav8CUjgAeAux+KcOvAEwjHIZL+IGz6UeXWGDrdRu5fW5E
 2woA==
X-Gm-Message-State: ANhLgQ3blBtPQegoz/Y0t/hfOpcrLhuWnDYDxcTPZvuekAeVKcLJGMsE
 BpvdNaIK0Ad5HD0rVo05M4wo4FkXlrWqEVXq10+eVFysg5NkFr50Vhq79R/rJQ9gM40fofCd7vI
 EePxGH2XmRjCMwI4=
X-Received: by 2002:a0c:f602:: with SMTP id r2mr16685956qvm.193.1583820822795; 
 Mon, 09 Mar 2020 23:13:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvOgZzRm18mN5VJ4IWQFuQkek7xURa2BFcgotITqpKv4fOlVfbvLcg0usbtaGyQJVs/P5Cnuw==
X-Received: by 2002:a0c:f602:: with SMTP id r2mr16685947qvm.193.1583820822484; 
 Mon, 09 Mar 2020 23:13:42 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id p126sm23656692qkd.108.2020.03.09.23.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 23:13:41 -0700 (PDT)
Date: Tue, 10 Mar 2020 02:13:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v2 3/4] virtio-net: implement RX RSS processing
Message-ID: <20200310021239-mutt-send-email-mst@kernel.org>
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
 <20200309083438.2389-4-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200309083438.2389-4-yuri.benditovich@daynix.com>
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 10:34:37AM +0200, Yuri Benditovich wrote:
> If VIRTIO_NET_F_RSS negotiated and RSS is enabled, process
> incoming packets, calculate packet's hash and place the
> packet into respective RX virtqueue.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/net/virtio-net.c            | 86 +++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-net.h |  1 +
>  2 files changed, 85 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 27071eccd2..abc41fdb16 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -42,6 +42,7 @@
>  #include "trace.h"
>  #include "monitor/qdev.h"
>  #include "hw/pci/pci.h"
> +#include "net_rx_pkt.h"
> =20
>  #define VIRTIO_NET_VM_VERSION    11
> =20
> @@ -1610,8 +1611,78 @@ static int receive_filter(VirtIONet *n, const uint=
8_t *buf, int size)
>      return 0;
>  }
> =20
> +static uint8_t virtio_net_get_hash_type(bool isip4,
> +                                        bool isip6,
> +                                        bool isudp,
> +                                        bool istcp,
> +                                        uint32_t types)
> +{
> +    uint32_t mask;
> +    if (isip4) {


An empty line after a declaration won't hurt, here and elsewhere.


> +        if (istcp && (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4)) {
> +            return NetPktRssIpV4Tcp;
> +        }
> +        if (isudp && (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4)) {
> +            return NetPktRssIpV4Udp;
> +        }
> +        if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
> +            return NetPktRssIpV4;
> +        }
> +    } else if (isip6) {
> +        mask =3D VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | VIRTIO_NET_RSS_HASH_T=
YPE_TCPv6;

Mask is only used on this path, move declaration within if ()?

> +        if (istcp && (types & mask)) {
> +            return (types & VIRTIO_NET_RSS_HASH_TYPE_TCP_EX) ?
> +                NetPktRssIpV6TcpEx : NetPktRssIpV6Tcp;
> +        }
> +        mask =3D VIRTIO_NET_RSS_HASH_TYPE_UDP_EX | VIRTIO_NET_RSS_HASH_T=
YPE_UDPv6;
> +        if (isudp && (types & mask)) {
> +            return (types & VIRTIO_NET_RSS_HASH_TYPE_UDP_EX) ?
> +                NetPktRssIpV6UdpEx : NetPktRssIpV6Udp;
> +        }
> +        mask =3D VIRTIO_NET_RSS_HASH_TYPE_IP_EX | VIRTIO_NET_RSS_HASH_TY=
PE_IPv6;
> +        if (types & mask) {
> +            return (types & VIRTIO_NET_RSS_HASH_TYPE_IP_EX) ?
> +                NetPktRssIpV6Ex : NetPktRssIpV6;
> +        }
> +    }
> +    return 0xff;
> +}
> +
> +static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf=
,
> +                                  size_t size)
> +{
> +    VirtIONet *n =3D qemu_get_nic_opaque(nc);
> +    unsigned int index =3D nc->queue_index, new_index;
> +    struct NetRxPkt *pkt =3D n->rss_data.pkt;
> +    uint8_t net_hash_type;
> +    uint32_t hash;
> +    bool isip4, isip6, isudp, istcp;
> +    net_rx_pkt_set_protocols(pkt, buf + n->host_hdr_len,
> +                             size - n->host_hdr_len);
> +    net_rx_pkt_get_protocols(pkt, &isip4, &isip6, &isudp, &istcp);
> +    if (isip4 && (net_rx_pkt_get_ip4_info(pkt)->fragment)) {
> +        istcp =3D isudp =3D false;
> +    }
> +    if (isip6 && (net_rx_pkt_get_ip6_info(pkt)->fragment)) {
> +        istcp =3D isudp =3D false;
> +    }
> +    net_hash_type =3D virtio_net_get_hash_type(isip4, isip6, isudp, istc=
p,
> +                                             n->rss_data.hash_types);
> +    if (net_hash_type > NetPktRssIpV6UdpEx) {
> +        return n->rss_data.default_queue;
> +    }
> +
> +    hash =3D net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.ke=
y);
> +    new_index =3D hash & (n->rss_data.indirections_len - 1);
> +    new_index =3D n->rss_data.indirections[new_index];
> +    if (index =3D=3D new_index) {
> +        return -1;
> +    }
> +    return new_index;
> +}
> +
>  static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t =
*buf,
> -                                      size_t size)
> +                                      size_t size, bool no_rss)
>  {
>      VirtIONet *n =3D qemu_get_nic_opaque(nc);
>      VirtIONetQueue *q =3D virtio_net_get_subqueue(nc);
> @@ -1625,6 +1696,14 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
te *nc, const uint8_t *buf,
>          return -1;
>      }
> =20
> +    if (!no_rss && n->rss_data.enabled) {
> +        int index =3D virtio_net_process_rss(nc, buf, size);
> +        if (index >=3D 0) {
> +            NetClientState *nc2 =3D qemu_get_subqueue(n->nic, index);
> +            return virtio_net_receive_rcu(nc2, buf, size, true);
> +        }
> +    }
> +
>      /* hdr_len refers to the header we supply to the guest */
>      if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr=
_len)) {
>          return 0;
> @@ -1719,7 +1798,7 @@ static ssize_t virtio_net_do_receive(NetClientState=
 *nc, const uint8_t *buf,
>  {
>      RCU_READ_LOCK_GUARD();
> =20
> -    return virtio_net_receive_rcu(nc, buf, size);
> +    return virtio_net_receive_rcu(nc, buf, size, false);
>  }
> =20
>  static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
> @@ -3295,6 +3374,8 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
> =20
>      QTAILQ_INIT(&n->rsc_chains);
>      n->qdev =3D dev;
> +
> +    net_rx_pkt_init(&n->rss_data.pkt, false);
>  }
> =20
>  static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
> @@ -3331,6 +3412,7 @@ static void virtio_net_device_unrealize(DeviceState=
 *dev, Error **errp)
>      g_free(n->vqs);
>      qemu_del_nic(n->nic);
>      virtio_net_rsc_cleanup(n);
> +    net_rx_pkt_uninit(n->rss_data.pkt);
>      virtio_cleanup(vdev);
>  }
> =20
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index cf16f5192e..45670dd054 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -209,6 +209,7 @@ struct VirtIONet {
>          uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
>          uint16_t indirections_len;
>          uint16_t default_queue;
> +        struct NetRxPkt *pkt;
>      } rss_data;
>  };
> =20
> --=20
> 2.17.1


