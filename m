Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E88C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542F5206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542F5206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXpzf-0008WE-By
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <emacsray@gmail.com>) id 1iXpyz-00081N-H4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <emacsray@gmail.com>) id 1iXpyy-0001Ds-2T
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:11:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <emacsray@gmail.com>) id 1iXpyx-0001Cj-RL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:11:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so2005009pfl.7
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 09:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uVEZFiM+WYWnZs8RY8vKON8yrPY9OJsUeNe7gmzBl+8=;
 b=CCaHBiJTun8HueEsU5IfEudrLDQkdrYaa8AO8gza/KHrfkxTAWQQ+RVXkObx9ivZPp
 Vh8iyIOaLx1mX0KeqTOhPn5qBwlAonixdpSG6F5NqGDYETcgrDl8TgpOKTq09qL3Nzm3
 NdGlYEogZSummU+/nw28fJ6Gj/apmYzH/PA8KRAS7yWeuMZVaGb8pmDCHVP4y5aX8Scx
 d8wSu4cLVvMFMCLbjvSOYdG3r+b5ccAyRspXcm7cQyL0MsNERRsV7GC3P6+bvCBhKnb3
 Z74wJKQGL9WjBisPw5wq04F67BWCiN6rwb3MTEQCDSKiJc58pKe6ArYoKQOp2y9AfJY5
 pChQ==
X-Gm-Message-State: APjAAAU1E+uS3WoRN9wSdzkJSCx2mRjS9sxH6x8dCbMqFB0FSBEk79p/
 RwvyelExTHyUFsmL91uVSGM=
X-Google-Smtp-Source: APXvYqw7pP+AMqO5JrDOsMf9IuIGrh7imNe8954UxB9NXzZ3rxBBJIPBDnM4RtRhnHK0I387+FSs5w==
X-Received: by 2002:a62:4d43:: with SMTP id a64mr12260111pfb.197.1574356262776; 
 Thu, 21 Nov 2019 09:11:02 -0800 (PST)
Received: from localhost ([2620:15c:2d1:100:7901:ead3:b8cd:1c59])
 by smtp.gmail.com with ESMTPSA id t8sm115996pjr.25.2019.11.21.09.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 09:11:01 -0800 (PST)
Date: Thu, 21 Nov 2019 09:11:01 -0800
From: Fangrui Song <i@maskray.me>
To: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] Fix incorrect int->float conversions caught by clang
 -Wimplicit-int-float-conversion
Message-ID: <20191121171101.jjlxc72n7vtpeqyc@gmail.com>
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
 <87tv6z7vb0.fsf@dusky.pond.sub.org> <87pnhmol25.fsf@trasno.org>
 <20191120173018.4jahw3pei3zcupvo@gmail.com>
 <f193df45-e4e7-808d-af20-cb98d8fcf96a@linaro.org>
 <87mucpb7vr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mu547a2ytondnir6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mucpb7vr.fsf@dusky.pond.sub.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mu547a2ytondnir6
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2019-11-21, Markus Armbruster wrote:
>Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 11/20/19 6:30 PM, Fangrui Song wrote:
>>> On 2019-11-20, Juan Quintela wrote:
>>>> Markus Armbruster <armbru@redhat.com> wrote:
>>>>> Fangrui Song <i@maskray.me> writes:
>[...]
>>>>>> diff --git a/util/cutils.c b/util/cutils.c
>>>>>> index fd591cadf0..2b4484c015 100644
>>>>>> --- a/util/cutils.c
>>>>>> +++ b/util/cutils.c
>>>>>> @@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char
>>>>>> **end,
>>>>>>           goto out;
>>>>>>       }
>>>>>>       /*
>>>>>> -     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
>>>>>> +     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
>>>>>>        * through double (53 bits of precision).
>>>>>>        */
>>>>>> -    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
>>>>>> +    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
>>>>>>           retval = -ERANGE;
>>>>>>           goto out;
>>>>>>       }
>>>>
>>>> This comment was really bad (it says the same that the code).
>>>> On the other hand, I can *kind of* understand what does 0xffff<more
>>>> f's here>.
>>>>
>>>> But I am at a complete loss about what value is:
>>>>
>>>> nextafter(0x1p64, 0).
>>>>
>>>> Can we put what value is that instead?
>>>
>>> It is a C99 hexadecimal floating-point literal.
>>> 0x1p64 represents hex fraction 1.0 scaled by 2**64, that is 2**64.
>>>
>>> We can write this as `val * mul > 0xfffffffffffff800p0`, but I feel that
>>> counting the number of f's is error-prone and is not fun.
>>>
>>> (We cannot use val * mul >= 0x1p64.
>>> If FLT_EVAL_METHOD == 2, the intermediate computation val * mul will be
>>> performed at long double precision, val * mul may not by representable
>>> by a double and will overflow as (double)0x1p64.)
>>
>> I agree about not spelling out the f's, or the 0x800 at the end.  That's
>> something that the compiler can do for us, resolving this standard library
>> function at compile-time.
>>
>> We just need a better comment.  Perhaps:
>>
>>     /*
>>      * Values near UINT64_MAX overflow to 2**64 when converting
>>      * to double precision.  Compare against the maximum representable
>>      * double precision value below 2**64, computed as "the next value
>>      * after 2**64 (0x1p64) in the direction of 0".
>>      */
>
>Yes, please.

Thanks for the suggestion. Attached a new patch.

--mu547a2ytondnir6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="qemu.patch"

From 13312e91e5565a6bed8c394d5711603c7a8f8a3c Mon Sep 17 00:00:00 2001
From: Fangrui Song <i@maskray.me>
Date: Fri, 15 Nov 2019 16:27:47 -0800
Subject: [PATCH] Fix incorrect integer->float conversion caught by clang -Wimplicit-int-float-conversion
To: qemu-devel@nongnu.org

The warning will be enabled by default in clang 10. It is not available for clang <= 9.

qemu/migration/migration.c:2038:24: error: implicit conversion from 'long' to 'double' changes value from 9223372036854775807 to 9223372036854775808 [-Werror,-Wimplicit-int-float-conversion]
...
qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned long' to 'double' changes value from 18446744073709550592 to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]

Signed-off-by: Fangrui Song <i@maskray.me>
---
 migration/migration.c | 3 +--
 util/cutils.c         | 8 +++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..09b150663f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2035,11 +2035,10 @@ void qmp_migrate_set_downtime(double value, Error **errp)
     }
 
     value *= 1000; /* Convert to milliseconds */
-    value = MAX(0, MIN(INT64_MAX, value));
 
     MigrateSetParameters p = {
         .has_downtime_limit = true,
-        .downtime_limit = value,
+        .downtime_limit = (int64_t)value,
     };
 
     qmp_migrate_set_parameters(&p, errp);
diff --git a/util/cutils.c b/util/cutils.c
index fd591cadf0..77acadc70a 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -239,10 +239,12 @@ static int do_strtosz(const char *nptr, const char **end,
         goto out;
     }
     /*
-     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
-     * through double (53 bits of precision).
+     * Values near UINT64_MAX overflow to 2**64 when converting to double
+     * precision.  Compare against the maximum representable double precision
+     * value below 2**64, computed as "the next value after 2**64 (0x1p64) in
+     * the direction of 0".
      */
-    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
+    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
         retval = -ERANGE;
         goto out;
     }
-- 
2.24.0


--mu547a2ytondnir6--

