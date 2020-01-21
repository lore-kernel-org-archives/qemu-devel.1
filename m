Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD5AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD9020882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf6rJEbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD9020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrEO-00072F-VJ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrezanin@redhat.com>) id 1itrDg-0006SI-D8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1itrDd-0006yx-18
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:57:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mrezanin@redhat.com>) id 1itrDc-0006xJ-T0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579604230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36eSsXbt1PCk0ZqLu/KWTYAoirFOz3wbJa5qGq/YBZ8=;
 b=Jf6rJEbFwwvsIJ0ThpTABJsy+Ho2dVUpHH9RvAIvLNAAIiLB8GWMApUlHVvKDu8yjllLc1
 p+9TXc87cXNEZTNvFXwGlmnrX8XQzVs+KLf3JX9D2ela7pJRWyRG+WQzzYxM+JZJ6Q2dnE
 Q3f4JuSofkedvffHxKhDQWRjRTK2A0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-HyeibIlOMzi73y7khP9UOg-1; Tue, 21 Jan 2020 05:57:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17B768C3C82;
 Tue, 21 Jan 2020 10:57:08 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED0C45DA70;
 Tue, 21 Jan 2020 10:57:07 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id ACFF018095FF;
 Tue, 21 Jan 2020 10:57:06 +0000 (UTC)
Date: Tue, 21 Jan 2020 05:57:06 -0500 (EST)
From: Miroslav Rezanina <mrezanin@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Message-ID: <105074722.2949784.1579604226517.JavaMail.zimbra@redhat.com>
In-Reply-To: <fdc3e6c2-87e4-2e51-cbee-d9c7a008eec9@kaod.org>
References: <cover.1579598240.git.mrezanin@redhat.com>
 <07957dcab31f65de3dd30efa91e6b9152ac79879.1579598240.git.mrezanin@redhat.com>
 <c1b01c90-e42c-b65f-c7b8-2a589510a7d0@redhat.com>
 <fdc3e6c2-87e4-2e51-cbee-d9c7a008eec9@kaod.org>
Subject: Re: [PATCH 2/2] aspeed/i2c: Prevent uninitialized warning
MIME-Version: 1.0
X-Originating-IP: [10.40.204.25, 10.4.195.24]
Thread-Topic: aspeed/i2c: Prevent uninitialized warning
Thread-Index: UFtmhiX1gQxBEhJcRpb5d5AmLeqFCQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: HyeibIlOMzi73y7khP9UOg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "C=C3=A9dric Le Goater" <clg@kaod.org>
> To: "Thomas Huth" <thuth@redhat.com>, mrezanin@redhat.com, qemu-devel@non=
gnu.org
> Cc: "peter maydell" <peter.maydell@linaro.org>, "Andrew Jeffery" <andrew@=
aj.id.au>, "Joel Stanley" <joel@jms.id.au>,
> qemu-trivial@nongnu.org
> Sent: Tuesday, January 21, 2020 11:44:14 AM
> Subject: Re: [PATCH 2/2] aspeed/i2c: Prevent uninitialized warning
>=20
> On 1/21/20 11:02 AM, Thomas Huth wrote:
> > On 21/01/2020 10.28, mrezanin@redhat.com wrote:
> >> From: Miroslav Rezanina <mrezanin@redhat.com>
> >>
> >> Compiler reports uninitialized warning for cmd_flags variable.
> >>
> >> Adding NULL initialization to prevent this warning.
> >>
> >> Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
> >> ---
> >>  hw/i2c/aspeed_i2c.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> >> index 2da04a4..445182a 100644
> >> --- a/hw/i2c/aspeed_i2c.c
> >> +++ b/hw/i2c/aspeed_i2c.c
> >> @@ -400,7 +400,7 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *bu=
s)
> >> =20
> >>  static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
> >>  {
> >> -    g_autofree char *cmd_flags;
> >> +    g_autofree char *cmd_flags =3D NULL;
> >>      uint32_t count;
> >> =20
> >>      if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF_ENABLE)) {
> >=20
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> >=20
> > ... maybe someone with enough Perl-foo (i.e. not me ;-)) should add a
> > check to our check_patch.pl script so that it complains when new code i=
s
> > introduced that uses g_autofree without initializing the variable...
>=20
> weird. The cmd_flags variable is assigned just after and used
> in a trace.
>=20

As g_autofree is used, variable has to be initialized otherwise will compil=
er
complain even in the case we write to variable immediately after.

Mirek

> C.
>=20
>=20

--=20
Miroslav Rezanina
Software Engineer - Virtualization Team Maintainer


