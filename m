Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A7C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D402076A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCjewxik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D402076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHShZ-0005nU-Pk
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHSfa-0002VD-ES
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHSfZ-0008Ci-BC
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:35:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHSfZ-0008CO-6m
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWbqAjjEORmNRjveRi8aSNJU015o76XsqG11DIvUqsY=;
 b=eCjewxikLwYlrRSbiO/ehclg3H5c7N2wCZiysN+Ae3L43OGWZQAiNb+TZ8Fr1Gu2/I5Agt
 x8JNyglXxmuMiMomxkr7R4RV1p2ui/j+8+lUp6nNiyDllSsRNqmZNrJQwmNfs03l4e0KA9
 LWGExbkudNBNGNYA2JFMIxHunrQhcQI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-f1a09t40PXGgROs1I8lExg-1; Thu, 26 Mar 2020 09:35:33 -0400
X-MC-Unique: f1a09t40PXGgROs1I8lExg-1
Received: by mail-wm1-f70.google.com with SMTP id m4so2459622wmi.5
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 06:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oe5Sj9BOMqMHBwakfMzaHFgjRHOo6TbkLkxQohWf+J0=;
 b=QJvXOwBnoim/R3NEPY2tjrLVndTixy2a8F5wopxun0tleKOAPE2+cFg8ynjjHUKfWZ
 X2+iPBGSvQk9UUM88XGOIrW1M8VHRA0fINx5iq9Ek28yHarxvcXHI+RtME/cGb5tjIer
 H15C/+5YiB8EATTf/Z49qBP7kmKTxFiS/wCL4C5yXYJ2qBjY6nH//1zYig7voK8isvLl
 5T1XTfUJGz170vrKiX0KlIiyTsSWnNbY+lBD0V/9mFJqlzBqlDEL1iYMsSqEzqqaCu6y
 QxkxKgK2QdiIY8wBmdiwUNPm92uKwyl8RR0Q/g8+uOuc6qK3/hkBY7q1SWVSPGpSQwNO
 DCWA==
X-Gm-Message-State: ANhLgQ0b4U2k4TGvNQC+P7Shf7A+ODWZVrsoGvikVyb17Y5UN1TwxpWV
 Pg5Z5/F5gQGS6CzR+oABS4HMv4HsVkWu3w1/Hlzqq5xooweIY+WwkrAr5QlWsBQePqT13VRY3q/
 wZ4j8YzuUj/R/ajs=
X-Received: by 2002:a7b:c050:: with SMTP id u16mr26923wmc.68.1585229731963;
 Thu, 26 Mar 2020 06:35:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsPv8aG1cKuA3PGgdPx2bc5XgKCByfANdnDEBVZcj2+K8sqXLcXhcpI/7Rr3+AWO2nVwsySSA==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr26903wmc.68.1585229731715;
 Thu, 26 Mar 2020 06:35:31 -0700 (PDT)
Received: from redhat.com (bzq-109-67-62-195.red.bezeqint.net. [109.67.62.195])
 by smtp.gmail.com with ESMTPSA id i1sm3584158wrq.89.2020.03.26.06.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 06:35:31 -0700 (PDT)
Date: Thu, 26 Mar 2020 09:35:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v6 7/7] virtio-net: add migration support for RSS and
 hash report
Message-ID: <20200326093451-mutt-send-email-mst@kernel.org>
References: <20200320115751.19446-1-yuri.benditovich@daynix.com>
 <20200320115751.19446-8-yuri.benditovich@daynix.com>
 <CAOEp5OcZXEXx0gXZTUOvEbH8dteu5S9fzCFJiTGVZkJGyGrv0A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OcZXEXx0gXZTUOvEbH8dteu5S9fzCFJiTGVZkJGyGrv0A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code looks OK but patchew testing shows failures. If they are false positiv=
es
pls reply to that mail.

On Thu, Mar 26, 2020 at 02:34:39PM +0200, Yuri Benditovich wrote:
> ping
>=20
> On Fri, Mar 20, 2020 at 1:58 PM Yuri Benditovich <yuri.benditovich@daynix=
.com>
> wrote:
>=20
>     Save and restore RSS/hash report configuration.
>=20
>     Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     ---
>     =A0hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++
>     =A01 file changed, 37 insertions(+)
>=20
>     diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>     index a0614ad4e6..7de7587abd 100644
>     --- a/hw/net/virtio-net.c
>     +++ b/hw/net/virtio-net.c
>     @@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void *o=
paque,
>     int version_id)
>     =A0 =A0 =A0 =A0 =A0}
>     =A0 =A0 =A0}
>=20
>     +=A0 =A0 if (n->rss_data.enabled) {
>     +=A0 =A0 =A0 =A0 trace_virtio_net_rss_enable(n->rss_data.hash_types,
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 n->rss_data.indirections_len,
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sizeof(n->rss_data.key));
>     +=A0 =A0 } else {
>     +=A0 =A0 =A0 =A0 trace_virtio_net_rss_disable();
>     +=A0 =A0 }
>     =A0 =A0 =A0return 0;
>     =A0}
>=20
>     @@ -3019,6 +3026,32 @@ static const VMStateDescription
>     vmstate_virtio_net_has_vnet =3D {
>     =A0 =A0 =A0},
>     =A0};
>=20
>     +static bool virtio_net_rss_needed(void *opaque)
>     +{
>     +=A0 =A0 return VIRTIO_NET(opaque)->rss_data.enabled;
>     +}
>     +
>     +static const VMStateDescription vmstate_virtio_net_rss =3D {
>     +=A0 =A0 .name=A0 =A0 =A0 =3D "virtio-net-device/rss",
>     +=A0 =A0 .version_id =3D 1,
>     +=A0 =A0 .minimum_version_id =3D 1,
>     +=A0 =A0 .needed =3D virtio_net_rss_needed,
>     +=A0 =A0 .fields =3D (VMStateField[]) {
>     +=A0 =A0 =A0 =A0 VMSTATE_BOOL(rss_data.enabled, VirtIONet),
>     +=A0 =A0 =A0 =A0 VMSTATE_BOOL(rss_data.redirect, VirtIONet),
>     +=A0 =A0 =A0 =A0 VMSTATE_BOOL(rss_data.populate_hash, VirtIONet),
>     +=A0 =A0 =A0 =A0 VMSTATE_UINT32(rss_data.hash_types, VirtIONet),
>     +=A0 =A0 =A0 =A0 VMSTATE_UINT16(rss_data.indirections_len, VirtIONet)=
,
>     +=A0 =A0 =A0 =A0 VMSTATE_UINT16(rss_data.default_queue, VirtIONet),
>     +=A0 =A0 =A0 =A0 VMSTATE_UINT8_ARRAY(rss_data.key, VirtIONet,
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 VIRTIO_NET_R=
SS_MAX_KEY_SIZE),
>     +=A0 =A0 =A0 =A0 VMSTATE_VARRAY_UINT16_ALLOC(rss_data.indirections_ta=
ble,
>     VirtIONet,
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 rss_data.indirections_len, 0,
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 vmstate_info_uint16, uint16_t),
>     +=A0 =A0 =A0 =A0 VMSTATE_END_OF_LIST()
>     +=A0 =A0 },
>     +};
>     +
>     =A0static const VMStateDescription vmstate_virtio_net_device =3D {
>     =A0 =A0 =A0.name =3D "virtio-net-device",
>     =A0 =A0 =A0.version_id =3D VIRTIO_NET_VM_VERSION,
>     @@ -3069,6 +3102,10 @@ static const VMStateDescription
>     vmstate_virtio_net_device =3D {
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0has_ctrl_g=
uest_offloads),
>     =A0 =A0 =A0 =A0 =A0VMSTATE_END_OF_LIST()
>     =A0 =A0 },
>     +=A0 =A0 .subsections =3D (const VMStateDescription * []) {
>     +=A0 =A0 =A0 =A0 &vmstate_virtio_net_rss,
>     +=A0 =A0 =A0 =A0 NULL
>     +=A0 =A0 }
>     =A0};
>=20
>     =A0static NetClientInfo net_virtio_info =3D {
>     --
>     2.17.1
>=20
>=20


