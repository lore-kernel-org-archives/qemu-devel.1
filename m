Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88910C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4460322527
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="fAl0Y54H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4460322527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if6p8-0002mX-4M
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 13:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1if6mR-000207-KW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1if6mP-00012O-JV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:32:11 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:53956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1if6mK-0000vg-CS; Wed, 11 Dec 2019 13:32:04 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 300BF96EF0;
 Wed, 11 Dec 2019 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576089121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQ5xyVW08Yw0tiMnTbHBQxwUQsPAL+SLR0RjCN/xVwQ=;
 b=fAl0Y54H0WvabByUlsIUS+w7FlVJ5wnWmaPKFYP6B9IJyDLtaPdF1nDzKfZ0fXDPHqHjmN
 yYZKskzRQCnD5AvqmXGgIcSOX0hgc8uKv4aIxM8mwB2wB85bEhPkIhd6d46sKvIWDewdAh
 7eLhssqavBHsko38WYhL2ta0EgKkozs=
Subject: Re: [PATCH v3 08/20] gdbstub: extend GByteArray to read register
 helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-9-alex.bennee@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <b65e722f-7524-9269-3f36-6045ab5393c5@greensocs.com>
Date: Wed, 11 Dec 2019 19:31:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191211170520.7747-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576089121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQ5xyVW08Yw0tiMnTbHBQxwUQsPAL+SLR0RjCN/xVwQ=;
 b=QWFzz8Xc8qssztDzulzl2qUg/Y2Hi3b+740Hj8v5WC7oYh1MVWDFq9M86v9ZfrVFwJ9tFR
 y3TcCJ8illJ7PbaWhQqvEG6BLU+/Rvec8D0lkx0m9OjRljRSApaCqFsVVNBg46viyjQY4O
 gW2UoLQW/+EjMSGHrOvGYbBXqfLImMM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576089121; a=rsa-sha256; cv=none;
 b=AdJvTldr38lAKee51wr23drslH+ZiFf69ixXo+bZmkc2IjO+Zts7XspKqv1O1VaoZ7qC+M
 mBHDotNTEDcdIEctLayxnBt8LgdnrzSdWB63rlOqQENmprqqzK+YeY+gyknZpKZ5U9sWzz
 /hxW4+LBQmnBHJOLPq26xZHVOC55fJc=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 alan.hayward@arm.com, "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 richard.henderson@linaro.org,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
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


Hi Alex,

On 12/11/19 6:05 PM, Alex Benn=C3=A9e wrote:
> Instead of passing a pointer to memory now just extend the GByteArray
> to all the read register helpers. They can then safely append their
> data through the normal way. We don't bother with this abstraction for
> write registers as we have already ensured the buffer being copied
> from is the correct size.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

[...]

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0ac950d6c71..6476245e789 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -47,30 +47,27 @@ static bool get_phys_addr_lpae(CPUARMState *env, ta=
rget_ulong address,
> =20
>  static void switch_mode(CPUARMState *env, int mode);
> =20
> -static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
> +static int vfp_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
>  {
>      int nregs;
> =20
>      /* VFP data registers are always little-endian.  */
>      nregs =3D arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
>      if (reg < nregs) {
> -        stq_le_p(buf, *aa32_vfp_dreg(env, reg));
> -        return 8;
> +        return gdb_get_reg64(buf, *aa32_vfp_dreg(env, reg));

It was a little-endian version, you've put a target-endian version.
Is that what you meant ?

>      }
>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>          /* Aliases for Q regs.  */
>          nregs +=3D 16;
>          if (reg < nregs) {
>              uint64_t *q =3D aa32_vfp_qreg(env, reg - 32);
> -            stq_le_p(buf, q[0]);
> -            stq_le_p(buf + 8, q[1]);
> -            return 16;
> +            return gdb_get_reg128(buf, q[0], q[1]);

Ditto here.

>          }
>      }
>      switch (reg - nregs) {
> -    case 0: stl_p(buf, env->vfp.xregs[ARM_VFP_FPSID]); return 4;
> -    case 1: stl_p(buf, vfp_get_fpscr(env)); return 4;
> -    case 2: stl_p(buf, env->vfp.xregs[ARM_VFP_FPEXC]); return 4;
> +    case 0: return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]); =
break;
> +    case 1: return gdb_get_reg32(buf, vfp_get_fpscr(env)); break;
> +    case 2: return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPEXC]); =
break;
>      }
>      return 0;
>  }
> @@ -101,7 +98,7 @@ static int vfp_gdb_set_reg(CPUARMState *env, uint8_t=
 *buf, int reg)
>      return 0;
>  }
> =20
> -static int aarch64_fpu_gdb_get_reg(CPUARMState *env, uint8_t *buf, int=
 reg)
> +static int aarch64_fpu_gdb_get_reg(CPUARMState *env, GByteArray *buf, =
int reg)
>  {
>      switch (reg) {
>      case 0 ... 31:
> @@ -204,7 +201,7 @@ static void write_raw_cp_reg(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
>      }
>  }
> =20
> -static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
> +static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int r=
eg)
>  {
>      ARMCPU *cpu =3D env_archcpu(env);
>      const ARMCPRegInfo *ri;

[...]

> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 823759c92e7..6f08021cc22 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -114,10 +114,11 @@ void ppc_maybe_bswap_register(CPUPPCState *env, u=
int8_t *mem_buf, int len)
>   * the FP regs zero size when talking to a newer gdb.
>   */
> =20
> -int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> +    uint8_t *mem_buf;
>      int r =3D ppc_gdb_register_len(n);
> =20
>      if (!r) {
> @@ -126,17 +127,17 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8=
_t *mem_buf, int n)
> =20
>      if (n < 32) {
>          /* gprs */
> -        gdb_get_regl(mem_buf, env->gpr[n]);
> +        gdb_get_regl(buf, env->gpr[n]);
>      } else if (n < 64) {
>          /* fprs */
> -        stfq_p(mem_buf, *cpu_fpr_ptr(env, n - 32));
> +        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
>      } else {
>          switch (n) {
>          case 64:
> -            gdb_get_regl(mem_buf, env->nip);
> +            gdb_get_regl(buf, env->nip);
>              break;
>          case 65:
> -            gdb_get_regl(mem_buf, env->msr);
> +            gdb_get_regl(buf, env->msr);
>              break;
>          case 66:
>              {
> @@ -145,31 +146,33 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8=
_t *mem_buf, int n)
>                  for (i =3D 0; i < 8; i++) {
>                      cr |=3D env->crf[i] << (32 - ((i + 1) * 4));
>                  }
> -                gdb_get_reg32(mem_buf, cr);
> +                gdb_get_reg32(buf, cr);
>                  break;
>              }
>          case 67:
> -            gdb_get_regl(mem_buf, env->lr);
> +            gdb_get_regl(buf, env->lr);
>              break;
>          case 68:
> -            gdb_get_regl(mem_buf, env->ctr);
> +            gdb_get_regl(buf, env->ctr);
>              break;
>          case 69:
> -            gdb_get_reg32(mem_buf, env->xer);
> +            gdb_get_reg32(buf, env->xer);
>              break;
>          case 70:
> -            gdb_get_reg32(mem_buf, env->fpscr);
> +            gdb_get_reg32(buf, env->fpscr);
>              break;
>          }
>      }
> +    mem_buf =3D buf->data - r;

Should it not be something more like this ?
mem_buf =3D buf->data + buf->len - r;

There seem to be the same issue below for every
ppc_maybe_bswap_register() call.

>      ppc_maybe_bswap_register(env, mem_buf, r);
>      return r;
>  }
> =20
> -int ppc_cpu_gdb_read_register_apple(CPUState *cs, uint8_t *mem_buf, in=
t n)
> +int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int=
 n)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> +    uint8_t *mem_buf;
>      int r =3D ppc_gdb_register_len_apple(n);
> =20
>      if (!r) {
> @@ -178,21 +181,21 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs,=
 uint8_t *mem_buf, int n)
> =20
>      if (n < 32) {
>          /* gprs */
> -        gdb_get_reg64(mem_buf, env->gpr[n]);
> +        gdb_get_reg64(buf, env->gpr[n]);
>      } else if (n < 64) {
>          /* fprs */
> -        stfq_p(mem_buf, *cpu_fpr_ptr(env, n - 32));
> +        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
>      } else if (n < 96) {
>          /* Altivec */
> -        stq_p(mem_buf, n - 64);
> -        stq_p(mem_buf + 8, 0);
> +        gdb_get_reg64(buf, n - 64);
> +        gdb_get_reg64(buf, 0);
>      } else {
>          switch (n) {
>          case 64 + 32:
> -            gdb_get_reg64(mem_buf, env->nip);
> +            gdb_get_reg64(buf, env->nip);
>              break;
>          case 65 + 32:
> -            gdb_get_reg64(mem_buf, env->msr);
> +            gdb_get_reg64(buf, env->msr);
>              break;
>          case 66 + 32:
>              {
> @@ -201,23 +204,24 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs,=
 uint8_t *mem_buf, int n)
>                  for (i =3D 0; i < 8; i++) {
>                      cr |=3D env->crf[i] << (32 - ((i + 1) * 4));
>                  }
> -                gdb_get_reg32(mem_buf, cr);
> +                gdb_get_reg32(buf, cr);
>                  break;
>              }
>          case 67 + 32:
> -            gdb_get_reg64(mem_buf, env->lr);
> +            gdb_get_reg64(buf, env->lr);
>              break;
>          case 68 + 32:
> -            gdb_get_reg64(mem_buf, env->ctr);
> +            gdb_get_reg64(buf, env->ctr);
>              break;
>          case 69 + 32:
> -            gdb_get_reg32(mem_buf, env->xer);
> +            gdb_get_reg32(buf, env->xer);
>              break;
>          case 70 + 32:
> -            gdb_get_reg64(mem_buf, env->fpscr);
> +            gdb_get_reg64(buf, env->fpscr);
>              break;
>          }
>      }
> +    mem_buf =3D buf->data - r;
>      ppc_maybe_bswap_register(env, mem_buf, r);
>      return r;
>  }
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> index ba726dec4d0..154f876e44c 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9587,7 +9587,7 @@ static int gdb_find_spr_idx(CPUPPCState *env, int=
 n)
>      return -1;
>  }
> =20
> -static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +static int gdb_get_spr_reg(CPUPPCState *env, GByteArray *buf, int n)
>  {
>      int reg;
>      int len;
> @@ -9598,8 +9598,8 @@ static int gdb_get_spr_reg(CPUPPCState *env, uint=
8_t *mem_buf, int n)
>      }
> =20
>      len =3D TARGET_LONG_SIZE;
> -    stn_p(mem_buf, len, env->spr[reg]);
> -    ppc_maybe_bswap_register(env, mem_buf, len);
> +    gdb_get_regl(buf, env->spr[reg]);
> +    ppc_maybe_bswap_register(env, buf->data - len, len);
>      return len;
>  }
> =20
> @@ -9621,15 +9621,18 @@ static int gdb_set_spr_reg(CPUPPCState *env, ui=
nt8_t *mem_buf, int n)
>  }
>  #endif
> =20
> -static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n=
)
> +static int gdb_get_float_reg(CPUPPCState *env, GByteArray *buf, int n)
>  {
> +    uint8_t *mem_buf;
>      if (n < 32) {
> -        stfq_p(mem_buf, *cpu_fpr_ptr(env, n));
> +        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
> +        mem_buf =3D buf->data - 8;
>          ppc_maybe_bswap_register(env, mem_buf, 8);
>          return 8;
>      }
>      if (n =3D=3D 32) {
> -        stl_p(mem_buf, env->fpscr);
> +        gdb_get_reg32(buf, env->fpscr);
> +        mem_buf =3D buf->data - 4;
>          ppc_maybe_bswap_register(env, mem_buf, 4);
>          return 4;
>      }
> @@ -9651,28 +9654,31 @@ static int gdb_set_float_reg(CPUPPCState *env, =
uint8_t *mem_buf, int n)
>      return 0;
>  }
> =20
> -static int gdb_get_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +static int gdb_get_avr_reg(CPUPPCState *env, GByteArray *buf, int n)
>  {
> +    uint8_t *mem_buf;
> +
>      if (n < 32) {
>          ppc_avr_t *avr =3D cpu_avr_ptr(env, n);
>          if (!avr_need_swap(env)) {
> -            stq_p(mem_buf, avr->u64[0]);
> -            stq_p(mem_buf + 8, avr->u64[1]);
> +            gdb_get_reg128(buf, avr->u64[0] , avr->u64[1]);
>          } else {
> -            stq_p(mem_buf, avr->u64[1]);
> -            stq_p(mem_buf + 8, avr->u64[0]);
> +            gdb_get_reg128(buf, avr->u64[1] , avr->u64[0]);
>          }
> +        mem_buf =3D buf->data - 16;
>          ppc_maybe_bswap_register(env, mem_buf, 8);
>          ppc_maybe_bswap_register(env, mem_buf + 8, 8);
>          return 16;
>      }
>      if (n =3D=3D 32) {
> -        stl_p(mem_buf, helper_mfvscr(env));
> +        gdb_get_reg32(buf, helper_mfvscr(env));
> +        mem_buf =3D buf->data - 4;
>          ppc_maybe_bswap_register(env, mem_buf, 4);>          return 4;
>      }
>      if (n =3D=3D 33) {
> -        stl_p(mem_buf, (uint32_t)env->spr[SPR_VRSAVE]);
> +        gdb_get_reg32(buf, (uint32_t)env->spr[SPR_VRSAVE]);
> +        mem_buf =3D buf->data - 4;
>          ppc_maybe_bswap_register(env, mem_buf, 4);
>          return 4;
>      }
> @@ -9707,25 +9713,25 @@ static int gdb_set_avr_reg(CPUPPCState *env, ui=
nt8_t *mem_buf, int n)
>      return 0;
>  }
> =20
> -static int gdb_get_spe_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +static int gdb_get_spe_reg(CPUPPCState *env, GByteArray *buf, int n)
>  {
>      if (n < 32) {
>  #if defined(TARGET_PPC64)
> -        stl_p(mem_buf, env->gpr[n] >> 32);
> -        ppc_maybe_bswap_register(env, mem_buf, 4);
> +        gdb_get_reg32(buf, env->gpr[n] >> 32);
> +        ppc_maybe_bswap_register(env, buf->data - 4, 4);
>  #else
> -        stl_p(mem_buf, env->gprh[n]);
> +        gdb_get_reg32(buf, env->gprh[n]);
>  #endif
>          return 4;
>      }
>      if (n =3D=3D 32) {
> -        stq_p(mem_buf, env->spe_acc);
> -        ppc_maybe_bswap_register(env, mem_buf, 8);
> +        gdb_get_reg64(buf, env->spe_acc);
> +        ppc_maybe_bswap_register(env, buf->data - 8, 8);
>          return 8;
>      }
>      if (n =3D=3D 33) {
> -        stl_p(mem_buf, env->spe_fscr);
> -        ppc_maybe_bswap_register(env, mem_buf, 4);
> +        gdb_get_reg32(buf, env->spe_fscr);
> +        ppc_maybe_bswap_register(env, buf->data - 4, 4);
>          return 4;
>      }
>      return 0;
> @@ -9760,11 +9766,11 @@ static int gdb_set_spe_reg(CPUPPCState *env, ui=
nt8_t *mem_buf, int n)
>      return 0;
>  }
> =20
> -static int gdb_get_vsx_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +static int gdb_get_vsx_reg(CPUPPCState *env, GByteArray *buf, int n)
>  {
>      if (n < 32) {
> -        stq_p(mem_buf, *cpu_vsrl_ptr(env, n));
> -        ppc_maybe_bswap_register(env, mem_buf, 8);
> +        gdb_get_reg64(buf, *cpu_vsrl_ptr(env, n));
> +        ppc_maybe_bswap_register(env, buf->data - 8, 8);
>          return 8;
>      }
>      return 0;

Otherwise, other files seem ok.

Regards,
--
Damien


