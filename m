Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0948C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791EF20724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbN+DtJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791EF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKLB-0003W8-NR
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFKKA-0002sA-Kf
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFKK9-0001fM-FD
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:16:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFKK9-0001en-AL
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584721000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WPGyl0ES/D0a+JnECTtVka7RZxzK4aeXitbCQH4DaQA=;
 b=VbN+DtJmZRuEuG5XgJccaU4Ib6xBDYGJtFLBvYeoyr7JeZ0qB7DFRgpcgmYI0hMrmvqmRB
 8rCStXLxpNqP3TpqiGBcqTGtcB6dna3wxvniOh64bnRrJmJjay2LYD/T4nkXKBb0GfYMS9
 2M9+T63Xl8pdHDklT7XkvTb5Ir32p5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-p_DgBYmkOQ2mKp-DM6FjVA-1; Fri, 20 Mar 2020 12:16:38 -0400
X-MC-Unique: p_DgBYmkOQ2mKp-DM6FjVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09C1E8017CC;
 Fri, 20 Mar 2020 16:16:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD42594972;
 Fri, 20 Mar 2020 16:16:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4954F1138404; Fri, 20 Mar 2020 17:16:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] ppc/ppc405_boards: Remove unnecessary NULL check
References: <20200320155740.5342-1-philmd@redhat.com>
Date: Fri, 20 Mar 2020 17:16:31 +0100
In-Reply-To: <20200320155740.5342-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 20 Mar 2020 16:57:40
 +0100")
Message-ID: <877dzfypb4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex =?utf-8?Q?Benn?= =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> This code is inside the "if (dinfo)" condition, so testing
> again here whether it is NULL is unnecessary.
>
> Fixes: dd59bcae7 (Don't size flash memory to match backing image)
> Reported-by: Coverity (CID 1421917)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/ppc/ppc405_boards.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index e6bffb9e1a..6198ec1035 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -191,7 +191,7 @@ static void ref405ep_init(MachineState *machine)
>          bios_size =3D 8 * MiB;
>          pflash_cfi02_register((uint32_t)(-bios_size),
>                                "ef405ep.bios", bios_size,
> -                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              blk_by_legacy_dinfo(dinfo),
>                                64 * KiB, 1,
>                                2, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
> @@ -459,7 +459,7 @@ static void taihu_405ep_init(MachineState *machine)
>          bios_size =3D 2 * MiB;
>          pflash_cfi02_register(0xFFE00000,
>                                "taihu_405ep.bios", bios_size,
> -                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              blk_by_legacy_dinfo(dinfo),
>                                64 * KiB, 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
> @@ -494,7 +494,7 @@ static void taihu_405ep_init(MachineState *machine)
>      if (dinfo) {
>          bios_size =3D 32 * MiB;
>          pflash_cfi02_register(0xfc000000, "taihu_405ep.flash", bios_size=
,
> -                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              blk_by_legacy_dinfo(dinfo),
>                                64 * KiB, 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);

Reviewed-by: Markus Armbruster <armbru@redhat.com>


