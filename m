Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E8C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC65F20749
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkhjWkc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC65F20749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC7rQ-0004ye-Q6
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 16:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jC7qh-0004St-0r
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jC7qf-0000uo-Vq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:21:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jC7qf-0000ui-Rn
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583958061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8w75AdQdzA85zlo0503D6bWGmfY3m2f3+ZZ1nSgdUTU=;
 b=MkhjWkc3q24shXjmBN9GULgASQYf7V6AyhT7wDqKbqY61RAdlOcozubc0u+brZWv3jUFu8
 zPaj2EJZzazH7Os7N+/PEMdzBpr+AR/VFzPTiD69JH8sv/lxGqxglUTLIEPP75AIFKuftf
 0VQYhkuNHTESjtNe4gJGfNiL4erod0Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-esPQJbLMMfeSCOewoRz7-w-1; Wed, 11 Mar 2020 16:20:59 -0400
X-MC-Unique: esPQJbLMMfeSCOewoRz7-w-1
Received: by mail-qk1-f200.google.com with SMTP id c1so159019qkg.21
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 13:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=HJlTrBB/2ZBGIl3iRiUb2Myys1soX8gqFz6FF7/tH4M=;
 b=GL4jg6cF6yZzF7hytzxKatNjJ7p2ywZehUa3971olXxjXOyYE5jJbNkqGZmvmmGF4y
 hObyjawYTuDjxTPS19VcAVt1aRNeiRueXl1Xhmi1VARBHGyT6ysMgWRgK4EMmdWo56OD
 q+VG6svx25E+7rm/OY8Sv59TgKJltngziOvTuKRGP5Nc/XlOqkF7mk6t7Y75Mf5JT389
 UjOCIr6iE+i04iwnbmgNUzpLm5a+jU98NMvSdTSiK0FJj8S+dgNDgQxbbd9s2LKI6zOY
 3Eq4C9GXwHOcN7HMREfiIumv79+GjMFwkwEBqXr6XHPnufXW23fiJheUq9Ld5LVtQ/eq
 D0IA==
X-Gm-Message-State: ANhLgQ1Mj69BiCjYOxOfgJzOPfvmKaAcJqLn8y7sFll48ZiQy6D07Fub
 XwDHOAbRgqjowFdgt5HoYjHD4qMMNqlC3hoq43reNT566/QujwFBzce3ucn3GeMdqEyHy//AGxh
 panBwpJkxWieKXvE=
X-Received: by 2002:a37:27cd:: with SMTP id n196mr4679876qkn.144.1583958059034; 
 Wed, 11 Mar 2020 13:20:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4Eq8Cl885NGo8s+eMa4fSbnmPHMehpQpcugnVjnpOU32xD2v6kxImA6xOkctFxPP2MzY9pQ==
X-Received: by 2002:a37:27cd:: with SMTP id n196mr4679857qkn.144.1583958058702; 
 Wed, 11 Mar 2020 13:20:58 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id j17sm26764006qth.27.2020.03.11.13.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 13:20:57 -0700 (PDT)
Date: Wed, 11 Mar 2020 16:20:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v3 5/6] virtio-net: add migration support for RSS and
 hast report
Message-ID: <20200311161924-mutt-send-email-mst@kernel.org>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-6-yuri.benditovich@daynix.com>
 <20200311094706-mutt-send-email-mst@kernel.org>
 <CAOEp5OdjP4XsSkyCU0n1YGvyWwayOH5D6iTP-8RRLYfwSJd=7Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OdjP4XsSkyCU0n1YGvyWwayOH5D6iTP-8RRLYfwSJd=7Q@mail.gmail.com>
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

On Wed, Mar 11, 2020 at 04:00:44PM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Wed, Mar 11, 2020 at 3:48 PM Michael S. Tsirkin <mst@redhat.com> wrote=
:
>=20
>     On Wed, Mar 11, 2020 at 02:35:17PM +0200, Yuri Benditovich wrote:
>     > Save and restore RSS/hash report configuration.
>     >
>     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     > ---
>     >=A0 hw/net/virtio-net.c | 9 +++++++++
>     >=A0 1 file changed, 9 insertions(+)
>     >
>     > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>     > index 7b6a929e8c..c8d97d45cd 100644
>     > --- a/hw/net/virtio-net.c
>     > +++ b/hw/net/virtio-net.c
>     > @@ -2869,6 +2869,13 @@ static int virtio_net_post_load_device(void
>     *opaque, int version_id)
>     >=A0 =A0 =A0 =A0 =A0 }
>     >=A0 =A0 =A0 }
>     >=A0
>     > +=A0 =A0 if (n->rss_data.enabled) {
>     > +=A0 =A0 =A0 =A0 trace_virtio_net_rss_enable(n->rss_data.hash_types=
,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 n->rss_data.indirections_len,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 sizeof(n->rss_data.key));
>     > +=A0 =A0 } else {
>     > +=A0 =A0 =A0 =A0 trace_virtio_net_rss_disable();
>     > +=A0 =A0 }
>     >=A0 =A0 =A0 return 0;
>     >=A0 }
>     >=A0
>     > @@ -3094,6 +3101,8 @@ static const VMStateDescription
>     vmstate_virtio_net_device =3D {
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vmstate_virti=
o_net_tx_waiting),
>     >=A0 =A0 =A0 =A0 =A0 VMSTATE_UINT64_TEST(curr_guest_offloads, VirtION=
et,
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 has_ctrl=
_guest_offloads),
>     > +=A0 =A0 =A0 =A0 VMSTATE_UINT8_ARRAY(rss_data_migration, VirtIONet,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(Vir=
tioNetRssData)),
>     >=A0 =A0 =A0 =A0 =A0 VMSTATE_END_OF_LIST()
>     >=A0 =A0 =A0},
>=20
>=20
>     I think we should migrate the length too. Avoid arbitrary limits.
>=20
>=20
> The length of what?

Of the tables.
> The structure is fixed-length and the intention=A0is just to
> keep/restore it.
> The length of indirection table and the table itself are part of the stru=
cture.


And that's a problem, because
1. we are wasting memory for a rarely used feature
2. if we want to make the table bigger, we'll need to break
   migration compatibility

Just allocate these dynamically as needed, and migrate length.


>=20
>     Yes this means we should allocate the indirection arrays on the fly.
>     But that's probably a good idea anyway.
>=20
>     >=A0 };
>     > --
>     > 2.17.1
>=20
>=20


