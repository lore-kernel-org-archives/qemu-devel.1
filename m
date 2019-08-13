Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D81C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9F620673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4zybM/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9F620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUIC-0001Fz-60
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxUHl-0000rP-8D
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxUHj-0007yp-TN
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:44:13 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxUHj-0007xt-Kx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:44:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id p77so783055wme.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LQyl5aWQc93bKQSUDmlvoJeR4YGYuq9+EMH+0OUHlqE=;
 b=Q4zybM/1Pv26sUV6KmqKOcA/ZOamoxMxhA8SKhQHVLk8aiDJHYGXF+UMMFyY7rdXig
 BA1zhYXPvSf+H7SWnslgt7UD8J6HBnnwxi86SbjfZMLP8I9Ig65cVGm7ydmvruZ0nK9w
 REgeV5WVEWAVPvzy1C/HVfwwFsATaC4skeXRju52bYPjzG+2TXBzoMQb8qbSfeMSaVMU
 u5Z+dX0zJLk+gpxx0YmCNtOICx5ePxyeFu3XVdn4wtGigGLVuBC6CTbXP0vs9rTnWvUd
 Ac1Ow9OYF8ECj1hpLbEa3FnRqCdKik9VeEBLc+VDMoj0NG+V7u3oqcA2j7xwvoZC/cNz
 knxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LQyl5aWQc93bKQSUDmlvoJeR4YGYuq9+EMH+0OUHlqE=;
 b=kGJBLReQrI1DMflGnOReeVQiRefHtHzslz3oDSHVjoc/bT5mAGncj/wP4FYR2PoGRV
 xPD5BBAiWhbcxCw8XD5KACFQ7p81cBejm3lVvlmqpibxyTdh5IBsJrST2Xqoxj2p2v+E
 mypbeG/pnZbrWE0OaCJbuUToWpX/jpIBbS4PIjnCnP6+drE8mV9UNWeDcYgpu/YHB+LS
 s6wxMlBqb8HbS8y/+06kvRexYPrAaSJxk9gTEC8/fnFBHuv8Q9firKRNggQQKSW9hXuI
 DHW9JF/nYZy1mFcnWKaobnlmW/cgxpEWhpI1p/8hcHYq59flS/yUNrPpwqPDNIeOoVTk
 whSg==
X-Gm-Message-State: APjAAAXaq8pjmwaDYa2DNNQGCEZ5hW5F6Qj+FBqOYLNPrXo7lNC1CBlP
 VwDfP4+9ppjcMq795/ZcRIrGUHRjZSE=
X-Google-Smtp-Source: APXvYqxTT+AIQpKv8uBOvCEugPtfeyGZbTXUEdV9fORTOWu3m+OEcjlObTwu1x/G6+KeLrrie7C3Vg==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr2378986wmk.97.1565693049065; 
 Tue, 13 Aug 2019 03:44:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v12sm91304034wrr.87.2019.08.13.03.44.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 03:44:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 060661FF87;
 Tue, 13 Aug 2019 11:44:08 +0100 (BST)
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-12-armbru@redhat.com> <87blwuodot.fsf@linaro.org>
 <87y2zytsgi.fsf@dusky.pond.sub.org> <875zn1aacx.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
In-reply-to: <875zn1aacx.fsf@dusky.pond.sub.org>
Date: Tue, 13 Aug 2019 11:44:07 +0100
Message-ID: <875zn1ny4o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v4 11/29] typedefs: Separate incomplete
 types and function types
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> While there, drop the obsolete file comment.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>  include/qemu/typedefs.h | 12 ++++++++----
>>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>>>> index fcdaae58c4..29346648d4 100644
>>>> --- a/include/qemu/typedefs.h
>>>> +++ b/include/qemu/typedefs.h
>>>> @@ -1,10 +1,10 @@
>>>>  #ifndef QEMU_TYPEDEFS_H
>>>>  #define QEMU_TYPEDEFS_H
>>>>
>>>> -/* A load of opaque types so that device init declarations don't have=
 to
>>>> -   pull in all the real definitions.  */
>>>> -
>>>> -/* Please keep this list in case-insensitive alphabetical order */
>>>> +/*
>>>> + * Incomplete struct types
>>>
>>> Maybe expand this a little...
>>>
>>>   "Incomplete struct types for modules that don't need the complete
>>>   definitions but still pass around typed variables."?
>>
>> If we explain proper use of qemu/typedefs.h in HACKING, as discussed in
>> review of v1[*], we could point there.
>
> Perhaps rewriting the obsolete file comment would be better.  Something
> like this:
>
>     /*
>      * This header is for selectively avoiding #include just to get a
>      * typedef name.
>      *
>      * Declaring a typedef name in its "obvious" place can result in
>      * inclusion cycles, in particular for complete struct and union
>      * types that need more types for their members.  It can also result
>      * in headers pulling in many more headers, slowing down builds.
>      *
>      * You can break such cycles and unwanted dependencies by declaring
>      * the typedef name here.
>      *
>      * For struct types used in only a few headers, judicious use of the
>      * struct tag instead of the typedef name is commonly preferable.
>      */
>
>     /*
>      * Incomplete struct types
>      * Please keep this list in case-insensitive alphabetical order.
>      */
>     typedef struct AdapterInfo AdapterInfo;
>     [...]
>
>     /*
>      * Pointer types
>      * Such typedefs should be limited to cases where the typedef's users
>      * are oblivious of its "pointer-ness".
>      * Please keep this list in case-insensitive alphabetical order.
>      */
>     typedef struct IRQState *qemu_irq;
>
>     /*
>      * Function types
>      */
>     typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>     typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_i=
d);
>     typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>
> What do you think?

A definite improvement on what is currently there ;-)

>
> [...]


--
Alex Benn=C3=A9e

