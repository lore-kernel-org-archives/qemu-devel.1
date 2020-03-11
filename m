Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD67C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6E920873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbo1L8bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6E920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1iD-00042x-4v
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jC1hU-0003Ph-0G
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jC1hR-0005BJ-S4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:47:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56281
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jC1hR-000595-Nm
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZ+e/lX1wwunGlLByqSBe8KiqcVIkflaXozg8bWItOs=;
 b=Hbo1L8bXc6NGXzKT1T0TW8pk0HowsG93YxBdD9L4ZRG3YFMl3nUSN2YCY2TGM3xn+MqBfT
 w8Z2qVY/w/KJtjyCIXnOHdVX8RnZkBWKdawBVuucsoOHCkw2uITIoD86f+OTUdSafZ8qXd
 FH6VcShvs7g9gTiwL8+RGdPzGjlAx2M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-X7MbyohAMnSxWJNRaudnxg-1; Wed, 11 Mar 2020 09:47:03 -0400
X-MC-Unique: X7MbyohAMnSxWJNRaudnxg-1
Received: by mail-qv1-f70.google.com with SMTP id e16so1340314qvr.16
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 06:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jRLPiG3NV7cEF1iLac7jF8IzKaCS9PK5dKTHwTFRKpQ=;
 b=lTaYvk1zDFfR26cDykQhmAwLQt7psp4E/ujmCPwgaKbuEKnLgjd/HewHf7HsqCEZF7
 GD+yJU5/HuwTyfZMl9wGWoR0zeZNgO/uzZ8NtqSk7eZWyvbmoebjQLrkOr3BPcineLum
 ySPjSZcAk3IcbV/+qc2rA7iRW6vYPNXfVWteP0sgwnuWipYPRAklRaIqBHzBqaGhjgML
 Z2qkX1YsRepKJ/A36l8+jdOvmu4myhi9Qyhk5vVwAqJF3yTAO0rEWriNRTuwBaa34CB1
 fRM7BmdsN3FP5dcAxECG/yydiFYhM+x0e2iYKIDxSId8hD7Ym1oHhGwviPrQxCaz5xrc
 P9dw==
X-Gm-Message-State: ANhLgQ1m+ovPsphtQlXWBlajPB90Uno1lioAJWaGKAZPImHKVeH3ZqQJ
 5nF52+Nl/twdYcTF4zKQpQwZODsGgnVOgpue/2DEqklg6tZdKqEiwhKCog622OLlrzlOl9mxRQB
 M+xVEggQMOg7FcS0=
X-Received: by 2002:a05:6214:11ec:: with SMTP id
 e12mr2972424qvu.89.1583934422564; 
 Wed, 11 Mar 2020 06:47:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsr8jCH7cAvFNhFdAjcXS3m4PnLInw5WYz3Chf7uVgrEZ2tJ5NueCKZy8D9H722kuq0lF45bQ==
X-Received: by 2002:a05:6214:11ec:: with SMTP id
 e12mr2972412qvu.89.1583934422254; 
 Wed, 11 Mar 2020 06:47:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id f3sm15838292qtv.51.2020.03.11.06.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 06:47:01 -0700 (PDT)
Date: Wed, 11 Mar 2020 09:46:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v3 1/6] virtio-net: introduce RSS and hash report features
Message-ID: <20200311094553-mutt-send-email-mst@kernel.org>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-2-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200311123518.4025-2-yuri.benditovich@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Wed, Mar 11, 2020 at 02:35:13PM +0200, Yuri Benditovich wrote:
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/net/virtio-net.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 3627bb1717..9545b0e84f 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -71,6 +71,101 @@
>  #define VIRTIO_NET_IP6_ADDR_SIZE   32      /* ipv6 saddr + daddr */
>  #define VIRTIO_NET_MAX_IP6_PAYLOAD VIRTIO_NET_MAX_TCP_PAYLOAD
> =20
> +/* TODO: remove after virtio-net header update */
> +#if !defined(VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> +#define VIRTIO_NET_F_HASH_REPORT    57  /* Supports hash report */
> +#define VIRTIO_NET_F_RSS            60  /* Supports RSS RX steering */
> +
> +/* supported/enabled hash types */
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
> +
> +#define __le16 uint16_t
> +#define __le32 uint32_t
> +#define __u8   uint8_t
> +#define __u16  uint16_t
> +#define __u32  uint32_t

Let's just use uint16_t etc directly please.

> +struct virtio_net_config_with_rss {
> +    /* The config defining mac address (if VIRTIO_NET_F_MAC) */
> +    __u8 mac[ETH_ALEN];
> +    /* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
> +    __u16 status;
> +    /*
> +     * Maximum number of each of transmit and receive queues;
> +     * see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
> +     * Legal values are between 1 and 0x8000
> +     */
> +    __u16 max_virtqueue_pairs;
> +    /* Default maximum transmit unit advice */
> +    __u16 mtu;
> +    /*
> +     * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
> +     * Any other value stands for unknown.
> +     */
> +    __u32 speed;
> +    /*
> +     * 0x00 - half duplex
> +     * 0x01 - full duplex
> +     * Any other value stands for unknown.
> +     */
> +    __u8 duplex;
> +    /* maximum size of RSS key */
> +    __u8 rss_max_key_size;
> +    /* maximum number of indirection table entries */
> +    __le16 rss_max_indirection_table_length;
> +    /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> +    __le32 supported_hash_types;
> +} __attribute__((packed));
> +
> +#define virtio_net_config virtio_net_config_with_rss

Do we have to? Let's just tweak code to do the right thing...

> +
> +struct virtio_net_hdr_v1_hash {
> +    struct virtio_net_hdr_v1 hdr;
> +    __le32 hash_value;
> +#define VIRTIO_NET_HASH_REPORT_NONE            0
> +#define VIRTIO_NET_HASH_REPORT_IPv4            1
> +#define VIRTIO_NET_HASH_REPORT_TCPv4           2
> +#define VIRTIO_NET_HASH_REPORT_UDPv4           3
> +#define VIRTIO_NET_HASH_REPORT_IPv6            4
> +#define VIRTIO_NET_HASH_REPORT_TCPv6           5
> +#define VIRTIO_NET_HASH_REPORT_UDPv6           6
> +#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> +#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> +#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> +    __le16 hash_report;
> +    __le16 padding;
> +};
> +
> +/*
> + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
> + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
> + * the receive steering to use a hash calculated for incoming packet
> + * to decide on receive virtqueue to place the packet. The command
> + * also provides parameters to calculate a hash and receive virtqueue.
> + */
> +struct virtio_net_rss_config {
> +    __le32 hash_types;
> +    __le16 indirection_table_mask;
> +    __le16 unclassified_queue;
> +    __le16 indirection_table[1/* + indirection_table_mask */];
> +    __le16 max_tx_vq;
> +    __u8 hash_key_length;
> +    __u8 hash_key_data[/* hash_key_length */];
> +};
> +
> +#define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> +#define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
> +
> +#endif
> +
>  /* Purge coalesced packets timer interval, This value affects the perfor=
mance
>     a lot, and should be tuned carefully, '300000'(300us) is the recommen=
ded
>     value to pass the WHQL test, '50000' can gain 2x netperf throughput w=
ith
> --=20
> 2.17.1


