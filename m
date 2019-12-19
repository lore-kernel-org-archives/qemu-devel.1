Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44261C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F70220716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqmdw2Fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F70220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii053-0007aH-Px
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihzw8-0002nO-G1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihzw6-0001zQ-IR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:50:08 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihzw6-0001vq-8F
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:50:06 -0500
Received: by mail-wr1-x442.google.com with SMTP id b6so6922349wrq.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 09:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+7J6cwWsK5m8RqJIJw6UIA4O+t2/hnH9oWFBaj1UuGk=;
 b=aqmdw2Fxer+fvZqA0W7mDAfv3bUKgoVaVNuTu1BbpO4Sh7mH/QseDpDry+Y2fds+qu
 vEw48Q7sd5ZaGYJa9O5z/x/m/+IqONfjxP6BYR//UsU7nU7MHpM9MYVOio82jTd4ay5k
 /Dmhih6XpTVhDBtxQ0L0lBLhj8D+kRj/XbSltCWnVe0xZk/Yo7lcH9I3REA4xottjyC+
 1hNCbx6IbOhtfOjPnJjnqPGvEWNDePIwIcKrA17s+tcTo+ge34AZhy54rywi/25LqkC4
 o275hzNubYxw0OJ4FApSuYhP0yvZX/2PfXlU+yIv1uz1nT8U34Lco+2zmQXseuvjAEAb
 R2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+7J6cwWsK5m8RqJIJw6UIA4O+t2/hnH9oWFBaj1UuGk=;
 b=mL+GYrQMqVMaPlJJZNQu4bn7Y1mDEVdMGJbZqCqKG+31h3mXPumL9xqiOxnQUkR20X
 kx0S2hDuRcdY7MAiCZjSdBKhYovVa/eS3m4bzoNlhNrm4FLPM2n+nHI0M/p86mAqkXRo
 f0c7EHjz/JC2cqeJi7rKiFo22nm24KFBkGAYlT1eKTCHrKsUzUamxk6DFF8mxM9lUSWu
 3pNRhfDL5PYlPikCu8f6OGIY6HebK9rNvYK+ei4Ih//YZ7Gdbbo1A4NHmdhVcSALM/iu
 vo5GOMqI+k1IIzwNcDLNEZk29yY4aPw/fmMDpeBr4I3jRyBir5Si/uNozkg4CzUcS/ms
 o9wA==
X-Gm-Message-State: APjAAAWoIFoN7YcEWbEl0Z55KeQAw3bIaB4zZXmJzcmUBc8RdqU05bpp
 +0teh6ElT7YijuRLVhYaVWvwRA==
X-Google-Smtp-Source: APXvYqz13j+q5pdEgvqzsgbPKB8JtdS/k6KeljD9N1df6AJ+pYoOVFElzTAtoGfaBs0k0l0e37/Krw==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr10353018wrr.309.1576777803448; 
 Thu, 19 Dec 2019 09:50:03 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x10sm6945535wrv.60.2019.12.19.09.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 09:50:01 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C55D51FF87;
 Thu, 19 Dec 2019 17:50:00 +0000 (GMT)
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-9-alex.bennee@linaro.org>
 <b65e722f-7524-9269-3f36-6045ab5393c5@greensocs.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v3 08/20] gdbstub: extend GByteArray to read register
 helpers
In-reply-to: <b65e722f-7524-9269-3f36-6045ab5393c5@greensocs.com>
Date: Thu, 19 Dec 2019 17:50:00 +0000
Message-ID: <87mubodx2v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 luis.machado@linaro.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 alan.hayward@arm.com, "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 richard.henderson@linaro.org, "open list:S390 TCG
 CPUs" <qemu-s390x@nongnu.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Damien Hedde <damien.hedde@greensocs.com> writes:

> Hi Alex,
>
> On 12/11/19 6:05 PM, Alex Benn=C3=A9e wrote:
>> Instead of passing a pointer to memory now just extend the GByteArray
>> to all the read register helpers. They can then safely append their
>> data through the normal way. We don't bother with this abstraction for
>> write registers as we have already ensured the buffer being copied
>> from is the correct size.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> [...]
>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 0ac950d6c71..6476245e789 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -47,30 +47,27 @@ static bool get_phys_addr_lpae(CPUARMState *env, tar=
get_ulong address,
>>=20=20
>>  static void switch_mode(CPUARMState *env, int mode);
>>=20=20
>> -static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
>> +static int vfp_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
>>  {
>>      int nregs;
>>=20=20
>>      /* VFP data registers are always little-endian.  */
>>      nregs =3D arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
>>      if (reg < nregs) {
>> -        stq_le_p(buf, *aa32_vfp_dreg(env, reg));
>> -        return 8;
>> +        return gdb_get_reg64(buf, *aa32_vfp_dreg(env, reg));
>
> It was a little-endian version, you've put a target-endian version.
> Is that what you meant ?

Yes - I suspect this would have been broken if used by a big-endian
system. gdbstub generally (SVE excepted) wants things in target order.

>
>>      }
>>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>>          /* Aliases for Q regs.  */
>>          nregs +=3D 16;
>>          if (reg < nregs) {
>>              uint64_t *q =3D aa32_vfp_qreg(env, reg - 32);
>> -            stq_le_p(buf, q[0]);
>> -            stq_le_p(buf + 8, q[1]);
>> -            return 16;
>> +            return gdb_get_reg128(buf, q[0], q[1]);
>
> Ditto here.
>
>>          }
>>      }
>>      switch (reg - nregs) {
>> -    case 0: stl_p(buf, env->vfp.xregs[ARM_VFP_FPSID]); return 4;
>> -    case 1: stl_p(buf, vfp_get_fpscr(env)); return 4;
>> -    case 2: stl_p(buf, env->vfp.xregs[ARM_VFP_FPEXC]); return 4;
>> +    case 0: return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]); b=
reak;
>> +    case 1: return gdb_get_reg32(buf, vfp_get_fpscr(env)); break;
>> +    case 2: return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPEXC]); b=
reak;
>>      }
>>      return 0;
>>  }
>> @@ -101,7 +98,7 @@ static int vfp_gdb_set_reg(CPUARMState *env, uint8_t =
*buf, int reg)
>>      return 0;
>>  }
>>=20=20
>> -static int aarch64_fpu_gdb_get_reg(CPUARMState *env, uint8_t *buf, int =
reg)
>> +static int aarch64_fpu_gdb_get_reg(CPUARMState *env, GByteArray *buf, i=
nt reg)
>>  {
>>      switch (reg) {
>>      case 0 ... 31:
>> @@ -204,7 +201,7 @@ static void write_raw_cp_reg(CPUARMState *env, const=
 ARMCPRegInfo *ri,
>>      }
>>  }
>>=20=20
>> -static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
>> +static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int re=
g)
>>  {
>>      ARMCPU *cpu =3D env_archcpu(env);
>>      const ARMCPRegInfo *ri;
>
> [...]
>
>> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
>> index 823759c92e7..6f08021cc22 100644
>> --- a/target/ppc/gdbstub.c
>> +++ b/target/ppc/gdbstub.c
>> @@ -114,10 +114,11 @@ void ppc_maybe_bswap_register(CPUPPCState *env, ui=
nt8_t *mem_buf, int len)
>>   * the FP regs zero size when talking to a newer gdb.
>>   */
>>=20=20
>> -int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
>> +int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
>>  {
>>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>>      CPUPPCState *env =3D &cpu->env;
>> +    uint8_t *mem_buf;
>>      int r =3D ppc_gdb_register_len(n);
>>=20=20
>>      if (!r) {
>> @@ -126,17 +127,17 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_=
t *mem_buf, int n)
>>=20=20
>>      if (n < 32) {
>>          /* gprs */
>> -        gdb_get_regl(mem_buf, env->gpr[n]);
>> +        gdb_get_regl(buf, env->gpr[n]);
>>      } else if (n < 64) {
>>          /* fprs */
>> -        stfq_p(mem_buf, *cpu_fpr_ptr(env, n - 32));
>> +        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
>>      } else {
>>          switch (n) {
>>          case 64:
>> -            gdb_get_regl(mem_buf, env->nip);
>> +            gdb_get_regl(buf, env->nip);
>>              break;
>>          case 65:
>> -            gdb_get_regl(mem_buf, env->msr);
>> +            gdb_get_regl(buf, env->msr);
>>              break;
>>          case 66:
>>              {
>> @@ -145,31 +146,33 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_=
t *mem_buf, int n)
>>                  for (i =3D 0; i < 8; i++) {
>>                      cr |=3D env->crf[i] << (32 - ((i + 1) * 4));
>>                  }
>> -                gdb_get_reg32(mem_buf, cr);
>> +                gdb_get_reg32(buf, cr);
>>                  break;
>>              }
>>          case 67:
>> -            gdb_get_regl(mem_buf, env->lr);
>> +            gdb_get_regl(buf, env->lr);
>>              break;
>>          case 68:
>> -            gdb_get_regl(mem_buf, env->ctr);
>> +            gdb_get_regl(buf, env->ctr);
>>              break;
>>          case 69:
>> -            gdb_get_reg32(mem_buf, env->xer);
>> +            gdb_get_reg32(buf, env->xer);
>>              break;
>>          case 70:
>> -            gdb_get_reg32(mem_buf, env->fpscr);
>> +            gdb_get_reg32(buf, env->fpscr);
>>              break;
>>          }
>>      }
>> +    mem_buf =3D buf->data - r;
>
> Should it not be something more like this ?
> mem_buf =3D buf->data + buf->len - r;

Good catch.

>
> There seem to be the same issue below for every
> ppc_maybe_bswap_register() call.

Fixed.


--=20
Alex Benn=C3=A9e

