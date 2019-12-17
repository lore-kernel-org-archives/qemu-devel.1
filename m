Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A77DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD452207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtTjCsqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD452207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihBbb-0002bx-3E
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 07:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ihBaY-00027J-JC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ihBaW-0000M7-Gq
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:04:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31031
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ihBaW-0000J5-Cg
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576584267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7SbSCKV9dl/jpvBY0yOX1eEJGNy7lThtDnwXnGs39g=;
 b=MtTjCsqJwjQTeWNFIAe6iVr8A9tRIgDSjswkGsgkAG33wnHZrq2ov5rqRuuWKv/hR9Gyru
 xIi+oNM1F+myGYEpf6WLdqAcTzqC6MIL6+6uS9ESsng7dhNF7Uz4e0rSgd/BHhzrCD+8F6
 HZllxz71Kpepq6F+R95/zy2k/MZGHfU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-DStZX7ZSOTuJyOjwj64cKg-1; Tue, 17 Dec 2019 07:04:25 -0500
Received: by mail-wr1-f72.google.com with SMTP id j13so5248592wrr.20
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 04:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=OWae+cuybe3ezTnE36cWgw6y1DmbqygsrVlTmtr37NQ=;
 b=X69CELy4fevrCbBD60+I+wQFpUYCuWbzd9S71TA05h/1/G8KkRs7Hsce9qES4fGKHg
 AVy6OALB7wJlPEvgvse+coK0kgNjfllv8wBOn9nXD48P9jF1UmEY4c9V51tvtt4qLpXK
 gVBXLu0BKjrRaalG3HjrA8Kv1cvNuZ1xPAldJqLdFzIK63Ay1YoHQJwImXgsHEopfJ58
 0zpNkQxyMmN8WFI94FORKu09rIRvBgm6VLx+FzyU+oMqbB4eCdga0aYEX9sNKNuyncPK
 6MJF1CYwDpXWXJjqi40HqglXX7wsxir2F7EMBDKWz7eTpGfaFOBoWqT3SSAzpAdoirAl
 Cqdg==
X-Gm-Message-State: APjAAAV3r+O5Z5Ubq0vERYjnnJ343AoS3g+7PKTs9qOXUwqopEFGTZCm
 eKWO1E/KtD5Yk/FhyR9556CzZHovyGJQIdLyXCXNmpdNxpHOuyNGMPnTa5uUfYoniVrWbeR8Gk1
 fwSqn4WbDWJ9gUtA=
X-Received: by 2002:a1c:1b41:: with SMTP id b62mr4931949wmb.53.1576584264470; 
 Tue, 17 Dec 2019 04:04:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwizPkyetWkCdTFH8pjO9VGTDdR7HinPrMUp7OnnyY7HqISID4j8cJAo8CuMrCFdv+jlrHTLg==
X-Received: by 2002:a1c:1b41:: with SMTP id b62mr4931915wmb.53.1576584264129; 
 Tue, 17 Dec 2019 04:04:24 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:1c42:ed63:2256:4add?
 ([2a01:e0a:466:71c0:1c42:ed63:2256:4add])
 by smtp.gmail.com with ESMTPSA id b15sm2726657wmj.13.2019.12.17.04.04.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 04:04:23 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <87a786sse9.fsf@dusky.pond.sub.org>
Date: Tue, 17 Dec 2019 13:04:22 +0100
Message-Id: <64E0F779-B750-4766-9978-58A8B4737839@redhat.com>
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: DStZX7ZSOTuJyOjwj64cKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
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
Cc: Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org, ehabkost@redhat.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 5 Dec 2019, at 16:29, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Tao Xu <tao3.xu@intel.com> writes:
>=20
>> Parse input string both as a double and as a uint64_t, then use the
>> method which consumes more characters. Update the related test cases.
>>=20
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
> [...]
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 77acadc70a..b08058c57c 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -212,24 +212,43 @@ static int do_strtosz(const char *nptr, const char=
 **end,
>>                       const char default_suffix, int64_t unit,
>>                       uint64_t *result)
>> {
>> -    int retval;
>> -    const char *endptr;
>> +    int retval, retd, retu;
>> +    const char *suffix, *suffixd, *suffixu;
>>     unsigned char c;
>>     int mul_required =3D 0;
>> -    double val, mul, integral, fraction;
>> +    bool use_strtod;
>> +    uint64_t valu;
>> +    double vald, mul, integral, fraction;
>=20
> Note for later: @mul is double.
>=20
>> +
>> +    retd =3D qemu_strtod_finite(nptr, &suffixd, &vald);
>> +    retu =3D qemu_strtou64(nptr, &suffixu, 0, &valu);
>> +    use_strtod =3D strlen(suffixd) < strlen(suffixu);
>> +
>> +    /*
>> +     * Parse @nptr both as a double and as a uint64_t, then use the met=
hod
>> +     * which consumes more characters.
>> +     */
>=20
> The comment is in a funny place.  I'd put it right before the
> qemu_strtod_finite() line.
>=20
>> +    if (use_strtod) {
>> +        suffix =3D suffixd;
>> +        retval =3D retd;
>> +    } else {
>> +        suffix =3D suffixu;
>> +        retval =3D retu;
>> +    }
>>=20
>> -    retval =3D qemu_strtod_finite(nptr, &endptr, &val);
>>     if (retval) {
>>         goto out;
>>     }
>=20
> This is even more subtle than it looks.

But why it is even necessary?

The =E2=80=9Ccontract=E2=80=9D for the function used to be that it returned=
 rounded values
beyond 2^53, which in itself is curious.

But now it=E2=80=99s a 6-dimensional matrix of hell with NaNs and barfnots,=
 when the
name implies it=E2=80=99s simply doing a text to u64 conversion=E2=80=A6

There is certainly a reason, but I=E2=80=99m really curious what it is :-)

>=20
> A close reading of the function contracts leads to three cases for each
> conversion:
>=20
> * parse error (including infinity and NaN)
>=20
>  @retu / @retd is -EINVAL
>  @valu / @vald is uninitialized
>  @suffixu / @suffixd is @nptr
>=20
> * range error
>=20
>  @retu / @retd is -ERANGE
>  @valu / @vald is our best approximation of the conversion result
>  @suffixu / @suffixd points to the first character not consumed by the
>  conversion.
>=20
>  Sub-cases:
>=20
>  - uint64_t overflow
>=20
>    We know the conversion result exceeds UINT64_MAX.
>=20
>  - double overflow
>=20
>    we know the conversion result's magnitude exceeds the largest
>    representable finite double DBL_MAX.
>=20
>  - double underflow
>=20
>    we know the conversion result is close to zero (closer than DBL_MIN,
>    the smallest normalized positive double).
>=20
> * success
>=20
>  @retu / @retd is 0
>  @valu / @vald is the conversion result
>  @suffixu / @suffixd points to the first character not consumed by the
>  conversion.
>=20
> This leads to a matrix (parse error, uint64_t overflow, success) x
> (parse error, double overflow, double underflow, success).  We need to
> check the code does what we want for each element of this matrix, and
> document any behavior that's not perfectly obvious.
>=20
> (success, success): we pick uint64_t if qemu_strtou64() consumed more
> characters than qemu_strtod_finite(), else double.  "More" is important
> here; when they consume the same characters, we *need* to use the
> uint64_t result.  Example: for "18446744073709551615", we need to use
> uint64_t 18446744073709551615, not double 18446744073709551616.0.  But
> for "18446744073709551616.", we need to use the double.  Good.
>=20
> (success, parse error) and (parse error, success): we pick the one that
> succeeds, because success consumes characters, and failure to parse does
> not.  Good.
>=20
> (parse error, parse error): neither consumes characters, so we pick
> uint64_t.  Good.
>=20
> (parse error, double overflow), (parse error, double underflow) and
> (uint64_t overflow, parse error): we pick the range error, because it
> consumes characters.  Good.
>=20
> These are the simple combinations.  The remainder are hairier: (success,
> double overflow), (success, double underflow), (uint64_t overflow,
> success).  I lack the time to analyze them today.  Must be done before
> we take this patch.  Any takers?
>=20
>> -    fraction =3D modf(val, &integral);
>> -    if (fraction !=3D 0) {
>> -        mul_required =3D 1;
>> +    if (use_strtod) {
>> +        fraction =3D modf(vald, &integral);
>> +        if (fraction !=3D 0) {
>> +            mul_required =3D 1;
>> +        }
>>     }
>=20
> Here, @suffix points to the suffix character, if any.
>=20
>> -    c =3D *endptr;
>> +    c =3D *suffix;
>>     mul =3D suffix_mul(c, unit);
>>     if (mul >=3D 0) {
>> -        endptr++;
>> +        suffix++;
>=20
> Now @suffix points to the first character not consumed, *not* the
> suffix.
>=20
> Your patch effectively renames @endptr to @suffix.  I think @endptr is
> the better name.  Keeping the name also makes the diff smaller and
> slightly easier to review.
>=20
>>     } else {
>>         mul =3D suffix_mul(default_suffix, unit);
>=20
> suffix_mul() returns int64_t.  The assignment converts it to double.
> Fine before the patch, because @mul is the multiplier for a double
> value.  No longer true after the patch, see below.
>=20
>>         assert(mul >=3D 0);
>> @@ -238,23 +257,36 @@ static int do_strtosz(const char *nptr, const char=
 **end,
>>         retval =3D -EINVAL;
>>         goto out;
>>     }
>> -    /*
>> -     * Values near UINT64_MAX overflow to 2**64 when converting to doub=
le
>> -     * precision.  Compare against the maximum representable double pre=
cision
>> -     * value below 2**64, computed as "the next value after 2**64 (0x1p=
64) in
>> -     * the direction of 0".
>> -     */
>> -    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
>> -        retval =3D -ERANGE;
>> -        goto out;
>> +
>> +    if (use_strtod) {
>> +        /*
>> +         * Values near UINT64_MAX overflow to 2**64 when converting to =
double
>> +         * precision. Compare against the maximum representable double =
precision
>> +         * value below 2**64, computed as "the next value after 2**64 (=
0x1p64)
>> +         * in the direction of 0".
>> +         */
>> +        if ((vald * mul > nextafter(0x1p64, 0)) || vald < 0) {
>> +            retval =3D -ERANGE;
>> +            goto out;
>> +        }
>> +        *result =3D vald * mul;
>=20
> Here, @mul is a multiplier for double vald.
>=20
>> +    } else {
>> +        /* Reject negative input and overflow output */
>> +        while (qemu_isspace(*nptr)) {
>> +            nptr++;
>> +        }
>> +        if (*nptr =3D=3D '-' || UINT64_MAX / (uint64_t) mul < valu) {
>> +            retval =3D -ERANGE;
>> +            goto out;
>> +        }
>> +        *result =3D valu * (uint64_t) mul;
>=20
> Here, @mul is a multiplier for uint64_t valu.
>=20
> Please change @mul to int64_t to reduce conversions.
>=20
>>     }
>> -    *result =3D val * mul;
>>     retval =3D 0;
>>=20
>> out:
>>     if (end) {
>> -        *end =3D endptr;
>> -    } else if (*endptr) {
>> +        *end =3D suffix;
>> +    } else if (*suffix) {
>>         retval =3D -EINVAL;
>>     }
>=20
>=20


