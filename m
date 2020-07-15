Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E834FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4D720672
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4D720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvbkt-00085T-5w
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 03:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jvbkC-0007bB-0l
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:22:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:53501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jvbk9-0003hN-4G
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:22:19 -0400
IronPort-SDR: oYGs4/5BUEknd0r1vfJBPNmqNLAtE466ak9hCTDX4wIe3Yw3ol5j/ZbvogPbWpKSlPgWlPwD3x
 T0vEz3QM6nFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="136554590"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="136554590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 00:22:12 -0700
IronPort-SDR: 8qappwCPKaCoRAx7D++e418paCz1rk1sh3Sp7XS73k1xo6X15Ekz49E0HV6dvPfaBGFLU1chJC
 2LM/IKYkEtdQ==
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="459972590"
Received: from unknown (HELO [10.239.13.102]) ([10.239.13.102])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 00:22:11 -0700
Subject: Re: [Qemu-devel][PATCH v5 2/4] x86/cpuid: Add XSAVES feature words
 and CET related state bits
To: Yang Weijiang <weijiang.yang@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
References: <20200510014250.28111-1-weijiang.yang@intel.com>
 <20200510014250.28111-3-weijiang.yang@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <cf6a15c0-462b-1f2e-b43c-a6e7672d9d41@intel.com>
Date: Wed, 15 Jul 2020 15:22:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200510014250.28111-3-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 03:22:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/2020 9:42 AM, Yang Weijiang wrote:
> CET SHSTK/IBT MSRs can be saved/restored with XSAVES/XRSTORS, but
> currently the related feature words are not supported, so add the
> new entries. XSAVES/RSTORS always use compacted storage format, which
> means the supervisor states' offsets are always 0, ignore them while
> calculating stardard format storage size.
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>   target/i386/cpu.c | 38 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 90ffc5f3b1..3174e05482 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -965,7 +965,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
>               NULL, "avx512vbmi", "umip", "pku",
> -            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
> +            NULL /* ospke */, "waitpkg", "avx512vbmi2", "shstk",
>               "gfni", "vaes", "vpclmulqdq", "avx512vnni",
>               "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
>               "la57", NULL, NULL, NULL,
> @@ -988,7 +988,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               NULL, NULL, "md-clear", NULL,
>               NULL, NULL, NULL, NULL,
>               NULL, NULL, NULL /* pconfig */, NULL,
> -            NULL, NULL, NULL, NULL,
> +            "ibt", NULL, NULL, NULL,
>               NULL, NULL, "spec-ctrl", "stibp",
>               NULL, "arch-capabilities", "core-capability", "ssbd",
>           },
> @@ -1069,6 +1069,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>           },
>           .tcg_features = TCG_XSAVE_FEATURES,
>       },
> +    /* Below are xsaves feature words */
> +    [FEAT_XSAVES_LO] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .cpuid = {
> +            .eax = 0xD,
> +            .needs_ecx = true,
> +            .ecx = 1,
> +            .reg = R_ECX,
> +        },
> +        .migratable_flags = XSTATE_CET_U_MASK,

why exclude XSTATE_CET_S_MASK? Is any reason why it not migratable?

> +    },
> +    [FEAT_XSAVES_HI] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .cpuid = {
> +            .eax = 0xD,
> +            .needs_ecx = true,
> +            .ecx = 1,
> +            .reg = R_EDX
> +        },
> +    },
>       [FEAT_6_EAX] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
> @@ -1455,6 +1475,14 @@ static const ExtSaveArea x86_ext_save_areas[] = {
>             { .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
>               .offset = offsetof(X86XSaveArea, pkru_state),
>               .size = sizeof(XSavePKRU) },
> +    [XSTATE_CET_U_BIT] = {
> +            .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
> +            .offset = 0 /*supervisor mode component, offset = 0 */,
> +            .size = sizeof(XSavesCETU) },
> +    [XSTATE_CET_S_BIT] = {
> +            .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_CET_SHSTK,
> +            .offset = 0 /*supervisor mode component, offset = 0 */,
> +            .size = sizeof(XSavesCETS) },
>   };
>   
>   static uint32_t xsave_area_size(uint64_t mask)
> @@ -1465,6 +1493,9 @@ static uint32_t xsave_area_size(uint64_t mask)
>       for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
>           const ExtSaveArea *esa = &x86_ext_save_areas[i];
>           if ((mask >> i) & 1) {
> +            if (i >= 2 && !esa->offset) {
> +                continue;
> +            }
>               ret = MAX(ret, esa->offset + esa->size);
>           }
>       }
> @@ -6008,6 +6039,9 @@ static void x86_cpu_reset(DeviceState *dev)
>       }
>       for (i = 2; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
>           const ExtSaveArea *esa = &x86_ext_save_areas[i];
> +        if (!esa->offset) {
> +            continue;
> +        }
>           if (env->features[esa->feature] & esa->bits) {
>               xcr0 |= 1ull << i;
>           }
> 


