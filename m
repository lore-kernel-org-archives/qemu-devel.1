Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D96C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29B921D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDlcX0yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29B921D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9cF-000298-NX
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iD9D8-0001G7-Gt
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iD9D6-0000Dr-Cs
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:28:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iD9D6-0000DP-8k
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569425286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=gtV6AkusAY7cOSr3j840Z3A+GWh8lOEC9NajOi5Pffg=;
 b=RDlcX0ynFUc+Fb5l+/wStSoa6+KZpbehts9JtMKMiR7lph60I/Bzb8TJ8lGT+qMilIDvOa
 IHu7Js4vlLsntDWFW+AQ+pdA1l5dCeJc3gAhD46pIdPYrPEtbStJzUIfAct6TSVoAbiHEP
 4ZjStDPxjEB5PH50LpFEPR66SgTsr48=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-Co32aUDwPIeoG1tWqRPGPg-1; Wed, 25 Sep 2019 11:28:02 -0400
Received: by mail-wr1-f69.google.com with SMTP id a15so2556710wrq.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=avp5xnJPphol5YnZVra89uogJ8mSsmfVtUCpByUensM=;
 b=VOeK5RxM2zFsYpuMiSm4xsAVupJrX9j5R0N/HvQ5VuIXhTj1QyaBABn+NxKbhhnkXh
 3bwLap17Dz7nPhH3J0F5wAShrzUioPsLxm9P+7PZWSIJmBwi2gXhgpjhp9VsQScr40xv
 1Z+yNr5zchSyAtP/peYxffX0XObWu1xt4iDYGdkLkR9gA1AI0erN1JKjdb+k6/vY1USv
 nHhQccJZzR+taBkROxJgeTq0KLW6N8GdxivhVfp3Z8KoiaS9iekjORJ5qHcy5lEw288U
 KzraKKx1BM5T4sffxO1J15f8fdxbIlQvXv7kxvUjNuNt1A0wcISlo0bEZ6vmr4qX8Dd+
 g0Jg==
X-Gm-Message-State: APjAAAWFTjvCnVicPJFH+nIXeZquaI81G92HdBAzhkcIvyx74tivo8bP
 hGT7jjitLVa3GCjkU293+8TwbiChoF1KmqhJpN/REDrDToGpIxe/t8mnpBTSMxQ4p5Yut6ur/aN
 /m0qAc+PhAtjOgsY=
X-Received: by 2002:adf:ce91:: with SMTP id r17mr673731wrn.97.1569425281353;
 Wed, 25 Sep 2019 08:28:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxthYLo22Laubsqw0tlHOOdliSgvueybBD20mBk7aC4aM2woMVmiz6UrkJs/BMLtLLzb0O5VQ==
X-Received: by 2002:adf:ce91:: with SMTP id r17mr673715wrn.97.1569425281090;
 Wed, 25 Sep 2019 08:28:01 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id o9sm10016422wrh.46.2019.09.25.08.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 08:28:00 -0700 (PDT)
Subject: Re: [PATCH v2 01/20] target/mips: Clean up helper.c
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1569415572-19635-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8f976a4a-e56a-d1f7-def9-14dd66140f0c@redhat.com>
Date: Wed, 25 Sep 2019 17:27:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1569415572-19635-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: Co32aUDwPIeoG1tWqRPGPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: arikalo@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 2:45 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/helper.c | 132 +++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 80 insertions(+), 52 deletions(-)
>=20
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index a2b6459..3dd1aae 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -39,8 +39,8 @@ enum {
>  #if !defined(CONFIG_USER_ONLY)
> =20
>  /* no MMU emulation */
> -int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> -                        target_ulong address, int rw, int access_type)
> +int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> +                       target_ulong address, int rw, int access_type)
>  {
>      *physical =3D address;
>      *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> @@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *ph=
ysical, int *prot,
>  }
> =20
>  /* fixed mapping MMU emulation */
> -int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *pro=
t,
> -                           target_ulong address, int rw, int access_type=
)
> +int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot=
,
> +                          target_ulong address, int rw, int access_type)
>  {
>      if (address <=3D (int32_t)0x7FFFFFFFUL) {
> -        if (!(env->CP0_Status & (1 << CP0St_ERL)))
> +        if (!(env->CP0_Status & (1 << CP0St_ERL))) {
>              *physical =3D address + 0x40000000UL;
> -        else
> +        } else {
>              *physical =3D address;
> -    } else if (address <=3D (int32_t)0xBFFFFFFFUL)
> +        }
> +    } else if (address <=3D (int32_t)0xBFFFFFFFUL) {
>          *physical =3D address & 0x1FFFFFFF;
> -    else
> +    } else {
>          *physical =3D address;
> +    }
> =20
>      *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>      return TLBRET_MATCH;
>  }
> =20
>  /* MIPS32/MIPS64 R4000-style MMU emulation */
> -int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> -                     target_ulong address, int rw, int access_type)
> +int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> +                    target_ulong address, int rw, int access_type)
>  {
>      uint16_t ASID =3D env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
>      int i;
> @@ -99,8 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physic=
al, int *prot,
>              if (rw !=3D MMU_DATA_STORE || (n ? tlb->D1 : tlb->D0)) {
>                  *physical =3D tlb->PFN[n] | (address & (mask >> 1));
>                  *prot =3D PAGE_READ;
> -                if (n ? tlb->D1 : tlb->D0)
> +                if (n ? tlb->D1 : tlb->D0) {
>                      *prot |=3D PAGE_WRITE;
> +                }
>                  if (!(n ? tlb->XI1 : tlb->XI0)) {
>                      *prot |=3D PAGE_EXEC;
>                  }
> @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am, bool eu=
, int mmu_idx)
>      int32_t adetlb_mask;
> =20
>      switch (mmu_idx) {
> -    case 3 /* ERL */:
> -        /* If EU is set, always unmapped */
> +    case 3:
> +        /*
> +         * ERL
> +         * If EU is set, always unmapped
> +         */

My IDE show the current form nicer when the switch is folded.

Are these comment really bothering checkpatch?

>          if (eu) {
>              return 0;
>          }
> @@ -204,9 +210,9 @@ static int get_segctl_physical_address(CPUMIPSState *=
env, hwaddr *physical,
>                                      pa & ~(hwaddr)segmask);
>  }
> =20
> -static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
> -                                int *prot, target_ulong real_address,
> -                                int rw, int access_type, int mmu_idx)
> +static int get_physical_address(CPUMIPSState *env, hwaddr *physical,
> +                               int *prot, target_ulong real_address,
> +                               int rw, int access_type, int mmu_idx)
>  {
>      /* User mode can only access useg/xuseg */
>  #if defined(TARGET_MIPS64)
> @@ -252,14 +258,15 @@ static int get_physical_address (CPUMIPSState *env,=
 hwaddr *physical,
>          } else {
>              segctl =3D env->CP0_SegCtl2 >> 16;
>          }
> -        ret =3D get_segctl_physical_address(env, physical, prot, real_ad=
dress, rw,
> -                                          access_type, mmu_idx, segctl,
> -                                          0x3FFFFFFF);
> +        ret =3D get_segctl_physical_address(env, physical, prot,
> +                                          real_address, rw, access_type,
> +                                          mmu_idx, segctl, 0x3FFFFFFF);
>  #if defined(TARGET_MIPS64)
>      } else if (address < 0x4000000000000000ULL) {
>          /* xuseg */
>          if (UX && address <=3D (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
> -            ret =3D env->tlb->map_address(env, physical, prot, real_addr=
ess, rw, access_type);
> +            ret =3D env->tlb->map_address(env, physical, prot,
> +                                        real_address, rw, access_type);
>          } else {
>              ret =3D TLBRET_BADADDR;
>          }
> @@ -267,7 +274,8 @@ static int get_physical_address (CPUMIPSState *env, h=
waddr *physical,
>          /* xsseg */
>          if ((supervisor_mode || kernel_mode) &&
>              SX && address <=3D (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
> -            ret =3D env->tlb->map_address(env, physical, prot, real_addr=
ess, rw, access_type);
> +            ret =3D env->tlb->map_address(env, physical, prot,
> +                                        real_address, rw, access_type);
>          } else {
>              ret =3D TLBRET_BADADDR;
>          }
> @@ -307,7 +315,8 @@ static int get_physical_address (CPUMIPSState *env, h=
waddr *physical,
>          /* xkseg */
>          if (kernel_mode && KX &&
>              address <=3D (0xFFFFFFFF7FFFFFFFULL & env->SEGMask)) {
> -            ret =3D env->tlb->map_address(env, physical, prot, real_addr=
ess, rw, access_type);
> +            ret =3D env->tlb->map_address(env, physical, prot,
> +                                        real_address, rw, access_type);
>          } else {
>              ret =3D TLBRET_BADADDR;
>          }
> @@ -328,8 +337,10 @@ static int get_physical_address (CPUMIPSState *env, =
hwaddr *physical,
>                                            access_type, mmu_idx,
>                                            env->CP0_SegCtl0 >> 16, 0x1FFF=
FFFF);
>      } else {
> -        /* kseg3 */
> -        /* XXX: debug segment is not emulated */
> +        /*
> +         * kseg3
> +         * XXX: debug segment is not emulated
> +         */

Ditto.

>          ret =3D get_segctl_physical_address(env, physical, prot, real_ad=
dress, rw,
>                                            access_type, mmu_idx,
>                                            env->CP0_SegCtl0, 0x1FFFFFFF);
> @@ -515,9 +526,9 @@ static void raise_mmu_exception(CPUMIPSState *env, ta=
rget_ulong address,
>  #if defined(TARGET_MIPS64)
>      env->CP0_EntryHi &=3D env->SEGMask;
>      env->CP0_XContext =3D
> -        /* PTEBase */   (env->CP0_XContext & ((~0ULL) << (env->SEGBITS -=
 7))) |
> -        /* R */         (extract64(address, 62, 2) << (env->SEGBITS - 9)=
) |
> -        /* BadVPN2 */   (extract64(address, 13, env->SEGBITS - 13) << 4)=
;
> +        (env->CP0_XContext & ((~0ULL) << (env->SEGBITS - 7))) | /* PTEBa=
se */
> +        (extract64(address, 62, 2) << (env->SEGBITS - 9)) |     /* R    =
   */
> +        (extract64(address, 13, env->SEGBITS - 13) << 4);       /* BadVP=
N2 */
>  #endif
>      cs->exception_index =3D exception;
>      env->error_code =3D error_code;
> @@ -945,7 +956,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
>  }
> =20
>  #ifndef CONFIG_USER_ONLY
> -hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong addres=
s, int rw)
> +hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong addres=
s,
> +                                  int rw)
>  {
>      hwaddr physical;
>      int prot;
> @@ -1005,7 +1017,7 @@ static const char * const excp_names[EXCP_LAST + 1]=
 =3D {
>  };
>  #endif
> =20
> -target_ulong exception_resume_pc (CPUMIPSState *env)
> +target_ulong exception_resume_pc(CPUMIPSState *env)
>  {
>      target_ulong bad_pc;
>      target_ulong isa_mode;
> @@ -1013,8 +1025,10 @@ target_ulong exception_resume_pc (CPUMIPSState *en=
v)
>      isa_mode =3D !!(env->hflags & MIPS_HFLAG_M16);
>      bad_pc =3D env->active_tc.PC | isa_mode;
>      if (env->hflags & MIPS_HFLAG_BMASK) {
> -        /* If the exception was raised from a delay slot, come back to
> -           the jump.  */
> +        /*
> +         * If the exception was raised from a delay slot, come back to
> +         *  the jump.
> +         */
>          bad_pc -=3D (env->hflags & MIPS_HFLAG_B16 ? 2 : 4);
>      }
> =20
> @@ -1022,14 +1036,14 @@ target_ulong exception_resume_pc (CPUMIPSState *e=
nv)
>  }
> =20
>  #if !defined(CONFIG_USER_ONLY)
> -static void set_hflags_for_handler (CPUMIPSState *env)
> +static void set_hflags_for_handler(CPUMIPSState *env)
>  {
>      /* Exception handlers are entered in 32-bit mode.  */
>      env->hflags &=3D ~(MIPS_HFLAG_M16);
>      /* ...except that microMIPS lets you choose.  */
>      if (env->insn_flags & ASE_MICROMIPS) {
> -        env->hflags |=3D (!!(env->CP0_Config3
> -                           & (1 << CP0C3_ISA_ON_EXC))
> +        env->hflags |=3D (!!(env->CP0_Config3 &
> +                           (1 << CP0C3_ISA_ON_EXC))
>                          << MIPS_HFLAG_M16_SHIFT);
>      }
>  }
> @@ -1096,10 +1110,12 @@ void mips_cpu_do_interrupt(CPUState *cs)
>      switch (cs->exception_index) {
>      case EXCP_DSS:
>          env->CP0_Debug |=3D 1 << CP0DB_DSS;
> -        /* Debug single step cannot be raised inside a delay slot and
> -           resume will always occur on the next instruction
> -           (but we assume the pc has always been updated during
> -           code translation). */
> +        /*
> +         * Debug single step cannot be raised inside a delay slot and
> +         * resume will always occur on the next instruction
> +         * (but we assume the pc has always been updated during
> +         * code translation).
> +         */
>          env->CP0_DEPC =3D env->active_tc.PC | !!(env->hflags & MIPS_HFLA=
G_M16);
>          goto enter_debug_mode;
>      case EXCP_DINT:
> @@ -1111,7 +1127,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
>      case EXCP_DBp:
>          env->CP0_Debug |=3D 1 << CP0DB_DBp;
>          /* Setup DExcCode - SDBBP instruction */
> -        env->CP0_Debug =3D (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) | =
9 << CP0DB_DEC;
> +        env->CP0_Debug =3D (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) |
> +                         (9 << CP0DB_DEC);
>          goto set_DEPC;
>      case EXCP_DDBS:
>          env->CP0_Debug |=3D 1 << CP0DB_DDBS;
> @@ -1132,8 +1149,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
>          env->hflags |=3D MIPS_HFLAG_DM | MIPS_HFLAG_CP0;
>          env->hflags &=3D ~(MIPS_HFLAG_KSU);
>          /* EJTAG probe trap enable is not implemented... */
> -        if (!(env->CP0_Status & (1 << CP0St_EXL)))
> +        if (!(env->CP0_Status & (1 << CP0St_EXL))) {
>              env->CP0_Cause &=3D ~(1U << CP0Ca_BD);
> +        }
>          env->active_tc.PC =3D env->exception_base + 0x480;
>          set_hflags_for_handler(env);
>          break;
> @@ -1159,8 +1177,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
>          }
>          env->hflags |=3D MIPS_HFLAG_CP0;
>          env->hflags &=3D ~(MIPS_HFLAG_KSU);
> -        if (!(env->CP0_Status & (1 << CP0St_EXL)))
> +        if (!(env->CP0_Status & (1 << CP0St_EXL))) {
>              env->CP0_Cause &=3D ~(1U << CP0Ca_BD);
> +        }
>          env->active_tc.PC =3D env->exception_base;
>          set_hflags_for_handler(env);
>          break;
> @@ -1176,12 +1195,16 @@ void mips_cpu_do_interrupt(CPUState *cs)
>                  uint32_t pending =3D (env->CP0_Cause & CP0Ca_IP_mask) >>=
 CP0Ca_IP;
> =20
>                  if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
> -                    /* For VEIC mode, the external interrupt controller =
feeds
> -                     * the vector through the CP0Cause IP lines.  */
> +                    /*
> +                     * For VEIC mode, the external interrupt controller =
feeds
> +                     * the vector through the CP0Cause IP lines.
> +                     */
>                      vector =3D pending;
>                  } else {
> -                    /* Vectored Interrupts
> -                     * Mask with Status.IM7-IM0 to get enabled interrupt=
s. */
> +                    /*
> +                     * Vectored Interrupts
> +                     * Mask with Status.IM7-IM0 to get enabled interrupt=
s.
> +                     */
>                      pending &=3D (env->CP0_Status >> CP0St_IM) & 0xff;
>                      /* Find the highest-priority interrupt. */
>                      while (pending >>=3D 1) {
> @@ -1354,7 +1377,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
> =20
>          env->active_tc.PC +=3D offset;
>          set_hflags_for_handler(env);
> -        env->CP0_Cause =3D (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) | (cau=
se << CP0Ca_EC);
> +        env->CP0_Cause =3D (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) |
> +                         (cause << CP0Ca_EC);
>          break;
>      default:
>          abort();
> @@ -1390,7 +1414,7 @@ bool mips_cpu_exec_interrupt(CPUState *cs, int inte=
rrupt_request)
>  }
> =20
>  #if !defined(CONFIG_USER_ONLY)
> -void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
> +void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra)
>  {
>      CPUState *cs =3D env_cpu(env);
>      r4k_tlb_t *tlb;
> @@ -1400,16 +1424,20 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int i=
dx, int use_extra)
>      target_ulong mask;
> =20
>      tlb =3D &env->tlb->mmu.r4k.tlb[idx];
> -    /* The qemu TLB is flushed when the ASID changes, so no need to
> -       flush these entries again.  */
> +    /*
> +     * The qemu TLB is flushed when the ASID changes, so no need to
> +     * flush these entries again.
> +     */
>      if (tlb->G =3D=3D 0 && tlb->ASID !=3D ASID) {
>          return;
>      }
> =20
>      if (use_extra && env->tlb->tlb_in_use < MIPS_TLB_MAX) {
> -        /* For tlbwr, we can shadow the discarded entry into
> -           a new (fake) TLB entry, as long as the guest can not
> -           tell that it's there.  */
> +        /*
> +         * For tlbwr, we can shadow the discarded entry into
> +         * a new (fake) TLB entry, as long as the guest can not
> +         * tell that it's there.
> +         */
>          env->tlb->mmu.r4k.tlb[env->tlb->tlb_in_use] =3D *tlb;
>          env->tlb->tlb_in_use++;
>          return;
>=20

Except 2 comments, OK for the rest.

Another patch that makes rebasing very painful :(


