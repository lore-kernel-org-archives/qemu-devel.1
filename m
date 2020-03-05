Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FBC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77EA20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNs4kSVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77EA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9qRx-0006ID-Tm
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 08:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j9qRE-0005Ml-Ql
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j9qRC-00068F-Lt
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:21:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26189
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j9qRC-00065v-Hm
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583414477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MAJn7FO7MMhavnRdTuvWuPBkcrJ196FOucbi7SppM8=;
 b=NNs4kSVLgk0d8dWS7l+81vVDcDIak4TbMiDurVqO70jN1zXOgfpoZeK4nc6XOfcj6vUXnZ
 VL2yBJVrIf8Z0Rzhfo6vmmaivpycnD5Zziug8peVgt+tuLpYX0LuBkhHatBEEp82xwCv5M
 uzN5RH2dY12707i6XJMTUC7uVO5kmiQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-_PuUsmrwPDyQeeMuzXu1UA-1; Thu, 05 Mar 2020 08:21:15 -0500
X-MC-Unique: _PuUsmrwPDyQeeMuzXu1UA-1
Received: by mail-qk1-f200.google.com with SMTP id x19so3775175qkh.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 05:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pPBtf1KBfOnsy75NTbqtKKGkYYY4NdclOlx3Hf4j5zs=;
 b=N0XCCKNdnMnp99be0E4ikjEHJ5VeBPgeKnyjVspSQnHfyo3k9v4xhxvouK1xL046+4
 01k2aWKqa9jEhJN1wtdjDGL9OOgHvGbfp0dInHEXK9hexF3TcGbK5p1ApU0o3CvrvMER
 MYvYq8NgBoh/KSy3ugWEaPl+WY5aC3JfY0b/opxEZ8cJ6FFqXaNvc35S2izdcYCYVf0U
 zYW+2EbjETp/HlSqCHQM/ht2DMl1IkSBLIMp4VXz5ZsYUKBKVc7FwMdUwimlyuvf+ldN
 32TqXbrMTx9AKSYxrmMsjbkD8kVq87OneUbBQR3a55LPPKmtyqwzNya75fxMIJzALWFf
 9+zg==
X-Gm-Message-State: ANhLgQ1+D6xTdda1pCW2xUJdtprQz6L6HLabEbkuWKxadQvsHA7/sFH5
 DvHNQCjslZY8UEFaa6XPobcs4mTDOYmPXAJjJUeiFPgNNOk+7UHHl0B4wA1Scvd2K9aNqdambir
 3BhqKVq8mH6KT1zI=
X-Received: by 2002:a0c:c542:: with SMTP id y2mr6248730qvi.225.1583414475250; 
 Thu, 05 Mar 2020 05:21:15 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtEBpDxtuJpp1nQjU2nXfjBLL0pGp2qFTJoV0UDiwnyMcLN6c6fkYjGprvxucaWaphQxUYD9g==
X-Received: by 2002:a0c:c542:: with SMTP id y2mr6248710qvi.225.1583414474928; 
 Thu, 05 Mar 2020 05:21:14 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id d9sm15393296qth.34.2020.03.05.05.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 05:21:14 -0800 (PST)
Date: Thu, 5 Mar 2020 08:21:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 1/3] virtio-net: introduce RSS RX steering feature
Message-ID: <20200305082023-mutt-send-email-mst@kernel.org>
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <20200226174809.9675-2-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200226174809.9675-2-yuri.benditovich@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Wed, Feb 26, 2020 at 07:48:07PM +0200, Yuri Benditovich wrote:
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/standard-headers/linux/virtio_net.h | 37 +++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)


It will take a bit until next merge window when the linux
headers will be updated.
Until that happens you can just put these defines where
they are used.

> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standa=
rd-headers/linux/virtio_net.h
> index 260c3681d7..3bc100afe3 100644
> --- a/include/standard-headers/linux/virtio_net.h
> +++ b/include/standard-headers/linux/virtio_net.h
> @@ -57,6 +57,7 @@
>  =09=09=09=09=09 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=09/* Set MAC address */
> =20
> +#define VIRTIO_NET_F_RSS    =09  60=09/* Supports RSS RX steering */
>  #define VIRTIO_NET_F_STANDBY=09  62=09/* Act as standby for another devi=
ce
>  =09=09=09=09=09 * with the same MAC.
>  =09=09=09=09=09 */
> @@ -69,6 +70,16 @@
>  #define VIRTIO_NET_S_LINK_UP=091=09/* Link is up */
>  #define VIRTIO_NET_S_ANNOUNCE=092=09/* Announcement is needed */
> =20
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4              (1 << 0)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4             (1 << 1)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4             (1 << 2)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6              (1 << 3)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6             (1 << 4)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6             (1 << 5)
> +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX             (1 << 6)
> +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX            (1 << 7)
> +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX            (1 << 8)
> +
>  struct virtio_net_config {
>  =09/* The config defining mac address (if VIRTIO_NET_F_MAC) */
>  =09uint8_t mac[ETH_ALEN];
> @@ -92,6 +103,14 @@ struct virtio_net_config {
>  =09 * Any other value stands for unknown.
>  =09 */
>  =09uint8_t duplex;
> +
> +=09/* maximal size of RSS key */
> +=09uint8_t rss_max_key_size;
> +=09/* maximal number of indirection table entries */
> +=09uint16_t rss_max_indirection_table_length;
> +=09/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
> +=09uint32_t supported_hash_types;
> +
>  } QEMU_PACKED;
> =20
>  /*
> @@ -237,15 +256,29 @@ struct virtio_net_ctrl_mac {
>   * Accordingly, driver should not transmit new packets  on virtqueues ot=
her than
>   * specified.
>   */
> +#define VIRTIO_NET_CTRL_MQ   4
> + #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
> + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> +
> +/* for VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET */
>  struct virtio_net_ctrl_mq {
>  =09__virtio16 virtqueue_pairs;
>  };
> =20
> -#define VIRTIO_NET_CTRL_MQ   4
> - #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
>   #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
> =20
> +/* for VIRTIO_NET_CTRL_MQ_RSS_CONFIG */
> +struct virtio_net_rss_config {
> +    uint32_t hash_types;
> +    uint16_t indirection_table_mask;
> +    uint16_t unclassified_queue;
> +    uint16_t indirection_table[1/* + indirection_table_mask*/];
> +    uint16_t max_tx_vq;
> +    uint8_t hash_key_length;
> +    uint8_t hash_key_data[/*hash_key_length*/];
> +};
> +
>  /*
>   * Control network offloads
>   *
> --=20
> 2.17.1


