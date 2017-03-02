Received: from eggs.gnu.org ([2001:4830:134:3::10]:58736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cjWka-0006Fp-1x
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cjWkU-0001DD-4N
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:50:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cjWkT-0001D4-UI
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:50:50 -0500
References: <20170302193300.21188-1-brogers@suse.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <36cb066c-4d1f-dc7f-ada6-cef224566f2d@redhat.com>
Date: Thu, 2 Mar 2017 20:50:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170302193300.21188-1-brogers@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Exclude more cpu model code
 when building s390x linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Christian Borntraeger <borntraeger@de.ibm.com>

Am 02.03.2017 um 20:33 schrieb Bruce Rogers:
> Currently qemu-s390x segfaults. Avoid cpu model code which doesn't
> apply in linux user case.

That was also my impression, but it does apply. However, for now it
doesn't matter, as also tcg isn't properly wired up.

In general, linux-user can support _at least_ the same features as tcg,
in theory even more (all that only apply to kernel space).

We had a proper fix on this list by Richard Henderson, wonder what
happened to that?

This file should contain no CONFIG_USER_ONLY apart from the QMP
interface stuff.

> ---
>  target/s390x/cpu_models.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 2a894eec65..97e4e75f68 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -590,7 +590,6 @@ CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
>      cpu_info_from_model(baseline_info->model, &model, true);
>      return baseline_info;
>  }
> -#endif
>  
>  static void check_consistency(const S390CPUModel *model)
>  {
> @@ -660,7 +659,6 @@ static void check_compatibility(const S390CPUModel *max_model,
>  
>  static S390CPUModel *get_max_cpu_model(Error **errp)
>  {
> -#ifndef CONFIG_USER_ONLY
>      static S390CPUModel max_model;
>      static bool cached;
>  
> @@ -680,9 +678,9 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>          cached = true;
>          return &max_model;
>      }
> -#endif
>      return NULL;
>  }
> +#endif
>  
>  static inline void apply_cpu_model(const S390CPUModel *model, Error **errp)
>  {
> @@ -718,6 +716,7 @@ static inline void apply_cpu_model(const S390CPUModel *model, Error **errp)
>  
>  void s390_realize_cpu_model(CPUState *cs, Error **errp)
>  {
> +#ifndef CONFIG_USER_ONLY
>      S390CPUClass *xcc = S390_CPU_GET_CLASS(cs);
>      S390CPU *cpu = S390_CPU(cs);
>      const S390CPUModel *max_model;
> @@ -751,6 +750,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
>      }
>  
>      apply_cpu_model(cpu->model, errp);
> +#endif
>  }
>  
>  static void get_feature(Object *obj, Visitor *v, const char *name,
> 


-- 
Thanks,

David
