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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F24EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FB520663
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FB520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvbZh-0002cB-TS
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 03:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jvbYz-0002BI-6m
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:10:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:11769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jvbYw-0000Zm-CU
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:10:44 -0400
IronPort-SDR: rDA66K5j271eewF3wpOV0fq75NYNSsB4X6RwthE3UgKCgrfzn+NVPEPVUWV/94JlwWt7UR51o0
 4ncHWXbdoa2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="137225813"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="137225813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 00:10:35 -0700
IronPort-SDR: 9p1t0j9J2jLdg11JlK1gT1us7nusVgJxYVgzUYHXQ1lyk/HGolLwCzrLjAJP/hId+wwuenAlly
 Fdq/v4LIxGsA==
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="459969888"
Received: from unknown (HELO [10.239.13.102]) ([10.239.13.102])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 00:10:34 -0700
Subject: Re: [Qemu-devel][PATCH v5 1/4] x86/cpu: Add CET CPUID/XSAVES flags
 and data structures
To: Yang Weijiang <weijiang.yang@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
References: <20200510014250.28111-1-weijiang.yang@intel.com>
 <20200510014250.28111-2-weijiang.yang@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <158261ea-9800-11d1-4089-c9669dcd74c3@intel.com>
Date: Wed, 15 Jul 2020 15:10:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200510014250.28111-2-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=xiaoyao.li@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 03:10:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> CET feature SHSTK and IBT are enumerated via CPUID(EAX=0x7,0):ECX[bit 7]
> and EDX[bit 20] respectively. Two CET bits (bit 11 and 12) are defined in
> MSR_IA32_XSS to support XSAVES/XRSTORS. CPUID(EAX=0xd, 1):ECX[bit 11] and
> ECX[bit 12] correspond to CET states in user and supervisor mode respectively.
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>   target/i386/cpu.h | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e818fc712a..ed03cd1760 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -489,6 +489,9 @@ typedef enum X86Seg {
>   #define XSTATE_ZMM_Hi256_BIT            6
>   #define XSTATE_Hi16_ZMM_BIT             7
>   #define XSTATE_PKRU_BIT                 9
> +#define XSTATE_RESERVED_BIT             10

I think this is unnecessary. bit 8 and so many other undefined bits are 
reserved too.

> +#define XSTATE_CET_U_BIT                11
> +#define XSTATE_CET_S_BIT                12
>   
>   #define XSTATE_FP_MASK                  (1ULL << XSTATE_FP_BIT)
>   #define XSTATE_SSE_MASK                 (1ULL << XSTATE_SSE_BIT)
> @@ -499,6 +502,19 @@ typedef enum X86Seg {
>   #define XSTATE_ZMM_Hi256_MASK           (1ULL << XSTATE_ZMM_Hi256_BIT)
>   #define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
>   #define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
> +#define XSTATE_RESERVED_MASK            (1ULL << XSTATE_RESERVED_BIT)

Ditto.

> +#define XSTATE_CET_U_MASK               (1ULL << XSTATE_CET_U_BIT)
> +#define XSTATE_CET_S_MASK               (1ULL << XSTATE_CET_S_BIT)
> +
> +/* CPUID feature bits available in XCR0 */
> +#define CPUID_XSTATE_USER_MASK  (XSTATE_FP_MASK | XSTATE_SSE_MASK | \
> +                                 XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | \
> +                                 XSTATE_BNDCSR_MASK | XSTATE_OPMASK_MASK | \
> +                                 XSTATE_ZMM_Hi256_MASK | \
> +                                 XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK)
> +
> +/* CPUID feature bits available in XSS */
> +#define CPUID_XSTATE_KERNEL_MASK    (XSTATE_CET_U_MASK)

How about we name it XSTATE_XCR0_MASK and XSTATE_XSS_MASK.

They are not CPUID feature bit, at least the CPUID_ prefix needs to be 
removed.

>   
>   /* CPUID feature words */
>   typedef enum FeatureWord {
> @@ -536,6 +552,8 @@ typedef enum FeatureWord {
>       FEAT_VMX_EPT_VPID_CAPS,
>       FEAT_VMX_BASIC,
>       FEAT_VMX_VMFUNC,
> +    FEAT_XSAVES_LO,     /* CPUID[EAX=0xd,ECX=1].ECX */
> +    FEAT_XSAVES_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */

I don't think *XSAVES* is a good name, because XSAVES and manipulate the 
features masked by XCR0 | MSR_IA32_XSS. But this CPUID leaf only 
enumerated XSTATE features for XSS.

How about name it FEAT_XSS_LO/HI? or FEAT_XSAVES_XSS_HO/HI

>       FEATURE_WORDS,
>   } FeatureWord;
>   
> @@ -743,6 +761,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>   #define CPUID_7_0_ECX_WAITPKG           (1U << 5)
>   /* Additional AVX-512 Vector Byte Manipulation Instruction */
>   #define CPUID_7_0_ECX_AVX512_VBMI2      (1U << 6)
> +/* CET SHSTK feature */
> +#define CPUID_7_0_ECX_CET_SHSTK         (1U << 7)
>   /* Galois Field New Instructions */
>   #define CPUID_7_0_ECX_GFNI              (1U << 8)
>   /* Vector AES Instructions */
> @@ -770,6 +790,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>   #define CPUID_7_0_EDX_AVX512_4VNNIW     (1U << 2)
>   /* AVX512 Multiply Accumulation Single Precision */
>   #define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
> +/* CET IBT feature */
> +#define CPUID_7_0_EDX_CET_IBT           (1U << 20)
>   /* Speculation Control */
>   #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
>   /* Single Thread Indirect Branch Predictors */
> @@ -1260,6 +1282,19 @@ typedef struct XSavePKRU {
>       uint32_t padding;
>   } XSavePKRU;
>   
> +/* Ext. save area 11: User mode CET state */
> +typedef struct XSavesCETU {
> +    uint64_t u_cet;
> +    uint64_t user_ssp;
> +} XSavesCETU;
> +
> +/* Ext. save area 12: Supervisor mode CET state */
> +typedef struct XSavesCETS {
> +    uint64_t kernel_ssp;
> +    uint64_t pl1_ssp;
> +    uint64_t pl2_ssp;
> +} XSavesCETS;
> +
>   typedef struct X86XSaveArea {
>       X86LegacyXSaveArea legacy;
>       X86XSaveHeader header;
> 


