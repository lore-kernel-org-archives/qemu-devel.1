Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0184AC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD38206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WplZqoTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD38206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOHGQ-0005TZ-VF
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 04:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOHEM-0003Kp-I2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOHEL-0002Fy-4v
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:47:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOHEK-0002Fc-Tz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:47:41 -0400
Received: by mail-wm1-x343.google.com with SMTP id x25so12105764wmc.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YVAHqC8ZXZkoUovqp96EitxUTY0t+qHBmgVetuGF3bU=;
 b=WplZqoTIj4wrRdOzBvKyjdt340oky9/DNz6U1T2fjOgarVtq5z0kO1iwsvbQWfK0m9
 vY3bM9+E3zCQQmwaMlcEWzdmXWXCgXnYPPBqCPjw5mehEavW+MBkhZc/0b5qpka/Iq22
 yIVXRuCk8qI133EBRCw4QNC4Y7vL2iRCdZO+6FRgGm12jhZ5JhkbMu/+XVU/vVDSspYP
 x9U9Azx7JnGW6Sb7fQdcqLUCKEdiT4ULDG+/Csg5CEP7bY92GsYLQeyFaONvIqpiwXLc
 n7pjT+aCx74MhwJXGJgiyoyo/WVNsmssx6mscbNXKCuO7WVn7WmFEjPE1aJ/MD3SFHpN
 yOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YVAHqC8ZXZkoUovqp96EitxUTY0t+qHBmgVetuGF3bU=;
 b=qSMaxMWFNNftXnTs+LPP7ysRYGCmr1KvS1GqAoi3FNLeRtNoa71o4/Kbx1+eLRe63m
 +i1uqvVBA3h7M7JsCX7xWN6JxQgLuQJXrQUAHlyg14Ne9EKsuAcPEO+qcGi6DKoET6bJ
 STNi1Dr4kcah1XjkqAS/O7Ubf+8eDPv7PDq7+OjY1X1h5G+8s19/AOcLWdWsWHEYTvGO
 H2lIBPPiivGgRCP0vihtk8BnaIW3WNdnU9NqZtpqHU2N6oLDkkeIXIzz8ZuAGnpHBKOO
 mvvo2eCOoE6h8kAJby1BMvY7y4Zv/uUcqg9Cd5PsR4kIb9uSFaTkbcH8lYvTzM1nMclD
 hRiQ==
X-Gm-Message-State: AGi0Pua+j08FrQZ8fMniNbZYmQONAT4mhEelYd3CUJsnkq6mdH3bO5DP
 i/Nh3Lfb2k5Tll05tg9cp1jfkRI0zS4=
X-Google-Smtp-Source: APiQypJCCUIGPKACD8vNRcD9PeOw3M1qYSnSi3bxeRiFQ6iwgREOQfihJre6iI2M/JjmHt2NXCripQ==
X-Received: by 2002:a1c:f306:: with SMTP id q6mr1578456wmq.169.1586854058024; 
 Tue, 14 Apr 2020 01:47:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z11sm18420314wrv.58.2020.04.14.01.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 01:47:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F12151FF7E;
 Tue, 14 Apr 2020 09:47:35 +0100 (BST)
References: <20200413162902.7985-1-alex.bennee@linaro.org>
 <2c489489-f459-f029-029e-74bfbfc70e49@redhat.com>
 <87imi38433.fsf@linaro.org>
 <d97c8034-2a9f-fe26-c70b-49b4d19f800d@redhat.com>
 <875ze2zed7.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] .gitignore: include common build sub-directories
In-reply-to: <875ze2zed7.fsf@dusky.pond.sub.org>
Date: Tue, 14 Apr 2020 09:47:35 +0100
Message-ID: <873696qwrc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 4/13/20 4:32 PM, Alex Benn=C3=A9e wrote:
>>>
>>> Eric Blake <eblake@redhat.com> writes:
>>>
>>>> On 4/13/20 11:29 AM, Alex Benn=C3=A9e wrote:
>>>>> As out-of-tree builds become more common (or rather building in a
>>>>> subdir) we can add a lot of load to "git ls-files" as it hunts down
>>>>> sub-directories that are irrelevant to the source tree. This is
>>>>> especially annoying if you have a prompt that attempts to summarise
>>>>> the current git status on command completion.
>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>> ---
>>>>>    .gitignore | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>> diff --git a/.gitignore b/.gitignore
>>>>> index 0c5af83aa74..7757dc08a08 100644
>>>>> --- a/.gitignore
>>>>> +++ b/.gitignore
>>>>> @@ -141,6 +141,8 @@ cscope.*
>>>>>    tags
>>>>>    TAGS
>>>>>    docker-src.*
>>>>> +build
>>>>> +builds
>>>>
>>>> Would 'build-*' be worth adding as well?
>>>
>>> Sure - I'll add it to v2.
>>
>> Or even consolidate it into a single pattern: build* (which would
>> allow 'build', 'builds', 'build1', 'build23', 'build-fedora',
>> 'build-bug1234', ...)
>
> The looser the pattern, the higher the risk of unwanted matches.
>
> Would be less of an issue if we had a cleaner source root directory.

True but as of now we don't have anything matching bu* so I think build*
is fairly safe. I have ran into problems with over lax .gitignore
stanzas before but I don't think it's taken too long to figure out what
was going on. It's not like having a build subdir isn't a common
"out-of-tree" build idiom.

--=20
Alex Benn=C3=A9e

