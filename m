Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82FAC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A9824655
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WntVs19G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A9824655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihE1U-0001U2-Od
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihE0h-0000bi-N5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihE0g-0007zN-35
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:39:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54932
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihE0f-0007sC-SK
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576593576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QExHWzO0L4RoNstO3bubBl6nG2vLJPM6xtLIsRa9alY=;
 b=WntVs19GGZP5VZf6el7/5WMqgtkTZaLyqgukBGctt8CngQMbj8E1AFyUWntfbG1B3Grrr2
 wAy7sVnbYdDqj2Yy+FuH9IUpZIXmOsqialtP83gQzXNaufMojaGCuMrPqQW15I9bC/jKaG
 G39QosPZ3g54C7hpR8xig/xH2f6rysQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-1CDrM_kFNtayAuZI4O45Kw-1; Tue, 17 Dec 2019 09:39:32 -0500
Received: by mail-wm1-f69.google.com with SMTP id n17so476182wmk.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=auOLY9E5UQR9Nt2Vd5T+jcSgI88miFvqR7j1i26WgtA=;
 b=FK9ZwZCQWmgF2YlxwpphQYLN6E40b2K1egFTildJLiFzKvuetA00r8VSjNrmkISsA/
 KTPKc5Y49DYn9ESCOUZ7ruk6TmWEkn2G3KyXBJJzPiJxifxrXZWX6x6ztd9pA7WzwVGE
 vVum3RbkrX1uyzPEg/9piUyPv+jVgleDarmojfBRZyqYIb7roRnsnKIUfFel7r7thLrR
 Yx1ArJ8AxDk+UrfHe0njvNT9FFFyZNugXUeO7c+WDjfqnRd5TJYUTzksdhF/SB86x2N/
 QTFikCG5ciYpqLw6ttkyZkEE9RO7kBTCxCw4JZIk3yNN9XDtXKePheGziX5f4hcJ4QnX
 ewFg==
X-Gm-Message-State: APjAAAVckMd6o6LRxdP0qCNFO/vc32ojwmt7YkEiMjbpa7NinwmKB3p6
 Z3TwopSbY8DvnNsWyW1DFkQtEEMxKdLV7Lj4NN2RjpxQ6J5E8BWvL3X195FQNjBh5ak5ZbPAoJs
 JMN9UgZWLVGp3T9A=
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr6051910wmm.57.1576593571284; 
 Tue, 17 Dec 2019 06:39:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJJ0G/CazOQktzb/MS+DJcE79Y+aceLyEDifO+1ag9i1mM8wt2xTQ3ZH4SiW6kPJaHZ7yEdQ==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr6051893wmm.57.1576593570976; 
 Tue, 17 Dec 2019 06:39:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id 188sm3363051wmd.1.2019.12.17.06.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 06:39:30 -0800 (PST)
Subject: Re: [RFC PATCH] semihosting: suspend recieving CPU when blocked
 (HACK, WIP)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
 <20191217121443.14757-1-alex.bennee@linaro.org>
 <1ca001f0-43a5-d8fc-fee0-3a318cc698e5@redhat.com> <87bls7vzjc.fsf@linaro.org>
 <976227bb-916a-2c50-1f8d-e146a199de15@redhat.com> <875zifvxw0.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b925a8ac-d624-1b35-1a25-da7544dd9fef@redhat.com>
Date: Tue, 17 Dec 2019 15:39:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <875zifvxw0.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: 1CDrM_kFNtayAuZI4O45Kw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: keithp@keithp.com, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 15:18, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 17/12/19 14:42, Alex Benn=C3=A9e wrote:
>>>> Why do you need to set exception_index to something other than -1 (usi=
ng
>>>> cpu_loop_exit_noexc for example)?
>>> If there is no exception to process we won't exit the main loop which w=
e
>>> need to do if we want to wait until there is data to read.
>>
>> Okay.
>>
>>>> Using ->stop here is a bit weird, since ->stop is usually related to
>>>> pause_all_vcpus.
>>>
>>> Arguably we could come up with a better API to cpu.c but this allows us
>>> to use cpu_resume(c->sleeping_cpu) when waking up rather than hand
>>> rolling our own wake-up mechanism.
>>
>> But we already have the right wake-up mechanism, which is
>> cpu->halted/cpu_has_work.
>=20
> cpu_has_work is a guest function though and semihosting_console is a
> common hw module. It can't peek into the guests internal state.

semihosting_console only needs to something like
cpu_interrupt(cpu->stopped_cpu, CPU_INTERRUPT_SEMIHOST).  (By the way,
the stopped_cpu should probably be a list to mimic the condition
variable---for example a GList).

> This all
> comes back to cpu_thread_is_idle anyway in making our decision about if
> we do or do not sleep on the halt_cond.
>=20
>> That also makes it possible to just use
>> EXCP_HALTED instead of adding a new EXCP_BLOCKED.
>=20
> We can certainly use EXCP_HALTED but maybe come up with a common way of
> entering the state? There seems to be a combination of messing around
> with special interrupts and direct poking of cs->halted =3D 1 while
> setting the exception. Maybe this could finally clear up the #if
> defined(TARGET_I386) hacking in cpus.c?

If you're talking accel/tcg/cpu-exec.c, that's different; the issue
there is that x86 has a kind of warm reset pin that is not equivalent to
cpu_reset.  Removing that would only entail adding a new member function
to CPUClass.

Paolo


