Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C44C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AAA20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AAA20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHYt-0000JO-U5
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hdH2T-0002xR-BH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hdH2R-0005XL-Qo
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:32:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hdH2R-0005UM-Ih
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:32:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so244119wrv.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FtcEXFK7NlBTMcGOYcg47ugmC8KoonYwN3BxvE7Oqy0=;
 b=jfttMO8jK2AA8ZpwT8ZNxagRr3uvnSKxigi/iKXYyQAcksqXoIBjCFZIiXPNdxWEcI
 6A3R4j3EENlfKPkAyg0lYoDsjInI3Rso8kvE1qRQeIFuRXabOEs54MMqf6yVSHhNOo0L
 gwOSrURdNS+/p9pplTsuu3P/+8rG/dq0qPg9I6R/j94kh5XIH1n8rwvh0+jaMN/dibOZ
 5PDwjHg5kUy5rz8ClncmA9V5c1il1MDbGYOETb98sINb62/yQ5ca+SU9nM7R+KELe4Rx
 sEu5d2EHIrsuMXD1iM0Frj0WF+3ylcEtW3Sn8Of5wSbaW7dSpoHXmyXlOZVGZB2RzYi9
 oBvg==
X-Gm-Message-State: APjAAAXt9xvoyqJd3K0GY/48Fpi1Z2OF6OidUzAOo+TsHR9i6inWn0zn
 CJCm2CYDPs9LlIC5QuPIN7L8LA==
X-Google-Smtp-Source: APXvYqwgt2hfL2TJvfr61m8X37Gn70MdhTh+pKILU4xTFz0PJfKwsKptrxFU50qzKrPDZRaiaHRXFQ==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr17369002wrk.229.1560875569728; 
 Tue, 18 Jun 2019 09:32:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51c0:d03f:68e:1f6d?
 ([2001:b07:6468:f312:51c0:d03f:68e:1f6d])
 by smtp.gmail.com with ESMTPSA id l124sm4711746wmf.36.2019.06.18.09.32.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 09:32:49 -0700 (PDT)
To: Xiaoyao Li <xiaoyao.li@linux.intel.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20190617153654.916-1-xiaoyao.li@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78e052c3-5f85-5343-baac-a0c3d351c3d7@redhat.com>
Date: Tue, 18 Jun 2019 18:32:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617153654.916-1-xiaoyao.li@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: define a new MSR based
 feature word - FEAT_CORE_CAPABILITY
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
Cc: Paul Lai <paul.c.lai@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/19 17:36, Xiaoyao Li wrote:
> MSR IA32_CORE_CAPABILITY is a feature-enumerating MSR, which only
> enumerates the feature split lock detection (via bit 5) by now.
> 
> The existence of MSR IA32_CORE_CAPABILITY is enumerated by CPUID.7_0:EDX[30].
> 
> The latest kernel patches about them can be found here:
> https://lkml.org/lkml/2019/4/24/1909
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> ---
> Changelog:
> v2
>     Add definition of MSR_CORE_CAP_SPLIT_LOCK_DETECT for SNR cpu model
> ---
>  target/i386/cpu.c | 22 +++++++++++++++++++++-
>  target/i386/cpu.h |  5 +++++
>  target/i386/kvm.c |  9 +++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index fbed2eb804..fc47c650b8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1085,7 +1085,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "spec-ctrl", "stibp",
> -            NULL, "arch-capabilities", NULL, "ssbd",
> +            NULL, "arch-capabilities", "core-capability", "ssbd",
>          },
>          .cpuid = {
>              .eax = 7,
> @@ -1203,6 +1203,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              }
>          },
>      },
> +    [FEAT_CORE_CAPABILITY] = {
> +        .type = MSR_FEATURE_WORD,
> +        .feat_names = {
> +            NULL, NULL, NULL, NULL,
> +            NULL, "split-lock-detect", NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .msr = {
> +            .index = MSR_IA32_CORE_CAPABILITY,
> +            .cpuid_dep = {
> +                FEAT_7_0_EDX,
> +                CPUID_7_0_EDX_CORE_CAPABILITY,
> +            },
> +        },
> +    },
>  };
>  
>  typedef struct X86RegisterInfo32 {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0732e059ec..192b0db076 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -345,6 +345,7 @@ typedef enum X86Seg {
>  #define MSR_IA32_SPEC_CTRL              0x48
>  #define MSR_VIRT_SSBD                   0xc001011f
>  #define MSR_IA32_PRED_CMD               0x49
> +#define MSR_IA32_CORE_CAPABILITY        0xcf
>  #define MSR_IA32_ARCH_CAPABILITIES      0x10a
>  #define MSR_IA32_TSCDEADLINE            0x6e0
>  
> @@ -496,6 +497,7 @@ typedef enum FeatureWord {
>      FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
>      FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
>      FEAT_ARCH_CAPABILITIES,
> +    FEAT_CORE_CAPABILITY,
>      FEATURE_WORDS,
>  } FeatureWord;
>  
> @@ -687,6 +689,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
>  #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
> +#define CPUID_7_0_EDX_CORE_CAPABILITY   (1U << 30)  /*Core Capability*/
>  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
>  
>  #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
> @@ -734,6 +737,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY (1U << 3)
>  #define MSR_ARCH_CAP_SSB_NO     (1U << 4)
>  
> +#define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
> +
>  #ifndef HYPERV_SPINLOCK_NEVER_RETRY
>  #define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
>  #endif
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 6899061b4e..da99e91ea9 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -95,6 +95,7 @@ static bool has_msr_spec_ctrl;
>  static bool has_msr_virt_ssbd;
>  static bool has_msr_smi_count;
>  static bool has_msr_arch_capabs;
> +static bool has_msr_core_capabs;
>  
>  static uint32_t has_architectural_pmu_version;
>  static uint32_t num_architectural_pmu_gp_counters;
> @@ -1515,6 +1516,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>                  case MSR_IA32_ARCH_CAPABILITIES:
>                      has_msr_arch_capabs = true;
>                      break;
> +                case MSR_IA32_CORE_CAPABILITY:
> +                    has_msr_core_capabs = true;
> +                    break;
>                  }
>              }
>          }
> @@ -2041,6 +2045,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>                            env->features[FEAT_ARCH_CAPABILITIES]);
>      }
>  
> +    if (has_msr_core_capabs) {
> +        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
> +                          env->features[FEAT_CORE_CAPABILITY]);
> +    }
> +
>      /*
>       * The following MSRs have side effects on the guest or are too heavy
>       * for normal writeback. Limit them to reset or full state updates.
> 

Queued, thanks.

Paolo

