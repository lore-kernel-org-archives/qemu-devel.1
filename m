Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D71C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044F32072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMLkcZFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044F32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAXr-0002jB-5O
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jAAX8-0002AV-RF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jAAX7-00089n-7H
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:48:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jAAX7-00086G-0y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583491723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PvDM6ihZuAaTRGH5fOIJ/fhyCSjNoaXL0TEZo43taJ0=;
 b=JMLkcZFHJ7cSqkPMbbRZzpxJF4L4qBwjAKLCStOPLgchKeu6MMSq/789vHF+N19ugR3Tso
 GH31ZXWL3R1VEVm84QQC2fcXWSDIbtvFGFfMVdJXw5ojNW16TAeH0ol3szbF6IOQ9U2Aqb
 zMrz8TL2GR0CYplie9EX7ajm21g8jTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-JcM9Iv4DNbe2D0IEgRtCrA-1; Fri, 06 Mar 2020 05:48:42 -0500
X-MC-Unique: JcM9Iv4DNbe2D0IEgRtCrA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 089168017CC;
 Fri,  6 Mar 2020 10:48:41 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4777277B6;
 Fri,  6 Mar 2020 10:48:39 +0000 (UTC)
Date: Fri, 6 Mar 2020 11:48:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/arm/cubieboard: make sure SOC object isn't leaked
Message-ID: <20200306114838.27603031@redhat.com>
In-Reply-To: <aef518d0-d8e5-7972-0530-8f8a4c64f1e1@redhat.com>
References: <20200303091254.22373-1-imammedo@redhat.com>
 <aef518d0-d8e5-7972-0530-8f8a4c64f1e1@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, drjones@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020 11:33:07 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 3/3/20 10:12 AM, Igor Mammedov wrote:
> > SOC object returned by object_new() is leaked in current code.
> > Set SOC parent explicitly to board and then unref to SOC object
> > to make sure that refererence returned by object_new() is taken
> > care of.
> >=20
> > The SOC object will be kept alive by its parent (machine) and
> > will be automatically freed when MachineState is destroyed.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reported-by: Andrew Jones <drjones@redhat.com>
> > ---
> >   hw/arm/cubieboard.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> > index 089f9a30c1..12f8ac798d 100644
> > --- a/hw/arm/cubieboard.c
> > +++ b/hw/arm/cubieboard.c
> > @@ -30,9 +30,14 @@ static struct arm_boot_info cubieboard_binfo =3D {
> >  =20
> >   static void cubieboard_init(MachineState *machine)
> >   {
> > -    AwA10State *a10 =3D AW_A10(object_new(TYPE_AW_A10));
> > +    AwA10State *a10;
> >       Error *err =3D NULL;
> >    =20
>=20
> What about using object_new_with_props similarly to commit e4c81e3a451f?
I prefer explicit object_property_add_child() and would use
above only if there are list of properties to feed to it.


>      a10 =3D AW_A10(object_new_with_props(TYPE_AW_A10, OBJECT(s), "soc",
>                                         &err, NULL));
>      if (err !=3D NULL) {
>          error_propagate(errp, err);
>          return;
>      }
>=20
> > +    a10 =3D AW_A10(object_new(TYPE_AW_A10));
> > +    object_property_add_child(OBJECT(machine), "soc", OBJECT(a10),
> > +                              &error_abort);
> > +    object_unref(OBJECT(a10));
> > +
> >       object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
> >       if (err !=3D NULL) {
> >           error_reportf_err(err, "Couldn't set phy address: ");
> >  =20
>=20


