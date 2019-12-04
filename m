Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54866C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FCC206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBrL2wp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FCC206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icW5O-0004FR-7t
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icW4R-0003fE-T1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icW4Q-00070Q-Q7
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:56:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icW4Q-00070B-MI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575471361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MgxO9ESAppqjsZ+axods+PWh44FAbjcTKVmzKuWeVE=;
 b=DBrL2wp6rh2WeMHmTClH0mvPGI/0sYwtKkFq2jQGfqQ9zi6WgRRZT9c0A0HbqAnKdXoR75
 xpA387+C0IqjUGgLC4kLbLiPeDhyjwVRdwo1fmsBy7+sJg4ltU7TzkE2QcMtf3UchRdwdw
 +q2Jv2hvQZ4UZ8nqpP5ZvKtdO9Y+Ldo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-b18knUL6PhSgN_Gfejl28w-1; Wed, 04 Dec 2019 09:55:59 -0500
Received: by mail-wr1-f69.google.com with SMTP id z14so3777760wrs.4
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 06:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U/etnBb4UC4sTQoeOwZJ/31OntsKMbTHdaRge4Xw4kA=;
 b=k09V6Vj6wTMdcFlXB1CUKwjYeKyTuHC9Lzt68MRWAIrIiUa+mMl971Ts7TrpFejObd
 P3Fjb6/3eLTs9HIpeulMREIz2hCGFJID7Z4ksooQr1K/dbPfu1oNVfmlKZRwSRskERJP
 p15S8wwAC88bhbMBlrECiW2UynGNKjSTdQi28Q5GKUqLJ8JsbdHj+zIAbmfn8OsqFN/K
 oo4EkUlUvBoOd4tGsNi7cb4pyoI5ZZolv+NHFm0GAyl+3ay1eAooPLstpsPqAH+3sbCy
 mjBFB4M8JiSqD8P5BE3QBoIh7Tvb22t54f1z3TRIBhC/csVuoS9xGEoTzkOKcyZunx+0
 Sm1w==
X-Gm-Message-State: APjAAAUkniwViKb/jTVoX1OfLG/9au4ZdTLrnZO6zE9ycumSs3tgiX+7
 GeoMvgoo/4O7XaUS7ps3N/RLChpKYYO+SqP5QukI7Y9a88resMNeG1EWVtojC+PqumGAKVJvLXA
 Jw8m+b590wqY/4F4=
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr4508482wrs.247.1575471358593; 
 Wed, 04 Dec 2019 06:55:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVEBCajO/I8Pg3ORBINHnWybFEz/dOWqSM9FnV7B1GVif9ODsvYqXMLN7+z8SrOeVi0XahLA==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr4508468wrs.247.1575471358416; 
 Wed, 04 Dec 2019 06:55:58 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id e6sm7681143wru.44.2019.12.04.06.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 06:55:57 -0800 (PST)
Subject: Re: [PATCH v2 07/18] hw/core: Fix fit_load_fdt() error handling
 violations
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191204093625.14836-1-armbru@redhat.com>
 <20191204093625.14836-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <184b12c5-e7f2-c20f-ecd5-b140719b9d3c@redhat.com>
Date: Wed, 4 Dec 2019 15:55:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204093625.14836-8-armbru@redhat.com>
Content-Language: en-US
X-MC-Unique: b18knUL6PhSgN_Gfejl28w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
> fit_load_fdt() passes @errp to fit_image_addr(), then recovers from
> ENOENT failures.  Passing @errp is wrong, because it works only as
> long as @errp is neither @error_fatal nor @error_abort.  Messed up in
> commit 3eb99edb48 "loader-fit: Wean off error_printf()".
>=20
> No caller actually passes such values.
>=20
> Fix anyway: splice in a local Error *err, and error_propagate().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/core/loader-fit.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 953b16bc82..c465921b8f 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -178,11 +178,12 @@ static int fit_load_fdt(const struct fit_loader *ld=
r, const void *itb,
>                           int cfg, void *opaque, const void *match_data,
>                           hwaddr kernel_end, Error **errp)
>   {
> +    Error *err =3D NULL;
>       const char *name;
>       const void *data;
>       const void *load_data;
>       hwaddr load_addr;
> -    int img_off, err;
> +    int img_off;
>       size_t sz;
>       int ret;
>  =20
> @@ -197,13 +198,13 @@ static int fit_load_fdt(const struct fit_loader *ld=
r, const void *itb,
>           return -EINVAL;
>       }
>  =20
> -    err =3D fit_image_addr(itb, img_off, "load", &load_addr, errp);
> -    if (err =3D=3D -ENOENT) {
> +    ret =3D fit_image_addr(itb, img_off, "load", &load_addr, &err);
> +    if (ret =3D=3D -ENOENT) {
>           load_addr =3D ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
> -        error_free(*errp);
> -    } else if (err) {
> -        error_prepend(errp, "unable to read FDT load address from FIT: "=
);
> -        ret =3D err;
> +        error_free(err);
> +    } else if (ret) {
> +        error_propagate_prepend(errp, err,
> +                                "unable to read FDT load address from FI=
T: ");
>           goto out;
>       }
>  =20

Cleaner.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


