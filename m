Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB6FC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFA6206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLgxpjZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFA6206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icW3c-0002iG-0W
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icW2U-00021K-4X
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icW2T-00045N-37
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:54:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icW2S-00044s-VW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575471240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MET1ygTifKkDd9CP5vuqmLy7BT9eoSj9N+5di6YmMSs=;
 b=KLgxpjZMJWvu1Lp57qCXYr/EFoT/v4SbQ4oOK7aE0MpS/H5R8814S5ZDRD/6dtkeE1Dfep
 sFtwJU4AqZFf3XiNRG/XdM3IcvkAGJWX96fiudWOItoVAILxKFpz/lINWMXjj6W9wOGaKs
 v28eDqVIgER1i2po2YK3+z4gi45e/74=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-ybBRFv7FMwWZObuAMuEOUw-1; Wed, 04 Dec 2019 09:53:59 -0500
Received: by mail-wm1-f72.google.com with SMTP id 18so2293090wmp.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 06:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5wrEWD+gyIH+pvaEl1G5uT+RGxzurSvLZw7ecSZTSXM=;
 b=rxsW18EZoHSjd15xZbJS3P2ahBiBD3cgCufXEc+ilRDDK2i+wd+lTGerXDaxmhHdf8
 u13wcqN8QNTZ6S6MZYyxK2j194HWmaEeGwL8jC9wiPJb4P0VKn4B4AFuPSOcQzd/6ApN
 E53cUs8hMj0vIYZGw3p5pMVncwcnXcZyxcAOC4giyzipEFZWnizlRIHRAsF7UY6afwHS
 mrAM83OtIngrCc6Zl4uHtOuORdKuAXgFa0xhJD/TL4EliIBozrNEV92poTjV6l+x+2gT
 prwZoV1fBS3bUSZCj9GzqcouoxE9kZmFE4LGJIEw7EU2qj4uSjBydw1WD/4H+Px2ICGA
 uTDQ==
X-Gm-Message-State: APjAAAUq0cuUTBfzmkqNKY8R6veM1gUgcMA1FzoaryBYRum8JS8i0wEK
 ysZiaxchv3LXMuDtPh1rjRK2VJXhbgVZuEKPpwtcFfCR5SeY3Dog4hM2Zn7903lWycMxr8cAVCu
 zM0NsR8CboC9fzi8=
X-Received: by 2002:adf:e2cd:: with SMTP id d13mr4520991wrj.221.1575471237763; 
 Wed, 04 Dec 2019 06:53:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDAlOnCQMVkq1xIH7x0wUxK3mS6rNjYz7dEDrOTbxvbqZwVPG2kWEM+xpwsYwaaGibYOS+jQ==
X-Received: by 2002:adf:e2cd:: with SMTP id d13mr4520975wrj.221.1575471237621; 
 Wed, 04 Dec 2019 06:53:57 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id t1sm7728386wma.43.2019.12.04.06.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 06:53:57 -0800 (PST)
Subject: Re: [PATCH v2 04/18] tests: Clean up initialization of Error *err
 variables
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191204093625.14836-1-armbru@redhat.com>
 <20191204093625.14836-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39bf589f-5576-606e-bd6f-7b72a271a9d1@redhat.com>
Date: Wed, 4 Dec 2019 15:53:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204093625.14836-5-armbru@redhat.com>
Content-Language: en-US
X-MC-Unique: ybBRFv7FMwWZObuAMuEOUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 10:36 AM, Markus Armbruster wrote:
> Declaring a local Error *err without initializer looks suspicious.
> Fuse the declaration with the initialization to avoid that.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-qobject-output-visitor.c | 8 ++++----
>   tests/test-string-output-visitor.c  | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
> index 3e993e5ba8..d7761ebf84 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -145,10 +145,10 @@ static void test_visitor_out_enum_errors(TestOutput=
VisitorData *data,
>                                            const void *unused)
>   {
>       EnumOne i, bad_values[] =3D { ENUM_ONE__MAX, -1 };
> -    Error *err;
>  =20
>       for (i =3D 0; i < ARRAY_SIZE(bad_values) ; i++) {
> -        err =3D NULL;
> +        Error *err =3D NULL;
> +

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           visit_type_EnumOne(data->ov, "unused", &bad_values[i], &err);
>           error_free_or_abort(&err);
>           visitor_reset(data);
> @@ -240,11 +240,11 @@ static void test_visitor_out_struct_errors(TestOutp=
utVisitorData *data,
>       EnumOne bad_values[] =3D { ENUM_ONE__MAX, -1 };
>       UserDefOne u =3D {0};
>       UserDefOne *pu =3D &u;
> -    Error *err;
>       int i;
>  =20
>       for (i =3D 0; i < ARRAY_SIZE(bad_values) ; i++) {
> -        err =3D NULL;
> +        Error *err =3D NULL;
> +
>           u.has_enum1 =3D true;
>           u.enum1 =3D bad_values[i];
>           visit_type_UserDefOne(data->ov, "unused", &pu, &err);
> diff --git a/tests/test-string-output-visitor.c b/tests/test-string-outpu=
t-visitor.c
> index 02766c0f65..1be1540767 100644
> --- a/tests/test-string-output-visitor.c
> +++ b/tests/test-string-output-visitor.c
> @@ -207,10 +207,10 @@ static void test_visitor_out_enum_errors(TestOutput=
VisitorData *data,
>                                            const void *unused)
>   {
>       EnumOne i, bad_values[] =3D { ENUM_ONE__MAX, -1 };
> -    Error *err;
>  =20
>       for (i =3D 0; i < ARRAY_SIZE(bad_values) ; i++) {
> -        err =3D NULL;
> +        Error *err =3D NULL;
> +
>           visit_type_EnumOne(data->ov, "unused", &bad_values[i], &err);
>           error_free_or_abort(&err);
>       }
>=20


