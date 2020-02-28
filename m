Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7455246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNy/a30k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7455246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7c8L-00083U-To
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j7c7k-0007ZQ-Sa
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j7c7j-0001dI-GG
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:40:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33089
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j7c7j-0001cx-CY
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582882798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIKre3al2M9l4/z5F0k6TA/HIrqxxiT+SjpbtbYFv2s=;
 b=cNy/a30k/fzJ8+sdEgXHBxutF+q3pEfka/R4yJvo/CnFViFdyTV+Avp9bqfFCeYavXXOn2
 +LL0LGffGjw6n8t8MHM/Rmp1WuNqQNh2YLN7AqHujilKsBHVU1ifGBaHc+4LlJotJWetQE
 rdaRdVrHlprYL06zxc68WmTmZaCwnR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-uLS9PKoLPRSqPFk6kVqM-w-1; Fri, 28 Feb 2020 04:39:57 -0500
X-MC-Unique: uLS9PKoLPRSqPFk6kVqM-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E7AC800D50;
 Fri, 28 Feb 2020 09:39:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94ED087B08;
 Fri, 28 Feb 2020 09:39:52 +0000 (UTC)
Date: Fri, 28 Feb 2020 10:39:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH] hw/smbios: add options for type 4 max_speed and
 current_speed
Message-ID: <20200228103950.6fd7ecb5@redhat.com>
In-Reply-To: <6e6c6c8b-c67c-6433-2bb8-d246c5f49b62@huawei.com>
References: <20200225075046.30151-1-guoheyi@huawei.com>
 <4bd58f6e-e522-d920-bc9a-8198147e8856@redhat.com>
 <6e6c6c8b-c67c-6433-2bb8-d246c5f49b62@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: wanghaibin.wang@huawei.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 17:12:21 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> On 2020/2/25 17:24, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 2/25/20 8:50 AM, Heyi Guo wrote: =20
> >> Common VM users sometimes care about CPU speed, so we add two new
> >> options to allow VM vendors to present CPU speed to their users.
> >> Normally these information can be fetched from host smbios.
> >>
> >> Strictly speaking, the "max speed" and "current speed" in type 4
> >> are not really for the max speed and current speed of processor, for
> >> "max speed" identifies a capability of the system, and "current speed"
> >> identifies the processor's speed at boot (see smbios spec), but some
> >> applications do not tell the differences.
> >>
> >> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> >>
> >> ---
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >> =C2=A0 hw/smbios/smbios.c | 22 +++++++++++++++++++---
> >> =C2=A0 qemu-options.hx=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> >> =C2=A0 2 files changed, 21 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> >> index ffd98727ee..1d5439643d 100644
> >> --- a/hw/smbios/smbios.c
> >> +++ b/hw/smbios/smbios.c
> >> @@ -94,6 +94,8 @@ static struct {
> >> =C2=A0 =C2=A0 static struct {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *sock_pfx, *manufacturer, *v=
ersion, *serial, *asset,=20
> >> *part;
> >> +=C2=A0=C2=A0=C2=A0 uint32_t max_speed;
> >> +=C2=A0=C2=A0=C2=A0 uint32_t current_speed;
> >> =C2=A0 } type4;
> >> =C2=A0 =C2=A0 static struct {
> >> @@ -272,6 +274,14 @@ static const QemuOptDesc=20
> >> qemu_smbios_type4_opts[] =3D {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "vers=
ion",
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D QEMU_=
OPT_STRING,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .help =3D "vers=
ion number",
> >> +=C2=A0=C2=A0=C2=A0 },{
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "max_speed",
I'd suggest to use - instead of _ in option name

> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D QEMU_OPT_NUMBER,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .help =3D "max speed in MH=
z",
> >> +=C2=A0=C2=A0=C2=A0 },{
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "current_speed",
ditto

> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D QEMU_OPT_NUMBER,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .help =3D "speed at system=
 boot in MHz",
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },{
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "seri=
al",
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D QEMU_=
OPT_STRING,
> >> @@ -586,9 +596,8 @@ static void=20
> >> smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SMBIOS_TABLE_SET_STR(4, processor_versi=
on_str, type4.version);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->voltage =3D 0;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->external_clock =3D cpu_to_le16(0); /=
* Unknown */
> >> -=C2=A0=C2=A0=C2=A0 /* SVVP requires max_speed and current_speed to no=
t be unknown. */
> >> -=C2=A0=C2=A0=C2=A0 t->max_speed =3D cpu_to_le16(2000); /* 2000 MHz */
> >> -=C2=A0=C2=A0=C2=A0 t->current_speed =3D cpu_to_le16(2000); /* 2000 MH=
z */
> >> +=C2=A0=C2=A0=C2=A0 t->max_speed =3D cpu_to_le16(type4.max_speed);
> >> +=C2=A0=C2=A0=C2=A0 t->current_speed =3D cpu_to_le16(type4.current_spe=
ed);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->status =3D 0x41; /* Socket populated=
, CPU enabled */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->processor_upgrade =3D 0x01; /* Other=
 */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->l1_cache_handle =3D cpu_to_le16(0xFF=
FF); /* N/A */
> >> @@ -1129,6 +1138,13 @@ void smbios_entry_add(QemuOpts *opts, Error=20
> >> **errp)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 save_opt(&type4.serial, opts, "serial");
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 save_opt(&type4.asset, opts, "asset");
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 save_opt(&type4.part, opts, "part");
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * SVVP requires max_speed and current_speed to not be=20
> >> unknown, and
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * we set the default value to 2000MHz as we did before.
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ty=
pe4.max_speed =3D qemu_opt_get_number(opts, "max_speed",=20
> >> 2000);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ty=
pe4.current_speed =3D qemu_opt_get_number(opts,=20
> >> "current_speed",
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2000); =20
> >
> > Maybe check speeds are <=3D UINT16_MAX else set errp? =20
>=20
> OK; I can do that in the v2. But I would wait for the maintainers to=20
> provide more comments :)
>=20
> Thanks,
>=20
> Heyi
>=20
> > =20
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 11:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
> >> diff --git a/qemu-options.hx b/qemu-options.hx
> >> index ac315c1ac4..bc9ef0fda8 100644
> >> --- a/qemu-options.hx
> >> +++ b/qemu-options.hx
> >> @@ -2233,6 +2233,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specify SMBIOS type =
3 fields\n"
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-smbios=20
> >> type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr][,serial=
=3Dstr]\n"
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [,asset=3Dstr][,part=3Dstr]\n"
> >> +=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [,max_speed=3D%d][,current_speed=3D%d]\n"
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specify SMBIOS type =
4 fields\n"
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-smbios=20
> >> type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr][,serial=3D=
str]\n"
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [,asset=3Dstr][,part=3Dstr=
][,speed=3D%d]\n"
> >> @@ -2255,7 +2256,7 @@ Specify SMBIOS type 2 fields
> >> =C2=A0 @item -smbios=20
> >> type=3D3[,manufacturer=3D@var{str}][,version=3D@var{str}][,serial=3D@v=
ar{str}][,asset=3D@var{str}][,sku=3D@var{str}]
> >> =C2=A0 Specify SMBIOS type 3 fields
> >> =C2=A0 -@item -smbios=20
> >> type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}][,version=3D=
@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str}]
> >> +@item -smbios=20
> >> type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}][,version=3D=
@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str}][,max=
_speed=3D@var{%d}][,current_speed=3D@var{%d}]
> >> =C2=A0 Specify SMBIOS type 4 fields
> >> =C2=A0 =C2=A0 @item -smbios=20
> >> type=3D17[,loc_pfx=3D@var{str}][,bank=3D@var{str}][,manufacturer=3D@va=
r{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str}][,speed=
=3D@var{%d}]
> >> =20
> >
> >
> > . =20
>=20


