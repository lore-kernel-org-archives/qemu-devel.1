Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F4C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359EB20716
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzBOj6eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359EB20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihA3i-0007tt-CD
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 05:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihA34-0007Tf-5Y
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihA30-0006hr-SW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:25:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22088
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihA30-0006f9-4m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576578345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpEEspXTfhvuqd/JM76Z3jQ5wplc4fS/KP6yqEZkFOw=;
 b=fzBOj6eQDrwi+Piti4L9bbpZDAK9K25yD0KjSD1S4s400kkG3ubb6ywSf3Ydc0pEqO/qyV
 HpMokVPcDRGuWCxXfh2blCnjaivFLzg3eSwZorC7ndggrwSPYQIQ/Bk6Og9a9mFsa4Udu4
 4j7Y9KveNb6KBP2DRl3P4OmdlswINGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-bbq2dfDJPh684Cm5cUiD6A-1; Tue, 17 Dec 2019 05:25:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A9DF593A1;
 Tue, 17 Dec 2019 10:25:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 990B860C63;
 Tue, 17 Dec 2019 10:25:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2548311386A7; Tue, 17 Dec 2019 11:25:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
 <b7c442e3-cc7e-155e-5370-db9a371928a6@intel.com>
Date: Tue, 17 Dec 2019 11:25:39 +0100
In-Reply-To: <b7c442e3-cc7e-155e-5370-db9a371928a6@intel.com> (Tao Xu's
 message of "Mon, 9 Dec 2019 13:38:39 +0800")
Message-ID: <87y2vbgsf0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bbq2dfDJPh684Cm5cUiD6A-1
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> On 12/5/19 11:29 PM, Markus Armbruster wrote:
>> Tao Xu <tao3.xu@intel.com> writes:
>>
>>> Parse input string both as a double and as a uint64_t, then use the
>>> method which consumes more characters. Update the related test cases.
>>>
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>> ---
>> [...]
>>> diff --git a/util/cutils.c b/util/cutils.c
>>> index 77acadc70a..b08058c57c 100644
>>> --- a/util/cutils.c
>>> +++ b/util/cutils.c
>>> @@ -212,24 +212,43 @@ static int do_strtosz(const char *nptr, const cha=
r **end,
>>>                         const char default_suffix, int64_t unit,
>>>                         uint64_t *result)
>>>   {
>>> -    int retval;
>>> -    const char *endptr;
>>> +    int retval, retd, retu;
>>> +    const char *suffix, *suffixd, *suffixu;
>>>       unsigned char c;
>>>       int mul_required =3D 0;
>>> -    double val, mul, integral, fraction;
>>> +    bool use_strtod;
>>> +    uint64_t valu;
>>> +    double vald, mul, integral, fraction;
>>
>> Note for later: @mul is double.
>>
>>> +
>>> +    retd =3D qemu_strtod_finite(nptr, &suffixd, &vald);
>>> +    retu =3D qemu_strtou64(nptr, &suffixu, 0, &valu);

Note for later: passing 0 to base accepts octal and hexadecimal
integers.

>>> +    use_strtod =3D strlen(suffixd) < strlen(suffixu);
>>> +
>>> +    /*
>>> +     * Parse @nptr both as a double and as a uint64_t, then use the me=
thod
>>> +     * which consumes more characters.
>>> +     */
>>
>> The comment is in a funny place.  I'd put it right before the
>> qemu_strtod_finite() line.
>>
>>> +    if (use_strtod) {
>>> +        suffix =3D suffixd;
>>> +        retval =3D retd;
>>> +    } else {
>>> +        suffix =3D suffixu;
>>> +        retval =3D retu;
>>> +    }
>>>   -    retval =3D qemu_strtod_finite(nptr, &endptr, &val);
>>>       if (retval) {
>>>           goto out;
>>>       }
>>
>> This is even more subtle than it looks.
>>
>> A close reading of the function contracts leads to three cases for each
>> conversion:
>>
>> * parse error (including infinity and NaN)
>>
>>    @retu / @retd is -EINVAL
>>    @valu / @vald is uninitialized
>>    @suffixu / @suffixd is @nptr
>>
>> * range error
>>
>>    @retu / @retd is -ERANGE
>>    @valu / @vald is our best approximation of the conversion result
>>    @suffixu / @suffixd points to the first character not consumed by the
>>    conversion.
>>
>>    Sub-cases:
>>
>>    - uint64_t overflow
>>
>>      We know the conversion result exceeds UINT64_MAX.
>>
>>    - double overflow
>>
>>      we know the conversion result's magnitude exceeds the largest
>>      representable finite double DBL_MAX.
>>
>>    - double underflow
>>
>>      we know the conversion result is close to zero (closer than DBL_MIN=
,
>>      the smallest normalized positive double).
>>
>> * success
>>
>>    @retu / @retd is 0
>>    @valu / @vald is the conversion result
>>    @suffixu / @suffixd points to the first character not consumed by the
>>    conversion.
>>
>> This leads to a matrix (parse error, uint64_t overflow, success) x
>> (parse error, double overflow, double underflow, success).  We need to
>> check the code does what we want for each element of this matrix, and
>> document any behavior that's not perfectly obvious.
>>
>> (success, success): we pick uint64_t if qemu_strtou64() consumed more
>> characters than qemu_strtod_finite(), else double.  "More" is important
>> here; when they consume the same characters, we *need* to use the
>> uint64_t result.  Example: for "18446744073709551615", we need to use
>> uint64_t 18446744073709551615, not double 18446744073709551616.0.  But
>> for "18446744073709551616.", we need to use the double.  Good.

Also fun: for "0123", we use uint64_t 83, not double 123.0.  But for
"0123.", we use 123.0, not 83.

Do we really want to accept octal and hexadecimal integers?

>> (success, parse error) and (parse error, success): we pick the one that
>> succeeds, because success consumes characters, and failure to parse does
>> not.  Good.
>>
>> (parse error, parse error): neither consumes characters, so we pick
>> uint64_t.  Good.
>>
>> (parse error, double overflow), (parse error, double underflow) and
>> (uint64_t overflow, parse error): we pick the range error, because it
>> consumes characters.  Good.
>>
>> These are the simple combinations.  The remainder are hairier: (success,
>> double overflow), (success, double underflow), (uint64_t overflow,
>> success).  I lack the time to analyze them today.  Must be done before
>> we take this patch.  Any takers?
>
> (success, double overflow), (success, double underflow), pick double
> overflow error, return -ERANGE. Because it consumes
> characters. Example: for "1.79769e+309", qemu_strtou64 consumes "1",
> and prases as uint64_t; but qemu_strtod_finite return -ERANGE and
> consumes all characters. It is OK.

The only way to have double overflow when uint64_t succeeds is an
exponent.  Double consumes the characters making up the exponent,
uint64_t does not.  We use double.

The only way to have double underflow is with an exponent or a decimal
point.  Double consumes their characters, uint64_t does not.  We use
double.

Okay.

> (uint64_t overflow, success), consume the same characters, use the
> uint64_t return -ERANGE. Note that even if qemu_strtod_finite can
> parse these cases such as "18446744073709551617", but the result is
> uint64_t so we also need to return -ERANGE. It is OK.

That's just one of two cases, I think.  The other one is when the
overflowing integer is followed by an exponent or decimal point.  We use
double then.  Converting the double to uint64_t overflows, except when a
negative exponent brings the number into range.

Examples: "18446744073709551617" picks uint64_t overflow,
"18446744073709551617.0" picks double success (but converting it to
uint64_t below overflows), and "18446744073709551617e-10" picks double
success (converted to 1844674407 below).

Okay.

> Thank you for your analysis and suggestion. I will add more test cases
> to cover some of these analysis.

Good move.


