Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED8C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F252C20731
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIK3IqCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F252C20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlRC-0000Xa-Ul
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iXlPq-0007tL-G3
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iXlPo-0007ZJ-Qv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:18:30 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iXlPo-0007Xc-KE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:18:28 -0500
Received: by mail-il1-x142.google.com with SMTP id m5so3076406ilq.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y3MhZPgLY4zqi0GSymeP9L0FmrE+Bfwx7RjlwxxwXCI=;
 b=aIK3IqCPY9vqQrTo6pbyBV6FnHGNPJ0wtNxHOEibmUL+8+DFIYwCR0OBrX8aCrGUSB
 WfYzWUZyErnTqm3iQKsNC0o8DVh+dcRVfgLtnPtijwRLARtDWdEnGwodIgi2SypVoz7q
 IePj0no/l5z4LDGxKA0C8nW4rtZ12w5e+y6EBV1xuIKBOhNHi8gXatWxXKCqEdWi8g2s
 YfLHXVGXwrhqRJt8QTOSlRmkJpw1YHwWip1zQjJp64FoY+HlfHbm7LCEh1LSwPkadz8j
 IDFMG5y7X/MZZe4FZf7uMXJm3TdwVETmleXBbfGGSVIbu8PR+548+hQumq0Qa8WWLQKy
 aukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y3MhZPgLY4zqi0GSymeP9L0FmrE+Bfwx7RjlwxxwXCI=;
 b=szvU1gvmfcupm/HkSVAGsiiCFzUT4HnplSFiyW9SBof7jf//E4BoMzeml+rzn+AN7z
 gDse2nKuQ+5OmzxPPB06bKJk8crID0WL0h2Ny6JCgJWRDED9YyRFqPYYhGjrcvUFvbUm
 p9B1IPYPELOycSmVOd/I9joceNjdobKtEpNhamky118x1tP1fr37MX9N3HvDAvYYDelT
 PSFb7sVJCr5PdV++QffIGPGZNyghzSr3i4nyGzfcJGv1HwWY/fHUg3s7Ibg+qrnRisJm
 gRvIWFS1ms4aF1uWvahedtjZNGs/MSIeTqbiwFp0n6gxKX5RGIxRRazYXIXzhYsqpfWi
 iwAw==
X-Gm-Message-State: APjAAAVRiyOjoSECy7jVUjXL75sYSWyM4SjHzACTI2pcRUpMtGU5FSyW
 ztSRgtn0noEfDztoR8AE59hbgWpcU2UtBw==
X-Google-Smtp-Source: APXvYqy8Exzxl0Xhzw1G0YrBokDJrFqDKOtfbTBOrG+p+36S90dVpM9pCwlWcPFK20OJuLTavitWcg==
X-Received: by 2002:a92:86c5:: with SMTP id l66mr9460323ilh.280.1574338704602; 
 Thu, 21 Nov 2019 04:18:24 -0800 (PST)
Received: from [192.168.44.35] ([172.58.139.152])
 by smtp.gmail.com with ESMTPSA id k6sm816354iom.52.2019.11.21.04.18.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 04:18:23 -0800 (PST)
Subject: Re: [PATCH] Fix incorrect int->float conversions caught by clang
 -Wimplicit-int-float-conversion
To: Fangrui Song <i@maskray.me>, Juan Quintela <quintela@redhat.com>
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
 <87tv6z7vb0.fsf@dusky.pond.sub.org> <87pnhmol25.fsf@trasno.org>
 <20191120173018.4jahw3pei3zcupvo@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f193df45-e4e7-808d-af20-cb98d8fcf96a@linaro.org>
Date: Thu, 21 Nov 2019 13:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120173018.4jahw3pei3zcupvo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 6:30 PM, Fangrui Song wrote:
> On 2019-11-20, Juan Quintela wrote:
>> Markus Armbruster <armbru@redhat.com> wrote:
>>> Fangrui Song <i@maskray.me> writes:
>>>
>>>> The warning will be enabled by default in clang 10. It is not
>>>> available for clang <= 9.
>>>>
>>>> qemu/migration/migration.c:2038:24: error: implicit conversion from
>>>> 'long' to 'double' changes value from 9223372036854775807 to
>>>> 9223372036854775808 [-Werror,-Wimplicit-int-float-conversion]
>>>> ...
>>>> qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned
>>>> long' to 'double' changes value from 18446744073709550592 to
>>>> 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
>>>>
>>>> Signed-off-by: Fangrui Song <i@maskray.me>
>>>> ---
>>>>   migration/migration.c | 4 ++--
>>>>   util/cutils.c         | 4 ++--
>>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 354ad072fa..ac3ea2934a 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -53,6 +53,7 @@
>>>>   #include "monitor/monitor.h"
>>>>   #include "net/announce.h"
>>>>   #include "qemu/queue.h"
>>>> +#include <math.h>
>>>>
>>>>   #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed
>>>> throttling */
>>>>
>>>> @@ -2035,11 +2036,10 @@ void qmp_migrate_set_downtime(double value, Error
>>>> **errp)
>>>         if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
>>>             error_setg(errp, "Parameter 'downtime_limit' expects an integer
>>> in "
>>>                              "the range of 0 to %d seconds",
>>>                              MAX_MIGRATE_DOWNTIME_SECONDS);
>>>             return;
>>>>       }
>>>
>>> @value is now in [0,2000].
>>>
>>>>
>>>>       value *= 1000; /* Convert to milliseconds */
>>>
>>> @value is in [0,2000000]
>>>
>>>> -    value = MAX(0, MIN(INT64_MAX, value));
>>>
>>> This does nothing.
>>>
>>>>
>>>>       MigrateSetParameters p = {
>>>>           .has_downtime_limit = true,
>>>> -        .downtime_limit = value,
>>>> +        .downtime_limit = (int64_t)fmin(value, nextafter(0x1p63, 0)),
>>>
>>> This does nothing and is hard to read :)
>>>
>>> Can we simply drop the offending line statement instead?
>>
>> Agreed aboutdropping the whole bussines for migration.
>>
>>
>>>>       };
>>>>
>>>>       qmp_migrate_set_parameters(&p, errp);
>>>> diff --git a/util/cutils.c b/util/cutils.c
>>>> index fd591cadf0..2b4484c015 100644
>>>> --- a/util/cutils.c
>>>> +++ b/util/cutils.c
>>>> @@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char
>>>> **end,
>>>>           goto out;
>>>>       }
>>>>       /*
>>>> -     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
>>>> +     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
>>>>        * through double (53 bits of precision).
>>>>        */
>>>> -    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
>>>> +    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
>>>>           retval = -ERANGE;
>>>>           goto out;
>>>>       }
>>
>> This comment was really bad (it says the same that the code).
>> On the other hand, I can *kind of* understand what does 0xffff<more
>> f's here>.
>>
>> But I am at a complete loss about what value is:
>>
>> nextafter(0x1p64, 0).
>>
>> Can we put what value is that instead?
> 
> It is a C99 hexadecimal floating-point literal.
> 0x1p64 represents hex fraction 1.0 scaled by 2**64, that is 2**64.
> 
> We can write this as `val * mul > 0xfffffffffffff800p0`, but I feel that
> counting the number of f's is error-prone and is not fun.
> 
> (We cannot use val * mul >= 0x1p64.
> If FLT_EVAL_METHOD == 2, the intermediate computation val * mul will be
> performed at long double precision, val * mul may not by representable
> by a double and will overflow as (double)0x1p64.)

I agree about not spelling out the f's, or the 0x800 at the end.  That's
something that the compiler can do for us, resolving this standard library
function at compile-time.

We just need a better comment.  Perhaps:

    /*
     * Values near UINT64_MAX overflow to 2**64 when converting
     * to double precision.  Compare against the maximum representable
     * double precision value below 2**64, computed as "the next value
     * after 2**64 (0x1p64) in the direction of 0".
     */


r~

