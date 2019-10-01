Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E3C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EAF2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8xvVhnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EAF2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMBD-0008Mc-7t
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFM8I-0006j1-Se
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFM8G-0006IH-Do
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:40:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFM8G-0006HB-7Q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:40:16 -0400
Received: by mail-wm1-x342.google.com with SMTP id a6so4293523wma.5
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VU9EYM0m5B7S8EPMwHBy8k3bQXLjfT39hP72D3Jen/8=;
 b=Z8xvVhnPU/8D3jpX+D8yIg282jzWv9kanm9MEgMPjy7XKy1ww3Www9zaXA/3CZs18D
 siwUsOg0Jmm7BpJjRgLpV1kep2YQ72gObn1dyOlXv0zXMPf1qZ/d2cMUX0rgT9SvmrKL
 U0fim013WJAj6HZhUF+uXrjBvNovrlqU+NiOo8lo2KxkjmR9rIaA+gCO3eybw2B1htQd
 6IrgYAQbr+GshG5t20zsYA/I5WxaeM8wFcqIw2qrTi2/sNMyED/0wEH18vmWMebAUGMQ
 +3b7vktsRvTJPM/0v0VJsM0tiirXORlWrDKQuxuEhGpxz5IG0t4iu9e76FtaNez0zn91
 Z1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VU9EYM0m5B7S8EPMwHBy8k3bQXLjfT39hP72D3Jen/8=;
 b=J68PB4f8yGdQsl9p4TzPAmUcBDGVHhGzsjtrhjc90gLVwer4eUMTfKlfBP/Qm7khmr
 /r3DT+ntNmfvz02TNPSYZIvGmp2gulvxzfdUojfHfCfT6VLkKS2VOkawDUPlMZkmqhbs
 mTVYsBs+7xUsgIUujMyGOFmOOGLg48NQEXDg3oCAtgW3iF6SCfTZkk037jZaet/GjzYz
 dxIo4WtOJJuyxf/K4DzT83ZR9pu+IKLmAK3oUhlkq4xb2jhf0yu6lzHOM4jSoGz1juUX
 VyPTK1LcZTEfPT+MW2X0rWcufIxHm9b5KTMabKUIevAYWYkweSwnmWfE5+LPxK7P5uKO
 D+Vg==
X-Gm-Message-State: APjAAAXa0mTddYi+TxhT1YR0oatxs/lQLHxMRzLYPFKvChJ8lS3xvriQ
 RbgPZa4uM18bmzp1ixs+bGVoTA==
X-Google-Smtp-Source: APXvYqwBDYdJkUqDKQkwZ0i4bX5BqUcNZHIYSTWsOVRXZe0vPmCKzKXS1f8TdsDG71BhJE22nS01dw==
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr5002123wmi.31.1569951614671;
 Tue, 01 Oct 2019 10:40:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n22sm4022141wmk.19.2019.10.01.10.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:40:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 284421FF87;
 Tue,  1 Oct 2019 18:40:13 +0100 (BST)
References: <20191001160426.26644-1-alex.bennee@linaro.org>
 <5582c91e-ac0e-9f74-a3de-82f7fe25fadd@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] cpus: kick all vCPUs when running thread=single
In-reply-to: <5582c91e-ac0e-9f74-a3de-82f7fe25fadd@redhat.com>
Date: Tue, 01 Oct 2019 18:40:13 +0100
Message-ID: <874l0sl5z6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 01/10/19 18:04, Alex Benn=C3=A9e wrote:
>> qemu_cpu_kick is used for a number of reasons including to indicate
>> there is work to be done. However when thread=3Dsingle the old
>> qemu_cpu_kick_rr_cpu only advanced the vCPU to the next executing one
>> which can lead to a hang in the case that:
>>
>>   a) the kick is from outside the vCPUs (e.g. iothread)
>>   b) the timers are paused (i.e. iothread calling run_on_cpu)
>>
>> To avoid this lets split qemu_cpu_kick_rr into two functions. One for
>> the timer which continues to advance to the next timeslice and another
>> for all other kicks.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Doug Gale <doug16k@gmail.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  cpus.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> Looks good to me.  Single-threaded TCG is not going to have high vCPU
> counts anyway.

Are you going to take this via your queue?

>
> Paolo
>
>> diff --git a/cpus.c b/cpus.c
>> index d2c61ff155..bee7209134 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -949,8 +949,8 @@ static inline int64_t qemu_tcg_next_kick(void)
>>      return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
>>  }
>>
>> -/* Kick the currently round-robin scheduled vCPU */
>> -static void qemu_cpu_kick_rr_cpu(void)
>> +/* Kick the currently round-robin scheduled vCPU to next */
>> +static void qemu_cpu_kick_rr_next_cpu(void)
>>  {
>>      CPUState *cpu;
>>      do {
>> @@ -961,6 +961,16 @@ static void qemu_cpu_kick_rr_cpu(void)
>>      } while (cpu !=3D atomic_mb_read(&tcg_current_rr_cpu));
>>  }
>>
>> +/* Kick all RR vCPUs */
>> +static void qemu_cpu_kick_rr_cpus(void)
>> +{
>> +    CPUState *cpu;
>> +
>> +    CPU_FOREACH(cpu) {
>> +        cpu_exit(cpu);
>> +    };
>> +}
>> +
>>  static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
>>  {
>>  }
>> @@ -993,7 +1003,7 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockTy=
pe type)
>>  static void kick_tcg_thread(void *opaque)
>>  {
>>      timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
>> -    qemu_cpu_kick_rr_cpu();
>> +    qemu_cpu_kick_rr_next_cpu();
>>  }
>>
>>  static void start_tcg_kick_timer(void)
>> @@ -1828,9 +1838,11 @@ void qemu_cpu_kick(CPUState *cpu)
>>  {
>>      qemu_cond_broadcast(cpu->halt_cond);
>>      if (tcg_enabled()) {
>> -        cpu_exit(cpu);
>> -        /* NOP unless doing single-thread RR */
>> -        qemu_cpu_kick_rr_cpu();
>> +        if (qemu_tcg_mttcg_enabled()) {
>> +            cpu_exit(cpu);
>> +        } else {
>> +            qemu_cpu_kick_rr_cpus();
>> +        }
>>      } else {
>>          if (hax_enabled()) {
>>              /*
>>


--
Alex Benn=C3=A9e

