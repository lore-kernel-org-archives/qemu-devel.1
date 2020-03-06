Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFFAC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9762B207FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYM5gmdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9762B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAABb-0003dp-LV
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAAAz-00038C-MR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAAAy-0004Kd-Bt
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:25:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53341
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAAAy-0004Ic-7C
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583490351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwTG91Z0UrMLSgqKM3z5NdRNykS8obtcjvFPhfrFI/I=;
 b=hYM5gmdAQopjxNxxcTouZmNmEhlMZIgN0znrY5QBnGqhFiK9expBuheyQutHGTwYkxxRKm
 Fv1fu9UJ0AkFif0dUY6fautJOd6k5T6xoYYta7iYY/2/Ru5n3aAME6BET9nwLXMPakJ1t6
 bsoFz/QJEUfJVKaajI51E6Cmfpl6aRI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-4AHpjZ5bPCioD01wLDEcvw-1; Fri, 06 Mar 2020 05:25:50 -0500
X-MC-Unique: 4AHpjZ5bPCioD01wLDEcvw-1
Received: by mail-qk1-f198.google.com with SMTP id v189so1150766qkb.16
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 02:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AW4v09Vd96b9fi6my7L4ohTPyY7UcwbrJewejEw9AHI=;
 b=NmFT3HqfH3tE5CRN97PnuRaP1x8D8q9fUp7TIZyFxsI/OC7x/EFXcsnx/lb4YFeVrq
 7sCji3av+JjdpQRunBIQhlY/Ai5o6VtDP1X5fVBYJ1UHrcAKVZHLBM9Ld+bFo7ii1GIg
 lvEM8tGEubdKXSPk2BCpsoWApJX0qzoOfQPiAaFZ2J/xAWWDvfACVYEoFqqHggH2Z8Nk
 hkkYtQTCA6Yp20DQ45dO8lk1UanwPTIcZKncQGUNLjVYBU9ShOi+Xmk+T0YnUGm0Io1r
 mqPxz5TGM1aLBUP2Il1WFqSSHSscm2mtGE+CCN/5M7NuBj/O5AI5BSnsrfXC4e6MWTCC
 urzw==
X-Gm-Message-State: ANhLgQ1naJKdm/5Bw3hIOGHkfV2FX3y9HAyrh/x+j6IqlDQw03gxm/HA
 hdfohHowHEDjX4BT7xcEX75Mv+Z9uH3MrhaX0ffm8lAasdjOBHtdQUrOIC3oQS7qAUW91agYKem
 G+bxUOGfr390qioE=
X-Received: by 2002:a0c:d603:: with SMTP id c3mr2229030qvj.45.1583490348813;
 Fri, 06 Mar 2020 02:25:48 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu2UbDFSCHwP7D6rxln5dc25KjIVhA8b+6v+G8yPgus7XWeJKbhuCu72TIXr2yIW4uSaXeF9w==
X-Received: by 2002:a0c:d603:: with SMTP id c3mr2229017qvj.45.1583490348535;
 Fri, 06 Mar 2020 02:25:48 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id a23sm17214816qko.77.2020.03.06.02.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 02:25:47 -0800 (PST)
Date: Fri, 6 Mar 2020 05:25:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 1/3] virtio-net: introduce RSS RX steering feature
Message-ID: <20200306052517-mutt-send-email-mst@kernel.org>
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <20200226174809.9675-2-yuri.benditovich@daynix.com>
 <20200305082023-mutt-send-email-mst@kernel.org>
 <CAOEp5Oc+dTzJHzof9suUbXEgBnYoa4bh87K-ALWMzw_MzYf4Mw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Oc+dTzJHzof9suUbXEgBnYoa4bh87K-ALWMzw_MzYf4Mw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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

On Fri, Mar 06, 2020 at 11:29:50AM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Thu, Mar 5, 2020 at 3:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
>     On Wed, Feb 26, 2020 at 07:48:07PM +0200, Yuri Benditovich wrote:
>     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     > ---
>     >=A0 include/standard-headers/linux/virtio_net.h | 37 +++++++++++++++=
++++--
>     >=A0 1 file changed, 35 insertions(+), 2 deletions(-)
>=20
>=20
>     It will take a bit until next merge window when the linux
>     headers will be updated.
>     Until that happens you can just put these defines where
>     they are used.
>=20
>=20
> We also extend the configuration virtio_net_config structure and its
> field 'supported_hash_types' uses these defines. Please advise.


Make a private copy of it with a different name for now.
Add a comment so we don't forget to remove down the road.

>=20
>=20
>     > diff --git a/include/standard-headers/linux/virtio_net.h b/include/
>     standard-headers/linux/virtio_net.h
>     > index 260c3681d7..3bc100afe3 100644
>     > --- a/include/standard-headers/linux/virtio_net.h
>     > +++ b/include/standard-headers/linux/virtio_net.h
>     > @@ -57,6 +57,7 @@
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 * Steering */
>     >=A0 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=A0 =A0 =A0 =A0 /* Set MAC =
address */
>     >=A0
>     > +#define VIRTIO_NET_F_RSS=A0 =A0 =A0 =A060=A0 =A0 /* Supports RSS R=
X steering */
>     >=A0 #define VIRTIO_NET_F_STANDBY=A0 =A062=A0 =A0 /* Act as standby f=
or another
>     device
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 * with the same MAC.
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 */
>     > @@ -69,6 +70,16 @@
>     >=A0 #define VIRTIO_NET_S_LINK_UP 1=A0 =A0 =A0 =A0/* Link is up */
>     >=A0 #define VIRTIO_NET_S_ANNOUNCE=A0 =A0 =A0 =A0 2=A0 =A0 =A0 =A0/* =
Announcement is needed *
>     /
>     >=A0
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv4=A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
1 << 0)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4=A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1 << 1)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4=A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1 << 2)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_IPv6=A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
1 << 3)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6=A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1 << 4)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6=A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1 << 5)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX=A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1 << 6)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX=A0 =A0 =A0 =A0 =A0 =A0 (1 =
<< 7)
>     > +#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX=A0 =A0 =A0 =A0 =A0 =A0 (1 =
<< 8)
>     > +
>     >=A0 struct virtio_net_config {
>     >=A0 =A0 =A0 =A0/* The config defining mac address (if VIRTIO_NET_F_M=
AC) */
>     >=A0 =A0 =A0 =A0uint8_t mac[ETH_ALEN];
>     > @@ -92,6 +103,14 @@ struct virtio_net_config {
>     >=A0 =A0 =A0 =A0 * Any other value stands for unknown.
>     >=A0 =A0 =A0 =A0 */
>     >=A0 =A0 =A0 =A0uint8_t duplex;
>     > +
>     > +=A0 =A0 =A0/* maximal size of RSS key */
>     > +=A0 =A0 =A0uint8_t rss_max_key_size;
>     > +=A0 =A0 =A0/* maximal number of indirection table entries */
>     > +=A0 =A0 =A0uint16_t rss_max_indirection_table_length;
>     > +=A0 =A0 =A0/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
>     > +=A0 =A0 =A0uint32_t supported_hash_types;
>     > +
>     >=A0 } QEMU_PACKED;
>     >=A0
>     >=A0 /*
>     > @@ -237,15 +256,29 @@ struct virtio_net_ctrl_mac {
>     >=A0 =A0* Accordingly, driver should not transmit new packets=A0 on v=
irtqueues
>     other than
>     >=A0 =A0* specified.
>     >=A0 =A0*/
>     > +#define VIRTIO_NET_CTRL_MQ=A0 =A04
>     > + #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET=A0 =A0 =A0 =A0 0
>     > + #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG=A0 =A0 =A0 =A0 =A0 1
>     > +
>     > +/* for VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET */
>     >=A0 struct virtio_net_ctrl_mq {
>     >=A0 =A0 =A0 =A0__virtio16 virtqueue_pairs;
>     >=A0 };
>     >=A0
>     > -#define VIRTIO_NET_CTRL_MQ=A0 =A04
>     > - #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET=A0 =A0 =A0 =A0 0
>     >=A0 =A0#define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN=A0 =A0 =A0 =A0 1
>     >=A0 =A0#define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX=A0 =A0 =A0 =A0 0x8000
>     >=A0
>     > +/* for VIRTIO_NET_CTRL_MQ_RSS_CONFIG */
>     > +struct virtio_net_rss_config {
>     > +=A0 =A0 uint32_t hash_types;
>     > +=A0 =A0 uint16_t indirection_table_mask;
>     > +=A0 =A0 uint16_t unclassified_queue;
>     > +=A0 =A0 uint16_t indirection_table[1/* + indirection_table_mask*/]=
;
>     > +=A0 =A0 uint16_t max_tx_vq;
>     > +=A0 =A0 uint8_t hash_key_length;
>     > +=A0 =A0 uint8_t hash_key_data[/*hash_key_length*/];
>     > +};
>     > +
>     >=A0 /*
>     >=A0 =A0* Control network offloads
>     >=A0 =A0*
>     > --
>     > 2.17.1
>=20
>=20


