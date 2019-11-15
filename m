Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23DC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85FC20748
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnlr2oKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85FC20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaUR-00063j-IA
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iVaSC-0004Rw-AE
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iVaSA-0000MB-4Z
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:11:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52405
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iVaSA-0000Ly-0l
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573819913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zohSGVw+3v3W3bhN4Pgqo5qi1DuJYOjGj/hm7Bnra5A=;
 b=Fnlr2oKAHoffh3MQo8VB0PXOC19lXKc1eLFx0P2Q0xWmBv/8BUY00HAOsUuXzjGrIQLAG/
 44S4DQYwAQqF/OVUoDdkkYHItfYNAG8OTXD1ZCRjsHkfRl0GDzSYXZUFbpJhJ4JANRMvOc
 iC8Hbyo7IpxPyTqYteAYKeBAAGh9i4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-wYwhWi-_NOaa6lS3PQ-YhA-1; Fri, 15 Nov 2019 07:11:52 -0500
Received: by mail-wm1-f72.google.com with SMTP id f14so5916383wmc.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 04:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A37ifwbPeskXOwInqaKYsFCbMiRTeSD5XG1L6pyv0Iw=;
 b=o8PCLAOhEPXlcpqS/ck++VcnHBmlqDGWCelVNK3vqwLuYQWrZIAOhy4Wyc4aiEPCP8
 u5gk7/S44CzvBag3M375N9MpyEr77WCkSsLc2o4EEhtcK+RN57SxNVBb34UaJ5BkFhjz
 hwJ4fpWPtGo8dVNoim+Q3PJQXvOVt1nBK57c8OduaQVrBtg5Fyo/lSmlDgLUmiBcMkWt
 zU6zvzs4oefURvf+iQWmDM64eT3Sopl9/LOwVo7kvZllEEZGdL2Kf+M0AIQC+vQY9I4z
 yq6WfoWYwUiyz2jwQ4eqcoscR9XwL8g6OSucayyx3cQx4DIZQz/8NmVRMn1MMs4jP/jM
 TYug==
X-Gm-Message-State: APjAAAXw5cA31S5hO/tIpMyrf/mQnU5FXxpzjcBkev/osGVMhkqWwwHd
 Fy0duaLzqG1rMp5U0pIwusDF/BwMODAzznvoqf2jU614IBFKE4DDJTojEVeYIHAcP7WpXSUhqiW
 2d/x/m4/vo0bcf74=
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr14874669wmg.93.1573819910975; 
 Fri, 15 Nov 2019 04:11:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMYyB2176iRoT6bCOoDhiHMg4VFsy8Q8/EHJC6KtRJaSdJ4Yw0HmTMAPaAQFgBe/3nia/p+A==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr14874634wmg.93.1573819910672; 
 Fri, 15 Nov 2019 04:11:50 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id z11sm13792936wrg.0.2019.11.15.04.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2019 04:11:50 -0800 (PST)
Subject: Re: [PATCH v16 03/14] util/cutils: refactor do_strtosz() to support
 suffixes list
To: Tao Xu <tao3.xu@intel.com>, mst@redhat.com, imammedo@redhat.com,
 eblake@redhat.com, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 armbru@redhat.com, mdroth@linux.vnet.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-4-tao3.xu@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f523361e-1aec-1bf7-2985-f6619adf3d95@redhat.com>
Date: Fri, 15 Nov 2019 13:11:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191115075352.17734-4-tao3.xu@intel.com>
Content-Language: en-US
X-MC-Unique: wYwhWi-_NOaa6lS3PQ-YhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: jingqi.liu@intel.com, fan.du@intel.com, qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Markus & Stefan.

On 11/15/19 8:53 AM, Tao Xu wrote:
> Add do_strtomul() to convert string according to different suffixes.
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> No changes in v16.
>=20
> Changes in v15:
>      - Add a new patch to refactor do_strtosz() (Eduardo)
> ---
>   util/cutils.c | 72 ++++++++++++++++++++++++++++++---------------------
>   1 file changed, 42 insertions(+), 30 deletions(-)
>=20
> diff --git a/util/cutils.c b/util/cutils.c
> index d94a468954..ffef92338a 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -181,41 +181,37 @@ int fcntl_setfl(int fd, int flag)
>   }
>   #endif
>  =20
> -static int64_t suffix_mul(char suffix, int64_t unit)
> +static int64_t suffix_mul(const char *suffixes[], int num_suffix,
> +                          const char *endptr, int *offset, int64_t unit)
>   {
> -    switch (qemu_toupper(suffix)) {
> -    case 'B':
> -        return 1;
> -    case 'K':
> -        return unit;
> -    case 'M':
> -        return unit * unit;
> -    case 'G':
> -        return unit * unit * unit;
> -    case 'T':
> -        return unit * unit * unit * unit;
> -    case 'P':
> -        return unit * unit * unit * unit * unit;
> -    case 'E':
> -        return unit * unit * unit * unit * unit * unit;
> +    int i, suffix_len;
> +    int64_t mul =3D 1;
> +
> +    for (i =3D 0; i < num_suffix; i++) {
> +        suffix_len =3D strlen(suffixes[i]);
> +        if (g_ascii_strncasecmp(suffixes[i], endptr, suffix_len) =3D=3D =
0) {
> +            *offset =3D suffix_len;

So now we can parse "8kB" and "8Kb", and this might be confusing when=20
parsing bit units.

   https://en.wikipedia.org/wiki/Kilobyte#Definitions_and_usage:

   IEC 80000-13 standard uses the term 'byte' to mean
   eight bits (1 B =3D 8 bit).

At some point we'll need to add the IEC suffix parsing to this function.

   https://en.wikipedia.org/wiki/Kibibyte#Definition

Meanwhile, can you keep it to upper case suffix only?

> +            return mul;
> +    }
> +        mul *=3D unit;
>       }
> +
>       return -1;
>   }
>  =20
>   /*
> - * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
> - * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
> - * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
> - * other error.
> + * Convert string according to different suffixes. End pointer will be r=
eturned
> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on othe=
r error.
>    */
> -static int do_strtosz(const char *nptr, const char **end,
> -                      const char default_suffix, int64_t unit,
> +static int do_strtomul(const char *nptr, const char **end,
> +                       const char *suffixes[], int num_suffix,
> +                       const char *default_suffix, int64_t unit,
>                         uint64_t *result)
>   {
>       int retval;
>       const char *endptr;
> -    unsigned char c;
>       int mul_required =3D 0;
> +    int offset =3D 0;
>       long double val, mul, integral, fraction;
>  =20
>       retval =3D qemu_strtold_finite(nptr, &endptr, &val);
> @@ -226,12 +222,12 @@ static int do_strtosz(const char *nptr, const char =
**end,
>       if (fraction !=3D 0) {
>           mul_required =3D 1;
>       }
> -    c =3D *endptr;
> -    mul =3D suffix_mul(c, unit);
> +
> +    mul =3D suffix_mul(suffixes, num_suffix, endptr, &offset, unit);
>       if (mul >=3D 0) {
> -        endptr++;
> +        endptr +=3D offset;
>       } else {
> -        mul =3D suffix_mul(default_suffix, unit);
> +        mul =3D suffix_mul(suffixes, num_suffix, default_suffix, &offset=
, unit);
>           assert(mul >=3D 0);
>       }
>       if (mul =3D=3D 1 && mul_required) {
> @@ -256,19 +252,35 @@ out:
>       return retval;
>   }
>  =20
> +/*
> + * Convert string to bytes, allowing either B/b for bytes, K/k for KB,

Then also fix here "B/b for bytes".

> + * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned

Shouldn't we refuse m/g/t? (m is the 'milli' suffix)

Thanks,

Phil.

> + * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
> + * other error.
> + */
> +static int do_strtosz(const char *nptr, const char **end,
> +                      const char *default_suffix, int64_t unit,
> +                      uint64_t *result)
> +{
> +    static const char *suffixes[] =3D { "B", "K", "M", "G", "T", "P", "E=
" };
> +
> +    return do_strtomul(nptr, end, suffixes, ARRAY_SIZE(suffixes),
> +                       default_suffix, unit, result);
> +}
> +
>   int qemu_strtosz(const char *nptr, const char **end, uint64_t *result)
>   {
> -    return do_strtosz(nptr, end, 'B', 1024, result);
> +    return do_strtosz(nptr, end, "B", 1024, result);
>   }
>  =20
>   int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *resu=
lt)
>   {
> -    return do_strtosz(nptr, end, 'M', 1024, result);
> +    return do_strtosz(nptr, end, "M", 1024, result);
>   }
>  =20
>   int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *r=
esult)
>   {
> -    return do_strtosz(nptr, end, 'B', 1000, result);
> +    return do_strtosz(nptr, end, "B", 1000, result);
>   }
>  =20
>   /**
>=20


