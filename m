Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A25C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E43620715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvdKpJ4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E43620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6FP-0000rH-Dj
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY6EH-00006v-AP
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY6EF-0004Pv-FG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:31:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY6EF-0004PW-Bz
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574418714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYA/qZH7SEH+SbJXsSV9MHaPz28asRCDcSNFH/N3Qz8=;
 b=BvdKpJ4Y3hOKmEHtIBr96UrNbRZ+j3/ajkEhMB2t/TtU7NNhU45c3rWYzC/ACrGpJpDnEr
 CFKhYIfROTrV9kQre69arQtgPej7Xpj1OtcYOdXmNTNDmzKLYCjdvFhNj1+Kv0V56E0U9W
 15QzgQzX/9F2cdIe2Fu+Jw3id5yqEbk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-GQhSqiuCMzaIekM1Y7khkQ-1; Fri, 22 Nov 2019 05:31:52 -0500
Received: by mail-wm1-f70.google.com with SMTP id f16so2888768wmb.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JaDrCm8MaVsnCFTV92p1IB0RGBhGfw49ODXTvu0Ncig=;
 b=NKVxvHbaHgnZ+2QDXKjTuczJdP0BmOghQ9f0mkfdfE0GzzQNTchzUmkmbjexrht8na
 IoH+bJUynJUmw4DKRfWG5O2MWtpGz81ifmKrhuHv6nzuhfY+J1O/T0x0fZzKpb4Cq/t0
 Gji7u9Tjkq46199PUXapenrHuRm2IxmqOGcpcaPMwvmy5uVTf4Aap6aowujG8ax9TigR
 7dgkzM11QFrEttmAObtK1trZ1xtdhIJ04rCRPwGAeX6bHxUzGGUHacZdAfrTuyAnTxwO
 nRC2pUvzYHwr+am4+E6DfvfB2W+B+r/igGc5tOj6UgRSbahZas6OQ0hL2l9GHWQbLpmy
 vcSQ==
X-Gm-Message-State: APjAAAVRMDogkaB/ON8F2sP4Y8sI9P4GyjtgBslnj2J2wx9XHQlMJhDr
 /++5yOQfHJKtgJClfMVqX7awiUXQ8aKViK7EDTwzGJT4pqlrdmgAITwVzOmzaYdy+yE/0uG36RK
 Q3ongp09z4YfDhv4=
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr14864775wma.34.1574418711665; 
 Fri, 22 Nov 2019 02:31:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEKMWYL3qGcD/T7/K3jFU5c1o3q6dqffGHbIVFwbCOk4Ws7kuA5Y85Zz9xGtyrjp+lt4ujhw==
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr14864753wma.34.1574418711440; 
 Fri, 22 Nov 2019 02:31:51 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id o21sm2930993wmc.17.2019.11.22.02.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 02:31:50 -0800 (PST)
Subject: Re: [PATCH v3 1/2] migration: Fix incorrect integer->float conversion
 caught by clang
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191122080039.12771-1-armbru@redhat.com>
 <20191122080039.12771-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2827a9a2-16fa-9639-d3b7-076e2acefae9@redhat.com>
Date: Fri, 22 Nov 2019 11:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122080039.12771-2-armbru@redhat.com>
Content-Language: en-US
X-MC-Unique: GQhSqiuCMzaIekM1Y7khkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Fangrui Song <i@maskray.me>, richard.henderson@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 9:00 AM, Markus Armbruster wrote:
> From: Fangrui Song <i@maskray.me>
>=20
> Clang does not like qmp_migrate_set_downtime()'s code to clamp double
> @value to 0..INT64_MAX:
>=20
>      qemu/migration/migration.c:2038:24: error: implicit conversion from =
'long' to 'double' changes value from 9223372036854775807 to 92233720368547=
75808 [-Werror,-Wimplicit-int-float-conversion]
>=20
> The warning will be enabled by default in clang 10. It is not
> available for clang <=3D 9.
>=20
> The clamp is actually useless; @value is checked to be within
> 0..MAX_MIGRATE_DOWNTIME_SECONDS immediately before.  Delete it.
>=20
> While there, make the conversion from double to int64_t explicit.
>=20
> Signed-off-by: Fangrui Song <i@maskray.me>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> [Patch split, commit message improved]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   migration/migration.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 354ad072fa..09b150663f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2035,11 +2035,10 @@ void qmp_migrate_set_downtime(double value, Error=
 **errp)
>       }
>  =20
>       value *=3D 1000; /* Convert to milliseconds */
> -    value =3D MAX(0, MIN(INT64_MAX, value));
>  =20
>       MigrateSetParameters p =3D {
>           .has_downtime_limit =3D true,
> -        .downtime_limit =3D value,
> +        .downtime_limit =3D (int64_t)value,

I agree with Eric a one line comment about the explicit cast is=20
welcomed. We can still use 'git blame', find the last commit sha, then=20
look at the commit description. But having it along the code is=20
straightforward.

Preferably with a comment (the maintainer queing this can amend it):
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       };
>  =20
>       qmp_migrate_set_parameters(&p, errp);
>=20


