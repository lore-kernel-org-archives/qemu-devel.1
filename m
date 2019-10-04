Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606CEC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3CA215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBCUbch9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3CA215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNTy-0005IV-54
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iGNRA-0003jH-EX
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iGNR8-0008MS-4B
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:15:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iGNR6-0008LQ-K6
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:15:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id r5so7106675wrm.12
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GvhVYeaTrlQ57nBiUBBdjG0/K/BXl2BRc3Cxhd3iROY=;
 b=QBCUbch90Euvos0425OIqwlsyT9OqIc9uHcsXhAlvLpTpXjb2KgaWgRPL33Gkt0eIc
 m/YLh09yCUEmQknlINd8RV7HmqVUzlc58aCm8XShOCjSg+4QP/JlndKuenKK4XdE56D0
 nrmf9X08nFigJi4wSAitfmSS2C8LXnofcVVoQIYr5dmblJpDGxYD75xzK/UHdphYUi8Y
 8CY9Z3w0qYJJMJUFFw5OJsVrnowVpJhrmqO6H4dtvqq9CxGMH4UCtMHZriPnp26MjZQ/
 vh/IdOvS4oSLjrdUFh/7sZ1BBbYGk1ojJ/rUegraL4FtDxHSrIqOheQ08qoUeZ/4hM5/
 1m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GvhVYeaTrlQ57nBiUBBdjG0/K/BXl2BRc3Cxhd3iROY=;
 b=M7LGPp9JpQLlytNGjackFWPvVa4MGHuQ3zoULR4ATPSwQ3o/YwShSm8gcdI9zSpzsN
 ZWOWxUjofgMf2vvQ6iZL1orNV3JRc4+ZBK3ZufGClZCLYfZiwQfOKvsqbUFnY2xDOFIM
 t0YFnosSvDI8axpwAblEoMQd6agf+/6VORI7YOPZotuUntf2Xr5IuZspR7zINhi2BbP4
 0acfBinP9s4+tVbPqiSvu9PKR5/c/6KMhbHGx3Wl5SGcIBYpY8tExirrlDni4vPYQbtR
 i91sX2kZCZeKMKIoVxqbC4l3Rnljuhypj69y0oSMMNoxpgDkjIVdDNjMWxyEtGj864Tr
 CMqA==
X-Gm-Message-State: APjAAAV7FUCTA0I/gGigfqcalyhO8kzjfDr8b8GaWdCBtTYgtFEGKizn
 AlbJ5TW1JWtspgqJCFnR1sGfRQ==
X-Google-Smtp-Source: APXvYqxwZ4gk9ffULiNADRKp7BbhO14r3BiVxiddnDHu5G9nCeBm6MiJUH1ulvP5vrkYni8K21h8nw==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr6265236wrw.32.1570194954751;
 Fri, 04 Oct 2019 06:15:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b22sm5629531wmj.36.2019.10.04.06.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2019 06:15:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 553181FF87;
 Fri,  4 Oct 2019 14:15:53 +0100 (BST)
References: <20191002082636.7739-1-david@redhat.com>
 <87zhijjwph.fsf@linaro.org>
 <0479ad1f-348e-ed40-c2c6-aef168afdb7e@linaro.org>
 <379c2065-adfe-0847-46f3-7f25c7650df9@linaro.org>
 <17a008ed-8ec0-2732-347d-bb04b6d832e8@redhat.com>
 <CAFEAcA97hjbh+0rhTABhn_FwhLOoGq53=_397cGv9cnZfmQRUA@mail.gmail.com>
 <8ff6a5ef-7e44-5505-8d8f-a0e5bef29479@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] s390x/tcg: MVCL: Exit to main loop if requested
In-reply-to: <8ff6a5ef-7e44-5505-8d8f-a0e5bef29479@redhat.com>
Date: Fri, 04 Oct 2019 14:15:53 +0100
Message-ID: <87eezsircm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 04.10.19 14:11, Peter Maydell wrote:
>> On Fri, 4 Oct 2019 at 09:02, David Hildenbrand <david@redhat.com> wrote:
>>> So shall we leave this patch as-is (adding a summary of what you
>>> explained to the description) or shall we somehow factor out the
>>> TCG-internal-thingy check?
>>
>> Nothing else in target code touches the icount data structures,
>> so if this s390 insn needs to make this check I think it ought
>> to do it by calling a function implemented by the tcg code;
>> that can then have a good name that describes what it's doing
>> and a doc comment explaining the reason we need to have it.
>>
>> thanks
>> -- PMM
>>
>
> I can offer something like this:
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 49db07ba0b..d370ac0134 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -72,6 +72,26 @@ void QEMU_NORETURN cpu_loop_exit(CPUState *cpu);
>  void QEMU_NORETURN cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
>  void QEMU_NORETURN cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
>
> +/**
> + * cpu_cond_loop_exit_restore:
> + * @cpu: the vCPU state to be restored
> + * @pc: the host PC
> + *
> + * Trigger a cpu_loop_exit_restore() in case somebody asked for a return
> + * to the main loop (e.g. cpu_exit() or cpu_interrupt()).
> + *
> + * This is helpful for architectures that support interruptible
> + * instructions. After writing back all state to registers/memory, this
> + * call can be used to conditionally return back to the main loop or to
> + * continue executing the interruptible instruction.
> + */
> +static inline void cpu_cond_loop_exit_restore(CPUState *cpu, uintptr_t p=
c)
> +{
> +    if (unlikely((int32_t)atomic_read(&cpu_neg(cs)->icount_decr.u32) < 0=
)) {
> +        cpu_loop_exit_restore(cs, ra);
> +    }
> +}
> +

cpu_loop_exit_restore_cond_irq
cpu_loop_exit_restore_ifirq
cpu_loop_exit_restore_conditional
cpu_loop_exit_restore_maybe

meh, naming stuff is hard:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>  #if !defined(CONFIG_USER_ONLY)
>  void cpu_reloading_memory_map(void);
>  /**
>
>
> Or, as alternative, something like "cpu_shall_exit()" which only
> wraps the single check.


--
Alex Benn=C3=A9e

