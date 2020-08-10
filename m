Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B37C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51002070B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjIZHcaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51002070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5567-0000Yw-5P
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k554w-0008NF-95
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:30:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k554u-0002P3-9m
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:30:53 -0400
Received: by mail-wm1-x341.google.com with SMTP id f18so13197722wmc.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rr2Aa/tBbQSJhcJvMZLMKbdnKQizMu/1Tl9jwD7aDcI=;
 b=UjIZHcaQxfPcKDr3LA6r6P+iJID83sEfJItIgcL9hI1k5xkJpxB4gGoszNUNpHc5PO
 8JAU2sluEZB/LrzwweUyBAoPPWIYGpKJ+9X8lLrM3P4QZOfC5SjP5jw589wnpqpOTe1n
 mQiMPmq9itPvgyG42o0LEPREP8k/w2zSkthxROk3TXGjwa8oxpPnV/nfbTQiRfd9qsv1
 l/eS/MpPOGmP5QKp0snu1yQYTSaX4ZELdgbwR/7DKb2onk6EHYJkdlzDekiiIaMBrjqo
 okTNw/KbZlCa0vfzCaNepIW+UyB8jerOkoOU5LGde5WVYkz5JE20+frhbbPSvtr31K41
 1mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rr2Aa/tBbQSJhcJvMZLMKbdnKQizMu/1Tl9jwD7aDcI=;
 b=ZB7P41isjeJBT+FFxsibrFNvXDzXmdX1KdQdVESCYua0K3vUPyuchO7ckG0VNNvRhH
 ChQd0liBKet4TWcomcgo6/LhcUyQB/6zuFIXgGKDCakK/gYoXlOf+YVMatW9dZSdFOAM
 /l5hN71JHvr1ZWm36vtMA8eSC2oarzDv7R1nyJqUj73Y4nfW65e3hpGX/LZX6KnAh0G7
 KsjjXJq1ST+nkWM78aPjyjCP6haT/qp5xvEk/o0wDg9dOMYEXjzQaYKvJSReLKK39kTK
 r3+x0vM5sv/oW0USukBhl6BhY0fEFo10SwUn53y5TW0wzLiCJLBFLbH1rE4RLNiiDG5N
 Na/w==
X-Gm-Message-State: AOAM532iq2WADeBPQ9MHc11C9+D/VQIwpc6GrXysl5pfg/YsJuVPhYdq
 pKdJgjwlms8339LYhjLKmAbm7Bu8Hlg=
X-Google-Smtp-Source: ABdhPJwzd+7au8g9+GpJLuWhDZ/SqbbWpbaIlOA8J1rprvq7H9ny+IsqcQDl9UDhliZMdXwsD8wBjw==
X-Received: by 2002:a05:600c:c7:: with SMTP id
 u7mr25763728wmm.135.1597055449126; 
 Mon, 10 Aug 2020 03:30:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z207sm21752058wmc.2.2020.08.10.03.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 03:30:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 132711FF7E;
 Mon, 10 Aug 2020 11:30:47 +0100 (BST)
References: <20200806114036.10646-1-alex.bennee@linaro.org>
 <f29af0bb-7a3c-9d32-5799-42a4efa5d097@suse.de>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH] CODING_STYLE.rst: flesh out our naming conventions.
In-reply-to: <f29af0bb-7a3c-9d32-5799-42a4efa5d097@suse.de>
Date: Mon, 10 Aug 2020 11:30:47 +0100
Message-ID: <87imdq3i94.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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


Claudio Fontana <cfontana@suse.de> writes:

> On 8/6/20 1:40 PM, Alex Benn=C3=A9e wrote:
>> Mention a few of the more common naming conventions we follow in the
>> code base including common variable names and function prefix and
>> suffix examples.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  CODING_STYLE.rst | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>=20
>> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
>> index 427699e0e42..17cb42ba761 100644
>> --- a/CODING_STYLE.rst
>> +++ b/CODING_STYLE.rst
>> @@ -109,9 +109,32 @@ names are lower_case_with_underscores_ending_with_a=
_t, like the POSIX
>>  uint64_t and family.  Note that this last convention contradicts POSIX
>>  and is therefore likely to be changed.
>>=20=20
>> +Variable Naming Conventions
>> +---------------------------
>> +
>> +A number of common short naming conventions exist for variables that use
>> +common QEMU types. For example when dealing with the architecture
>> +independent CPUState this is often in a ``cs`` pointer variable
>> +whereas the concrete CPUArchState us usually held in a pointer called
>> +``env``.
>> +
>> +Likewise in device emulation code the common DeviceState is usually
>> +called ``dev`` with the actual state structure often the very terse
>> +``s`` or maybe ``foodev``.
>> +
>> +Function Naming Conventions
>> +---------------------------
>> +
>>  When wrapping standard library functions, use the prefix ``qemu_`` to a=
lert
>>  readers that they are seeing a wrapped version; otherwise avoid this pr=
efix.
>>=20=20
>> +Functions that are expected to be called with some sort of lock held
>> +usually have the suffix ``_locked``.
>> +
>> +Public functions (i.e. declared in public headers) tend to be prefixes
>> +with the subsystem or file they came from. For example ``tlb_`` for
>> +functions from ``cputlb.c`` or ``cpu_`` for functions from cpus.c.
>
> Hi Alex,
>
> agree with the sentiment, for cpus.c I would suggest cpus_ though.
>
> There are otherwise so many cpu_ functions and cpu.c modules.. using
> cpus_ would help a lot to understand that it is part of softmmu/cpus.c
>
> Wdyt?

I was mainly documenting existing conventions - I guess cpus is a poor
example to follow as it has so many cpu_ functions in them. I guess the
prefix is a loose association at best.

> Also cpus.c contains a lot of qemu_ that is not used to wrap standard
> library functions.

Certainly a lot of the static internal functions could be shorted names
dropping the qemu_ prefix. Most uses of qemu_ across the code base are
utility functions although not all wrap existing functions.

> After the current cpus refactoring, I could take care of improving the
> naming conventions in cpus.c

I wouldn't expend a lot of effort on a grand re-naming but certainly
it's worth cleaning stuff up as you go moving things about.

>
> Thanks,
>
> Claudio
>
>
>> +
>>  Block structure
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20=20
>>=20


--=20
Alex Benn=C3=A9e

