Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C736DC2BAEE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72D420749
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awg42JVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72D420749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC7pn-0003Uq-NW
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 16:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jC7p2-0002av-NZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jC7p0-0000Ce-Lz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:19:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50023
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jC7p0-0000CP-H3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583957957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DY0iOw8aCkXNW03axEMLVxlFRUiQQcw8CASyhZn2Ud4=;
 b=awg42JVpoX6SaTBL7z4x3hfY6Kth1Xcdy+vGc0lhEs6uitPOWmgR5lKExSqTlmpVE0ZRS1
 xYjcSc1cF1SIbyHytRfgtJaT6jo4EmCXO3+r3zIfkDg1zgvuEHfhYuHWm7BhVlls+gKXrg
 5FjpfaHq3PyOBHQ7rhD31mZus7E+Y4Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-wIxlXqCGPN-doZs7N_5smA-1; Wed, 11 Mar 2020 16:19:16 -0400
X-MC-Unique: wIxlXqCGPN-doZs7N_5smA-1
Received: by mail-qt1-f200.google.com with SMTP id d2so2016578qtr.9
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 13:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wGirIuTk4cvgmvGoG4Hd4NaK1XJFsEs9Y8K1dZPMK6g=;
 b=W1cCXpazuqyc+XxG8CIobu9h1xVtdhOYbnGNg80iPUBtd1LPnaRDojzFekTeJr7IyN
 F/s9rSrlezzdE2izM/7MtyFs4jnNXICvzL9rf7cCSdPBScB3UDO3xATulGIXHo7XFIww
 x35izKlcD6nED0WOIfaVrB5rQ0Sbi/vXQ535nJR6PAbIoZpSOEMK7NQzxpurbGSLpnX5
 3usz8gwn+pmZKyz8Nnac7JdynEQRJGdQmDlsoaBduqTX5EhWx3r57x8G5bA6QBiIo0YO
 t6s0IJl4vP53sImwPsFC8TMgGYqAPjqMvyU7E7ieXQg4dKngJ+qXIbLcrRXUXgN6yNy4
 32eA==
X-Gm-Message-State: ANhLgQ1FxJwlPrZFsU1e1VtZM7Igt1t7OTDVLCZmKy05sdpa0Qli4sHY
 5pcY/Wasgq5BGpfYULT/DQiDj9Umftsinx6IgchMsObaEsw0Aly00wmnuZrz+hrAu9NGr9qUSLL
 gtR6H1CEfLSCL+nA=
X-Received: by 2002:ac8:1e08:: with SMTP id n8mr4293395qtl.175.1583957955557; 
 Wed, 11 Mar 2020 13:19:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsU9swn3vGwYAn5pK3cWTbg0khabNng8C4H+6V/ChPiRmx/u8MV54G9cCJuGHuVbj5gPj3qew==
X-Received: by 2002:ac8:1e08:: with SMTP id n8mr4293368qtl.175.1583957955154; 
 Wed, 11 Mar 2020 13:19:15 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id x22sm4726402qki.54.2020.03.11.13.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 13:19:14 -0700 (PDT)
Date: Wed, 11 Mar 2020 16:19:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v3 1/6] virtio-net: introduce RSS and hash report features
Message-ID: <20200311161819-mutt-send-email-mst@kernel.org>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-2-yuri.benditovich@daynix.com>
 <20200311094553-mutt-send-email-mst@kernel.org>
 <CAOEp5OdgDB5u-SeZO3y4iCTjFy6hpNfPA-ADaBbnvx=MHD_dTw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OdgDB5u-SeZO3y4iCTjFy6hpNfPA-ADaBbnvx=MHD_dTw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 03:57:58PM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Wed, Mar 11, 2020 at 3:47 PM Michael S. Tsirkin <mst@redhat.com> wrote=
:
>=20
>     On Wed, Mar 11, 2020 at 02:35:13PM +0200, Yuri Benditovich wrote:
>     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     > ---
>     >=A0 hw/net/virtio-net.c | 95 +++++++++++++++++++++++++++++++++++++++=
++++++
>     >=A0 1 file changed, 95 insertions(+)
>     >
>     > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>     > index 3627bb1717..9545b0e84f 100644
>     > --- a/hw/net/virtio-net.c
>     > +++ b/hw/net/virtio-net.c
>     > @@ -71,6 +71,101 @@
>     >=A0 #define VIRTIO_NET_IP6_ADDR_SIZE=A0 =A032=A0 =A0 =A0 /* ipv6 sad=
dr + daddr */
>     >=A0 #define VIRTIO_NET_MAX_IP6_PAYLOAD VIRTIO_NET_MAX_TCP_PAYLOAD
>     >=A0
>     > +/* TODO: remove after virtio-net header update */
>     > +#if !defined(VIRTIO_NET_RSS_HASH_TYPE_IPv4)
>     > +#define VIRTIO_NET_F_HASH_REPORT=A0 =A0 57=A0 /* Supports hash rep=
ort */
>     > +#define VIRTIO_NET_F_RSS=A0 =A0 =A0 =A0 =A0 =A0 60=A0 /* Supports =
RSS RX steering */
>     > +
>     > +/* supported/enabled hash types */
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4=A0 =A0 =A0 =A0 =A0 (1 << 0)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4=A0 =A0 =A0 =A0 =A0(1 << 1)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4=A0 =A0 =A0 =A0 =A0(1 << 2)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6=A0 =A0 =A0 =A0 =A0 (1 << 3)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6=A0 =A0 =A0 =A0 =A0(1 << 4)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6=A0 =A0 =A0 =A0 =A0(1 << 5)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX=A0 =A0 =A0 =A0 =A0(1 << 6)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX=A0 =A0 =A0 =A0 (1 << 7)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX=A0 =A0 =A0 =A0 (1 << 8)
>     > +
>     > +#define __le16 uint16_t
>     > +#define __le32 uint32_t
>     > +#define __u8=A0 =A0uint8_t
>     > +#define __u16=A0 uint16_t
>     > +#define __u32=A0 uint32_t
>=20
>     Let's just use uint16_t etc directly please.
>=20
>     > +struct virtio_net_config_with_rss {
>     > +=A0 =A0 /* The config defining mac address (if VIRTIO_NET_F_MAC) *=
/
>     > +=A0 =A0 __u8 mac[ETH_ALEN];
>     > +=A0 =A0 /* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
>     > +=A0 =A0 __u16 status;
>     > +=A0 =A0 /*
>     > +=A0 =A0 =A0* Maximum number of each of transmit and receive queues=
;
>     > +=A0 =A0 =A0* see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
>     > +=A0 =A0 =A0* Legal values are between 1 and 0x8000
>     > +=A0 =A0 =A0*/
>     > +=A0 =A0 __u16 max_virtqueue_pairs;
>     > +=A0 =A0 /* Default maximum transmit unit advice */
>     > +=A0 =A0 __u16 mtu;
>     > +=A0 =A0 /*
>     > +=A0 =A0 =A0* speed, in units of 1Mb. All values 0 to INT_MAX are l=
egal.
>     > +=A0 =A0 =A0* Any other value stands for unknown.
>     > +=A0 =A0 =A0*/
>     > +=A0 =A0 __u32 speed;
>     > +=A0 =A0 /*
>     > +=A0 =A0 =A0* 0x00 - half duplex
>     > +=A0 =A0 =A0* 0x01 - full duplex
>     > +=A0 =A0 =A0* Any other value stands for unknown.
>     > +=A0 =A0 =A0*/
>     > +=A0 =A0 __u8 duplex;
>     > +=A0 =A0 /* maximum size of RSS key */
>     > +=A0 =A0 __u8 rss_max_key_size;
>     > +=A0 =A0 /* maximum number of indirection table entries */
>     > +=A0 =A0 __le16 rss_max_indirection_table_length;
>     > +=A0 =A0 /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
>     > +=A0 =A0 __le32 supported_hash_types;
>     > +} __attribute__((packed));
>     > +
>     > +#define virtio_net_config virtio_net_config_with_rss
>=20
>     Do we have to? Let's just tweak code to do the right thing...
>=20
>=20
> Are we going to update the virtio_net some time?
> If yes, IMO makes sense to do less tweaking in the middle of the code.
> Then, upon update of virtio_net.h - easily remove all these defines that =
were
> added in virtio-net.c=A0

We'll update it in a month or two. But I'd be reluctant to merge hacks
since people tend to copy-paste code ...

>=20
>=20
>     > +
>     > +struct virtio_net_hdr_v1_hash {
>     > +=A0 =A0 struct virtio_net_hdr_v1 hdr;
>     > +=A0 =A0 __le32 hash_value;
>     > +#define VIRTIO_NET_HASH_REPORT_NONE=A0 =A0 =A0 =A0 =A0 =A0 0
>     > +#define VIRTIO_NET_HASH_REPORT_IPv4=A0 =A0 =A0 =A0 =A0 =A0 1
>     > +#define VIRTIO_NET_HASH_REPORT_TCPv4=A0 =A0 =A0 =A0 =A0 =A02
>     > +#define VIRTIO_NET_HASH_REPORT_UDPv4=A0 =A0 =A0 =A0 =A0 =A03
>     > +#define VIRTIO_NET_HASH_REPORT_IPv6=A0 =A0 =A0 =A0 =A0 =A0 4
>     > +#define VIRTIO_NET_HASH_REPORT_TCPv6=A0 =A0 =A0 =A0 =A0 =A05
>     > +#define VIRTIO_NET_HASH_REPORT_UDPv6=A0 =A0 =A0 =A0 =A0 =A06
>     > +#define VIRTIO_NET_HASH_REPORT_IPv6_EX=A0 =A0 =A0 =A0 =A07
>     > +#define VIRTIO_NET_HASH_REPORT_TCPv6_EX=A0 =A0 =A0 =A0 8
>     > +#define VIRTIO_NET_HASH_REPORT_UDPv6_EX=A0 =A0 =A0 =A0 9
>     > +=A0 =A0 __le16 hash_report;
>     > +=A0 =A0 __le16 padding;
>     > +};
>     > +
>     > +/*
>     > + * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect a=
s
>     > + * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configure=
s
>     > + * the receive steering to use a hash calculated for incoming pack=
et
>     > + * to decide on receive virtqueue to place the packet. The command
>     > + * also provides parameters to calculate a hash and receive virtqu=
eue.
>     > + */
>     > +struct virtio_net_rss_config {
>     > +=A0 =A0 __le32 hash_types;
>     > +=A0 =A0 __le16 indirection_table_mask;
>     > +=A0 =A0 __le16 unclassified_queue;
>     > +=A0 =A0 __le16 indirection_table[1/* + indirection_table_mask */];
>     > +=A0 =A0 __le16 max_tx_vq;
>     > +=A0 =A0 __u8 hash_key_length;
>     > +=A0 =A0 __u8 hash_key_data[/* hash_key_length */];
>     > +};
>     > +
>     > +#define VIRTIO_NET_CTRL_MQ_RSS_CONFIG=A0 =A0 =A0 =A0 =A0 1
>     > +#define VIRTIO_NET_CTRL_MQ_HASH_CONFIG=A0 =A0 =A0 =A0 =A02
>     > +
>     > +#endif
>     > +
>     >=A0 /* Purge coalesced packets timer interval, This value affects th=
e
>     performance
>     >=A0 =A0 =A0a lot, and should be tuned carefully, '300000'(300us) is =
the
>     recommended
>     >=A0 =A0 =A0value to pass the WHQL test, '50000' can gain 2x netperf =
throughput
>     with
>     > --
>     > 2.17.1
>=20
>=20


