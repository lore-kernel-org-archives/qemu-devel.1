Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24984ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF78420872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCO54puE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF78420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8Of-00011a-HM
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7cC-0003qq-E5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7cB-0000L3-7O
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:23:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7cA-0000Kb-Sw
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571325777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAlyzMek75JaE3w6t6cVdFW7pX4b/3qGpoKyRsKQyqM=;
 b=VCO54puETunMn1BY5gWeOkfzNnWRQWiVjHQDuVTOmAOiADUXCrb8guwT5yt1QOVzLG4nzz
 FRF+HIMrEHR3+7Et2XpiCxJX669RXPLirRduvkuJmMIbq3aNx6Uv+Ag+W9i0FL/ir2Iytz
 zjWpQQc5kWqImofUzohKPqDzhmivEo4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-odIqJXnLPNy6-4dywTqGww-1; Thu, 17 Oct 2019 11:22:55 -0400
Received: by mail-wr1-f69.google.com with SMTP id s9so1109516wrw.23
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0+eHbN6RPRVuck2GdGDf/GQlIKqhVxnGZhHroDpXgkY=;
 b=ODFlJDOu+27L/E31n5plcm35y0czj4NUfEp4LdSIb/fQAiw8gStAN3pwbqM3iDlcYa
 6lHYGZNGgKFQaDqHsMhuS3VX5T55NrrO27JiztMB9DAuL6k15RzHD8aP4bK0RmxiRIip
 m9Ub4EYyEF7UmSYTxKbGYa81g33URLqsFqA5qBGo+wzOnWFhbJr3AzvnowlixkPr2duR
 l5TpV8ysrA6i3/rFQnOnRM7sTZ5rLkJdqAGh+ZozT39lM+w0gq0Ca8LliaNqB0Gvwr/1
 7BOC8FsKo/SSK+XFhVTYfFXZcQ+Ok8srXW3d9sTLPPbxO4GGAJnDYe/SH2y/NnIyg39/
 6WSg==
X-Gm-Message-State: APjAAAX0BcMtlRnZ1V+cpxnu/HgOVFurPEsAUG5c0q1wkHkoCiQTbOSy
 9heZE+az6hdxsR6jE+D+mGF+IYh2D9ee5Ss3AmKQd8c38TIVGBWM14If7pSs64XDAsyBqcB4SZX
 VEH+lIZ1Lb6SbM9E=
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr3369332wrr.251.1571325774682; 
 Thu, 17 Oct 2019 08:22:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz7BfYUCGGDgmReMM7e3Fcx/3iRF02BqbG6DHi7QIV4ZC4gnw+MvUZpE1yjrLjM2p7agSrXlw==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr3369313wrr.251.1571325774458; 
 Thu, 17 Oct 2019 08:22:54 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id x129sm3258807wmg.8.2019.10.17.08.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:22:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/timer/slavio_timer.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191017132351.4762-1-peter.maydell@linaro.org>
 <20191017132351.4762-3-peter.maydell@linaro.org>
 <2210f783-1159-1263-dfff-3bd84111e2f5@redhat.com>
 <CAFEAcA_jYjN=pQ719kbrRGXF2f8uDg_uj1r_dO0320qqB1Nppg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f1ada0bb-4d8c-69cc-df00-3f69c3891718@redhat.com>
Date: Thu, 17 Oct 2019 17:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_jYjN=pQ719kbrRGXF2f8uDg_uj1r_dO0320qqB1Nppg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: odIqJXnLPNy6-4dywTqGww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 5:00 PM, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 15:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> Hi Peter,
>>
>> On 10/17/19 3:23 PM, Peter Maydell wrote:
>>> Switch the slavio_timer code away from bottom-half based ptimers to
>>> the new transaction-based ptimer API.  This just requires adding
>>> begin/commit calls around the various places that modify the ptimer
>>> state, and using the new ptimer_init() function to create the timer.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/timer/slavio_timer.c | 20 ++++++++++++++++----
>>>    1 file changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
>>> index 692d213897d..0e2efe6fe89 100644
>>> --- a/hw/timer/slavio_timer.c
>>> +++ b/hw/timer/slavio_timer.c
>>> @@ -30,7 +30,6 @@
>>>    #include "hw/sysbus.h"
>>>    #include "migration/vmstate.h"
>>>    #include "trace.h"
>>> -#include "qemu/main-loop.h"
>>>    #include "qemu/module.h"
>>>
>>>    /*
>>> @@ -213,6 +212,7 @@ static void slavio_timer_mem_writel(void *opaque, h=
waddr addr,
>>>        saddr =3D addr >> 2;
>>>        switch (saddr) {
>>>        case TIMER_LIMIT:
>>> +        ptimer_transaction_begin(t->timer);
>>>            if (slavio_timer_is_user(tc)) {
>>>                uint64_t count;
>>
>>
>> This part is odd since there is a check on t->timer !=3D NULL later, and
>> ptimer_transaction_commit() can't take NULL.
>=20
> Hmm, I hadn't noticed that. I think the bug is the check
> for NULL, though, beacuse the slavio_timer_init() function
> always initializes all the timer pointers, so there's
> no situation where the pointer can be non-NULL as far
> as I can see. So I think I'd rather fix this by removing
> the NULL pointer check...

Yes, you are correct.

>>> @@ -255,13 +258,16 @@ static void slavio_timer_mem_writel(void *opaque,=
 hwaddr addr,
>>>        case TIMER_COUNTER_NORST:
>>>            // set limit without resetting counter
>>>            t->limit =3D val & TIMER_MAX_COUNT32;
>>> +        ptimer_transaction_begin(t->timer);
>>>            if (t->limit =3D=3D 0) { /* free-run */
>>>                ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(TIMER_MAX_CO=
UNT32), 0);
>>>            } else {
>>>                ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 0=
);
>>>            }
>>> +        ptimer_transaction_commit(t->timer);
>>>            break;
>>>        case TIMER_STATUS:
>>> +        ptimer_transaction_begin(t->timer);
>>>            if (slavio_timer_is_user(tc)) {
>>
>> I'd move the begin() here.
>=20
> This would be awkward because then it won't neatly nest with
> the commit call unless you add an extra if() for the
> commit or otherwise rearrange/duplicate code...
>=20
>>>                // start/stop user counter
>>>                if (val & 1) {
>>> @@ -273,6 +279,7 @@ static void slavio_timer_mem_writel(void *opaque, h=
waddr addr,
>>>                }
>>>            }
>>>            t->run =3D val & 1;
>>> +        ptimer_transaction_commit(t->timer);
>=20
> ...because the commit should come after we have finished
> updating the timer state (t->run in this case), because
> the trigger callback slavio_timer_irq() otherwise sees
> inconsistent half-updated state if commit() calls it.

Oh, slavio_timer_irq() calls slavio_timer_get_out() which accesses the=20
ptimer... OK I missed that.

Whew we need to be extra cautious with this API...

If possible I'd rather see the patch removing the NULL check previous to=20
this one, anyway:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks,

Phil.


