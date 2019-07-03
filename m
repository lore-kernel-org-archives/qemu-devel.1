Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D2C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E152189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvB3hkdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E152189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiQK-0005Yx-Cp
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39391)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hiiMo-0003CF-Qk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hiiMn-0004gJ-Gw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:44:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hiiMn-0004fR-Ah
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:44:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so2914901wma.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7C4mFnjuzIWCK0XbKb7En7qRSpsPwvIHjTK7pDd1ej4=;
 b=PvB3hkdIzOk8mm/QrKDbVK7TPWb3BqgeVKqsP6u0IcqwB9YgFqECmqvJ33aVF7X3Pb
 uzk4wFDbImzekZhVeqX0BiCMugy3zic/SfirL+pSL+qjk4T0qbXqpic5zP3dm+ptVYdt
 pmL4ZMDETrxK9AZ1aI1JoldLdXHPGADg4XFYFnttMlmntz1dFkLqO/CGZxdHXvEgnxhR
 /D13pG9HPlvFCXPUTRJk1b3sovC1VOzzA0nvQXV6Q0PAmlyRFJRWRcV4xksNc0LHmT8x
 eruztuP0bt3C+75g+SGgMmoBG3QwZ53x0+yRHKtXhmVJGjI3kzqfzNAwBUv8rbTBFYml
 gRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7C4mFnjuzIWCK0XbKb7En7qRSpsPwvIHjTK7pDd1ej4=;
 b=XhkIuR23hPc4hzgzB0dBYRNPWFdD4ubHdcZtJwzsQ3kkWSeSYYvNKYSTPh+btR41rM
 yJu69XkslDewnv6gmtzlpdsSHfHyc69fCNpARS6tvAbMQjOgrbJMKpF1QAYZYVDEJYH8
 rt+l37uqeObpoLgRcGTdwhvAIwWGyLbBQukmHb/07RqUCynFmu3yG9bv7IlvHVvdyuWY
 oscw759Sc0a33AfMkNGIbc4bE6XJoyWvCODIfXPdxBjHywvD/j23YaddtJAPXUubU72u
 hooCD6bd2zpZxdYFQmZOrAC6Z1ngTF6I0l4GAfDAs8tnPwfg8ExeY0YR1UcXJtYtxpHn
 4WNw==
X-Gm-Message-State: APjAAAVQuB1JcIT2ve43gd9DlAViV4Zi4Gqham66Y8QSyx9PxMRpPNND
 YbkV7wYqsrG80Qx/sUNd4idVEA==
X-Google-Smtp-Source: APXvYqx0pYxh+YpWb6ik6o/H6X3kActfZEOqz525ifQJjoWDhcACbZPcWacXLRdmBjgcP95hOt81yA==
X-Received: by 2002:a1c:7a15:: with SMTP id v21mr8679029wmc.176.1562172259600; 
 Wed, 03 Jul 2019 09:44:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h14sm3430954wrs.66.2019.07.03.09.44.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 09:44:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADD6A1FF87;
 Wed,  3 Jul 2019 17:44:18 +0100 (BST)
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-5-alex.bennee@linaro.org>
 <2c0b9e7f-f4d1-b52b-1f3a-4100bf50c151@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <2c0b9e7f-f4d1-b52b-1f3a-4100bf50c151@redhat.com>
Date: Wed, 03 Jul 2019 17:44:18 +0100
Message-ID: <87lfxfvzj1.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 4/4] target/arm: remove run time
 semihosting checks
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Alex, Peter.
>
> On 7/3/19 5:52 PM, Alex Benn=C3=A9e wrote:
>> Now we do all our checking and use a common EXCP_SEMIHOST for
>> semihosting operations we can make helper code a lot simpler.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/arm/helper.c | 84 +++++++++------------------------------------
>>  1 file changed, 17 insertions(+), 67 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index ad29dc4072..5c1f741380 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -10364,83 +10364,33 @@ static void arm_cpu_do_interrupt_aarch64(CPUSt=
ate *cs)
>>                    new_el, env->pc, pstate_read(env));
>>  }
>>
>> -static inline bool check_for_semihosting(CPUState *cs)
>> +/*
>> + * Check whether this exception is a semihosting call; if so
>> + * then handle it and return true; otherwise return false.
>> + *
>> + * All the permission and validity checks are done at translate time.
>> + */
>> +static inline bool handle_semihosting(CPUState *cs)
>>  {
>> -    /* Check whether this exception is a semihosting call; if so
>> -     * then handle it and return true; otherwise return false.
>> -     */
>>      ARMCPU *cpu =3D ARM_CPU(cs);
>>      CPUARMState *env =3D &cpu->env;
>>
>> -    if (is_a64(env)) {
>> -        if (cs->exception_index =3D=3D EXCP_SEMIHOST) {
>> -            /* This is always the 64-bit semihosting exception.
>> -             * The "is this usermode" and "is semihosting enabled"
>> -             * checks have been done at translate time.
>> -             */
>> +    if (cs->exception_index =3D=3D EXCP_SEMIHOST) {
>> +        if (is_a64(env)) {
>>              qemu_log_mask(CPU_LOG_INT,
>>                            "...handling as semihosting call 0x%" PRIx64 =
"\n",
>>                            env->xregs[0]);
>>              env->xregs[0] =3D do_arm_semihosting(env);
>> -            return true;
>> -        }
>> -        return false;
>> -    } else {
>> -        uint32_t imm;
>> -
>> -        /* Only intercept calls from privileged modes, to provide some
>> -         * semblance of security.
>> -         */
>> -        if (cs->exception_index !=3D EXCP_SEMIHOST &&
>> -            (!semihosting_enabled() ||
>> -             ((env->uncached_cpsr & CPSR_M) =3D=3D ARM_CPU_MODE_USR))) {
>> -            return false;
>> -        }
>> -
>> -        switch (cs->exception_index) {
>> -        case EXCP_SEMIHOST:
>> -            /* This is always a semihosting call; the "is this usermode"
>> -             * and "is semihosting enabled" checks have been done at
>> -             * translate time.
>> -             */
>> -            break;
>> -        case EXCP_SWI:
>> -            /* Check for semihosting interrupt.  */
>> -            if (env->thumb) {
>> -                imm =3D arm_lduw_code(env, env->regs[15] - 2, arm_sctlr=
_b(env))
>> -                    & 0xff;
>> -                if (imm =3D=3D 0xab) {
>> -                    break;
>> -                }
>> -            } else {
>> -                imm =3D arm_ldl_code(env, env->regs[15] - 4, arm_sctlr_=
b(env))
>> -                    & 0xffffff;
>> -                if (imm =3D=3D 0x123456) {
>> -                    break;
>> -                }
>> -            }
>> -            return false;
>> -        case EXCP_BKPT:
>> -            /* See if this is a semihosting syscall.  */
>> -            if (env->thumb) {
>> -                imm =3D arm_lduw_code(env, env->regs[15], arm_sctlr_b(e=
nv))
>> -                    & 0xff;
>> -                if (imm =3D=3D 0xab) {
>> -                    env->regs[15] +=3D 2;
>> -                    break;
>> -                }
>> -            }
>> -            return false;
>> -        default:
>> -            return false;
>> +        } else {
>> +            qemu_log_mask(CPU_LOG_INT,
>> +                          "...handling as semihosting call 0x%x\n",
>> +                          env->regs[0]);
>> +            env->regs[0] =3D do_arm_semihosting(env);
>>          }
>> -
>> -        qemu_log_mask(CPU_LOG_INT,
>> -                      "...handling as semihosting call 0x%x\n",
>> -                      env->regs[0]);
>> -        env->regs[0] =3D do_arm_semihosting(env);
>>          return true;
>>      }
>> +
>> +    return false;
>>  }
>>
>>  /* Handle a CPU exception for A and R profile CPUs.
>> @@ -10476,7 +10426,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>>       * code that caused the exception, not the target exception level,
>>       * so must be handled here.
>>       */
>> -    if (check_for_semihosting(cs)) {
>> +    if (handle_semihosting(cs)) {
>>          return;
>>      }
>>
>>
>
> This patch clashes with this one:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00343.html
> that Peter already queued:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00692.html
>
> Peter, if you want this for 4.1, it might be easier to dequeue "Restrict
> semi-hosting to TCG", apply Alex series, and re-apply "Restrict
> semi-hosting to TCG", the conflicts should be trivial (function name
> changed check_for_semihosting -> handle_semihosting).

This isn't 4.1 material - unless I can figure out the weird single-step
while semihosting bug.

>
> Thanks,
>
> Phil.


--
Alex Benn=C3=A9e

