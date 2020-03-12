Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD1EC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59969206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjYDAz76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59969206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJ7n-0000MZ-Cg
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 04:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCJ76-00083e-T6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCJ75-0000Ej-G9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:22:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43461
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCJ75-0000EK-C3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584001362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ol9yK6++2tTjuGBZIYnj7FK20hIstBYvg7g7cvAicQ=;
 b=RjYDAz76c8fIh5WD5+kWPqkGfQ1PKq0rHHNwmI1TXT9DY0Dnc+TjSE5D70lbEL3mAxUJvK
 N4yYlWTPtHkrRnNCgBtJCNUdHkpNsFwSURXIWVooiWLjww/FUjlmTgGqnebCGljNJd7r8S
 Tua2zppEJeagQMC/rz5iyDgQvcR7jSc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-ObZBpQflOum2lkOi3xmVtw-1; Thu, 12 Mar 2020 04:22:40 -0400
X-MC-Unique: ObZBpQflOum2lkOi3xmVtw-1
Received: by mail-qk1-f199.google.com with SMTP id e13so3301058qkm.23
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 01:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=y07wKixD9bXDYzgLRAj/SblRz1JIbf7etI9MTIvBiK8=;
 b=brHDruYjxzXQ7lSHWToF4kIdI4R+ppB1pSlYKTNhSnqiJIg0eiLN4bpoP4GpdrHZkg
 Y22n6/40NlfqX3Oc7xb/GlIYHwlrA/iALck0FJ61vqNqb9u+nWPH0s85BuXhjh6l103p
 GyzEdxxHGy/17dwXKXSp1dGNORI+l42cdSzUBvDwiHhq1eptj1Xo5/dCRftvYc8hD4LQ
 JH4ji8kBjmRWGmlgjk3Q+Ob5HwqRb6ClL6z4f0jrUsrgY/25bELWDfzKTVLYwl/oj7Im
 xjs5KF384hGJ2PLDyh0ssJGiut/qGAE+mHlcOABe3OmJGJqmTV8E+NB4AUhGb5HTe12C
 xEjQ==
X-Gm-Message-State: ANhLgQ0pL1ecc1ByT+sLSZegky4efk73nXTtfvH3QdfLUEQjMiXrZnjP
 lCdmpyzG3a7p2fLp3D0D/jzCiazyUk6x4jSatO3j4A+oS4SW7QGBZGcZgw9v8gx7XGmq40ecQIV
 n/nUW7etsbYO+4z4=
X-Received: by 2002:ac8:7693:: with SMTP id g19mr6271291qtr.25.1584001359831; 
 Thu, 12 Mar 2020 01:22:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv1ZPS36m29U5sAyFN73kv9bIRR6S2DU5CKXR3ZAoUY4660GGLJ4VIiYpmUF7RvCaT4jgRMdQ==
X-Received: by 2002:ac8:7693:: with SMTP id g19mr6271280qtr.25.1584001359570; 
 Thu, 12 Mar 2020 01:22:39 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id m27sm2900117qtf.80.2020.03.12.01.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 01:22:38 -0700 (PDT)
Date: Thu, 12 Mar 2020 04:22:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v3 5/6] virtio-net: add migration support for RSS and
 hast report
Message-ID: <20200312041915-mutt-send-email-mst@kernel.org>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-6-yuri.benditovich@daynix.com>
 <20200311094706-mutt-send-email-mst@kernel.org>
 <CAOEp5OdjP4XsSkyCU0n1YGvyWwayOH5D6iTP-8RRLYfwSJd=7Q@mail.gmail.com>
 <20200311161924-mutt-send-email-mst@kernel.org>
 <CAOEp5Oe8iwSgSGoPuBWJh_6FvSHMTnhJSLAMCt=vM9azmQfp0g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Oe8iwSgSGoPuBWJh_6FvSHMTnhJSLAMCt=vM9azmQfp0g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 09:37:06AM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Wed, Mar 11, 2020 at 10:21 PM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>=20
>     On Wed, Mar 11, 2020 at 04:00:44PM +0200, Yuri Benditovich wrote:
>     >
>     >
>     > On Wed, Mar 11, 2020 at 3:48 PM Michael S. Tsirkin <mst@redhat.com>
>     wrote:
>     >
>     >=A0 =A0 =A0On Wed, Mar 11, 2020 at 02:35:17PM +0200, Yuri Benditovic=
h wrote:
>     >=A0 =A0 =A0> Save and restore RSS/hash report configuration.
>     >=A0 =A0 =A0>
>     >=A0 =A0 =A0> Signed-off-by: Yuri Benditovich <yuri.benditovich@dayni=
x.com>
>     >=A0 =A0 =A0> ---
>     >=A0 =A0 =A0>=A0 hw/net/virtio-net.c | 9 +++++++++
>     >=A0 =A0 =A0>=A0 1 file changed, 9 insertions(+)
>     >=A0 =A0 =A0>
>     >=A0 =A0 =A0> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>     >=A0 =A0 =A0> index 7b6a929e8c..c8d97d45cd 100644
>     >=A0 =A0 =A0> --- a/hw/net/virtio-net.c
>     >=A0 =A0 =A0> +++ b/hw/net/virtio-net.c
>     >=A0 =A0 =A0> @@ -2869,6 +2869,13 @@ static int virtio_net_post_load_=
device(void
>     >=A0 =A0 =A0*opaque, int version_id)
>     >=A0 =A0 =A0>=A0 =A0 =A0 =A0 =A0 }
>     >=A0 =A0 =A0>=A0 =A0 =A0 }
>     >=A0 =A0 =A0>=A0
>     >=A0 =A0 =A0> +=A0 =A0 if (n->rss_data.enabled) {
>     >=A0 =A0 =A0> +=A0 =A0 =A0 =A0 trace_virtio_net_rss_enable(n->rss_dat=
a.hash_types,
>     >=A0 =A0 =A0> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 n->rss_data.indirections_len,
>     >=A0 =A0 =A0> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 sizeof(n->rss_data.key));
>     >=A0 =A0 =A0> +=A0 =A0 } else {
>     >=A0 =A0 =A0> +=A0 =A0 =A0 =A0 trace_virtio_net_rss_disable();
>     >=A0 =A0 =A0> +=A0 =A0 }
>     >=A0 =A0 =A0>=A0 =A0 =A0 return 0;
>     >=A0 =A0 =A0>=A0 }
>     >=A0 =A0 =A0>=A0
>     >=A0 =A0 =A0> @@ -3094,6 +3101,8 @@ static const VMStateDescription
>     >=A0 =A0 =A0vmstate_virtio_net_device =3D {
>     >=A0 =A0 =A0>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0v=
mstate_virtio_net_tx_waiting),
>     >=A0 =A0 =A0>=A0 =A0 =A0 =A0 =A0 VMSTATE_UINT64_TEST(curr_guest_offlo=
ads, VirtIONet,
>     >=A0 =A0 =A0>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 has_ctrl_guest_offloads),
>     >=A0 =A0 =A0> +=A0 =A0 =A0 =A0 VMSTATE_UINT8_ARRAY(rss_data_migration=
, VirtIONet,
>     >=A0 =A0 =A0> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sizeof(VirtioNetRssData)),
>     >=A0 =A0 =A0>=A0 =A0 =A0 =A0 =A0 VMSTATE_END_OF_LIST()
>     >=A0 =A0 =A0>=A0 =A0 =A0},
>     >
>     >
>     >=A0 =A0 =A0I think we should migrate the length too. Avoid arbitrary=
 limits.
>     >
>     >
>     > The length of what?
>=20
>     Of the tables.
>     > The structure is fixed-length and the intention=A0is just to
>     > keep/restore it.
>     > The length of indirection table and the table itself are part of th=
e
>     structure.
>=20
>=20
>     And that's a problem, because
>     1. we are wasting memory for a rarely used feature
>     2. if we want to make the table bigger, we'll need to break
>     =A0 =A0migration compatibility
>=20
>     Just allocate these dynamically as needed, and migrate length.
>=20
>=20
> Unfortunately, this does not make things much better.
> The maximum table size is 128, i.e we have persistent=A0allocation of 256=
 bytes.
> 1. Addition of the code to make the allocation dynamic and migrate it wil=
l eat
> most of this.

But that's shared between all VMs. Table is per VM.

> 2. If we decide to change the maximum size if future, we anyway create
> incompatibility. The driver asks what is maximum indirection table size a=
t the
> initialization time and the OS provides a table according to this. If we
> migrate between two different implementations we find ourselves with queu=
e mask
> that is not compatible with maximum size. I'd rather add the comment "do =
not
> change these numbers".
> 3. Size of key for Toeplitz is always 40
>=20
> Please confirm you want to make it dynamic anyway
>=20

Let's just make the code future-proof for when we want to change it.

>=20
> =A0
>=20
>=20
>=20
>     >
>     >=A0 =A0 =A0Yes this means we should allocate the indirection arrays =
on the fly.
>     >=A0 =A0 =A0But that's probably a good idea anyway.
>     >
>     >=A0 =A0 =A0>=A0 };
>     >=A0 =A0 =A0> --
>     >=A0 =A0 =A0> 2.17.1
>     >
>     >
>=20
>=20


