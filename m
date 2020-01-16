Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B795C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C40524694
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4ORlHRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C40524694
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is94T-0007Ae-GE
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is93f-0005ui-AK
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is93b-0000tt-Ty
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:35:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is93b-0000sr-QH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579196146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ta2JcirT5qOqNe0IGzzTJGzlmlo7VzUxFcNUvoTkoGY=;
 b=C4ORlHRE+mBMZLWbNyqcA7VVeTOoee3+6fWVZhbz1dIA0Q2bI7zdHTpk3iwuMFUJ1hOkbK
 6YAjFkXxMh/sFvm4ZMloxhOgbAaFluz5ThuWhyov7UbsGDDUmjAdOKH8yqn1X9mdBU15wf
 ZBwtUAgBAYCsYPsUczO2tGOsJuHxpPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-kFj0gK4GOMaz3NNBMG2zDw-1; Thu, 16 Jan 2020 12:35:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE50B107ACC5;
 Thu, 16 Jan 2020 17:35:41 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E11F5D9C9;
 Thu, 16 Jan 2020 17:35:40 +0000 (UTC)
Date: Thu, 16 Jan 2020 18:35:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 08/86] arm:aspeed: actually check RAM size
Message-ID: <20200116183538.2f84604c@redhat.com>
In-Reply-To: <83481ccb-38e4-d0a2-18b5-66fcd7248521@kaod.org>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-9-git-send-email-imammedo@redhat.com>
 <83481ccb-38e4-d0a2-18b5-66fcd7248521@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: kFj0gK4GOMaz3NNBMG2zDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 09:41:03 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 1/15/20 4:06 PM, Igor Mammedov wrote:
> > It's supposed that SOC will check if "-m" provided
> > RAM size is valid by setting "ram-size" property and
> > then board would read back valid (possibly corrected
> > value) to map RAM MemoryReging with valid size.
> > Well it isn't doing so, since check is called only
> > indirectly from
> >   aspeed_sdmc_reset()->asc->compute_conf()
> > or much later when guest writes to configuration
> > register.
> >=20
> > So depending on "-m" value QEMU end-ups with a warning
> > and an invalid MemoryRegion size allocated and mapped.
> > (examples:
> >  -M ast2500-evb -m 1M
> >     0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-contain=
er
> >       0000000080000000-00000000800fffff (prio 0, ram): ram
> >       0000000080100000-00000000bfffffff (prio 0, i/o): max_ram
> >  -M ast2500-evb -m 3G
> >     0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-contain=
er
> >       0000000080000000-000000013fffffff (prio 0, ram): ram
> >       [DETECTED OVERFLOW!] 0000000140000000-00000000bfffffff (prio 0, i=
/o): max_ram
> > )
> > On top of that sdmc falls back and reports to guest
> > "default" size, it thinks machine should have.>
> > I don't know how hardware is supposed to work so
> > I've kept it as is. =20
>=20
> The HW is hardwired and the modeling is trying to accommodate with
> the '-m' option, the machine definition and the SDRAM controller
> limits and register definitions for a given SoC. The result is not=20
> that good it seems :/=20
>=20
> > But as for CLI side machine should honor whatever
> > user configured or error out to make user fix CLI.
> >=20
> > This patch makes ram-size check actually work and
> > changes behavior from a warning later on during
> > machine reset to error_fatal at the moment SOC is
> > realized so user will have to fix RAM size on CLI
> > to start machine. =20
>=20
> commit 8e00d1a97d1d ("aspeed/sdmc: Introduce an object class per SoC")=20
> moved some calls from the realize handler to reset handler and it
> broke the checks on the RAM size.
>=20
> I think we should introduce get/set handlers on the "ram-size" property
> that would look for a matching size in an AspeedSDMCClass array of valid
> RAM sizes. The default size of the machine would be a valid default and
> bogus user defined sizes would be fatal to QEMU. =20

That's what I'm after, i.e. board either accepts user asked size or exits
with error. So as far as there aren't any fix-ups it should work for
the purpose of this series

>=20
> We could get rid of the code :
>=20
>     /* use a common default */
>     warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
>                 s->ram_size);
>     s->ram_size =3D 512 << 20;
>     return ASPEED_SDMC_AST2500_512MB;
>=20
>=20
> 'max_ram_size' would be the last entry of the AspeedSDMCClass array
> and, anyhow, we need to check bmc->max_ram is really needed. I am not=20
> sure anymore.=20

I'll rework aspeed parts taking in account feedback.

>=20
> Thanks,
>=20
> C.=20
>=20
> > It also gets out of the way mutable ram-size logic,
> > so we could consolidate RAM allocation logic around
> > pre-allocated hostmem backend (supplied by user or
> > auto created by generic machine code depending on
> > supplied -m/mem-path/mem-prealloc options.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: clg@kaod.org
> > CC: peter.maydell@linaro.org
> > CC: andrew@aj.id.au
> > CC: joel@jms.id.au
> > CC: qemu-arm@nongnu.org
> > ---
> >  hw/arm/aspeed.c       | 9 +--------
> >  hw/misc/aspeed_sdmc.c | 5 +++++
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index cc06af4..525c547 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -213,14 +213,7 @@ static void aspeed_machine_init(MachineState *mach=
ine)
> >                                  "hw-prot-key", &error_abort);
> >      }
> >      object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
> > -                             &error_abort);
> > -
> > -    /*
> > -     * Allocate RAM after the memory controller has checked the size
> > -     * was valid. If not, a default value is used.
> > -     */
> > -    ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "ram-size=
",
> > -                                        &error_abort);
> > +                             &error_fatal);
> > =20
> >      memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_s=
ize);
> >      memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
> > diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> > index 3fc80f0..b398e36 100644
> > --- a/hw/misc/aspeed_sdmc.c
> > +++ b/hw/misc/aspeed_sdmc.c
> > @@ -165,6 +165,11 @@ static void aspeed_sdmc_realize(DeviceState *dev, =
Error **errp)
> >      AspeedSDMCState *s =3D ASPEED_SDMC(dev);
> >      AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
> > =20
> > +    if (!g_hash_table_contains(asc->ram2feat,
> > +                               GINT_TO_POINTER(s->ram_size >> 20))) {
> > +        error_setg(errp, "Invalid RAM size 0x%" PRIx64, s->ram_size);
> > +        return;
> > +    }
> >      s->max_ram_size =3D asc->max_ram_size;
> > =20
> >      memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
> >  =20
>=20
>=20


