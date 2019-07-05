Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F42C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F3602133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3602133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVEI-0007t1-R9
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40349)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjVC5-0006UV-07
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjVC3-0008Jh-Dl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:52:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42144)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjVC3-0008J3-53
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:52:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3CB559442;
 Fri,  5 Jul 2019 20:52:29 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EFC0867F8;
 Fri,  5 Jul 2019 20:52:29 +0000 (UTC)
Date: Fri, 5 Jul 2019 17:52:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190705205228.GF5198@habkost.net>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-3-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562079681-19204-3-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 05 Jul 2019 20:52:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/7] target/i386: introduce generic feature
 dependency mechanism
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 05:01:16PM +0200, Paolo Bonzini wrote:
> Sometimes a CPU feature does not make sense unless another is
> present.  In the case of VMX features, KVM does not even allow
> setting the VMX controls to some invalid combinations.
> 
> Therefore, this patch adds a generic mechanism that looks for bits
> that the user explicitly cleared, and uses them to remove other bits
> from the expanded CPU definition.  If these dependent bits were also
> explicitly *set* by the user, this will be a warning for "-cpu check"
> and an error for "-cpu enforce".  If not, then the dependent bits are
> cleared silently, for convenience.
> 
> With VMX features, this will be used so that for example
> "-cpu host,-rdrand" will also hide support for RDRAND exiting.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 77 +++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9149d0d..412e834 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -799,10 +799,6 @@ typedef struct FeatureWordInfo {
>          /* If type==MSR_FEATURE_WORD */
>          struct {
>              uint32_t index;
> -            struct {   /*CPUID that enumerate this MSR*/
> -                FeatureWord cpuid_class;
> -                uint32_t    cpuid_flag;
> -            } cpuid_dep;
>          } msr;
>      };
>      uint32_t tcg_features; /* Feature flags supported by TCG */
> @@ -1197,10 +1193,6 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          },
>          .msr = {
>              .index = MSR_IA32_ARCH_CAPABILITIES,
> -            .cpuid_dep = {
> -                FEAT_7_0_EDX,
> -                CPUID_7_0_EDX_ARCH_CAPABILITIES
> -            }
>          },
>      },
>      [FEAT_CORE_CAPABILITY] = {
> @@ -1217,14 +1209,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          },
>          .msr = {
>              .index = MSR_IA32_CORE_CAPABILITY,
> -            .cpuid_dep = {
> -                FEAT_7_0_EDX,
> -                CPUID_7_0_EDX_CORE_CAPABILITY,
> -            },
>          },
>      },
>  };
>  
> +typedef struct FeatureDep {
> +    uint16_t from, to;

Why uint16_t and not FeatureWord?

> +    uint64_t from_flag, to_flags;

There are other parts of the code that take a
FeatureWord/uint32_t pair (which will become uint64_t).  I'd wrap
this into a typedef.  I also miss documentation on the exact
meaning of those fields.

    typedef struct FeatureMask {
        FeatureWord w;
        uint64_t mask;
    };
    
    
    typedef struct FeatureDependency {
       /*
        * Features in @to may be present only if _all_ features in @from
        * present too.
        */
       FeatureMask from, to;
    };
    
    static FeatureDep feature_dependencies[] = {
        {
            .from = { FEAT_7_0_EDX, CPUID_7_0_EDX_ARCH_CAPABILITIES
            .to =   { FEAT_ARCH_CAPABILITIES, ~0ull },
        },
        {
            .from = { FEAT_7_0_EDX, CPUID_7_0_EDX_CORE_CAPABILITY },
            .to =   { FEAT_CORE_CAPABILITY, ~0ull },
        },
    };


> +} FeatureDep;
> +
> +static FeatureDep feature_dependencies[] = {
> +    {
> +        .from = FEAT_7_0_EDX,            .from_flag = CPUID_7_0_EDX_ARCH_CAPABILITIES,
> +        .to = FEAT_ARCH_CAPABILITIES,    .to_flags = ~0ull,
> +    },
> +    {
> +        .from = FEAT_7_0_EDX,            .from_flag = CPUID_7_0_EDX_CORE_CAPABILITY,
> +        .to = FEAT_CORE_CAPABILITY,      .to_flags = ~0ull,
> +    },
> +};
> +
>  typedef struct X86RegisterInfo32 {
>      /* Name of register */
>      const char *name;
> @@ -5086,9 +5090,42 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>  {
>      CPUX86State *env = &cpu->env;
>      FeatureWord w;
> +    int i;
>      GList *l;
>      Error *local_err = NULL;
>  
> +    for (l = plus_features; l; l = l->next) {
> +        const char *prop = l->data;
> +        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }
> +
> +    for (l = minus_features; l; l = l->next) {
> +        const char *prop = l->data;
> +        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }

Maybe getting rid of plus_features/minus_features (as described
in the TODO comment below) will make things simpler.

> +
> +    for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
> +        FeatureDep *d = &feature_dependencies[i];
> +        if ((env->user_features[d->from] & d->from_flag) &&
> +            !(env->features[d->from] & d->from_flag)) {

Why does it matter if the feature was cleared explicitly by the
user?

> +            uint64_t unavailable_features = env->features[d->to] & d->to_flags;
> +
> +            /* Not an error unless the dependent feature was added explicitly.  */
> +            mark_unavailable_features(cpu, d->to, unavailable_features & env->user_features[d->to],
> +                                      "This feature depends on other features that were not requested");
> +
> +            /* Prevent adding the feature in the loop below.  */
> +            env->user_features[d->to] |= d->to_flags;
> +            env->features[d->to] &= ~d->to_flags;
> +        }
> +    }

Maybe move this entire block inside x86_cpu_filter_features()?

> +
>      /*TODO: Now cpu->max_features doesn't overwrite features
>       * set using QOM properties, and we can convert
>       * plus_features & minus_features to global properties
> @@ -5106,22 +5143,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          }
>      }
>  
> -    for (l = plus_features; l; l = l->next) {
> -        const char *prop = l->data;
> -        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
> -        if (local_err) {
> -            goto out;
> -        }
> -    }
> -
> -    for (l = minus_features; l; l = l->next) {
> -        const char *prop = l->data;
> -        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
> -        if (local_err) {
> -            goto out;
> -        }
> -    }
> -
>      if (!kvm_enabled() || !cpu->expose_kvm) {
>          env->features[FEAT_KVM] = 0;
>      }
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Eduardo

