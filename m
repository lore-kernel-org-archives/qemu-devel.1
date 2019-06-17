Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581FDC31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14543206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQchchtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14543206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsLd-0004qV-AM
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsIX-0002RG-DG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsIV-0007Tg-J8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:07:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsIT-0007NC-E6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:07:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id p13so10089477wru.10
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fMNO9fgSd6qw2FjRsSFlcoQGvEJ6t61HedFULEfj7wM=;
 b=rQchchtc1GatagLxpjGQ/5uE0zjIoz2uAr1HX2ftvPVthU/hQw1H02n3YSwAqeNWj6
 oBLrSy9KMl6ito2aLtkOt9B8MM1uSbQV2eXZXE4U0IPpCrN+ygFom5+V0mU4ZsTtMtzr
 6jhR1aXk2+Q7HtV2UPqCMfXENhp3rxvO0Lc2J/JQMm9PENTtepVTSJS6r4hLTfeEI6zY
 QNsAWIhmrBnAN6VzYYpQh4DvnkrCckwR7/qva/lHL5GK+Pm6EsVdBSst3eqMKweJRY+H
 pDmMW3gDdUXrEIjhF/75xpT5/raM4kAcy+2qKDeNoesk3ByQ6owQLfJk6X8EV+dgznCY
 /EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fMNO9fgSd6qw2FjRsSFlcoQGvEJ6t61HedFULEfj7wM=;
 b=X8YExpsocR+JubdBObwyQGKe2zN1RT0UChEr8a1j2OYyRLsVms1SevsJd3F8+JA3oz
 6N4+V9ERyqmr7JF2NHMKOhMreqKFkN2isLdfeAF3NLm0cqkFPseis0jMeIZ2pT0FC2nj
 6KxehqpHmpPFL6pT7ZVXoA2x7alV2Fbl+zqfW8OJM7Y8fZtu07jt9hn+IAIbg4whc5xv
 09ZBm+qrbEEKpEDSqsEkG8qtMQlY/ixqCLufFbp+YTeqD7h6tN4/zciIW737RalKfSMT
 PH5w64yNLg9+vDD6c1tUk0R3Pk6d56oLsOY8eRXQTCJumecmuyZibQ0ijO92kcyU6VDE
 NgWQ==
X-Gm-Message-State: APjAAAW9Y9E/IgpRHf21vDDOlE9+IqqrSsnXca616O/jxx/6bBxW+uc4
 tUT2TChYegweLDl7PDPse06kRg==
X-Google-Smtp-Source: APXvYqzgssVWyx/e3N4gLgneKogbrlYNrB99IikwGaId6WUBt33KjIylf+5n1Ex3yXfQXydwmhGxOA==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr56294422wrw.309.1560780464022; 
 Mon, 17 Jun 2019 07:07:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s12sm10817616wmh.34.2019.06.17.07.07.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:07:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 02FD11FF87;
 Mon, 17 Jun 2019 15:07:43 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-8-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-8-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:07:42 +0100
Message-ID: <87v9x49ufl.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 07/23] target/arm: Declare
 some function publicly
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> In few commits we will split the v7-M functions from this file.
> Some function will be called out of helper.c. Declare them
> in the "internals.h" header.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c    | 69 +++++++++++++-----------------------------
>  target/arm/internals.h | 45 +++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 48 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 9a3766b759..a1e74cc471 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -35,17 +35,6 @@
>  #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable =
*/
>
>  #ifndef CONFIG_USER_ONLY
> -/* Cacheability and shareability attributes for a memory access */
> -typedef struct ARMCacheAttrs {
> -    unsigned int attrs:8; /* as in the MAIR register encoding */
> -    unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 =
PTEs */
> -} ARMCacheAttrs;
> -
> -static bool get_phys_addr(CPUARMState *env, target_ulong address,
> -                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
> -                          hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
> -                          target_ulong *page_size,
> -                          ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs=
);
>
>  static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>                                 MMUAccessType access_type, ARMMMUIdx mmu_=
idx,
> @@ -53,24 +42,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, targe=
t_ulong address,
>                                 target_ulong *page_size_ptr,
>                                 ARMMMUFaultInfo *fi, ARMCacheAttrs *cache=
attrs);
>
> -/* Security attributes for an address, as returned by v8m_security_looku=
p. */
> -typedef struct V8M_SAttributes {
> -    bool subpage; /* true if these attrs don't cover the whole TARGET_PA=
GE */
> -    bool ns;
> -    bool nsc;
> -    uint8_t sregion;
> -    bool srvalid;
> -    uint8_t iregion;
> -    bool irvalid;
> -} V8M_SAttributes;
> -
> -static void v8m_security_lookup(CPUARMState *env, uint32_t address,
> -                                MMUAccessType access_type, ARMMMUIdx mmu=
_idx,
> -                                V8M_SAttributes *sattrs);
>  #endif
>
> -static void switch_mode(CPUARMState *env, int mode);
> -
>  static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
>  {
>      int nregs;
> @@ -7552,7 +7525,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t =
addr, uint32_t op)
>      return 0;
>  }
>
> -static void switch_mode(CPUARMState *env, int mode)
> +void switch_mode(CPUARMState *env, int mode)
>  {
>      ARMCPU *cpu =3D env_archcpu(env);
>
> @@ -7574,7 +7547,7 @@ void aarch64_sync_64_to_32(CPUARMState *env)
>
>  #else
>
> -static void switch_mode(CPUARMState *env, int mode)
> +void switch_mode(CPUARMState *env, int mode)
>  {
>      int old_mode;
>      int i;
> @@ -7988,9 +7961,9 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
>   * stack pointers if it is done for the CONTROL register for the current
>   * security state.
>   */
> -static void write_v7m_control_spsel_for_secstate(CPUARMState *env,
> -                                                 bool new_spsel,
> -                                                 bool secstate)
> +void write_v7m_control_spsel_for_secstate(CPUARMState *env,
> +                                          bool new_spsel,
> +                                          bool secstate)
>  {
>      bool old_is_psp =3D v7m_using_psp(env);
>
> @@ -8015,7 +7988,7 @@ static void write_v7m_control_spsel_for_secstate(CP=
UARMState *env,
>   * Write to v7M CONTROL.SPSEL bit. This may change the current
>   * stack pointer between Main and Process stack pointers.
>   */
> -static void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
> +void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
>  {
>      write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure=
);
>  }
> @@ -8041,7 +8014,7 @@ void write_v7m_exception(CPUARMState *env, uint32_t=
 new_exc)
>  }
>
>  /* Switch M profile security state between NS and S */
> -static void switch_v7m_security_state(CPUARMState *env, bool new_secstat=
e)
> +void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
>  {
>      uint32_t new_ss_msp, new_ss_psp;
>
> @@ -9447,7 +9420,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
>      return true;
>  }
>
> -static void arm_log_exception(int idx)
> +void arm_log_exception(int idx)
>  {
>      if (qemu_loglevel_mask(CPU_LOG_INT)) {
>          const char *exc =3D NULL;
> @@ -12122,9 +12095,9 @@ static bool v8m_is_sau_exempt(CPUARMState *env,
>          (address >=3D 0xe00ff000 && address <=3D 0xe00fffff);
>  }
>
> -static void v8m_security_lookup(CPUARMState *env, uint32_t address,
> -                                MMUAccessType access_type, ARMMMUIdx mmu=
_idx,
> -                                V8M_SAttributes *sattrs)
> +void v8m_security_lookup(CPUARMState *env, uint32_t address,
> +                         MMUAccessType access_type, ARMMMUIdx mmu_idx,
> +                         V8M_SAttributes *sattrs)
>  {
>      /* Look up the security attributes for this address. Compare the
>       * pseudocode SecurityCheck() function.
> @@ -12229,11 +12202,11 @@ static void v8m_security_lookup(CPUARMState *en=
v, uint32_t address,
>      }
>  }
>
> -static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
> -                              MMUAccessType access_type, ARMMMUIdx mmu_i=
dx,
> -                              hwaddr *phys_ptr, MemTxAttrs *txattrs,
> -                              int *prot, bool *is_subpage,
> -                              ARMMMUFaultInfo *fi, uint32_t *mregion)
> +bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
> +                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
> +                       hwaddr *phys_ptr, MemTxAttrs *txattrs,
> +                       int *prot, bool *is_subpage,
> +                       ARMMMUFaultInfo *fi, uint32_t *mregion)
>  {
>      /* Perform a PMSAv8 MPU lookup (without also doing the SAU check
>       * that a full phys-to-virt translation does).
> @@ -12633,11 +12606,11 @@ static ARMCacheAttrs combine_cacheattrs(ARMCach=
eAttrs s1, ARMCacheAttrs s2)
>   * @fi: set to fault info if the translation fails
>   * @cacheattrs: (if non-NULL) set to the cacheability/shareability attri=
butes
>   */
> -static bool get_phys_addr(CPUARMState *env, target_ulong address,
> -                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
> -                          hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
> -                          target_ulong *page_size,
> -                          ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
> +bool get_phys_addr(CPUARMState *env, target_ulong address,
> +                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
> +                   hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
> +                   target_ulong *page_size,
> +                   ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
>  {
>      if (mmu_idx =3D=3D ARMMMUIdx_S12NSE0 || mmu_idx =3D=3D ARMMMUIdx_S12=
NSE1) {
>          /* Call ourselves recursively to do the stage 1 and then stage 2
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 5a02f458f3..04711b317a 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -985,4 +985,49 @@ static inline int exception_target_el(CPUARMState *e=
nv)
>      return target_el;
>  }
>
> +void arm_log_exception(int idx);
> +
> +/* Cacheability and shareability attributes for a memory access */
> +typedef struct ARMCacheAttrs {
> +    unsigned int attrs:8; /* as in the MAIR register encoding */
> +    unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 =
PTEs */
> +} ARMCacheAttrs;
> +
> +bool get_phys_addr(CPUARMState *env, target_ulong address,
> +                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
> +                   hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
> +                   target_ulong *page_size,
> +                   ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
> +
> +/* Security attributes for an address, as returned by v8m_security_looku=
p. */
> +typedef struct V8M_SAttributes {
> +    bool subpage; /* true if these attrs don't cover the whole TARGET_PA=
GE */
> +    bool ns;
> +    bool nsc;
> +    uint8_t sregion;
> +    bool srvalid;
> +    uint8_t iregion;
> +    bool irvalid;
> +} V8M_SAttributes;
> +
> +void v8m_security_lookup(CPUARMState *env, uint32_t address,
> +                         MMUAccessType access_type, ARMMMUIdx mmu_idx,
> +                         V8M_SAttributes *sattrs);
> +
> +void switch_mode(CPUARMState *, int);
> +
> +bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
> +                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
> +                       hwaddr *phys_ptr, MemTxAttrs *txattrs,
> +                       int *prot, bool *is_subpage,
> +                       ARMMMUFaultInfo *fi, uint32_t *mregion);
> +
> +void write_v7m_control_spsel_for_secstate(CPUARMState *env,
> +                                          bool new_spsel,
> +                                          bool secstate);
> +
> +void write_v7m_control_spsel(CPUARMState *env, bool new_spsel);
> +
> +void switch_v7m_security_state(CPUARMState *env, bool new_secstate);
> +
>  #endif


--
Alex Benn=C3=A9e

