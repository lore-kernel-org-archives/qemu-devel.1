Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC98C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4A22467C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcRcWutl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4A22467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBVAp-0000X1-Pa
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 23:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jBVAB-00007A-Pp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jBVA9-0008EZ-BO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:02:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jBVA9-0007zR-2E
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583809336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=crw1xNjNUz/SjEY1YTtzVHaJ8F9LjkVP2qJ4j4h0WyU=;
 b=JcRcWutlWhgwLYEC7R+GN54he5k/KAZJ1sHN02HVwnsSbSENIutrvHIGcVNN39dcawi4Sy
 PoN/2lXPN/iE8/Ab81sfWG0BF7s/QnfUBk8i7JhaaJ9ZMxgIEJetsFO+/xsMfe5ZaPe6aL
 6827P94zz6pp1hmSRAWysE5Kn4TEGTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-aej_NM4jMa6gpeGXFL020Q-1; Mon, 09 Mar 2020 23:02:12 -0400
X-MC-Unique: aej_NM4jMa6gpeGXFL020Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F79D800D54;
 Tue, 10 Mar 2020 03:02:11 +0000 (UTC)
Received: from [10.72.13.250] (ovpn-13-250.pek2.redhat.com [10.72.13.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C598A60C87;
 Tue, 10 Mar 2020 03:02:06 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] virtio-net: implement RSS configuration command
To: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 mst@redhat.com
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
 <20200309083438.2389-3-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2da1f442-ae53-b7b8-5622-eb93c061eecd@redhat.com>
Date: Tue, 10 Mar 2020 11:02:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200309083438.2389-3-yuri.benditovich@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
> Optionally report RSS feature.
> Handle RSS configuration command and keep RSS parameters
> in virtio-net device context.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>   hw/net/trace-events            |   3 +
>   hw/net/virtio-net.c            | 148 +++++++++++++++++++++++++++++++--
>   include/hw/virtio/virtio-net.h |  11 +++
>   3 files changed, 153 insertions(+), 9 deletions(-)
>
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index a1da98a643..9823480d91 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -371,6 +371,9 @@ virtio_net_announce_notify(void) ""
>   virtio_net_announce_timer(int round) "%d"
>   virtio_net_handle_announce(int round) "%d"
>   virtio_net_post_load_device(void)
> +virtio_net_rss_disable(void)
> +virtio_net_rss_error(int error_case) "case %d"
> +virtio_net_rss_enable(uint32_t p1, uint16_t p2, uint8_t p3) "hashes 0x%x=
, table of %d, key of %d"
>  =20
>   # tulip.c
>   tulip_reg_write(uint64_t addr, const char *name, int size, uint64_t val=
) "addr 0x%02"PRIx64" (%s) size %d value 0x%08"PRIx64
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9545b0e84f..27071eccd2 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -172,6 +172,16 @@ struct virtio_net_rss_config {
>      tso/gso/gro 'off'. */
>   #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
>  =20
> +#define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 |=
 \
> +                                         VIRTIO_NET_RSS_HASH_TYPE_TCPv4 =
| \
> +                                         VIRTIO_NET_RSS_HASH_TYPE_UDPv4 =
| \
> +                                         VIRTIO_NET_RSS_HASH_TYPE_IPv6 |=
 \
> +                                         VIRTIO_NET_RSS_HASH_TYPE_TCPv6 =
| \
> +                                         VIRTIO_NET_RSS_HASH_TYPE_UDPv6 =
| \
> +                                         VIRTIO_NET_RSS_HASH_TYPE_IP_EX =
| \
> +                                         VIRTIO_NET_RSS_HASH_TYPE_TCP_EX=
 | \
> +                                         VIRTIO_NET_RSS_HASH_TYPE_UDP_EX=
)
> +
>   /* temporary until standard header include it */
>   #if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
>  =20
> @@ -203,6 +213,8 @@ static VirtIOFeature feature_sizes[] =3D {
>        .end =3D endof(struct virtio_net_config, mtu)},
>       {.flags =3D 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
>        .end =3D endof(struct virtio_net_config, duplex)},
> +    {.flags =3D 1ULL << VIRTIO_NET_F_RSS,
> +     .end =3D endof(struct virtio_net_config, supported_hash_types)},
>       {}
>   };
>  =20
> @@ -233,6 +245,11 @@ static void virtio_net_get_config(VirtIODevice *vdev=
, uint8_t *config)
>       memcpy(netcfg.mac, n->mac, ETH_ALEN);
>       virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
>       netcfg.duplex =3D n->net_conf.duplex;
> +    netcfg.rss_max_key_size =3D VIRTIO_NET_RSS_MAX_KEY_SIZE;
> +    virtio_stw_p(vdev, &netcfg.rss_max_indirection_table_length,
> +                 VIRTIO_NET_RSS_MAX_TABLE_LEN);
> +    virtio_stl_p(vdev, &netcfg.supported_hash_types,
> +                 VIRTIO_NET_RSS_SUPPORTED_HASHES);
>       memcpy(config, &netcfg, n->config_size);
>   }
>  =20
> @@ -796,6 +813,7 @@ static uint64_t virtio_net_get_features(VirtIODevice =
*vdev, uint64_t features,
>           return features;
>       }
>  =20
> +    virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
>       features =3D vhost_net_get_features(get_vhost_net(nc->peer), featur=
es);
>       vdev->backend_features =3D features;
>  =20
> @@ -955,6 +973,7 @@ static void virtio_net_set_features(VirtIODevice *vde=
v, uint64_t features)
>       }
>  =20
>       virtio_net_set_multiqueue(n,
> +                              virtio_has_feature(features, VIRTIO_NET_F_=
RSS) ||
>                                 virtio_has_feature(features, VIRTIO_NET_F=
_MQ));
>  =20
>       virtio_net_set_mrg_rx_bufs(n,
> @@ -1231,25 +1250,134 @@ static int virtio_net_handle_announce(VirtIONet =
*n, uint8_t cmd,
>       }
>   }
>  =20
> +static void virtio_net_disable_rss(VirtIONet *n)
> +{
> +    if (n->rss_data.enabled) {
> +        trace_virtio_net_rss_disable();
> +    }
> +    n->rss_data.enabled =3D false;
> +}
> +
> +static uint16_t virtio_net_handle_rss(VirtIONet *n,
> +                                      struct iovec *iov, unsigned int io=
v_cnt)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    struct virtio_net_rss_config cfg;
> +    size_t s, offset =3D 0, size_get;
> +    uint16_t queues, i;
> +    struct {
> +        uint16_t us;
> +        uint8_t b;
> +    } QEMU_PACKED temp;
> +    int err;
> +
> +    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> +        err =3D 1;
> +        goto error;
> +    }
> +    size_get =3D offsetof(struct virtio_net_rss_config, indirection_tabl=
e);
> +    s =3D iov_to_buf(iov, iov_cnt, offset, &cfg, size_get);
> +    if (s !=3D size_get) {
> +        err =3D 2;
> +        goto error;
> +    }
> +    n->rss_data.hash_types =3D virtio_ldl_p(vdev, &cfg.hash_types);
> +    n->rss_data.indirections_len =3D
> +        virtio_lduw_p(vdev, &cfg.indirection_table_mask);
> +    n->rss_data.indirections_len++;
> +    if (!is_power_of_2(n->rss_data.indirections_len)) {
> +        err =3D 3;
> +        goto error;
> +    }
> +    if (n->rss_data.indirections_len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
> +        err =3D 4;
> +        goto error;
> +    }
> +    n->rss_data.default_queue =3D
> +        virtio_lduw_p(vdev, &cfg.unclassified_queue);
> +    if (n->rss_data.default_queue >=3D n->max_queues) {
> +        err =3D 5;
> +        goto error;
> +    }
> +    offset +=3D size_get;
> +    size_get =3D sizeof(uint16_t) * n->rss_data.indirections_len;
> +    s =3D iov_to_buf(iov, iov_cnt, offset, n->rss_data.indirections, siz=
e_get);
> +    if (s !=3D size_get) {
> +        err =3D 10;
> +        goto error;
> +    }
> +    for (i =3D 0; i < n->rss_data.indirections_len; ++i) {
> +        uint16_t val =3D n->rss_data.indirections[i];
> +        n->rss_data.indirections[i] =3D virtio_lduw_p(vdev, &val);
> +    }
> +    offset +=3D size_get;
> +    size_get =3D sizeof(temp);
> +    s =3D iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
> +    if (s !=3D size_get) {
> +        err =3D 11;
> +        goto error;
> +    }
> +    queues =3D virtio_lduw_p(vdev, &temp.us);
> +    if (queues =3D=3D 0 || queues > n->max_queues) {
> +        err =3D 12;
> +        goto error;
> +    }
> +    if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> +        err =3D 13;
> +        goto error;
> +    }
> +    if (!temp.b && n->rss_data.hash_types) {
> +        err =3D 20;
> +        goto error;
> +    }
> +    if (!temp.b && !n->rss_data.hash_types) {
> +        virtio_net_disable_rss(n);
> +        return queues;
> +    }
> +    offset +=3D size_get;
> +    size_get =3D temp.b;
> +    s =3D iov_to_buf(iov, iov_cnt, offset, n->rss_data.key, size_get);
> +    if (s !=3D size_get) {
> +        err =3D 21;
> +        goto error;
> +    }
> +    n->rss_data.enabled =3D true;
> +    trace_virtio_net_rss_enable(n->rss_data.hash_types,
> +                                n->rss_data.indirections_len,
> +                                temp.b);
> +    return queues;
> +error:
> +    warn_report("%s: error_case %d", __func__, err);


I'm not sure using warn_report() is good for such guest triggerable=20
behavior.


> +    trace_virtio_net_rss_error(err);


It looks to me it would be better to be verbose here (show temp.b or other)


> +    virtio_net_disable_rss(n);
> +    return 0;
> +}
> +
>   static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
>                                   struct iovec *iov, unsigned int iov_cnt=
)
>   {
>       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> -    struct virtio_net_ctrl_mq mq;
> -    size_t s;
>       uint16_t queues;
>  =20
> -    s =3D iov_to_buf(iov, iov_cnt, 0, &mq, sizeof(mq));
> -    if (s !=3D sizeof(mq)) {
> -        return VIRTIO_NET_ERR;
> -    }
> +    virtio_net_disable_rss(n);
> +    if (cmd =3D=3D VIRTIO_NET_CTRL_MQ_RSS_CONFIG) {
> +        queues =3D virtio_net_handle_rss(n, iov, iov_cnt);
> +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {


It looks to me RSS and MQ are mutually exclusive, is this intentional?


> +        struct virtio_net_ctrl_mq mq;
> +        size_t s;
> +        if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ)) {
> +            return VIRTIO_NET_ERR;
> +        }
> +        s =3D iov_to_buf(iov, iov_cnt, 0, &mq, sizeof(mq));
> +        if (s !=3D sizeof(mq)) {
> +            return VIRTIO_NET_ERR;
> +        }
> +        queues =3D virtio_lduw_p(vdev, &mq.virtqueue_pairs);
>  =20
> -    if (cmd !=3D VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {
> +    } else {
>           return VIRTIO_NET_ERR;
>       }
>  =20
> -    queues =3D virtio_lduw_p(vdev, &mq.virtqueue_pairs);
> -
>       if (queues < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
>           queues > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
>           queues > n->max_queues ||
> @@ -3304,6 +3432,8 @@ static Property virtio_net_properties[] =3D {
>       DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
>                       VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
>       DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, =
false),
> +    DEFINE_PROP_BIT64("rss", VirtIONet, host_features,
> +                    VIRTIO_NET_F_RSS, false),
>       DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
>                       VIRTIO_NET_F_RSC_EXT, false),
>       DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 96c68d4a92..cf16f5192e 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -126,6 +126,9 @@ typedef struct VirtioNetRscChain {
>   /* Maximum packet size we can receive from tap device: header + 64k */
>   #define VIRTIO_NET_MAX_BUFSIZE (sizeof(struct virtio_net_hdr) + (64 * K=
iB))
>  =20
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
> +
>   typedef struct VirtIONetQueue {
>       VirtQueue *rx_vq;
>       VirtQueue *tx_vq;
> @@ -199,6 +202,14 @@ struct VirtIONet {
>       bool failover;
>       DeviceListener primary_listener;
>       Notifier migration_state;
> +    struct {
> +        bool    enabled;
> +        uint32_t hash_types;
> +        uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +        uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
> +        uint16_t indirections_len;
> +        uint16_t default_queue;
> +    } rss_data;
>   };
>  =20
>   void virtio_net_set_netclient_name(VirtIONet *n, const char *name,


