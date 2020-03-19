Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F66AC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6914B20836
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDLk/txH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6914B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEyuE-0001kt-Ke
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jEytb-0001M4-Nx
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jEytZ-0006ep-Ce
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:23:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41711)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jEytZ-0006eI-4R
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584638628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hujIgjl5k2ahPadE6Be+4RwWo7WflkKU+ukT2FuozqA=;
 b=jDLk/txHugD4LTJ8mSPN0HEinXutgj//udxulRtPto+8oJTW9Ov65IzoLAOePGmiisuaO+
 lItcW7LDO3bz94tRrl8hheDDERuG4Fturdy5z8inhHAYIahLurQbdzAboZZvXANVP1+vEJ
 uB4jRUAUAkLDanKdcZNHD0Gg+H5BARQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-_nxNgmUMN6arTzsKbxeoGA-1; Thu, 19 Mar 2020 13:23:46 -0400
X-MC-Unique: _nxNgmUMN6arTzsKbxeoGA-1
Received: by mail-wr1-f70.google.com with SMTP id q18so1344633wrw.5
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9dIVQRdx/yeocKG2+s0Ni8SU+lcTYTKeAojt7RvOWoI=;
 b=ge8o6yNe2g9jAs12jGP+5ChstWbEGsKXiPqNGfP1MQeXwIPGGujfnnJEi5n5wShgGY
 LTTwU7ZRTC5CqCxY/Fs5nsc+BBDSIbCFlzdFzfnPOd7U5JnQaavtuOXgcrF6Xyh/Wu/j
 5GLb2ue8yHZAllr0bhAbAfTi7zUPcGXOTrby0J2ehBnNQKreZ6UrC3o9pTP8K7zxluxQ
 hbFdL8PVeKCaKud6d3sLDaV1nApIlJrJtYbKM4/fv0yWb/pTWojMXAD6tnkq3m+n2e+M
 A7nv5Megh3W+zzxXn2tC5jM23WhOghW/sWPmJIjhNW4WHx5dYWa6+Rx+Y0WvuFUHPGFk
 1UXA==
X-Gm-Message-State: ANhLgQ0qufd09UF9DDjTO/a545fO4hpucvdjbjZAP93JUo+v4pV47Fk1
 xD/4WLjb++FsiZKduwohuq1GfA/GTr2F2HNLl40uoy/3vM5nzBoBREL3lMXF2IUJQBnv6yf/+l6
 jyRJuLwaBpAj2GRI=
X-Received: by 2002:a5d:56c5:: with SMTP id m5mr5461476wrw.35.1584638624977;
 Thu, 19 Mar 2020 10:23:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsyF3CV0SqwbxcfjOR6owE2rDhTrtqHjq40yvOVNzfQzX0hnZWeqJkS957smLXofnzdeuVFTQ==
X-Received: by 2002:a5d:56c5:: with SMTP id m5mr5461453wrw.35.1584638624765;
 Thu, 19 Mar 2020 10:23:44 -0700 (PDT)
Received: from redhat.com (bzq-109-66-39-109.red.bezeqint.net. [109.66.39.109])
 by smtp.gmail.com with ESMTPSA id h13sm4400630wrv.39.2020.03.19.10.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 10:23:44 -0700 (PDT)
Date: Thu, 19 Mar 2020 13:23:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v5 7/7] virtio-net: add migration support for RSS and
 hash report
Message-ID: <20200319132300-mutt-send-email-mst@kernel.org>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-8-yuri.benditovich@daynix.com>
 <20200318104826.GF2850@work-vm>
 <CAOEp5Odhjr6h7erYz_VchjRF98-SNt27RW_T_ao7P0nwc-0ebg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Odhjr6h7erYz_VchjRF98-SNt27RW_T_ao7P0nwc-0ebg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 07:19:26PM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Wed, Mar 18, 2020 at 12:48 PM Dr. David Alan Gilbert <dgilbert@redhat.=
com>
> wrote:
>=20
>     * Yuri Benditovich (yuri.benditovich@daynix.com) wrote:
>     > Save and restore RSS/hash report configuration.
>     >
>     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     > ---
>     >=A0 hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
>     >=A0 1 file changed, 26 insertions(+)
>     >
>     > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>     > index a0614ad4e6..0b058aae9f 100644
>     > --- a/hw/net/virtio-net.c
>     > +++ b/hw/net/virtio-net.c
>     > @@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void
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
>     > @@ -3019,6 +3026,24 @@ static const VMStateDescription
>     vmstate_virtio_net_has_vnet =3D {
>     >=A0 =A0 =A0 },
>     >=A0 };
>     >=A0
>     > +static const VMStateDescription vmstate_rss =3D {
>     > +=A0 =A0 .name=A0 =A0 =A0 =3D "vmstate_rss",
>=20
>     You need to do something to avoid breaking migration compatibility
>     from/to old QEMU's and from/to QEMU's on hosts without the new virtio
>     features.
>     Probably adding a .needed =3D=A0 =A0here pointing to a function that
>     checks 'enabled' might do it.
>=20
>=20
> Does VMSTATE_STRUCT_TEST(..,..,checker_procedure,...) result the same thi=
ng?
>=20
> Another question about migration support:
> What is expected/required behavior?
> Possible cases:
> old qemu -> new qemu
> new qemu (new feature off) -> old qemu

works

> new qemu (new feature on) -> old qemu
>

fails gracefully

>=20
>     Dave
>=20
>=20
>     > +=A0 =A0 .fields =3D (VMStateField[]) {
>     > +=A0 =A0 =A0 =A0 VMSTATE_BOOL(enabled, VirtioNetRssData),
>     > +=A0 =A0 =A0 =A0 VMSTATE_BOOL(redirect, VirtioNetRssData),
>     > +=A0 =A0 =A0 =A0 VMSTATE_BOOL(populate_hash, VirtioNetRssData),
>     > +=A0 =A0 =A0 =A0 VMSTATE_UINT32(hash_types, VirtioNetRssData),
>     > +=A0 =A0 =A0 =A0 VMSTATE_UINT16(indirections_len, VirtioNetRssData)=
,
>     > +=A0 =A0 =A0 =A0 VMSTATE_UINT16(default_queue, VirtioNetRssData),
>     > +=A0 =A0 =A0 =A0 VMSTATE_UINT8_ARRAY(key, VirtioNetRssData,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 VIRTIO_NET=
_RSS_MAX_KEY_SIZE),
>     > +=A0 =A0 =A0 =A0 VMSTATE_VARRAY_UINT16_ALLOC(indirections_table,
>     VirtioNetRssData,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 indirections_len, 0,
>     > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 vmstate_info_uint16, uint16_t),
>     > +=A0 =A0 =A0 =A0 VMSTATE_END_OF_LIST()
>     > +=A0 =A0 },
>     > +};
>     > +
>     >=A0 static const VMStateDescription vmstate_virtio_net_device =3D {
>     >=A0 =A0 =A0 .name =3D "virtio-net-device",
>     >=A0 =A0 =A0 .version_id =3D VIRTIO_NET_VM_VERSION,
>     > @@ -3067,6 +3092,7 @@ static const VMStateDescription
>     vmstate_virtio_net_device =3D {
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vmstate_virti=
o_net_tx_waiting),
>     >=A0 =A0 =A0 =A0 =A0 VMSTATE_UINT64_TEST(curr_guest_offloads, VirtION=
et,
>     >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 has_ctrl=
_guest_offloads),
>     > +=A0 =A0 =A0 =A0 VMSTATE_STRUCT(rss_data, VirtIONet, 1, vmstate_rss=
,
>     VirtioNetRssData),
>     >=A0 =A0 =A0 =A0 =A0 VMSTATE_END_OF_LIST()
>     >=A0 =A0 =A0},
>     >=A0 };
>     > --
>     > 2.17.1
>     >
>     --
>     Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20


