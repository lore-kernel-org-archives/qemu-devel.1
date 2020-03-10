Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A65C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F73320727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="whEWG63k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F73320727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcAF-0003GE-4u
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBc8w-0002Xv-CW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBc8t-000059-G3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:29:46 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:42898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jBc8t-0008WH-9g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:29:43 -0400
Received: by mail-yw1-xc44.google.com with SMTP id v138so13109580ywa.9
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zkWl4OnIWpTBj3hEyR7WMFuLfPIyP4xT68y7IN8+wmU=;
 b=whEWG63kF6dT4fnHAtNz8bzHgKw5yWVQ92AQA0s6hLX9Ol3vzEbCyuRjnuedKi/OWq
 Q1Giy8cP3eVTXheCJxPve7zdHP50ZDOyktTwaxXtd/qqgx/9eFW+lR0l51WxApBsH1wJ
 y2K9bGiueM6OlDdaeUQ5/Cw5n788R4IHGBdgmq39AXZ5eg04CNwrqna4btVT9R0hh1xL
 gim28iypupRfruwK/f3ubIRDyCrC561jv0Q5GJFVAav4+Fd1Q6cyAfbtJh830tbFeoeQ
 PCXknjQ7MOwlpfiI8Bzg0+aYxcY1zQu7Ck2kdg7+SJWB4P4ZE8INTD9DmKU/jAw/UZBN
 s1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zkWl4OnIWpTBj3hEyR7WMFuLfPIyP4xT68y7IN8+wmU=;
 b=f47QlS40I3N5W6IQWhmm1lIFiG0Q2lwsELBzMwxBFj/RISoE9ws7/YQ9vg9BwBEWtz
 1wLQZSqjKvfF6SJlO8tzBj7r+EYy6T1i9Wcalfs+EwABQoyjFN+3ix/FgO4yXdUjEOlh
 SwcC/dX/f0XruXpoa0ksWRu6weJ474nCihpUYSrDThcyH0kRnz0nK+uzC0SvjHC8EsiH
 WnotCcl+Y6AaOyWxnKrSuIrFiKZx/cko5cUffki5yPakILaF1ehfjvIXGQ6XL+nhlOHF
 1WSLi9WJ0YU4jb8CFnOpBm9HiRLYWWwwy1n504wGN5NaDD2ekk+4f0TXLMdPhUFl6zva
 Z9LQ==
X-Gm-Message-State: ANhLgQ3vcGKKJQxDF9nw4swN+NLzKMQbB1v5hNFYCKn48ak9ogbiBsAk
 +Q5JDDWZq7MywI/1ZHUSbRmut7CTaKzYMdKuYJm59g==
X-Google-Smtp-Source: ADFU+vsfakXt0INCrtGRlUKXHVY9Ma3kRE7Gr6fF7yrFDu7c0slqsDvxD3zN+5oNH0boq6IjiZU01Yt3RDlO+R383dE=
X-Received: by 2002:a81:449:: with SMTP id 70mr21393127ywe.133.1583836182392; 
 Tue, 10 Mar 2020 03:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
 <20200309083438.2389-3-yuri.benditovich@daynix.com>
 <2da1f442-ae53-b7b8-5622-eb93c061eecd@redhat.com>
In-Reply-To: <2da1f442-ae53-b7b8-5622-eb93c061eecd@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 10 Mar 2020 12:29:32 +0200
Message-ID: <CAOEp5OdnfJydSG3ASY_ZGKXMRSM_=iQP3zHa-SqLKCXMyZ0-_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] virtio-net: implement RSS configuration command
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000008c4c205a07d994b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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

--00000000000008c4c205a07d994b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 5:02 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/3/9 =E4=B8=8B=E5=8D=884:34, Yuri Benditovich wrote:
> > Optionally report RSS feature.
> > Handle RSS configuration command and keep RSS parameters
> > in virtio-net device context.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >   hw/net/trace-events            |   3 +
> >   hw/net/virtio-net.c            | 148 +++++++++++++++++++++++++++++++-=
-
> >   include/hw/virtio/virtio-net.h |  11 +++
> >   3 files changed, 153 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/net/trace-events b/hw/net/trace-events
> > index a1da98a643..9823480d91 100644
> > --- a/hw/net/trace-events
> > +++ b/hw/net/trace-events
> > @@ -371,6 +371,9 @@ virtio_net_announce_notify(void) ""
> >   virtio_net_announce_timer(int round) "%d"
> >   virtio_net_handle_announce(int round) "%d"
> >   virtio_net_post_load_device(void)
> > +virtio_net_rss_disable(void)
> > +virtio_net_rss_error(int error_case) "case %d"
> > +virtio_net_rss_enable(uint32_t p1, uint16_t p2, uint8_t p3) "hashes
> 0x%x, table of %d, key of %d"
> >
> >   # tulip.c
> >   tulip_reg_write(uint64_t addr, const char *name, int size, uint64_t
> val) "addr 0x%02"PRIx64" (%s) size %d value 0x%08"PRIx64
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 9545b0e84f..27071eccd2 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -172,6 +172,16 @@ struct virtio_net_rss_config {
> >      tso/gso/gro 'off'. */
> >   #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
> >
> > +#define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv4
> | \
> > +                                         VIRTIO_NET_RSS_HASH_TYPE_TCPv=
4
> | \
> > +                                         VIRTIO_NET_RSS_HASH_TYPE_UDPv=
4
> | \
> > +                                         VIRTIO_NET_RSS_HASH_TYPE_IPv6
> | \
> > +                                         VIRTIO_NET_RSS_HASH_TYPE_TCPv=
6
> | \
> > +                                         VIRTIO_NET_RSS_HASH_TYPE_UDPv=
6
> | \
> > +                                         VIRTIO_NET_RSS_HASH_TYPE_IP_E=
X
> | \
> > +
>  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
> > +
>  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
> > +
> >   /* temporary until standard header include it */
> >   #if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
> >
> > @@ -203,6 +213,8 @@ static VirtIOFeature feature_sizes[] =3D {
> >        .end =3D endof(struct virtio_net_config, mtu)},
> >       {.flags =3D 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
> >        .end =3D endof(struct virtio_net_config, duplex)},
> > +    {.flags =3D 1ULL << VIRTIO_NET_F_RSS,
> > +     .end =3D endof(struct virtio_net_config, supported_hash_types)},
> >       {}
> >   };
> >
> > @@ -233,6 +245,11 @@ static void virtio_net_get_config(VirtIODevice
> *vdev, uint8_t *config)
> >       memcpy(netcfg.mac, n->mac, ETH_ALEN);
> >       virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
> >       netcfg.duplex =3D n->net_conf.duplex;
> > +    netcfg.rss_max_key_size =3D VIRTIO_NET_RSS_MAX_KEY_SIZE;
> > +    virtio_stw_p(vdev, &netcfg.rss_max_indirection_table_length,
> > +                 VIRTIO_NET_RSS_MAX_TABLE_LEN);
> > +    virtio_stl_p(vdev, &netcfg.supported_hash_types,
> > +                 VIRTIO_NET_RSS_SUPPORTED_HASHES);
> >       memcpy(config, &netcfg, n->config_size);
> >   }
> >
> > @@ -796,6 +813,7 @@ static uint64_t virtio_net_get_features(VirtIODevic=
e
> *vdev, uint64_t features,
> >           return features;
> >       }
> >
> > +    virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> >       features =3D vhost_net_get_features(get_vhost_net(nc->peer),
> features);
> >       vdev->backend_features =3D features;
> >
> > @@ -955,6 +973,7 @@ static void virtio_net_set_features(VirtIODevice
> *vdev, uint64_t features)
> >       }
> >
> >       virtio_net_set_multiqueue(n,
> > +                              virtio_has_feature(features,
> VIRTIO_NET_F_RSS) ||
> >                                 virtio_has_feature(features,
> VIRTIO_NET_F_MQ));
> >
> >       virtio_net_set_mrg_rx_bufs(n,
> > @@ -1231,25 +1250,134 @@ static int virtio_net_handle_announce(VirtIONe=
t
> *n, uint8_t cmd,
> >       }
> >   }
> >
> > +static void virtio_net_disable_rss(VirtIONet *n)
> > +{
> > +    if (n->rss_data.enabled) {
> > +        trace_virtio_net_rss_disable();
> > +    }
> > +    n->rss_data.enabled =3D false;
> > +}
> > +
> > +static uint16_t virtio_net_handle_rss(VirtIONet *n,
> > +                                      struct iovec *iov, unsigned int
> iov_cnt)
> > +{
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > +    struct virtio_net_rss_config cfg;
> > +    size_t s, offset =3D 0, size_get;
> > +    uint16_t queues, i;
> > +    struct {
> > +        uint16_t us;
> > +        uint8_t b;
> > +    } QEMU_PACKED temp;
> > +    int err;
> > +
> > +    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> > +        err =3D 1;
> > +        goto error;
> > +    }
> > +    size_get =3D offsetof(struct virtio_net_rss_config,
> indirection_table);
> > +    s =3D iov_to_buf(iov, iov_cnt, offset, &cfg, size_get);
> > +    if (s !=3D size_get) {
> > +        err =3D 2;
> > +        goto error;
> > +    }
> > +    n->rss_data.hash_types =3D virtio_ldl_p(vdev, &cfg.hash_types);
> > +    n->rss_data.indirections_len =3D
> > +        virtio_lduw_p(vdev, &cfg.indirection_table_mask);
> > +    n->rss_data.indirections_len++;
> > +    if (!is_power_of_2(n->rss_data.indirections_len)) {
> > +        err =3D 3;
> > +        goto error;
> > +    }
> > +    if (n->rss_data.indirections_len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
> > +        err =3D 4;
> > +        goto error;
> > +    }
> > +    n->rss_data.default_queue =3D
> > +        virtio_lduw_p(vdev, &cfg.unclassified_queue);
> > +    if (n->rss_data.default_queue >=3D n->max_queues) {
> > +        err =3D 5;
> > +        goto error;
> > +    }
> > +    offset +=3D size_get;
> > +    size_get =3D sizeof(uint16_t) * n->rss_data.indirections_len;
> > +    s =3D iov_to_buf(iov, iov_cnt, offset, n->rss_data.indirections,
> size_get);
> > +    if (s !=3D size_get) {
> > +        err =3D 10;
> > +        goto error;
> > +    }
> > +    for (i =3D 0; i < n->rss_data.indirections_len; ++i) {
> > +        uint16_t val =3D n->rss_data.indirections[i];
> > +        n->rss_data.indirections[i] =3D virtio_lduw_p(vdev, &val);
> > +    }
> > +    offset +=3D size_get;
> > +    size_get =3D sizeof(temp);
> > +    s =3D iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
> > +    if (s !=3D size_get) {
> > +        err =3D 11;
> > +        goto error;
> > +    }
> > +    queues =3D virtio_lduw_p(vdev, &temp.us);
> > +    if (queues =3D=3D 0 || queues > n->max_queues) {
> > +        err =3D 12;
> > +        goto error;
> > +    }
> > +    if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> > +        err =3D 13;
> > +        goto error;
> > +    }
> > +    if (!temp.b && n->rss_data.hash_types) {
> > +        err =3D 20;
> > +        goto error;
> > +    }
> > +    if (!temp.b && !n->rss_data.hash_types) {
> > +        virtio_net_disable_rss(n);
> > +        return queues;
> > +    }
> > +    offset +=3D size_get;
> > +    size_get =3D temp.b;
> > +    s =3D iov_to_buf(iov, iov_cnt, offset, n->rss_data.key, size_get);
> > +    if (s !=3D size_get) {
> > +        err =3D 21;
> > +        goto error;
> > +    }
> > +    n->rss_data.enabled =3D true;
> > +    trace_virtio_net_rss_enable(n->rss_data.hash_types,
> > +                                n->rss_data.indirections_len,
> > +                                temp.b);
> > +    return queues;
> > +error:
> > +    warn_report("%s: error_case %d", __func__, err);
>
>
> I'm not sure using warn_report() is good for such guest triggerable
> behavior.
>
>
> > +    trace_virtio_net_rss_error(err);
>
>
> It looks to me it would be better to be verbose here (show temp.b or othe=
r)
>
>
> > +    virtio_net_disable_rss(n);
> > +    return 0;
> > +}
> > +
> >   static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
> >                                   struct iovec *iov, unsigned int
> iov_cnt)
> >   {
> >       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> > -    struct virtio_net_ctrl_mq mq;
> > -    size_t s;
> >       uint16_t queues;
> >
> > -    s =3D iov_to_buf(iov, iov_cnt, 0, &mq, sizeof(mq));
> > -    if (s !=3D sizeof(mq)) {
> > -        return VIRTIO_NET_ERR;
> > -    }
> > +    virtio_net_disable_rss(n);
> > +    if (cmd =3D=3D VIRTIO_NET_CTRL_MQ_RSS_CONFIG) {
> > +        queues =3D virtio_net_handle_rss(n, iov, iov_cnt);
> > +    } else if (cmd =3D=3D VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {
>
>
> It looks to me RSS and MQ are mutually exclusive, is this intentional?
>

No they are not. The device can support RSS or MQ or both.
The driver can activate multiqueue by VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET.
The driver can activate multiqueue by  VIRTIO_NET_CTRL_MQ_RSS_CONFIG  .



>
>
> > +        struct virtio_net_ctrl_mq mq;
> > +        size_t s;
> > +        if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ)) {
> > +            return VIRTIO_NET_ERR;
> > +        }
> > +        s =3D iov_to_buf(iov, iov_cnt, 0, &mq, sizeof(mq));
> > +        if (s !=3D sizeof(mq)) {
> > +            return VIRTIO_NET_ERR;
> > +        }
> > +        queues =3D virtio_lduw_p(vdev, &mq.virtqueue_pairs);
> >
> > -    if (cmd !=3D VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {
> > +    } else {
> >           return VIRTIO_NET_ERR;
> >       }
> >
> > -    queues =3D virtio_lduw_p(vdev, &mq.virtqueue_pairs);
> > -
> >       if (queues < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> >           queues > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
> >           queues > n->max_queues ||
> > @@ -3304,6 +3432,8 @@ static Property virtio_net_properties[] =3D {
> >       DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features=
,
> >                       VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
> >       DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ=
,
> false),
> > +    DEFINE_PROP_BIT64("rss", VirtIONet, host_features,
> > +                    VIRTIO_NET_F_RSS, false),
> >       DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
> >                       VIRTIO_NET_F_RSC_EXT, false),
> >       DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
> > diff --git a/include/hw/virtio/virtio-net.h
> b/include/hw/virtio/virtio-net.h
> > index 96c68d4a92..cf16f5192e 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -126,6 +126,9 @@ typedef struct VirtioNetRscChain {
> >   /* Maximum packet size we can receive from tap device: header + 64k *=
/
> >   #define VIRTIO_NET_MAX_BUFSIZE (sizeof(struct virtio_net_hdr) + (64 *
> KiB))
> >
> > +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> > +#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
> > +
> >   typedef struct VirtIONetQueue {
> >       VirtQueue *rx_vq;
> >       VirtQueue *tx_vq;
> > @@ -199,6 +202,14 @@ struct VirtIONet {
> >       bool failover;
> >       DeviceListener primary_listener;
> >       Notifier migration_state;
> > +    struct {
> > +        bool    enabled;
> > +        uint32_t hash_types;
> > +        uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > +        uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
> > +        uint16_t indirections_len;
> > +        uint16_t default_queue;
> > +    } rss_data;
> >   };
> >
> >   void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>
>

--00000000000008c4c205a07d994b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10, 2020 at 5:02 AM Jason=
 Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/3/9 =E4=B8=8B=E5=8D=884:34, Yuri Benditovich wrote:<br>
&gt; Optionally report RSS feature.<br>
&gt; Handle RSS configuration command and keep RSS parameters<br>
&gt; in virtio-net device context.<br>
&gt;<br>
&gt; Signed-off-by: Yuri Benditovich &lt;<a href=3D"mailto:yuri.benditovich=
@daynix.com" target=3D"_blank">yuri.benditovich@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 148 +++++++++++++++++++++++++++++++--<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-net.h |=C2=A0 11 +++<br>
&gt;=C2=A0 =C2=A03 files changed, 153 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/trace-events b/hw/net/trace-events<br>
&gt; index a1da98a643..9823480d91 100644<br>
&gt; --- a/hw/net/trace-events<br>
&gt; +++ b/hw/net/trace-events<br>
&gt; @@ -371,6 +371,9 @@ virtio_net_announce_notify(void) &quot;&quot;<br>
&gt;=C2=A0 =C2=A0virtio_net_announce_timer(int round) &quot;%d&quot;<br>
&gt;=C2=A0 =C2=A0virtio_net_handle_announce(int round) &quot;%d&quot;<br>
&gt;=C2=A0 =C2=A0virtio_net_post_load_device(void)<br>
&gt; +virtio_net_rss_disable(void)<br>
&gt; +virtio_net_rss_error(int error_case) &quot;case %d&quot;<br>
&gt; +virtio_net_rss_enable(uint32_t p1, uint16_t p2, uint8_t p3) &quot;has=
hes 0x%x, table of %d, key of %d&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0# tulip.c<br>
&gt;=C2=A0 =C2=A0tulip_reg_write(uint64_t addr, const char *name, int size,=
 uint64_t val) &quot;addr 0x%02&quot;PRIx64&quot; (%s) size %d value 0x%08&=
quot;PRIx64<br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index 9545b0e84f..27071eccd2 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -172,6 +172,16 @@ struct virtio_net_rss_config {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 tso/gso/gro &#39;off&#39;. */<br>
&gt;=C2=A0 =C2=A0#define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv=
4 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VIRTIO_NET_RSS_HASH_TYPE_UDPv6 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VIRTIO_NET_RSS_HASH_TYPE_IP_EX | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* temporary until standard header include it */<br>
&gt;=C2=A0 =C2=A0#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -203,6 +213,8 @@ static VirtIOFeature feature_sizes[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =3D endof(struct virtio_net_config, mt=
u)},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{.flags =3D 1ULL &lt;&lt; VIRTIO_NET_F_SPEED=
_DUPLEX,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =3D endof(struct virtio_net_config, du=
plex)},<br>
&gt; +=C2=A0 =C2=A0 {.flags =3D 1ULL &lt;&lt; VIRTIO_NET_F_RSS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.end =3D endof(struct virtio_net_config, supporte=
d_hash_types)},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -233,6 +245,11 @@ static void virtio_net_get_config(VirtIODevice *v=
dev, uint8_t *config)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(netcfg.mac, n-&gt;mac, ETH_ALEN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_stl_p(vdev, &amp;netcfg.speed, n-&gt;=
net_conf.speed);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0netcfg.duplex =3D n-&gt;net_conf.duplex;<br>
&gt; +=C2=A0 =C2=A0 netcfg.rss_max_key_size =3D VIRTIO_NET_RSS_MAX_KEY_SIZE=
;<br>
&gt; +=C2=A0 =C2=A0 virtio_stw_p(vdev, &amp;netcfg.rss_max_indirection_tabl=
e_length,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_=
NET_RSS_MAX_TABLE_LEN);<br>
&gt; +=C2=A0 =C2=A0 virtio_stl_p(vdev, &amp;netcfg.supported_hash_types,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_=
NET_RSS_SUPPORTED_HASHES);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(config, &amp;netcfg, n-&gt;config_siz=
e);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -796,6 +813,7 @@ static uint64_t virtio_net_get_features(VirtIODevi=
ce *vdev, uint64_t features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return features;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 virtio_clear_feature(&amp;features, VIRTIO_NET_F_RSS);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0features =3D vhost_net_get_features(get_vhos=
t_net(nc-&gt;peer), features);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;backend_features =3D features;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -955,6 +973,7 @@ static void virtio_net_set_features(VirtIODevice *=
vdev, uint64_t features)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_set_multiqueue(n,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_has_feature(features, VIRTIO_NET=
_F_RSS) ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_has_feature(features=
, VIRTIO_NET_F_MQ));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_net_set_mrg_rx_bufs(n,<br>
&gt; @@ -1231,25 +1250,134 @@ static int virtio_net_handle_announce(VirtION=
et *n, uint8_t cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void virtio_net_disable_rss(VirtIONet *n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;rss_data.enabled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_net_rss_disable();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rss_data.enabled =3D false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint16_t virtio_net_handle_rss(VirtIONet *n,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iove=
c *iov, unsigned int iov_cnt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt; +=C2=A0 =C2=A0 struct virtio_net_rss_config cfg;<br>
&gt; +=C2=A0 =C2=A0 size_t s, offset =3D 0, size_get;<br>
&gt; +=C2=A0 =C2=A0 uint16_t queues, i;<br>
&gt; +=C2=A0 =C2=A0 struct {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t us;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t b;<br>
&gt; +=C2=A0 =C2=A0 } QEMU_PACKED temp;<br>
&gt; +=C2=A0 =C2=A0 int err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_RSS)) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 size_get =3D offsetof(struct virtio_net_rss_config, ind=
irection_table);<br>
&gt; +=C2=A0 =C2=A0 s =3D iov_to_buf(iov, iov_cnt, offset, &amp;cfg, size_g=
et);<br>
&gt; +=C2=A0 =C2=A0 if (s !=3D size_get) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rss_data.hash_types =3D virtio_ldl_p(vdev, &amp;c=
fg.hash_types);<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rss_data.indirections_len =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_lduw_p(vdev, &amp;cfg.indirection_=
table_mask);<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rss_data.indirections_len++;<br>
&gt; +=C2=A0 =C2=A0 if (!is_power_of_2(n-&gt;rss_data.indirections_len)) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;rss_data.indirections_len &gt; VIRTIO_NET_RSS=
_MAX_TABLE_LEN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rss_data.default_queue =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_lduw_p(vdev, &amp;cfg.unclassified=
_queue);<br>
&gt; +=C2=A0 =C2=A0 if (n-&gt;rss_data.default_queue &gt;=3D n-&gt;max_queu=
es) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 5;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 offset +=3D size_get;<br>
&gt; +=C2=A0 =C2=A0 size_get =3D sizeof(uint16_t) * n-&gt;rss_data.indirect=
ions_len;<br>
&gt; +=C2=A0 =C2=A0 s =3D iov_to_buf(iov, iov_cnt, offset, n-&gt;rss_data.i=
ndirections, size_get);<br>
&gt; +=C2=A0 =C2=A0 if (s !=3D size_get) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 10;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; n-&gt;rss_data.indirections_len; +=
+i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t val =3D n-&gt;rss_data.indirecti=
ons[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.indirections[i] =3D virtio=
_lduw_p(vdev, &amp;val);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 offset +=3D size_get;<br>
&gt; +=C2=A0 =C2=A0 size_get =3D sizeof(temp);<br>
&gt; +=C2=A0 =C2=A0 s =3D iov_to_buf(iov, iov_cnt, offset, &amp;temp, size_=
get);<br>
&gt; +=C2=A0 =C2=A0 if (s !=3D size_get) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 11;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 queues =3D virtio_lduw_p(vdev, &amp;<a href=3D"http://t=
emp.us" rel=3D"noreferrer" target=3D"_blank">temp.us</a>);<br>
&gt; +=C2=A0 =C2=A0 if (queues =3D=3D 0 || queues &gt; n-&gt;max_queues) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 12;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (temp.b &gt; VIRTIO_NET_RSS_MAX_KEY_SIZE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 13;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!temp.b &amp;&amp; n-&gt;rss_data.hash_types) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 20;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!temp.b &amp;&amp; !n-&gt;rss_data.hash_types) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_disable_rss(n);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return queues;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 offset +=3D size_get;<br>
&gt; +=C2=A0 =C2=A0 size_get =3D temp.b;<br>
&gt; +=C2=A0 =C2=A0 s =3D iov_to_buf(iov, iov_cnt, offset, n-&gt;rss_data.k=
ey, size_get);<br>
&gt; +=C2=A0 =C2=A0 if (s !=3D size_get) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 21;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 n-&gt;rss_data.enabled =3D true;<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_net_rss_enable(n-&gt;rss_data.hash_types,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;rss_data.indirections_len,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp.b);<br>
&gt; +=C2=A0 =C2=A0 return queues;<br>
&gt; +error:<br>
&gt; +=C2=A0 =C2=A0 warn_report(&quot;%s: error_case %d&quot;, __func__, er=
r);<br>
<br>
<br>
I&#39;m not sure using warn_report() is good for such guest triggerable <br=
>
behavior.<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 trace_virtio_net_rss_error(err);<br>
<br>
<br>
It looks to me it would be better to be verbose here (show temp.b or other)=
<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 virtio_net_disable_rss(n);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovec *iov, u=
nsigned int iov_cnt)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtIODevice *vdev =3D VIRTIO_DEVICE(n);<br>
&gt; -=C2=A0 =C2=A0 struct virtio_net_ctrl_mq mq;<br>
&gt; -=C2=A0 =C2=A0 size_t s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t queues;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 s =3D iov_to_buf(iov, iov_cnt, 0, &amp;mq, sizeof(mq));=
<br>
&gt; -=C2=A0 =C2=A0 if (s !=3D sizeof(mq)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return VIRTIO_NET_ERR;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 virtio_net_disable_rss(n);<br>
&gt; +=C2=A0 =C2=A0 if (cmd =3D=3D VIRTIO_NET_CTRL_MQ_RSS_CONFIG) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 queues =3D virtio_net_handle_rss(n, iov, =
iov_cnt);<br>
&gt; +=C2=A0 =C2=A0 } else if (cmd =3D=3D VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) =
{<br>
<br>
<br>
It looks to me RSS and MQ are mutually exclusive, is this intentional?<br><=
/blockquote><div><br></div><div>No they are not. The device can support RSS=
 or MQ or both.</div><div>The driver can activate multiqueue by VIRTIO_NET_=
CTRL_MQ_VQ_PAIRS_SET.</div><div>The driver can activate multiqueue by=C2=A0

VIRTIO_NET_CTRL_MQ_RSS_CONFIG=C2=A0 .</div><div></div><div>=C2=A0</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_net_ctrl_mq mq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t s;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_vdev_has_feature(vdev, VIRTIO=
_NET_F_MQ)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return VIRTIO_NET_ERR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s =3D iov_to_buf(iov, iov_cnt, 0, &amp;mq=
, sizeof(mq));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s !=3D sizeof(mq)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return VIRTIO_NET_ERR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 queues =3D virtio_lduw_p(vdev, &amp;mq.vi=
rtqueue_pairs);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (cmd !=3D VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return VIRTIO_NET_ERR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 queues =3D virtio_lduw_p(vdev, &amp;mq.virtqueue_pairs)=
;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (queues &lt; VIRTIO_NET_CTRL_MQ_VQ_PAIRS_=
MIN ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queues &gt; VIRTIO_NET_CTRL_MQ=
_VQ_PAIRS_MAX ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queues &gt; n-&gt;max_queues |=
|<br>
&gt; @@ -3304,6 +3432,8 @@ static Property virtio_net_properties[] =3D {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BIT64(&quot;ctrl_guest_offloads&=
quot;, VirtIONet, host_features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BIT64(&quot;mq&quot;, VirtIONet,=
 host_features, VIRTIO_NET_F_MQ, false),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_BIT64(&quot;rss&quot;, VirtIONet, host_feat=
ures,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 VIRTIO_NET_F_RSS, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BIT64(&quot;guest_rsc_ext&quot;,=
 VirtIONet, host_features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0VIRTIO_NET_F_RSC_EXT, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;rsc_interval&quot;,=
 VirtIONet, rsc_timeout,<br>
&gt; diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio=
-net.h<br>
&gt; index 96c68d4a92..cf16f5192e 100644<br>
&gt; --- a/include/hw/virtio/virtio-net.h<br>
&gt; +++ b/include/hw/virtio/virtio-net.h<br>
&gt; @@ -126,6 +126,9 @@ typedef struct VirtioNetRscChain {<br>
&gt;=C2=A0 =C2=A0/* Maximum packet size we can receive from tap device: hea=
der + 64k */<br>
&gt;=C2=A0 =C2=A0#define VIRTIO_NET_MAX_BUFSIZE (sizeof(struct virtio_net_h=
dr) + (64 * KiB))<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define VIRTIO_NET_RSS_MAX_KEY_SIZE=C2=A0 =C2=A0 =C2=A040<br>
&gt; +#define VIRTIO_NET_RSS_MAX_TABLE_LEN=C2=A0 =C2=A0 128<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0typedef struct VirtIONetQueue {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtQueue *rx_vq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtQueue *tx_vq;<br>
&gt; @@ -199,6 +202,14 @@ struct VirtIONet {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool failover;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceListener primary_listener;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Notifier migration_state;<br>
&gt; +=C2=A0 =C2=A0 struct {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool=C2=A0 =C2=A0 enabled;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t hash_types;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t indirections[VIRTIO_NET_RSS_MAX_=
TABLE_LEN];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t indirections_len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t default_queue;<br>
&gt; +=C2=A0 =C2=A0 } rss_data;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void virtio_net_set_netclient_name(VirtIONet *n, const cha=
r *name,<br>
<br>
</blockquote></div></div>

--00000000000008c4c205a07d994b--

