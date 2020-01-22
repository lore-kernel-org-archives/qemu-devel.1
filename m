Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8906AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B54B24656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EvELew3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B54B24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuKKj-00073F-G0
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 13:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuKJj-0006Pe-Aq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuKJh-0006Ok-W1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:01:27 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuKJh-0006O3-N9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:01:25 -0500
Received: by mail-pj1-x1041.google.com with SMTP id a6so243767pjh.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dnfEHm9HyvHwYytPGYJoBTQnFgHXFDV5JHgJbsUbubM=;
 b=EvELew3t9C9qZj014SRkfqEN60weeaUmTuhckcpurUYG1I1TPiERtnCb2MF7WGX8C+
 yHT4YS0elW6LG7hoks4TgIQBRZlvGOeghCieZ8YTkLgjtC6nDPbrGpkcWgFzPkrOovJA
 MsyXfHLFBpPlBdpAh4udY/1DpS9WAKaFrXlFs4zTqMpzYjjwi7f5p2c8UtTYIIXyVcJS
 /zQrZdsL2bXKE1JEF3Gc+7wOWZPKtDSK6A2DPy4SHHfOHY0WRqlyMH0bCdOwuZroq0UD
 zv2JWnJrFTnCbS/9KhLHBcw6Pe/p+nN2TBiSoP0/qwWnYBzdEFe9HiN2lMLFxSYXEK46
 8yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dnfEHm9HyvHwYytPGYJoBTQnFgHXFDV5JHgJbsUbubM=;
 b=n5L0sMkf3cGmBwyamyVrTjKkxmkWg7IQz/vLEY9oMPmNzDajhgB/NzlZOJZ+7IiD7g
 AjBuoScoPwtFGXiKl9P5YKeTAzr+FZQyLOr5ryt5qZ3NQEAqbupnwZqsV8pMf2O7PgL3
 hRf/Ks2cjhn+1yUmFznfjryZfLVwBOL+Ruq34Has8fUZs8AUwA9m3es4S37KgjgNbl4P
 5deeq64hgIiLTiIzIxZWjzh5Tlu5OoB+xQiSz2GaeZn2RT+inCTZB+SK/kw3XEDQKMHY
 V+gEvkSXF7gEoBBJbDj1PyPGSFB9dPVT7wRDzM0+6HkN6pbtq9Bbeed2IQL8tA6OqXYU
 EImQ==
X-Gm-Message-State: APjAAAXWrPhP1MR24nKXG/nhkeVVgd/RMxCVGwIybe1Cbvc5Kzsk2/wr
 rPTb8LyPtH+fPKyfkm1fKevOAZHGmpw=
X-Google-Smtp-Source: APXvYqy/U6WZoLxoA9VIsB9RPVOKWUFloVPaAoO0yWvn7m1nPwjBC7yflupRXMgaHBzxslGZ8K5C+g==
X-Received: by 2002:a17:90b:4004:: with SMTP id
 ie4mr4386592pjb.49.1579716084164; 
 Wed, 22 Jan 2020 10:01:24 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id u13sm4184989pjn.29.2020.01.22.10.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 10:01:23 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC PATCH] Implement qemu_thread_yield for posix,
 use it in mttcg to handle EXCP_YIELD
To: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190717054655.14104-1-npiggin@gmail.com>
 <87h81vdtv2.fsf@linaro.org> <1579604990.qzk2f3181l.astroid@bobo.none>
 <87ftg827ug.fsf@linaro.org> <20200122032659.GG2347@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f9572c3-508e-0bd1-a5d4-7e42fa168986@linaro.org>
Date: Wed, 22 Jan 2020 08:01:18 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122032659.GG2347@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 5:26 PM, David Gibson wrote:
> However, a more common use of qemu is the "pseries" machine type,
> which emulates only a guest (in the cpu architectural sense) with qemu
> taking the place of the hypervisor as well as emulating the cpus.  In
> that case the H_CONFER hypercall goes to qemu.
> 
>> If you are running QEMU as a KVM monitor this is still outside of it's
>> scope as all the scheduling shenanigans are dealt with inside the
>> kernel.
>>
>> From QEMU's TCG point of view we want to concern ourselves with what the
>> real hardware would do - which I think in this case is drop to the
>> hypervisor and let it sort it out.
> 
> Right, but with the "pseries" machine type qemu *is* the hypervisor.

In which case this behaviour doesn't seem implausible.

I will note that "pthread_yield" isn't standardized; "sched_yield" is the one
in POSIX.  Though that says nothing about how that syscall might affect a
hypothetical many-to-one pthread implementation.  You could, I suppose, have a
configure test for pthread_yield.

Also, the win32 implementation would be SwitchToThread():

https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-switchtothread

It looks like one need do nothing for the single-threaded implementation,
qemu_tcg_rr_cpu_thread_fn, as any return to the main loop will select the next
round-robin cpu.  But a note to say that's been tested would be nice.


r~

