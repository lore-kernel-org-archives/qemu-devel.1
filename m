Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA08FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA012207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYvp1Mte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA012207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN5A3-0003N1-Tc
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 21:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iN58x-0002Va-6i
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iN58v-0004co-Uj
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:08:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iN58v-0004be-QS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571792932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lw9zFY7qZn8lxXQHzGD/hwrcIV6kCpFMey6AAOakrkU=;
 b=iYvp1MteRwMlALVIdHREzh1zpKJN6xkJyYPf4rRWe1KRHt74mJo7N9tjfigPmz4y+372KQ
 T/89B5G/5NmEaHD6FgKg37Y+fb/gnsK/CgLgyC6EhPygnsaq3BYrPvDWiieU6+lW9X5xPP
 tvkxPyMVh39qWCZgvPlq35BX2pTQ8RA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-YastOYnvM5mSYdyLvWzu2w-1; Tue, 22 Oct 2019 21:08:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24D39800D49;
 Wed, 23 Oct 2019 01:08:49 +0000 (UTC)
Received: from localhost (ovpn-116-104.gru2.redhat.com [10.97.116.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB4119C70;
 Wed, 23 Oct 2019 01:08:48 +0000 (UTC)
Date: Tue, 22 Oct 2019 22:08:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v13 01/12] util/cutils: Add qemu_strtotime_ps()
Message-ID: <20191023010846.GH4084@habkost.net>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-2-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191020111125.27659-2-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YastOYnvM5mSYdyLvWzu2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: jingqi.liu@intel.com, fan.du@intel.com, qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

First of all, sorry for not reviewing this earlier.  I thought
other people were already looking at the first 4 patches.

On Sun, Oct 20, 2019 at 07:11:14PM +0800, Tao Xu wrote:
> To convert strings with time suffixes to numbers, support time unit are
> "ps" for picosecond, "ns" for nanosecond, "us" for microsecond, "ms"
> for millisecond or "s" for second.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> No changes in v13.
> ---
>  include/qemu/cutils.h |  1 +
>  util/cutils.c         | 82 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>=20
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index b54c847e0f..7b6d106bdd 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -182,5 +182,6 @@ int uleb128_decode_small(const uint8_t *in, uint32_t =
*n);
>   * *str1 is <, =3D=3D or > than *str2.
>   */
>  int qemu_pstrcmp0(const char **str1, const char **str2);
> +int qemu_strtotime_ps(const char *nptr, const char **end, uint64_t *resu=
lt);
> =20
>  #endif
> diff --git a/util/cutils.c b/util/cutils.c
> index fd591cadf0..a50c15f46a 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -847,3 +847,85 @@ int qemu_pstrcmp0(const char **str1, const char **st=
r2)
>  {
>      return g_strcmp0(*str1, *str2);
>  }
> +
> +static int64_t timeunit_mul(const char *unitstr)
> +{
> +    if (g_strcmp0(unitstr, "ps") =3D=3D 0) {
> +        return 1;

This makes do_strtotime("123ps,...", &end, ...) fail because of
trailing data.

> +    } else if (g_strcmp0(unitstr, "ns") =3D=3D 0) {
> +        return 1000;
> +    } else if (g_strcmp0(unitstr, "us") =3D=3D 0) {
> +        return 1000000;
> +    } else if (g_strcmp0(unitstr, "ms") =3D=3D 0) {
> +        return 1000000000LL;
> +    } else if (g_strcmp0(unitstr, "s") =3D=3D 0) {
> +        return 1000000000000LL;

Same as above, for the other suffixes.

> +    } else {
> +        return -1;

But this makes do_strtotime("123,...", &end, ...) work as
expected.

This is inconsistent.  I see that you are not testing non-NULL
`end` argument at test_qemu_strtotime_ps_trailing(), so that's
probably why this issue wasn't detected.

> +    }
> +}
> +
> +
> +/*
> + * Convert string to time, support time unit are ps for picosecond,
> + * ns for nanosecond, us for microsecond, ms for millisecond or s for se=
cond.
> + * End pointer will be returned in *end, if not NULL. Return -ERANGE on
> + * overflow, and -EINVAL on other error.
> + */
> +static int do_strtotime(const char *nptr, const char **end,
> +                      const char *default_unit, uint64_t *result)
> +{
> +    int retval;
> +    const char *endptr;
> +    int mul_required =3D 0;
> +    int64_t mul;
> +    double val, integral, fraction;
> +
> +    retval =3D qemu_strtod_finite(nptr, &endptr, &val);
> +    if (retval) {
> +        goto out;
> +    }
> +    fraction =3D modf(val, &integral);
> +    if (fraction !=3D 0) {
> +        mul_required =3D 1;
> +    }
> +
> +    mul =3D timeunit_mul(endptr);
> +
> +    if (mul =3D=3D 1000000000000LL) {
> +        endptr++;
> +    } else if (mul !=3D -1) {
> +        endptr +=3D 2;

This is fragile.  It can break very easily if additional
one-letter suffixes are added to timeunit_mul() in the future.

One option to make this safer is to make timeunit_mul() get a
pointer to endptr.


> +    } else {
> +        mul =3D timeunit_mul(default_unit);
> +        assert(mul >=3D 0);
> +    }
> +    if (mul =3D=3D 1 && mul_required) {
> +        retval =3D -EINVAL;
> +        goto out;
> +    }
> +    /*
> +     * Values >=3D 0xfffffffffffffc00 overflow uint64_t after their trip
> +     * through double (53 bits of precision).
> +     */
> +    if ((val * (double)mul >=3D 0xfffffffffffffc00) || val < 0) {
> +        retval =3D -ERANGE;
> +        goto out;
> +    }
> +    *result =3D val * (double)mul;
> +    retval =3D 0;
> +
> +out:
> +    if (end) {
> +        *end =3D endptr;

This indicates that having trailing data after the string is OK
if `end` is not NULL, but timeunit_mul() doesn't take that into
account.

Considering that this function is just a copy of do_strtosz(), I
suggest making do_strtosz() and suffix_mul() get a
suffix/multiplier table as input, instead of duplicating the
code.


> +    } else if (*endptr) {
> +        retval =3D -EINVAL;
> +    }
> +
> +    return retval;
> +}
> +
> +int qemu_strtotime_ps(const char *nptr, const char **end, uint64_t *resu=
lt)
> +{
> +    return do_strtotime(nptr, end, "ps", result);
> +}
> --=20
> 2.20.1
>=20

--=20
Eduardo


