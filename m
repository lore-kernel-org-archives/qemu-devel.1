Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35202C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0670C2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdUi3tbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0670C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdJ1-0003AS-73
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdFh-0000GO-4U
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdFf-0001wt-GI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:36:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihdFf-0001YK-1P
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:36:47 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so3228303wru.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 09:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=J4yMwC3JVUKyiDcFi9usF6f2hJRKwXZuCNuGmW3X7S0=;
 b=DdUi3tbB3guEhQgncu3BH6VZ5qXpcliB0Iik4N8B02UOfcF1xjoWmNEkumT7orc0mv
 pEcJgSGbd1WiNebDxE4w2wG0tD85JjqNzL97NEkcPmw/BOxZ72GdHTPTnclnaSqgtawA
 ANsvDK+1QU+PC9MuaSAv7W+qy6kPtjmNK/oMQIvaDoN6CoUqdikLL6WclH6LL/U4G7qx
 vvgmVYTnn5ZAx/AiEVjCRDl9YV4sMBEubC9XT+nfDYFuM9nbpA6Gmw8B8yoN4tZxvgh5
 J5dpYaTQH9OLEtXF+dk9VEdP2A5PY2ggUASgnp4T3Se60DwtwAyLDP//QIS7bFYWuahi
 WSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=J4yMwC3JVUKyiDcFi9usF6f2hJRKwXZuCNuGmW3X7S0=;
 b=s5DQZ5VHDftdznfDi6dqqgsKVVNy5l2J4GgP1mSnWYsgYolm9iouw73fmAKx33Iy81
 tv+M/k+hP3wvhMqQsPl3YxrcC45wgwpT1jqWYkfs8CwCJTjskAzHTs7ZxCWPfmCZoGQz
 yHml1S1Kgy6nYbkfJ54yblkcG9A2NnWwJYg/wul2ADpqSyrD2MT3LksQa2O5FeMHtoZL
 lcQsxf8tnmkkhMdjDbDV0fNBzDqSmDaw7rksvLv+7HCXGVc2HQxhNPbD+IGXtgSg6D8c
 Rt9vplmWdYs6Oi8hC3hzeLVeeIQBWcOQv7g7HzILFiSSi+4wTDYD63jYJfz6RVfJVcbZ
 E5oA==
X-Gm-Message-State: APjAAAVJpXQ6fLk3wzZbtI7HUx8KhDa/C83J2GQQfUK923OF0oDm2Cne
 eKJtxlG2eO0bLw1Sd0jxjP40NQ==
X-Google-Smtp-Source: APXvYqwn9WdNVUhjxzaRsnFbsWC52niGkpygCMI3sDxV6dHpv7uyQlDzSPZrUMdEd161APhhEexFYg==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr4079371wrt.229.1576690604840; 
 Wed, 18 Dec 2019 09:36:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g17sm3069922wmc.37.2019.12.18.09.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 09:36:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FD201FF87;
 Wed, 18 Dec 2019 17:36:42 +0000 (GMT)
References: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
 <20191217121443.14757-1-alex.bennee@linaro.org>
 <1ca001f0-43a5-d8fc-fee0-3a318cc698e5@redhat.com>
 <87bls7vzjc.fsf@linaro.org>
 <976227bb-916a-2c50-1f8d-e146a199de15@redhat.com>
 <875zifvxw0.fsf@linaro.org>
 <5c6068cb-f8bf-fe4b-391b-7ced97f14221@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] semihosting: suspend recieving CPU when blocked
 (HACK, WIP)
In-reply-to: <5c6068cb-f8bf-fe4b-391b-7ced97f14221@redhat.com>
Date: Wed, 18 Dec 2019 17:36:42 +0000
Message-ID: <877e2tfsd1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: keithp@keithp.com, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/12/19 15:18, Alex Benn=C3=A9e wrote:
>>=20
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> On 17/12/19 14:42, Alex Benn=C3=A9e wrote:
>>>>> Why do you need to set exception_index to something other than -1 (us=
ing
>>>>> cpu_loop_exit_noexc for example)?
>>>> If there is no exception to process we won't exit the main loop which =
we
>>>> need to do if we want to wait until there is data to read.
>>>
>>> Okay.
>>>
>>>>> Using ->stop here is a bit weird, since ->stop is usually related to
>>>>> pause_all_vcpus.
>>>>
>>>> Arguably we could come up with a better API to cpu.c but this allows us
>>>> to use cpu_resume(c->sleeping_cpu) when waking up rather than hand
>>>> rolling our own wake-up mechanism.
>>>
>>> But we already have the right wake-up mechanism, which is
>>> cpu->halted/cpu_has_work.
>>=20
>> cpu_has_work is a guest function though and semihosting_console is a
>> common hw module. It can't peek into the guests internal state.
>
> semihosting_console only needs to something like
> cpu_interrupt(cpu->stopped_cpu, CPU_INTERRUPT_SEMIHOST).

As an exception is being delivered we just end up re-executing the
EXCP_SEMIHOST. I still don't see why using cpu_interrupt is an
improvement seeing as it is secondary to exception processing.

> (By the way,
> the stopped_cpu should probably be a list to mimic the condition
> variable---for example a GSList).

ok

>
>> This all
>> comes back to cpu_thread_is_idle anyway in making our decision about if
>> we do or do not sleep on the halt_cond.
>>=20
>>> That also makes it possible to just use
>>> EXCP_HALTED instead of adding a new EXCP_BLOCKED.
>>=20
>> We can certainly use EXCP_HALTED but maybe come up with a common way of
>> entering the state? There seems to be a combination of messing around
>> with special interrupts and direct poking of cs->halted =3D 1 while
>> setting the exception. Maybe this could finally clear up the #if
>> defined(TARGET_I386) hacking in cpus.c?
>
> If you're talking accel/tcg/cpu-exec.c, that's different; the issue
> there is that x86 has a kind of warm reset pin that is not equivalent to
> cpu_reset.  Removing that would only entail adding a new member function
> to CPUClass.
>
> Paolo


--=20
Alex Benn=C3=A9e

