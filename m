Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512ACC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1A620722
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AI64YL4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1A620722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ88w-0006OM-9I
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 01:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZ886-0005xH-S7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZ884-00022P-HS
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:45:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42605
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZ884-00021q-4S
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574664346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=liv2r9nK8RW3wkx5PsZkJEFpHYfYAauehoZmSsqssvo=;
 b=AI64YL4t7AcR2Fpw43oiMesTAb6daEMd7FY2BoHegaI91nM6HHIIAkY8S1xJnJa/U4KcS4
 /c4IBdWKmJoz7zkFbPPi+4egy+v962E/1134CXhGW2matW9h4U4cuMKRhr28U/4yZter0c
 Yrj1x51dLVGP4HFGLWf1C791zcV1cq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-6DCvvbYqNcuaL7wO_N8cwg-1; Mon, 25 Nov 2019 01:45:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD7DD100726C;
 Mon, 25 Nov 2019 06:45:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C54B060C18;
 Mon, 25 Nov 2019 06:45:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 46F671138606; Mon, 25 Nov 2019 07:45:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 01/14] util/cutils: Add Add qemu_strtold and
 qemu_strtold_finite
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-2-tao3.xu@intel.com>
Date: Mon, 25 Nov 2019 07:45:38 +0100
In-Reply-To: <20191122074826.1373-2-tao3.xu@intel.com> (Tao Xu's message of
 "Fri, 22 Nov 2019 15:48:13 +0800")
Message-ID: <87zhgkjvxp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6DCvvbYqNcuaL7wO_N8cwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> Work like qemu_strtod() and qemu_strtold_finite, except store long
> double.
>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>
> No changes in v17.
> ---
>  include/qemu/cutils.h |  3 +++
>  util/cutils.c         | 48 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index b54c847e0f..48cf9bf776 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -146,6 +146,9 @@ int qemu_strtou64(const char *nptr, const char **endp=
tr, int base,
>                    uint64_t *result);
>  int qemu_strtod(const char *nptr, const char **endptr, double *result);
>  int qemu_strtod_finite(const char *nptr, const char **endptr, double *re=
sult);
> +int qemu_strtold(const char *nptr, const char **endptr, long double *res=
ult);
> +int qemu_strtold_finite(const char *nptr, const char **endptr,
> +                        long double *result);
> =20
>  int parse_uint(const char *s, unsigned long long *value, char **endptr,
>                 int base);
> diff --git a/util/cutils.c b/util/cutils.c
> index fd591cadf0..5db3b2add5 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -553,7 +553,7 @@ int qemu_strtou64(const char *nptr, const char **endp=
tr, int base,
> =20
>  /**
>   * Convert string @nptr to a double.
> -  *
> + *
>   * This is a wrapper around strtod() that is harder to misuse.
>   * Semantics of @nptr and @endptr match strtod() with differences
>   * noted below.
> @@ -616,6 +616,52 @@ int qemu_strtod_finite(const char *nptr, const char =
**endptr, double *result)
>      return ret;
>  }
> =20
> +/*
> + * Convert string @nptr to a long double.
> + *
> + * Works like qemu_strtod(), except it stores long double.

"except it stores long double" feels redundant.

In similar comments elsewhere in this file, we spell out the different
overflow behavior.  Let's do the same here, and replace the redundant
part by "except it stores +/-HUGE_VALL on overflow".

> + */
> +int qemu_strtold(const char *nptr, const char **endptr, long double *res=
ult)
> +{
> +    char *ep;
> +
> +    if (!nptr) {
> +        if (endptr) {
> +            *endptr =3D nptr;
> +        }
> +        return -EINVAL;
> +    }
> +
> +    errno =3D 0;
> +    *result =3D strtold(nptr, &ep);
> +    return check_strtox_error(nptr, ep, endptr, errno);
> +}
> +
> +/*
> + * Convert string @nptr to a finite long double.
> + *
> + * Works like qemu_strtod_finite(), except it stores long double.
> + */

Likewise.

> +int qemu_strtold_finite(const char *nptr, const char **endptr,
> +                        long double *result)
> +{
> +    long double tmp;
> +    int ret;
> +
> +    ret =3D qemu_strtold(nptr, endptr, &tmp);
> +    if (!ret && !isfinite(tmp)) {
> +        if (endptr) {
> +            *endptr =3D nptr;
> +        }
> +        ret =3D -EINVAL;
> +    }
> +
> +    if (ret !=3D -EINVAL) {
> +        *result =3D tmp;
> +    }
> +    return ret;
> +}
> +
>  /**
>   * Searches for the first occurrence of 'c' in 's', and returns a pointe=
r
>   * to the trailing null byte if none was found.

Preferably with the comments tweaked:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


