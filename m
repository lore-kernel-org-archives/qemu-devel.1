Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEFDC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF4C206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDFUxsM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF4C206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIvW-0003jc-Sl
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWIu3-0001t7-6p
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:11:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWIu1-0000UI-Hs
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588767112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vt9SliqM2j8xkrP1xGFxSvvkfmqNLfEXM6C9njeT6k0=;
 b=ZDFUxsM4brRtg9tYK+WZgU1158zBXNDcpfiF+oxbQ20xxfCpyrXMBKVjUwmoMBoe3kjTwE
 kWmNjOrV74hcgOTFoIHwJS2neTysKCWaECLQwVirDN7R2nKYg7jTD4N2Byb0x0mp0fZ0Op
 TbqtZEWTEZMkIy0CIU/nfZQAtpAdiuw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-YYRsg6ONOpiHSiNxRi__lQ-1; Wed, 06 May 2020 08:11:50 -0400
X-MC-Unique: YYRsg6ONOpiHSiNxRi__lQ-1
Received: by mail-wr1-f70.google.com with SMTP id z5so1194969wrt.17
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vt9SliqM2j8xkrP1xGFxSvvkfmqNLfEXM6C9njeT6k0=;
 b=Qru5tH5bQVbafGY0xXhOBMvPv3eOBhPLKz6raKcyHwxSIWoP/yqEwRCua9idAmLrkh
 q9huly+DlqIDwmey2ps5e8c7eBDm3hy91L23FiNNOGaGAPv8biVGWdxqjJawrSbTJyvK
 7AaaDnYWNjucMshHbU9ErOY9uHQ/ZcIkG9ElQyQfx26Eh6Zp+PnnSuL2QM/MuR+Gdx9a
 zOImViOzMY7pnaO7Ld6JyzlaCzHJ9P6jXzNrZIqGrOLjP+i7+r++ooOszMZaH411LMc0
 Lu85+NotYfj2Lg5IvhU5C/NKvaV85+xWpMRdfNxrdQHv4C0EXKr8gtLVp3Y2Q1BtjNko
 /6fQ==
X-Gm-Message-State: AGi0Pubq2Wkdtv36V/G3cEJHjo++vG1Uq9bI3fg0Vbbf+BuXOHowomgK
 eugFSh8owGOUUiqsTTWhFFTy8KhQRKbMTc1n56fw4l02cqELqZ8bNVQL/wHIvB4jLWHp4bfFuEX
 Z5Ep2yls3ZBxjeFc=
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr7209865wrx.107.1588767108791; 
 Wed, 06 May 2020 05:11:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypITkwYuWilC7he8r6kz3Ay7y1MhvlvXtclL+VvPjE0cooz5s8R+0HG/KsnWZ13/Y/LPi7HdoQ==
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr7209816wrx.107.1588767108346; 
 Wed, 06 May 2020 05:11:48 -0700 (PDT)
Received: from [192.168.1.37] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id w4sm2459947wro.28.2020.05.06.05.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2020 05:11:47 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] target/riscv: Drop support for ISA spec version
 1.09.1
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1588727508.git.alistair.francis@wdc.com>
 <31e61b6cd45bbfa91ce924cdb19ca9844f0907b9.1588727508.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <59587535-3780-fc3a-3c28-869c495cf739@redhat.com>
Date: Wed, 6 May 2020 14:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <31e61b6cd45bbfa91ce924cdb19ca9844f0907b9.1588727508.git.alistair.francis@wdc.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On 5/6/20 3:12 AM, Alistair Francis wrote:
> The RISC-V ISA spec version 1.09.1 has been deprecated in QEMU since
> 4.1. It's not commonly used so let's remove support for it.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c                            | 30 -------
>   target/riscv/cpu.h                            |  8 --
>   target/riscv/csr.c                            | 82 ++++---------------
>   .../riscv/insn_trans/trans_privileged.inc.c   |  6 --
>   tests/qtest/machine-none-test.c               |  4 +-
>   5 files changed, 19 insertions(+), 111 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 059d71f2c7..eeb91f8513 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -135,16 +135,6 @@ static void riscv_base32_cpu_init(Object *obj)
>       set_misa(env, 0);
>   }
>   
> -static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> -    set_priv_version(env, PRIV_VERSION_1_09_1);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> -    set_feature(env, RISCV_FEATURE_MMU);
> -    set_feature(env, RISCV_FEATURE_PMP);
> -}
> -
>   static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>   {
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
> @@ -182,16 +172,6 @@ static void riscv_base64_cpu_init(Object *obj)
>       set_misa(env, 0);
>   }
>   
> -static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> -    set_priv_version(env, PRIV_VERSION_1_09_1);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> -    set_feature(env, RISCV_FEATURE_MMU);
> -    set_feature(env, RISCV_FEATURE_PMP);
> -}
> -
>   static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>   {
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
> @@ -388,8 +368,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>               priv_version = PRIV_VERSION_1_11_0;
>           } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
>               priv_version = PRIV_VERSION_1_10_0;
> -        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
> -            priv_version = PRIV_VERSION_1_09_1;
>           } else {
>               error_setg(errp,
>                          "Unsupported privilege spec version '%s'",
> @@ -621,18 +599,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
>       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
>       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
> -    /* Depreacted */
> -    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init)

Shouldn't you let TYPE_RISCV_CPU_RV32GCSU_V1_10_0 until you remove v1.10.0?

Or remove TYPE_RISCV_CPU_RV32GCSU_V1_10_0 & 
TYPE_RISCV_CPU_RV64GCSU_V1_10_0 in another patch after this one 
(restricted to 1.09.1).

>   #elif defined(TARGET_RISCV64)
>       DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
>       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
>       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
> -    /* Deprecated */
> -    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init)

Ditto.

>   #endif
>   };
>   
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d0e7f5b9c5..c022539012 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -40,13 +40,6 @@
>   #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
>   #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
>   #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
> -/* Deprecated */
> -#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
> -#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
> -#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")

Ditto.

> -#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu-nommu")
> -#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.9.1")
> -#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.10.0")

Ditto.

>   
>   #define RV32 ((target_ulong)1 << (TARGET_LONG_BITS - 2))
>   #define RV64 ((target_ulong)2 << (TARGET_LONG_BITS - 2))
> @@ -80,7 +73,6 @@ enum {
>       RISCV_FEATURE_MISA
>   };
>   
> -#define PRIV_VERSION_1_09_1 0x00010901
>   #define PRIV_VERSION_1_10_0 0x00011000
>   #define PRIV_VERSION_1_11_0 0x00011100
>   
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 11d184cd16..df3498b24f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -58,31 +58,11 @@ static int ctr(CPURISCVState *env, int csrno)
>   #if !defined(CONFIG_USER_ONLY)
>       CPUState *cs = env_cpu(env);
>       RISCVCPU *cpu = RISCV_CPU(cs);
> -    uint32_t ctr_en = ~0u;
>   
>       if (!cpu->cfg.ext_counters) {
>           /* The Counters extensions is not enabled */
>           return -1;
>       }
> -
> -    /*
> -     * The counters are always enabled at run time on newer priv specs, as the
> -     * CSR has changed from controlling that the counters can be read to
> -     * controlling that the counters increment.
> -     */
> -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> -        return 0;
> -    }
> -
> -    if (env->priv < PRV_M) {
> -        ctr_en &= env->mcounteren;
> -    }
> -    if (env->priv < PRV_S) {
> -        ctr_en &= env->scounteren;
> -    }
> -    if (!(ctr_en & (1u << (csrno & 31)))) {
> -        return -1;
> -    }
>   #endif
>       return 0;
>   }
> @@ -358,34 +338,21 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>       int dirty;
>   
>       /* flush tlb on mstatus fields that affect VM */
> -    if (env->priv_ver <= PRIV_VERSION_1_09_1) {
> -        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
> -                MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
> -            tlb_flush(env_cpu(env));
> -        }
> -        mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
> -            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> -            MSTATUS_MPP | MSTATUS_MXR |
> -            (validate_vm(env, get_field(val, MSTATUS_VM)) ?
> -                MSTATUS_VM : 0);
> +    if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
> +            MSTATUS_MPRV | MSTATUS_SUM)) {
> +        tlb_flush(env_cpu(env));
>       }
> -    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> -        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
> -                MSTATUS_MPRV | MSTATUS_SUM)) {
> -            tlb_flush(env_cpu(env));
> -        }
> -        mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
> -            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> -            MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> -            MSTATUS_TW;
> +    mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
> +        MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> +        MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> +        MSTATUS_TW;
>   #if defined(TARGET_RISCV64)
> -            /*
> -             * RV32: MPV and MTL are not in mstatus. The current plan is to
> -             * add them to mstatush. For now, we just don't support it.
> -             */
> -            mask |= MSTATUS_MTL | MSTATUS_MPV;
> +        /*
> +         * RV32: MPV and MTL are not in mstatus. The current plan is to
> +         * add them to mstatush. For now, we just don't support it.
> +         */
> +        mask |= MSTATUS_MTL | MSTATUS_MPV;
>   #endif
> -    }
>   
>       mstatus = (mstatus & ~mask) | (val & mask);
>   
> @@ -553,8 +520,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
>   /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>   static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
>   {
> -    if (env->priv_ver > PRIV_VERSION_1_09_1
> -        && env->priv_ver < PRIV_VERSION_1_11_0) {
> +    if (env->priv_ver < PRIV_VERSION_1_11_0) {
>           return -1;
>       }
>       *val = env->mcounteren;
> @@ -564,8 +530,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
>   /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>   static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
>   {
> -    if (env->priv_ver > PRIV_VERSION_1_09_1
> -        && env->priv_ver < PRIV_VERSION_1_11_0) {
> +    if (env->priv_ver < PRIV_VERSION_1_11_0) {
>           return -1;
>       }
>       env->mcounteren = val;
> @@ -574,20 +539,13 @@ static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
>   
>   static int read_mucounteren(CPURISCVState *env, int csrno, target_ulong *val)
>   {
> -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> -        return -1;
> -    }
> -    *val = env->scounteren;
> +    return -1;
>       return 0;
>   }
>   
>   static int write_mucounteren(CPURISCVState *env, int csrno, target_ulong val)
>   {
> -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> -        return -1;
> -    }
> -    env->scounteren = val;
> -    return 0;
> +    return -1;
>   }
>   
>   /* Machine Trap Handling */
> @@ -829,13 +787,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
>       if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
>           return 0;
>       }
> -    if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val ^ env->sptbr)) {
> -        tlb_flush(env_cpu(env));
> -        env->sptbr = val & (((target_ulong)
> -            1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
> -    }
> -    if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
> -        validate_vm(env, get_field(val, SATP_MODE)) &&
> +    if (validate_vm(env, get_field(val, SATP_MODE)) &&
>           ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
>       {
>           if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
> index 76c2fad71c..1af9fa7df8 100644
> --- a/target/riscv/insn_trans/trans_privileged.inc.c
> +++ b/target/riscv/insn_trans/trans_privileged.inc.c
> @@ -95,12 +95,6 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
>   
>   static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
>   {
> -#ifndef CONFIG_USER_ONLY
> -    if (ctx->priv_ver <= PRIV_VERSION_1_09_1) {
> -        gen_helper_tlb_flush(cpu_env);
> -        return true;
> -    }
> -#endif
>       return false;
>   }
>   
> diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
> index 8bb54a6360..b52311ec2e 100644
> --- a/tests/qtest/machine-none-test.c
> +++ b/tests/qtest/machine-none-test.c
> @@ -54,8 +54,8 @@ static struct arch2cpu cpus_map[] = {
>       { "xtensa", "dc233c" },
>       { "xtensaeb", "fsf" },
>       { "hppa", "hppa" },
> -    { "riscv64", "rv64gcsu-v1.10.0" },
> -    { "riscv32", "rv32gcsu-v1.9.1" },
> +    { "riscv64", "sifive-u54" },
> +    { "riscv32", "sifive-u34" },
>       { "rx", "rx62n" },
>   };
>   
> 


