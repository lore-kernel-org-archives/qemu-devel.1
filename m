Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C9C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E769D20787
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TP31zOQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E769D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzOf-00071o-5G
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jEzO2-0006Ur-LB
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jEzO1-0000Vk-8L
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:55:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32501)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jEzO1-0000VV-4R
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584640516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWSWhsHG3YUMGV9JFIRsTvKBx/vD3Wu2M8aCGkfxqq4=;
 b=TP31zOQsEIuloz+fXSxDniy/GSny7TMmz6uMUeobOTbVz8nARahqcvmDa0ZqLFeJO/Rfgf
 DbcUQYAp3adV30SBSMFQJO3Sq2B17YiizFYuPjzwC1myVVTWFxy8lva7aJntual3qVln4J
 NbC3vVlihkcTABjtPzJv8Jv/H+R57Wk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-hgcueJC8OpKJPZyXNXTNiQ-1; Thu, 19 Mar 2020 13:55:14 -0400
X-MC-Unique: hgcueJC8OpKJPZyXNXTNiQ-1
Received: by mail-wr1-f71.google.com with SMTP id f13so1367754wro.23
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eoCdSB784DHRXNfDYh1NHSXjJqpz2QSKgrypjgfnz+g=;
 b=V9jKsKrlFkpIamjK4uBx1MYhMGYwHzM90wOncgzWQ0vu2lIoy/vJxoq2awmaydMr4e
 tXhSzwEb9PM2JPrkPSsl4w0G0qsvXNT1h42SAJmi84O4fOCHiEizY1NyS+DjfOxj348U
 MGjpRm0LRwENMdteQn1BvmQot5n8SuyW8yi0AsbTGVs5hk87RUyyZXlJ1vJ9k+uf9ln9
 lPHSv+dT3hLtKYTiwQq3wg1uCd3ydjnKSNP660JtJ/ndfLhKbExUu7A8fBulQk1n9UEL
 h4RA2uNP6bqKelB+Xdmi71J0VRy//TY6LOCMlh33J35uZqga3o+ktbqCKEpcNoGKupN5
 PHUQ==
X-Gm-Message-State: ANhLgQ3KNOdWCD/c1A73JgigtsNqvODKH777CwXGooxjDpXn78dbaWJf
 +oMfPUQ7h+cB2+cIXYIrn8fIOJYZE5XqgkjyN538SlRCpGTJfHwnB8s4Lrc68P46GrUoJZYWw07
 4y9NXY/0qL5CgYoU=
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr1084134wrw.15.1584640513767; 
 Thu, 19 Mar 2020 10:55:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuUV6V4EEvYc2LFB5eTe6pcd2Eo6N6c+cPb+LRU9VKN5TncRfOVmQN6ixIrzrb99Lj2iqlpKw==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr1084108wrw.15.1584640513525; 
 Thu, 19 Mar 2020 10:55:13 -0700 (PDT)
Received: from redhat.com (bzq-109-66-39-109.red.bezeqint.net. [109.66.39.109])
 by smtp.gmail.com with ESMTPSA id b82sm3972853wmb.46.2020.03.19.10.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 10:55:12 -0700 (PDT)
Date: Thu, 19 Mar 2020 13:55:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v5 6/7] vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC
 macro
Message-ID: <20200319135428-mutt-send-email-mst@kernel.org>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-7-yuri.benditovich@daynix.com>
 <20200318054039-mutt-send-email-mst@kernel.org>
 <CAOEp5Od6TNqbR0tTomGJoJudoA1Qx4-RAA1MniSFEw+FUbjAGA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Od6TNqbR0tTomGJoJudoA1Qx4-RAA1MniSFEw+FUbjAGA@mail.gmail.com>
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

On Thu, Mar 19, 2020 at 07:12:20PM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Wed, Mar 18, 2020 at 11:42 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>=20
>     On Wed, Mar 18, 2020 at 11:15:24AM +0200, Yuri Benditovich wrote:
>     > Similar to VMSTATE_VARRAY_UINT32_ALLOC, but the size is
>     > 16-bit field.
>     >
>     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>=20
>     Hmm this is exactly my patch isn't it? If yes pls fix up attribution
>     (if this is not reposted, then when applying):
>=20
>=20
> Of course, it is similar to the one you wrote inline.
> Unlike one you wrote inline this patch does not fail on checkpatch.

If you feel you modified it significantly enough, you can write
"based on a patch by mst".

> But the idea is the same, hard to invent something.
> Please just let me know what exactly should I do: resubmit or not and whe=
ther
> it is possible to fix it without resubmission.
> =A0
>=20
>=20
>     From: Michael S. Tsirkin <mst@redhat.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
>=20
>     > ---
>     >=A0 include/migration/vmstate.h | 10 ++++++++++
>     >=A0 1 file changed, 10 insertions(+)
>     >
>     > diff --git a/include/migration/vmstate.h b/include/migration/vmstat=
e.h
>     > index 30667631bc..baaefb6b9b 100644
>     > --- a/include/migration/vmstate.h
>     > +++ b/include/migration/vmstate.h
>     > @@ -432,6 +432,16 @@ extern const VMStateInfo vmstate_info_qlist;
>     >=A0 =A0 =A0 .offset=A0 =A0 =A0=3D vmstate_offset_pointer(_state, _fi=
eld, _type),=A0 =A0 =A0\
>     >=A0 }
>     >=A0
>     > +#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num,
>     _version, _info, _type) {\
>     > +=A0 =A0 .name=A0 =A0 =A0 =A0=3D (stringify(_field)),=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>     > +=A0 =A0 .version_id =3D (_version),=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>     > +=A0 =A0 .num_offset =3D vmstate_offset_value(_state, _field_num, u=
int16_t),\
>     > +=A0 =A0 .info=A0 =A0 =A0 =A0=3D &(_info),=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>     > +=A0 =A0 .size=A0 =A0 =A0 =A0=3D sizeof(_type),=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>     > +=A0 =A0 .flags=A0 =A0 =A0 =3D VMS_VARRAY_UINT16 | VMS_POINTER | VM=
S_ALLOC,=A0 =A0 =A0 =A0\
>     > +=A0 =A0 .offset=A0 =A0 =A0=3D vmstate_offset_pointer(_state, _fiel=
d, _type),=A0 =A0 =A0\
>     > +}
>     > +
>     >=A0 #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num,
>     _version, _info, _type) {\
>     >=A0 =A0 =A0 .name=A0 =A0 =A0 =A0=3D (stringify(_field)),=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>     >=A0 =A0 =A0 .version_id =3D (_version),=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>     > --
>     > 2.17.1
>=20
>=20


