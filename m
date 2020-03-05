Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A27C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EAA82073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ir6GQ3tB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAA82073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9qsa-00063p-Tb
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 08:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j9qrk-0005Dr-H2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j9qrj-0007NI-HC
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:48:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49849
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j9qrj-0007Kb-Cw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583416123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+VnPHXCdM1ruYsfahkKpY3F2lvog7w+FsvLfaWX0XU=;
 b=Ir6GQ3tBAnHZ3Ts/+7Az3LwsN9Ro1nbf6nAapRIP2wUlYk/8YdiSE6ZpZbIj5Ywbo2MSfa
 5LsgNsp5NHDZetIynFDE9K89tsVuI7LX/arj8eASrYAD0J+fGYJvQu8XEdvtNj7uiN6zhi
 KwfTD5y8a2t7iAIukNBRad9StFzyn5w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-Tm_vVgwuNIGj8Y7_rEyU0Q-1; Thu, 05 Mar 2020 08:48:41 -0500
X-MC-Unique: Tm_vVgwuNIGj8Y7_rEyU0Q-1
Received: by mail-wr1-f70.google.com with SMTP id o9so2330401wrw.14
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 05:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gsyUyUPltOyaG0CmvFZxAKR3eWI6lV29vRJfoKAg7FY=;
 b=U6hqHOY1CkXFYwFN4P7PrxiIvZpCH29KP1PZfDcv/3DzSc85fyzLqt3lvmXGTChKFP
 WMvkFR/o2G99s+LGeH9jDiqLHylVD8s0zLjqDONZnF7n1ZA3YuLILFCnRoYgdSxTW/Ig
 ALBDKbyRLClfiuYIIibZ5xdp7jwiCSAc9RpizIY7/kCp1wQnCt8lKcf7KLPpaHpcVobV
 SZqOt0JlDHqwZbMkf5xWQB5lH4G3+b/W1yfQb9DMh+f4IwVA1XzyEpKgHO86XShSQ+M7
 6LUKwCQu9jrDBAKTr1EnKVtAHVREqSHyHyyaq6bDA/LV2nFnHKp0ezBWHSWBELzMs0ix
 tg2Q==
X-Gm-Message-State: ANhLgQ2dugss+O32AD/JEoYUEJPjsVAwBgBXVrYRmopn0BT2bDJJvIWy
 tPOu6PXqJ1kDIav5dEGGZY6kTaag7QGieuMzmDAYjg1/US3dMWNhRnEbEWun/s24B0KMP+dH/4B
 fkFt9GSqJD+hNgpg=
X-Received: by 2002:a1c:e918:: with SMTP id q24mr9746985wmc.25.1583416120188; 
 Thu, 05 Mar 2020 05:48:40 -0800 (PST)
X-Google-Smtp-Source: ADFU+vunHM2fYLPgoBLdmfHItq7ipps+5rkO04vueG8TBu6BNNdR8Pt2a8eBdF2X2/cHR0yHgWG9NQ==
X-Received: by 2002:a1c:e918:: with SMTP id q24mr9746964wmc.25.1583416119933; 
 Thu, 05 Mar 2020 05:48:39 -0800 (PST)
Received: from steredhat (host34-204-dynamic.43-79-r.retail.telecomitalia.it.
 [79.43.204.34])
 by smtp.gmail.com with ESMTPSA id o8sm8923043wmh.15.2020.03.05.05.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 05:48:39 -0800 (PST)
Date: Thu, 5 Mar 2020 14:48:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/9] hw/audio/fmopl: Move ENV_CURVE to .heap to save
 32KiB of .bss
Message-ID: <20200305134837.ucdb6blcguyfrh6d@steredhat>
References: <20200305124525.14555-1-philmd@redhat.com>
 <20200305124525.14555-3-philmd@redhat.com>
 <20200305134403.sagzdlf5iyk2iufs@steredhat>
MIME-Version: 1.0
In-Reply-To: <20200305134403.sagzdlf5iyk2iufs@steredhat>
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 02:44:03PM +0100, Stefano Garzarella wrote:
> On Thu, Mar 05, 2020 at 01:45:18PM +0100, Philippe Mathieu-Daud=E9 wrote:
> > This buffer is only used by the adlib audio device. Move it to
> > the .heap to release 32KiB of .bss (size reported on x86_64 host).
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >  hw/audio/fmopl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> > index 173a7521f2..356d4dfbca 100644
> > --- a/hw/audio/fmopl.c
> > +++ b/hw/audio/fmopl.c
> > @@ -186,7 +186,7 @@ static int32_t *VIB_TABLE;
> > =20
> >  /* envelope output curve table */
> >  /* attack + decay + OFF */
> > -static int32_t ENV_CURVE[2*EG_ENT+1];
> > +static int32_t *ENV_CURVE;
> > =20
> >  /* multiple table */
> >  #define ML 2
> > @@ -1090,6 +1090,7 @@ FM_OPL *OPLCreate(int clock, int rate)
> >  =09OPL->clock =3D clock;
> >  =09OPL->rate  =3D rate;
> >  =09OPL->max_ch =3D max_ch;
> > +    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);

Should we use g_new0() ?

> >  =09/* init grobal tables */
> >  =09OPL_initialize(OPL);
> >  =09/* reset chip */
> > @@ -1127,6 +1128,7 @@ void OPLDestroy(FM_OPL *OPL)
> >  #endif
> >  =09OPL_UnLockTable();
> >  =09free(OPL);
> > +    g_free(ENV_CURVE);
>=20
> Just for curiosity, here the entire fmopl.c is indented with tabs.
>=20
> In this case, is it better to continue with the tabs or use spaces
> for new changes?
>=20
> Anyway the changes LGTM:
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


