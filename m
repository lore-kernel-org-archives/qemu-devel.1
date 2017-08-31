Received: from eggs.gnu.org ([2001:4830:134:3::10]:33186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPm3-0007fP-Sh
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnPlz-0002Lc-62
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:44:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnPly-0002LE-SV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:44:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F446C0587C6
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 13:44:41 +0000 (UTC)
References: <1503592308-93913-9-git-send-email-imammedo@redhat.com>
	<1504185578-80843-1-git-send-email-imammedo@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <94cbb70c-5d33-c638-9826-277a359d178e@redhat.com>
Date: Thu, 31 Aug 2017 15:44:38 +0200
MIME-Version: 1.0
In-Reply-To: <1504185578-80843-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 v4 08/25] s390x: replace
 cpu_s390x_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 31.08.2017 15:19, Igor Mammedov wrote:
> cpu_s390x_init() is used only *-user targets indirectly
> via cpu_init() macro and has a hack to assign ids to created
> cpus (I'm not sure if 'id' really matters to *-user emulation).

It only has one cpu, right? With the below mentioned patch, the default
"id"/ (the cpu_addr) will be 0. So you can create one CPU without any
hacks. Or can it create more than 1?

> 
> So to on safe side, instead of having custom wrapper to do numbering
> replace it with cpu_generic_init() and use S390CPUClass::next_cpu_id
> which could serve the same purpose as static variable and move cpu->id
> initialization to s390_cpu_initfn for CONFIG_USER_ONLY use-case.
> 
> PS:
> ifdef is ugly but it allows us to hide s390x detail that isn't
> set by *-user targets and reuse generic cpu creation utility
> for btoh machine and user emulation.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> ---
> v2:
>   - fix merge conflict in target/s390x/cpu.h caused by moving
>     cpu_init/cpu_s390x_init with the file in commit
>     (c862bddbc target/s390x: cleanup cpu.h)
> 
> CC: Cornelia Huck <cohuck@redhat.com>
> CC: david@redhat.com
> CC: Eduardo Habkost <ehabkost@redhat.com>
> 
> perhaps cpu->id isn't need by CONFIG_USER_ONLY but I'd leave to it
> s390x maintainers to deal with it.

Will most probably be dropped in

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06158.html

> ---
>  target/s390x/cpu.h    |  3 +--
>  target/s390x/cpu.c    |  7 +++++++
>  target/s390x/helper.c | 14 --------------
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 4ec3380..0bd97a5 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -688,8 +688,7 @@ const char *s390_default_cpu_model_name(void);
>  
>  
>  /* helper.c */
> -S390CPU *cpu_s390x_init(const char *cpu_model);
> -#define cpu_init(model) CPU(cpu_s390x_init(model))
> +#define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
>  S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
>  /* you can call this signal handler from your SIGBUS and SIGSEGV
>     signal handlers to inform the virtual CPU of exceptions. non zero
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 7267b60..74b3e4f 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -306,6 +306,13 @@ static void s390_cpu_initfn(Object *obj)
>          inited = true;
>          s390x_translate_init();
>      }
> +
> +#if defined(CONFIG_USER_ONLY)
> +    {
> +        S390CPUClass *scc = S390_CPU_GET_CLASS(obj);
> +        cpu->id = scc->next_cpu_id;
> +    }
> +#endif
>  }
>  
>  static void s390_cpu_finalize(Object *obj)
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 3adb9de..ba29504 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -129,20 +129,6 @@ out:
>      return cpu;
>  }
>  
> -S390CPU *cpu_s390x_init(const char *cpu_model)
> -{
> -    Error *err = NULL;
> -    S390CPU *cpu;
> -    /* Use to track CPU ID for linux-user only */
> -    static int64_t next_cpu_id;
> -
> -    cpu = s390x_new_cpu(cpu_model, next_cpu_id++, &err);
> -    if (err) {
> -        error_report_err(err);
> -    }
> -    return cpu;
> -}
> -
>  #ifndef CONFIG_USER_ONLY
>  
>  hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
> 


-- 

Thanks,

David
