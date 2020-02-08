Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12459C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 08:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2021021775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 08:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="neNfrSw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2021021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0LS5-0003Ae-Bp
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 03:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0LRY-0002mC-6O
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 03:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0LRX-0007sM-1y
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 03:26:23 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0LRV-0007px-QG
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 03:26:23 -0500
Received: by mail-wm1-x342.google.com with SMTP id b17so5222961wmb.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 00:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=e27Beo2K8ZrYSc94rjSWYoZKbM9Dki0JVSwCuwIVgJM=;
 b=neNfrSw68ugXj5XjyVxCsaqEA6hCU3+QTDDqe1N7kW01v7VuJK9LFXDDMFbbF/dzp0
 xJKq6YeWyDYW6rfKDScOxNZYEP+Kd/AUPMdo2oBuNrQszw9GhV1i8sMOnaDC6qZt/K9F
 C8k3xp2T0lG5a0BLi6CODx20C42sRF/UxqW6VpxP+hMi+pWBzRjuQEde56XzGHuZ2CyR
 l+kMVVVofDhCuTLsIiGWMSrnkEUJtmbcKQrGm9wM712FIGYhjbzDvzCUjZOREKdIo2v9
 U3OBhRgYukS/I2RmFwdfIKlCARhK3BEVQuB8/TESK74dYQqe9JtW/fnEeFOBbw9fODbq
 8SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e27Beo2K8ZrYSc94rjSWYoZKbM9Dki0JVSwCuwIVgJM=;
 b=iFGz9JaZXf8LShHgChTi1k8l6f8YutPfM/N7sXVfQbdK4FIzWNDM397TuY8giJ7ceV
 +WNrk171+CbC/IYFPN2ysYrLZ07Q4/nqvJLVrrXtrzdQzNtGJO7lZIzgvOro7fTa75kb
 av9QRqLBhCCjwSw7+wwrq1TcH+fp+yH6ACEyk45eNbas6fFbKhgRhZsxhgTlduFZERaf
 3QtNrJnwH9BKa8NHJtZXO+0ST/PkUaiwTFrC9xgP++bba5NevCBvkQ3jqVwYQawrBLFb
 u8EoDZgFaGFHWXzfLMTJPOBihrdVO6PNyG1Bizpk0/fcBWj5TI3N5vpLY10NJWiDm0DN
 1keA==
X-Gm-Message-State: APjAAAV57OeF4IfCAUUKxd3rotwvfFzIYeSAKhT9C3/RoOp+hnqsmIP4
 fla/QMaT0UOWqswb1w3Ttdsb6Q==
X-Google-Smtp-Source: APXvYqwCjEKceXXHydqWTUonM/prNOWsgHng5SAAmxz1NPHUbzq6IYBZt+zFDjhUA+2QR5wG9bJlkQ==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr3255850wmi.75.1581150379962;
 Sat, 08 Feb 2020 00:26:19 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id s12sm6690618wrw.20.2020.02.08.00.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Feb 2020 00:26:19 -0800 (PST)
Subject: Re: [PATCH v3 08/20] target/arm: Remove CPSR_RESERVED
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-9-richard.henderson@linaro.org>
 <CAFEAcA9ARyGgvZR8Ob1GYiRhqwmHKnUFodbUVzC-nk+ifP7oCw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7f805828-d165-31f3-9ea0-674524b630d7@linaro.org>
Date: Sat, 8 Feb 2020 08:26:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ARyGgvZR8Ob1GYiRhqwmHKnUFodbUVzC-nk+ifP7oCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 5:36 PM, Peter Maydell wrote:
>> -    return cpsr_read(env) & ~(CPSR_EXEC | CPSR_RESERVED);
>> +    /*
>> +     * We store the ARMv8 PSTATE.SS bit in env->uncached_cpsr.
>> +     * This is convenient for populating SPSR_ELx, but must be
>> +     * hidden from aarch32 mode, where it is not visible.
>> +     *
>> +     * TODO: ARMv8.4-DIT -- need to move SS somewhere else.
>> +     */
>> +    return cpsr_read(env) & ~(CPSR_EXEC | PSTATE_SS);
> 
> So previously we were masking out [23:21], and now we only mask
> out [21]. Is this OK because we've now masked everywhere that
> might have been able to write non-zero to [23:22] ?

Yes.

On the chance that I've missed one, we'll now call anything that fails to do so
a bug there, and not here.  ;-)

> (regarding the TODO comment, I guess the obvious place would
> be env->pstate.)

That was my thought too.  That env->pstate & PSTATE_SS would be where we leave
that bit all of the time, even when the rest of pstate is inactive in aa32 mode.


r~

