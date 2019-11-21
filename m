Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD33C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58775206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxiiFEJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58775206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnoL-0002XO-Cf
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXnne-000233-6z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXnnc-0002bK-Ez
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:51:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXnnc-0002b2-7F
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574347871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paLSyZxOfMio20kGhLQZQFPFJ9RlwqOzJ0E0TrMxmeo=;
 b=TxiiFEJCxFT9GVuWwEjdPmz52V3wKL2BVOU145WU7BYNHYQdy2hIy/ZC0bPTmwipdxcIbi
 aNJw6d1rt5MvVVffXcYO/JqVxOLfI1m9ZYt/q7t+aia+ZykCYmmLYP2QSUuljyZ7V8n2ub
 eSP+ahNKRdlXudCWMnRrFrXFgy11zBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-UYl5O1uaOpSTWuyxsk44XA-1; Thu, 21 Nov 2019 09:51:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D52B8018A3;
 Thu, 21 Nov 2019 14:51:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 004C660BDB;
 Thu, 21 Nov 2019 14:51:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7648B1138606; Thu, 21 Nov 2019 15:51:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] Fix incorrect int->float conversions caught by clang
 -Wimplicit-int-float-conversion
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
 <87tv6z7vb0.fsf@dusky.pond.sub.org> <87pnhmol25.fsf@trasno.org>
 <20191120173018.4jahw3pei3zcupvo@gmail.com>
 <f193df45-e4e7-808d-af20-cb98d8fcf96a@linaro.org>
Date: Thu, 21 Nov 2019 15:51:04 +0100
In-Reply-To: <f193df45-e4e7-808d-af20-cb98d8fcf96a@linaro.org> (Richard
 Henderson's message of "Thu, 21 Nov 2019 13:18:17 +0100")
Message-ID: <87mucpb7vr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: UYl5O1uaOpSTWuyxsk44XA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Fangrui Song <i@maskray.me>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/20/19 6:30 PM, Fangrui Song wrote:
>> On 2019-11-20, Juan Quintela wrote:
>>> Markus Armbruster <armbru@redhat.com> wrote:
>>>> Fangrui Song <i@maskray.me> writes:
[...]
>>>>> diff --git a/util/cutils.c b/util/cutils.c
>>>>> index fd591cadf0..2b4484c015 100644
>>>>> --- a/util/cutils.c
>>>>> +++ b/util/cutils.c
>>>>> @@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const c=
har
>>>>> **end,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Values >=3D 0xfffffffffffffc00 overflow u=
int64_t after their trip
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Values > nextafter(0x1p64, 0) overflow ui=
nt64_t after their trip
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * through double (53 bits of pre=
cision).
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -=C2=A0=C2=A0=C2=A0 if ((val * mul >=3D 0xfffffffffffffc00) || val < =
0) {
>>>>> +=C2=A0=C2=A0=C2=A0 if ((val * mul > nextafter(0x1p64, 0)) || val < 0=
) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retval =3D -ER=
ANGE;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> This comment was really bad (it says the same that the code).
>>> On the other hand, I can *kind of* understand what does 0xffff<more
>>> f's here>.
>>>
>>> But I am at a complete loss about what value is:
>>>
>>> nextafter(0x1p64, 0).
>>>
>>> Can we put what value is that instead?
>>=20
>> It is a C99 hexadecimal floating-point literal.
>> 0x1p64 represents hex fraction 1.0 scaled by 2**64, that is 2**64.
>>=20
>> We can write this as `val * mul > 0xfffffffffffff800p0`, but I feel that
>> counting the number of f's is error-prone and is not fun.
>>=20
>> (We cannot use val * mul >=3D 0x1p64.
>> If FLT_EVAL_METHOD =3D=3D 2, the intermediate computation val * mul will=
 be
>> performed at long double precision, val * mul may not by representable
>> by a double and will overflow as (double)0x1p64.)
>
> I agree about not spelling out the f's, or the 0x800 at the end.  That's
> something that the compiler can do for us, resolving this standard librar=
y
> function at compile-time.
>
> We just need a better comment.  Perhaps:
>
>     /*
>      * Values near UINT64_MAX overflow to 2**64 when converting
>      * to double precision.  Compare against the maximum representable
>      * double precision value below 2**64, computed as "the next value
>      * after 2**64 (0x1p64) in the direction of 0".
>      */

Yes, please.


