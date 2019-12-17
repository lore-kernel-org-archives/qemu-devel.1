Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00786C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFAB218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4AjWl8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFAB218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEO0-0001kb-OZ
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihELZ-0007ce-8K
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihELW-0006r0-Rr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:01:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26353
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihELW-0006pV-NI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576594870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOwBejLCeSUgHXihBeTfe0QrhEs74h6f6T8/EnZmf3U=;
 b=R4AjWl8V2VprGafBh7GGfdZdGQxHRZk5jMfjd+MaHYPBmK3ssvC56W0leJZRrM7Uk6gHIE
 OaLIB3VZ6n3xWKEqn62AyMPIjs2ZD29nzvrDmG+5mDp6oSh0ww6EVegsZPoSxHwm3EB7h8
 8FIzjCvl5zp8C2S39b+2TW98eRL3Eaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-qW62obU4OqyxlSwBQ_fyCA-1; Tue, 17 Dec 2019 10:01:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 076771093820;
 Tue, 17 Dec 2019 15:01:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E8F760BE0;
 Tue, 17 Dec 2019 15:01:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D88811386A7; Tue, 17 Dec 2019 16:01:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
 <64E0F779-B750-4766-9978-58A8B4737839@redhat.com>
 <87v9qfcae1.fsf@dusky.pond.sub.org>
 <50B6643C-78A7-4724-8A0B-3D51B1898FFE@redhat.com>
Date: Tue, 17 Dec 2019 16:01:05 +0100
In-Reply-To: <50B6643C-78A7-4724-8A0B-3D51B1898FFE@redhat.com> (Christophe de
 Dinechin's message of "Tue, 17 Dec 2019 15:12:52 +0100")
Message-ID: <87o8w7ate6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qW62obU4OqyxlSwBQ_fyCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Tao Xu <tao3.xu@intel.com>, mdroth@linux.vnet.ibm.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christophe de Dinechin <dinechin@redhat.com> writes:

>> On 17 Dec 2019, at 15:08, Markus Armbruster <armbru@redhat.com> wrote:
>>=20
>> Christophe de Dinechin <dinechin@redhat.com> writes:
>>=20
>>>> On 5 Dec 2019, at 16:29, Markus Armbruster <armbru@redhat.com> wrote:
>>>>=20
>>>> Tao Xu <tao3.xu@intel.com> writes:
>>>>=20
>>>>> Parse input string both as a double and as a uint64_t, then use the
>>>>> method which consumes more characters. Update the related test cases.
>>>>>=20
>>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>>> ---
>>>> [...]
>>>>> diff --git a/util/cutils.c b/util/cutils.c
>>>>> index 77acadc70a..b08058c57c 100644
>>>>> --- a/util/cutils.c
>>>>> +++ b/util/cutils.c
>>>>> @@ -212,24 +212,43 @@ static int do_strtosz(const char *nptr, const c=
har **end,
>>>>>                      const char default_suffix, int64_t unit,
>>>>>                      uint64_t *result)
>>>>> {
>>>>> -    int retval;
>>>>> -    const char *endptr;
>>>>> +    int retval, retd, retu;
>>>>> +    const char *suffix, *suffixd, *suffixu;
>>>>>    unsigned char c;
>>>>>    int mul_required =3D 0;
>>>>> -    double val, mul, integral, fraction;
>>>>> +    bool use_strtod;
>>>>> +    uint64_t valu;
>>>>> +    double vald, mul, integral, fraction;
>>>>=20
>>>> Note for later: @mul is double.
>>>>=20
>>>>> +
>>>>> +    retd =3D qemu_strtod_finite(nptr, &suffixd, &vald);
>>>>> +    retu =3D qemu_strtou64(nptr, &suffixu, 0, &valu);
>>>>> +    use_strtod =3D strlen(suffixd) < strlen(suffixu);
>>>>> +
>>>>> +    /*
>>>>> +     * Parse @nptr both as a double and as a uint64_t, then use the =
method
>>>>> +     * which consumes more characters.
>>>>> +     */
>>>>=20
>>>> The comment is in a funny place.  I'd put it right before the
>>>> qemu_strtod_finite() line.
>>>>=20
>>>>> +    if (use_strtod) {
>>>>> +        suffix =3D suffixd;
>>>>> +        retval =3D retd;
>>>>> +    } else {
>>>>> +        suffix =3D suffixu;
>>>>> +        retval =3D retu;
>>>>> +    }
>>>>>=20
>>>>> -    retval =3D qemu_strtod_finite(nptr, &endptr, &val);
>>>>>    if (retval) {
>>>>>        goto out;
>>>>>    }
>>>>=20
>>>> This is even more subtle than it looks.
>>>=20
>>> But why it is even necessary?
>>>=20
>>> The =E2=80=9Ccontract=E2=80=9D for the function used to be that it retu=
rned rounded values
>>> beyond 2^53, which in itself is curious.
>>>=20
>>> But now it=E2=80=99s a 6-dimensional matrix of hell with NaNs and barfn=
ots, when the
>>> name implies it=E2=80=99s simply doing a text to u64 conversion=E2=80=
=A6
>>>=20
>>> There is certainly a reason, but I=E2=80=99m really curious what it is =
:-)
>>=20
>> It all goes back to commit 9f9b17a4f0 "Introduce strtosz() library
>> function to convert a string to a byte count.".  To support "convenient"
>> usage like "1.5G", it parses the number part with strtod().  This limits
>> us to 53 bits of precision.  Larger sizes get rounded.
>>=20
>> I guess the excuse for this was that when you're dealing with sizes that
>> large (petabytes!), your least significant bits are zero anyway.
>>=20
>> Regardless, the interface is *awful*.  We should've forced the author to
>> spell it out in all its glory in a proper function contract.  That tends
>> to cool the enthusiasm for "convenient" syntax amazingly fast.
>>=20
>> The awful interface has been confusing people for close to a decade now.
>>=20
>> What to do?
>
> I see. Thanks for the rationale. I knew it had to make sense :-)

For a value of "sense"...

> I=E2=80=99d probably avoid strtod even with the convenient syntax above.
> Do you want 1.33e-6M to be allowed? Do we want to ever
> accept or generate NaN or Inf values?

NaN or Inf definitely not.  That's why we use qemu_strtod_finite()
before and after the patch.

No sane person should ever use 1.33e-6M.  Or even 1.1k (which yields
1126, rounded silently from machine number 1126.4000000000001, which
approximates the true value 1126.4).

Certain fractions are actually sane.  1.5k denotes a perfectly fine
integer, which the code manages not to screw up.  I'd recommend against
using fractions regardless.

What usage are we prepared to break?  What kind of confusion are we
willing to bear?  Those are the questions.

>> Tao Xu's patch tries to make the function do what its users expect,
>> namely parse a bleepin' 64 bit integer, without breaking any of the
>> "convenience" syntax.  Turns out that's amazingly subtle.  Are we making
>> things less confusing or more?


