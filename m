Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83937C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4968820674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsOIlRfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4968820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE5nV-0000gw-GV
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 02:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jE5mq-0000FA-1n
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jE5mo-0006PK-MD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:33:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jE5mo-0006DH-Gb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584426789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=No9S8Chm9dag70qOTYhkvSHBF8KWYOtAcTvU9DxwQtE=;
 b=OsOIlRfp1biCzLPCugwDT77U+/EiwkQDDfHZAe0/sr6E0onPx+omwkcsPkbHButpGJgjgN
 nDLzcj63j63he/JH4KD2YyR6t6gwVb72vQeEFniTb04xhuZIf6bz+dCDMMz9KA8oprFMKn
 ezj6BiigylaYtdOD/CB1OeFYCHlu/dc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-62vkHwtCOEeZbEnQr-XnQA-1; Tue, 17 Mar 2020 02:33:08 -0400
X-MC-Unique: 62vkHwtCOEeZbEnQr-XnQA-1
Received: by mail-wr1-f72.google.com with SMTP id h17so531950wru.16
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 23:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/+mWcJpINiuhC771xyw2g6nT2zYqyXzXgSvVXKr4Gcg=;
 b=YuY+9UyXHU8cewb/9NbvBmlZqg/IEB7Av8jyBAj/iTViINY368Ot7NtIDwl/GbnL+/
 0/Zjsvr+82EpMVY8ULfOhzwKxX5CF2XRV0ZAOnWoAU6EufvXJnWoePvnfdkZaJhbMM3I
 a6YQe5P859prR23DfYbfS8t0AMjDd9ZBcDGhz+RVRzE6bOW0uMMy50fZuZDuSCFHuozp
 gSvgGBJ8k+MbnR9inAImu+XMsP0v9BSbP+hyjK/ihNWR9PXZ9YQMyoU3DZTj0ZJHpqny
 gz58HKpZ88TfHTsNxX9LC23EEqWKBDdZemOAs2qMRsCjMbIyLAMJU+H+b/ojs1/fcVzu
 ESzw==
X-Gm-Message-State: ANhLgQ0Mo1C+DNfg/TPqvuy4neb7xZa5Fs1k7BlUKY0I7ycmHlqaYhXb
 H2oNUQa1TWsKUzVkPTFn+pCI0jiG/WlqqzMlQhDsy3JekFYG9Evn6giC1rtOUXTLiG0sCFN+t8m
 zwG0QBs9fd2fPFLA=
X-Received: by 2002:adf:9dc3:: with SMTP id q3mr3880174wre.261.1584426786762; 
 Mon, 16 Mar 2020 23:33:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvcixY1fVJxfAIo5If9tax0CZFzpyEO5z8am9IWtGFIc3StOOC1X3qE9s7+jeaZaJLEfX2V3w==
X-Received: by 2002:adf:9dc3:: with SMTP id q3mr3880129wre.261.1584426786459; 
 Mon, 16 Mar 2020 23:33:06 -0700 (PDT)
Received: from redhat.com (bzq-109-67-31-208.red.bezeqint.net. [109.67.31.208])
 by smtp.gmail.com with ESMTPSA id b82sm2552827wmb.46.2020.03.16.23.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 23:33:05 -0700 (PDT)
Date: Tue, 17 Mar 2020 02:33:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v4 6/6] virtio-net: add migration support for RSS and
 hash report
Message-ID: <20200317023032-mutt-send-email-mst@kernel.org>
References: <20200316100933.11499-1-yuri.benditovich@daynix.com>
 <20200316100933.11499-7-yuri.benditovich@daynix.com>
 <20200316190407-mutt-send-email-mst@kernel.org>
 <CAOEp5OfLAU1oyj=75K6CFPSH_YXz+mZsbSLRZ=LEMRcTvUdetA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OfLAU1oyj=75K6CFPSH_YXz+mZsbSLRZ=LEMRcTvUdetA@mail.gmail.com>
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 07:48:55AM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Tue, Mar 17, 2020 at 1:05 AM Michael S. Tsirkin <mst@redhat.com> wrote=
:
>=20
>     On Mon, Mar 16, 2020 at 12:09:33PM +0200, Yuri Benditovich wrote:
>     > Save and restore RSS/hash report configuration.
>     >
>     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     > ---
>     >=A0 hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
>     >=A0 1 file changed, 26 insertions(+)
>     >
>     > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>     > index a0614ad4e6..f343762a0f 100644
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
>     > +=A0 =A0 .fields =3D (VMStateField[]) {
>     > +=A0 =A0 =A0 =A0 VMSTATE_BOOL(enabled, VirtioNetRssData),
>     > +=A0 =A0 =A0 =A0 VMSTATE_BOOL(redirect, VirtioNetRssData),
>     > +=A0 =A0 =A0 =A0 VMSTATE_BOOL(populate_hash, VirtioNetRssData),
>     > +=A0 =A0 =A0 =A0 VMSTATE_UINT32(hash_types, VirtioNetRssData),
>     > +=A0 =A0 =A0 =A0 VMSTATE_UINT32(indirections_len, VirtioNetRssData)=
,
>=20
>=20
>     Why is this UINT32? Shouldn't it be UINT16?
>=20
>=20
> It is UINT32 in the _internal_ structure to use VMSTATE_VARRAY_UINT32_ALL=
OC.
> Otherwise I need to invent additional macro for the same operation with U=
INT16
> length.
> =A0

It's not internal - it's exposed as part of the migration stream format.
Adding VMSTATE_VARRAY_UINT16_ALLOC is as easy as:

-->

vmstate: add VMSTATE_VARRAY_UINT16_ALLOC

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

--

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 30667631bc..b0b89c6fe5 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -432,6 +432,16 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
 }
=20
+#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version, =
_info, _type) {\
+    .name       =3D (stringify(_field)),                               \
+    .version_id =3D (_version),                                        \
+    .num_offset =3D vmstate_offset_value(_state, _field_num, uint16_t),\
+    .info       =3D &(_info),                                          \
+    .size       =3D sizeof(_type),                                     \
+    .flags      =3D VMS_VARRAY_UINT16|VMS_POINTER|VMS_ALLOC,           \
+    .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
+}
+
 #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num, _version,=
 _info, _type) {\
     .name       =3D (stringify(_field)),                               \
     .version_id =3D (_version),                                        \


