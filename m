Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D99C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD38E2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwB1CJLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD38E2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBVIo-0002LS-WE
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 23:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jBVHt-0001U6-IB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jBVHs-0001Lo-2M
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:10:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56283
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jBVHr-0001L9-UK
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583809831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggL2705GufcO+EiBTVrG75N82vuAdmgPndlFcVRJJsw=;
 b=CwB1CJLQ1R1fWgIb52ar9MZbWnqjtUj8rei9UfQo2zdf6I9+6vHDH7l6gNLUKXtXXVcrZE
 1Y09zlD9y4XgG+03tIoNEOQE9WE7lexdVNWYmym3HcRQCdcjqPXX8NTPJIOe63YHcErAGt
 JNUqUD1By5Wj18SjTkvXSUuOHQL7O1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-Unzha6ywNiiy-2iPe9irEw-1; Mon, 09 Mar 2020 23:10:29 -0400
X-MC-Unique: Unzha6ywNiiy-2iPe9irEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EDDA189F762;
 Tue, 10 Mar 2020 03:10:28 +0000 (UTC)
Received: from [10.72.13.250] (ovpn-13-250.pek2.redhat.com [10.72.13.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B972A7386B;
 Tue, 10 Mar 2020 03:10:23 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] virtio-net: implement RX RSS processing
To: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 mst@redhat.com
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
 <20200309083438.2389-4-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4dc38e82-ed58-9835-5e27-f893b9580152@redhat.com>
Date: Tue, 10 Mar 2020 11:10:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200309083438.2389-4-yuri.benditovich@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/9 =E4=B8=8B=E5=8D=884:34, Yuri Benditovich wrote:
> If VIRTIO_NET_F_RSS negotiated and RSS is enabled, process
> incoming packets, calculate packet's hash and place the
> packet into respective RX virtqueue.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>   hw/net/virtio-net.c            | 86 +++++++++++++++++++++++++++++++++-
>   include/hw/virtio/virtio-net.h |  1 +
>   2 files changed, 85 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 27071eccd2..abc41fdb16 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -42,6 +42,7 @@
>   #include "trace.h"
>   #include "monitor/qdev.h"
>   #include "hw/pci/pci.h"
> +#include "net_rx_pkt.h"
>  =20
>   #define VIRTIO_NET_VM_VERSION    11
>  =20
> @@ -1610,8 +1611,78 @@ static int receive_filter(VirtIONet *n, const uint=
8_t *buf, int size)
>       return 0;
>   }
>  =20
> +static uint8_t virtio_net_get_hash_type(bool isip4,
> +                                        bool isip6,
> +                                        bool isudp,
> +                                        bool istcp,
> +                                        uint32_t types)
> +{
> +    uint32_t mask;
> +    if (isip4) {
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
>   static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t=
 *buf,
> -                                      size_t size)
> +                                      size_t size, bool no_rss)
>   {
>       VirtIONet *n =3D qemu_get_nic_opaque(nc);
>       VirtIONetQueue *q =3D virtio_net_get_subqueue(nc);
> @@ -1625,6 +1696,14 @@ static ssize_t virtio_net_receive_rcu(NetClientSta=
te *nc, const uint8_t *buf,
>           return -1;
>       }
>  =20
> +    if (!no_rss && n->rss_data.enabled) {
> +        int index =3D virtio_net_process_rss(nc, buf, size);
> +        if (index >=3D 0) {
> +            NetClientState *nc2 =3D qemu_get_subqueue(n->nic, index);
> +            return virtio_net_receive_rcu(nc2, buf, size, true);
> +        }
> +    }


In the long run, we need to implement steering ops and allow device=20
model to implement their own policy instead of doing hack like this.

Thanks


> +
>       /* hdr_len refers to the header we supply to the guest */
>       if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hd=
r_len)) {
>           return 0;
> @@ -1719,7 +1798,7 @@ static ssize_t virtio_net_do_receive(NetClientState=
 *nc, const uint8_t *buf,
>   {
>       RCU_READ_LOCK_GUARD();
>  =20
> -    return virtio_net_receive_rcu(nc, buf, size);
> +    return virtio_net_receive_rcu(nc, buf, size, false);
>   }
>  =20
>   static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
> @@ -3295,6 +3374,8 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>  =20
>       QTAILQ_INIT(&n->rsc_chains);
>       n->qdev =3D dev;
> +
> +    net_rx_pkt_init(&n->rss_data.pkt, false);
>   }
>  =20
>   static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
> @@ -3331,6 +3412,7 @@ static void virtio_net_device_unrealize(DeviceState=
 *dev, Error **errp)
>       g_free(n->vqs);
>       qemu_del_nic(n->nic);
>       virtio_net_rsc_cleanup(n);
> +    net_rx_pkt_uninit(n->rss_data.pkt);
>       virtio_cleanup(vdev);
>   }
>  =20
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index cf16f5192e..45670dd054 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -209,6 +209,7 @@ struct VirtIONet {
>           uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
>           uint16_t indirections_len;
>           uint16_t default_queue;
> +        struct NetRxPkt *pkt;
>       } rss_data;
>   };
>  =20


