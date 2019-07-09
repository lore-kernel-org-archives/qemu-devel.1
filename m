Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E7DC73C56
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26CA20861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNX/RKsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26CA20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkx6U-0005iQ-Jx
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 16:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39238)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hkx31-0004FR-Kh
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hkx2v-0002sg-PS
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:49:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hkx2n-0002jt-4i
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:48:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id f17so142129wme.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0fBXuyK5wDpaOTyxXaPAaiswAOct2dT4WjnyrTPSA1k=;
 b=mNX/RKsWfncUUDLAMI/2wBb0DtxyVLMec5iT0L9FtYNRsG5pH53wE0Y1lbocN8JzSe
 qZDBWDJTol+RkvAs/D0URHR9+f4CZQWiAgbRVQXTSy1sN8R/35o3U0NH8NTLovwafmk5
 rP/SOoI55vKUWeDefrVL+f4RI19Cstb8x3ZNszeaBCH3S4zxttlGPOeoAF0V0aNaSEjG
 z/j2Jm24Da3umPKxlsdOCDKMmh8YfQwwwgNgjYJG1QpkXV+xXnFuRsid+J6bw2fdDHmt
 Zw3Q65XiaNmXacTm3Djw2HmutAPqjqlY5LU0VYpSRdn8gn57IZQrzdQimBQh0dGYbHoh
 n9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0fBXuyK5wDpaOTyxXaPAaiswAOct2dT4WjnyrTPSA1k=;
 b=qWdcoideRqvRtZdmckHMuCHXs0K1QNY2niET8zAhjPuF4t1snfS5xN2fdoowMC1+sS
 u4yUh9p3bwkA862+oZVi/kbCPQkR6GBiEm4fIjBQhZWYys6OCDL0ETcHoJe1ohevRir8
 wYyHb8jtwgsNgHdZe+f6gVrcsr/kE6hy6+3jSV5hJK1sm3tC3u8P/oO5YPkDP26PoLtk
 ryyt5ey8hZpN0yFUnEbgd0bo8n3IDXZ0pfPaoSc6sgY5VC2u4/lWjewbUCCvIAYGPokx
 FajE8/q/47b5VjTmJJWPCZQN/5DyPxUDG6K7Cl/fUkOx095+Hw5XyGelQ5ff3seHKhFz
 VNiw==
X-Gm-Message-State: APjAAAVPbNd0W+63xb+amX3oPoBJeSL0332tlNPb9YhFXT4Gait6RPV5
 k3AY1Y3YE7EbyFVLYRiQYOUvPA==
X-Google-Smtp-Source: APXvYqwKhz+6yxq0CGZkBXKX/Wx4irs+z7dpblxehZraHC+I+Ui7psdwbDUmB1mK+19ehPCziKx2+A==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr1412574wme.167.1562705335495; 
 Tue, 09 Jul 2019 13:48:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l9sm49689wmh.36.2019.07.09.13.48.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 13:48:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A2901FF87;
 Tue,  9 Jul 2019 21:48:54 +0100 (BST)
References: <20190709163656.3100-1-richard.henderson@linaro.org>
 <20190709163656.3100-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <20190709163656.3100-6-richard.henderson@linaro.org>
Date: Tue, 09 Jul 2019 21:48:54 +0100
Message-ID: <87r26zdjd5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tcg: Release mmap_lock on
 translation fault
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Turn helper_retaddr into a multi-state flag that may now also
> indicate when we're performing a read on behalf of the translator.
> In this case, release the mmap_lock before the longjmp back to
> the main cpu loop, and thereby avoid a failing assert therein.
>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1832353
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

with check-tcg this time

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu_ldst_useronly_template.h | 20 +++++--
>  accel/tcg/user-exec.c                     | 66 ++++++++++++++++-------
>  2 files changed, 63 insertions(+), 23 deletions(-)
>
> diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu=
_ldst_useronly_template.h
> index d663826ac2..2378f2958c 100644
> --- a/include/exec/cpu_ldst_useronly_template.h
> +++ b/include/exec/cpu_ldst_useronly_template.h
> @@ -64,12 +64,18 @@
>  static inline RES_TYPE
>  glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
>  {
> -#if !defined(CODE_ACCESS)
> +#ifdef CODE_ACCESS
> +    RES_TYPE ret;
> +    set_helper_retaddr(1);
> +    ret =3D glue(glue(ld, USUFFIX), _p)(g2h(ptr));
> +    clear_helper_retaddr();
> +    return ret;
> +#else
>      trace_guest_mem_before_exec(
>          env_cpu(env), ptr,
>          trace_mem_build_info(SHIFT, false, MO_TE, false));
> -#endif
>      return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
> +#endif
>  }
>
>  #ifndef CODE_ACCESS
> @@ -90,12 +96,18 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>  static inline int
>  glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
>  {
> -#if !defined(CODE_ACCESS)
> +#ifdef CODE_ACCESS
> +    int ret;
> +    set_helper_retaddr(1);
> +    ret =3D glue(glue(lds, SUFFIX), _p)(g2h(ptr));
> +    clear_helper_retaddr();
> +    return ret;
> +#else
>      trace_guest_mem_before_exec(
>          env_cpu(env), ptr,
>          trace_mem_build_info(SHIFT, true, MO_TE, false));
> -#endif
>      return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
> +#endif
>  }
>
>  #ifndef CODE_ACCESS
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 4384b59a4d..897d1571c4 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -64,27 +64,56 @@ static inline int handle_cpu_signal(uintptr_t pc, sig=
info_t *info,
>      CPUState *cpu =3D current_cpu;
>      CPUClass *cc;
>      unsigned long address =3D (unsigned long)info->si_addr;
> -    MMUAccessType access_type;
> +    MMUAccessType access_type =3D is_write ? MMU_DATA_STORE : MMU_DATA_L=
OAD;
>
> -    /* We must handle PC addresses from two different sources:
> -     * a call return address and a signal frame address.
> -     *
> -     * Within cpu_restore_state_from_tb we assume the former and adjust
> -     * the address by -GETPC_ADJ so that the address is within the call
> -     * insn so that addr does not accidentally match the beginning of the
> -     * next guest insn.
> -     *
> -     * However, when the PC comes from the signal frame, it points to
> -     * the actual faulting host insn and not a call insn.  Subtracting
> -     * GETPC_ADJ in that case may accidentally match the previous guest =
insn.
> -     *
> -     * So for the later case, adjust forward to compensate for what
> -     * will be done later by cpu_restore_state_from_tb.
> -     */
> -    if (helper_retaddr) {
> +    switch (helper_retaddr) {
> +    default:
> +        /*
> +         * Fault during host memory operation within a helper function.
> +         * The helper's host return address, saved here, gives us a
> +         * pointer into the generated code that will unwind to the
> +         * correct guest pc.
> +         */
>          pc =3D helper_retaddr;
> -    } else {
> +        break;
> +
> +    case 0:
> +        /*
> +         * Fault during host memory operation within generated code.
> +         * (Or, a unrelated bug within qemu, but we can't tell from here=
).
> +         *
> +         * We take the host pc from the signal frame.  However, we cannot
> +         * use that value directly.  Within cpu_restore_state_from_tb, we
> +         * assume PC comes from GETPC(), as used by the helper functions,
> +         * so we adjust the address by -GETPC_ADJ to form an address that
> +         * is within the call insn, so that the address does not acciden=
tially
> +         * match the beginning of the next guest insn.  However, when the
> +         * pc comes from the signal frame it points to the actual faulti=
ng
> +         * host memory insn and not the return from a call insn.
> +         *
> +         * Therefore, adjust to compensate for what will be done later
> +         * by cpu_restore_state_from_tb.
> +         */
>          pc +=3D GETPC_ADJ;
> +        break;
> +
> +    case 1:
> +        /*
> +         * Fault during host read for translation, or loosely, "executio=
n".
> +         *
> +         * The guest pc is already pointing to the start of the TB for w=
hich
> +         * code is being generated.  If the guest translator manages the
> +         * page crossings correctly, this is exactly the correct address
> +         * (and if the translator doesn't handle page boundaries correct=
ly
> +         * there's little we can do about that here).  Therefore, do not
> +         * trigger the unwinder.
> +         *
> +         * Like tb_gen_code, release the memory lock before cpu_loop_exi=
t.
> +         */
> +        pc =3D 0;
> +        access_type =3D MMU_INST_FETCH;
> +        mmap_unlock();
> +        break;
>      }
>
>      /* For synchronous signals we expect to be coming from the vCPU
> @@ -155,7 +184,6 @@ static inline int handle_cpu_signal(uintptr_t pc, sig=
info_t *info,
>      clear_helper_retaddr();
>
>      cc =3D CPU_GET_CLASS(cpu);
> -    access_type =3D is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
>      cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
>      g_assert_not_reached();
>  }


--
Alex Benn=C3=A9e

