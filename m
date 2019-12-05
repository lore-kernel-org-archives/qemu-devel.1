Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997BFC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB46206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaiGn9/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB46206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictVg-0002rj-I1
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ict43-0000ct-SB
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ict41-0003qq-U5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:29:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ict41-0003mu-OA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575559748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6lcRgrMG9IZH+Jw6X0m5TMTB1LKRh7Al0OENKxLJSs=;
 b=YaiGn9/agWibcpt6zu6C0l/4BaKlGXMMyX7taX5UyqVcyBhivjNFY1tT5stfY/Sr/0VJ8E
 2F047OiBptAKVFkP3AtitJCR+0mhvZs5ezCBickecR8bOw+ONG0CcyRcQQnY09wxbxI2CK
 VupJ1P9O3o08vesuoi44LgoOK6DjsmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-TQgvyYjEMeW_8qeFW_SfKQ-1; Thu, 05 Dec 2019 10:29:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A949A18A6EE9;
 Thu,  5 Dec 2019 15:29:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5A5C5DA60;
 Thu,  5 Dec 2019 15:29:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7116A1138606; Thu,  5 Dec 2019 16:29:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
References: <20191205021459.29920-1-tao3.xu@intel.com>
Date: Thu, 05 Dec 2019 16:29:02 +0100
In-Reply-To: <20191205021459.29920-1-tao3.xu@intel.com> (Tao Xu's message of
 "Thu, 5 Dec 2019 10:14:59 +0800")
Message-ID: <87a786sse9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: TQgvyYjEMeW_8qeFW_SfKQ-1
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> Parse input string both as a double and as a uint64_t, then use the
> method which consumes more characters. Update the related test cases.
>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
[...]
> diff --git a/util/cutils.c b/util/cutils.c
> index 77acadc70a..b08058c57c 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -212,24 +212,43 @@ static int do_strtosz(const char *nptr, const char =
**end,
>                        const char default_suffix, int64_t unit,
>                        uint64_t *result)
>  {
> -    int retval;
> -    const char *endptr;
> +    int retval, retd, retu;
> +    const char *suffix, *suffixd, *suffixu;
>      unsigned char c;
>      int mul_required =3D 0;
> -    double val, mul, integral, fraction;
> +    bool use_strtod;
> +    uint64_t valu;
> +    double vald, mul, integral, fraction;

Note for later: @mul is double.

> +
> +    retd =3D qemu_strtod_finite(nptr, &suffixd, &vald);
> +    retu =3D qemu_strtou64(nptr, &suffixu, 0, &valu);
> +    use_strtod =3D strlen(suffixd) < strlen(suffixu);
> +
> +    /*
> +     * Parse @nptr both as a double and as a uint64_t, then use the meth=
od
> +     * which consumes more characters.
> +     */

The comment is in a funny place.  I'd put it right before the
qemu_strtod_finite() line.

> +    if (use_strtod) {
> +        suffix =3D suffixd;
> +        retval =3D retd;
> +    } else {
> +        suffix =3D suffixu;
> +        retval =3D retu;
> +    }
> =20
> -    retval =3D qemu_strtod_finite(nptr, &endptr, &val);
>      if (retval) {
>          goto out;
>      }

This is even more subtle than it looks.

A close reading of the function contracts leads to three cases for each
conversion:

* parse error (including infinity and NaN)

  @retu / @retd is -EINVAL
  @valu / @vald is uninitialized
  @suffixu / @suffixd is @nptr

* range error

  @retu / @retd is -ERANGE
  @valu / @vald is our best approximation of the conversion result
  @suffixu / @suffixd points to the first character not consumed by the
  conversion.

  Sub-cases:

  - uint64_t overflow

    We know the conversion result exceeds UINT64_MAX.

  - double overflow

    we know the conversion result's magnitude exceeds the largest
    representable finite double DBL_MAX.

  - double underflow

    we know the conversion result is close to zero (closer than DBL_MIN,
    the smallest normalized positive double).

* success

  @retu / @retd is 0
  @valu / @vald is the conversion result
  @suffixu / @suffixd points to the first character not consumed by the
  conversion.

This leads to a matrix (parse error, uint64_t overflow, success) x
(parse error, double overflow, double underflow, success).  We need to
check the code does what we want for each element of this matrix, and
document any behavior that's not perfectly obvious.

(success, success): we pick uint64_t if qemu_strtou64() consumed more
characters than qemu_strtod_finite(), else double.  "More" is important
here; when they consume the same characters, we *need* to use the
uint64_t result.  Example: for "18446744073709551615", we need to use
uint64_t 18446744073709551615, not double 18446744073709551616.0.  But
for "18446744073709551616.", we need to use the double.  Good.

(success, parse error) and (parse error, success): we pick the one that
succeeds, because success consumes characters, and failure to parse does
not.  Good.

(parse error, parse error): neither consumes characters, so we pick
uint64_t.  Good.

(parse error, double overflow), (parse error, double underflow) and
(uint64_t overflow, parse error): we pick the range error, because it
consumes characters.  Good.

These are the simple combinations.  The remainder are hairier: (success,
double overflow), (success, double underflow), (uint64_t overflow,
success).  I lack the time to analyze them today.  Must be done before
we take this patch.  Any takers?

> -    fraction =3D modf(val, &integral);
> -    if (fraction !=3D 0) {
> -        mul_required =3D 1;
> +    if (use_strtod) {
> +        fraction =3D modf(vald, &integral);
> +        if (fraction !=3D 0) {
> +            mul_required =3D 1;
> +        }
>      }

Here, @suffix points to the suffix character, if any.

> -    c =3D *endptr;
> +    c =3D *suffix;
>      mul =3D suffix_mul(c, unit);
>      if (mul >=3D 0) {
> -        endptr++;
> +        suffix++;

Now @suffix points to the first character not consumed, *not* the
suffix.

Your patch effectively renames @endptr to @suffix.  I think @endptr is
the better name.  Keeping the name also makes the diff smaller and
slightly easier to review.

>      } else {
>          mul =3D suffix_mul(default_suffix, unit);

suffix_mul() returns int64_t.  The assignment converts it to double.
Fine before the patch, because @mul is the multiplier for a double
value.  No longer true after the patch, see below.

>          assert(mul >=3D 0);
> @@ -238,23 +257,36 @@ static int do_strtosz(const char *nptr, const char =
**end,
>          retval =3D -EINVAL;
>          goto out;
>      }
> -    /*
> -     * Values near UINT64_MAX overflow to 2**64 when converting to doubl=
e
> -     * precision.  Compare against the maximum representable double prec=
ision
> -     * value below 2**64, computed as "the next value after 2**64 (0x1p6=
4) in
> -     * the direction of 0".
> -     */
> -    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
> -        retval =3D -ERANGE;
> -        goto out;
> +
> +    if (use_strtod) {
> +        /*
> +         * Values near UINT64_MAX overflow to 2**64 when converting to d=
ouble
> +         * precision. Compare against the maximum representable double p=
recision
> +         * value below 2**64, computed as "the next value after 2**64 (0=
x1p64)
> +         * in the direction of 0".
> +         */
> +        if ((vald * mul > nextafter(0x1p64, 0)) || vald < 0) {
> +            retval =3D -ERANGE;
> +            goto out;
> +        }
> +        *result =3D vald * mul;

Here, @mul is a multiplier for double vald.

> +    } else {
> +        /* Reject negative input and overflow output */
> +        while (qemu_isspace(*nptr)) {
> +            nptr++;
> +        }
> +        if (*nptr =3D=3D '-' || UINT64_MAX / (uint64_t) mul < valu) {
> +            retval =3D -ERANGE;
> +            goto out;
> +        }
> +        *result =3D valu * (uint64_t) mul;

Here, @mul is a multiplier for uint64_t valu.

Please change @mul to int64_t to reduce conversions.

>      }
> -    *result =3D val * mul;
>      retval =3D 0;
> =20
>  out:
>      if (end) {
> -        *end =3D endptr;
> -    } else if (*endptr) {
> +        *end =3D suffix;
> +    } else if (*suffix) {
>          retval =3D -EINVAL;
>      }


