Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9254C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C83920730
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C83920730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTq6-0003ZG-J9
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <emacsray@gmail.com>) id 1iXTo7-0002aW-K0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <emacsray@gmail.com>) id 1iXTo5-00019D-UF
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:30:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <emacsray@gmail.com>) id 1iXTo5-00018o-KX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:30:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so50399pfh.9
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 09:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GKWksBOyTGFrcb1yXhvRt7iles2TcQvLBi45Rj/q3kc=;
 b=pt2GQG+NH/kcBFNbdFSoS2pNLgx03PNhQDP9ZpSsjjtEpef/74yJ2b2s5G1DRz4Zrd
 YqRupMrNrIOAGVRlCfXHNIyibxDkws6LMYAVUP2mSb6ZiY8+SWYXnYDgVj3G+8YmI/GC
 pw+P9OpIPyxU+FGZJbZ40AtGC0sVgSv9aRBabnouWK31egsO95DAZ8uuFMdKTJC1ya3B
 K+LuqN6Flt53ElPyaRrgyRql0oLI7bHXymPZY4JBL/SAWrqSqqYGi+NsQpI+PkMDMGio
 CUs5Xx3/xYGx29JjgME1wdPIWMY9vmjlXrLvOEykxl0xFYgvo79AmeBhcpx00pc+iODd
 BW4Q==
X-Gm-Message-State: APjAAAU8Ui+wpLaBmnCSbyAMQKvSZbsOQzzD8Y0Gmu+mstli9i8M7p1B
 4t/DIIm8RjEHZtcEZOT9d8I=
X-Google-Smtp-Source: APXvYqxu5Npbddi1Q9Cpd0BVLewSWuTHPM8WmZ91KkjRtmlLWqgy0pGziG3RYikzgMdO2hMxy88U3A==
X-Received: by 2002:a63:4415:: with SMTP id r21mr4655640pga.184.1574271020037; 
 Wed, 20 Nov 2019 09:30:20 -0800 (PST)
Received: from localhost ([2620:15c:2d1:100:7901:ead3:b8cd:1c59])
 by smtp.gmail.com with ESMTPSA id c3sm28045111pgi.19.2019.11.20.09.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 09:30:19 -0800 (PST)
Date: Wed, 20 Nov 2019 09:30:18 -0800
From: Fangrui Song <i@maskray.me>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] Fix incorrect int->float conversions caught by clang
 -Wimplicit-int-float-conversion
Message-ID: <20191120173018.4jahw3pei3zcupvo@gmail.com>
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
 <87tv6z7vb0.fsf@dusky.pond.sub.org> <87pnhmol25.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87pnhmol25.fsf@trasno.org>
User-Agent: NeoMutt/20180223-112-0c5bf3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
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
Cc: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-11-20, Juan Quintela wrote:
>Markus Armbruster <armbru@redhat.com> wrote:
>> Fangrui Song <i@maskray.me> writes:
>>
>>> The warning will be enabled by default in clang 10. It is not
>>> available for clang <= 9.
>>>
>>> qemu/migration/migration.c:2038:24: error: implicit conversion from
>>> 'long' to 'double' changes value from 9223372036854775807 to
>>> 9223372036854775808 [-Werror,-Wimplicit-int-float-conversion]
>>> ...
>>> qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned
>>> long' to 'double' changes value from 18446744073709550592 to
>>> 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
>>>
>>> Signed-off-by: Fangrui Song <i@maskray.me>
>>> ---
>>>   migration/migration.c | 4 ++--
>>>   util/cutils.c         | 4 ++--
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 354ad072fa..ac3ea2934a 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -53,6 +53,7 @@
>>>   #include "monitor/monitor.h"
>>>   #include "net/announce.h"
>>>   #include "qemu/queue.h"
>>> +#include <math.h>
>>>
>>>   #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
>>>
>>> @@ -2035,11 +2036,10 @@ void qmp_migrate_set_downtime(double value, Error **errp)
>>         if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
>>             error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
>>                              "the range of 0 to %d seconds",
>>                              MAX_MIGRATE_DOWNTIME_SECONDS);
>>             return;
>>>       }
>>
>> @value is now in [0,2000].
>>
>>>
>>>       value *= 1000; /* Convert to milliseconds */
>>
>> @value is in [0,2000000]
>>
>>> -    value = MAX(0, MIN(INT64_MAX, value));
>>
>> This does nothing.
>>
>>>
>>>       MigrateSetParameters p = {
>>>           .has_downtime_limit = true,
>>> -        .downtime_limit = value,
>>> +        .downtime_limit = (int64_t)fmin(value, nextafter(0x1p63, 0)),
>>
>> This does nothing and is hard to read :)
>>
>> Can we simply drop the offending line statement instead?
>
>Agreed aboutdropping the whole bussines for migration.
>
>
>>>       };
>>>
>>>       qmp_migrate_set_parameters(&p, errp);
>>> diff --git a/util/cutils.c b/util/cutils.c
>>> index fd591cadf0..2b4484c015 100644
>>> --- a/util/cutils.c
>>> +++ b/util/cutils.c
>>> @@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char **end,
>>>           goto out;
>>>       }
>>>       /*
>>> -     * Values >= 0xfffffffffffffc00 overflow uint64_t after their trip
>>> +     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
>>>        * through double (53 bits of precision).
>>>        */
>>> -    if ((val * mul >= 0xfffffffffffffc00) || val < 0) {
>>> +    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
>>>           retval = -ERANGE;
>>>           goto out;
>>>       }
>
>This comment was really bad (it says the same that the code).
>On the other hand, I can *kind of* understand what does 0xffff<more
>f's here>.
>
>But I am at a complete loss about what value is:
>
>nextafter(0x1p64, 0).
>
>Can we put what value is that instead?

It is a C99 hexadecimal floating-point literal.
0x1p64 represents hex fraction 1.0 scaled by 2**64, that is 2**64.

We can write this as `val * mul > 0xfffffffffffff800p0`, but I feel that
counting the number of f's is error-prone and is not fun.

(We cannot use val * mul >= 0x1p64.
If FLT_EVAL_METHOD == 2, the intermediate computation val * mul will be
performed at long double precision, val * mul may not by representable
by a double and will overflow as (double)0x1p64.)

