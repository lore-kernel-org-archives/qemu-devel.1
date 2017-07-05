Received: from eggs.gnu.org ([2001:4830:134:3::10]:54007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dSgol-0007FO-5Z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dSgoi-0006iO-17
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:41:55 -0400
References: <149924459296.25523.6693809356627708668.stgit@bahia.lan>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <4d2505f5-ee00-7cb3-4933-a7be8c82fb14@redhat.com>
Date: Wed, 5 Jul 2017 11:41:46 +0200
MIME-Version: 1.0
In-Reply-To: <149924459296.25523.6693809356627708668.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc/kvm: have the "family" CPU alias to
 point to TYPE_HOST_POWERPC_CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 05/07/2017 10:49, Greg Kurz wrote:
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index f2f7c531bc7b..f7a7ea5858a3 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2445,6 +2445,7 @@ static int kvm_ppc_register_host_cpu_type(void)
>          .class_init = kvmppc_host_cpu_class_init,
>      };
>      PowerPCCPUClass *pvr_pcc;
> +    ObjectClass *oc;
>      DeviceClass *dc;
>      int i;
>  
> @@ -2455,6 +2456,9 @@ static int kvm_ppc_register_host_cpu_type(void)
>      type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
>      type_register(&type_info);
>  
> +    oc = object_class_by_name(type_info.name);
> +    g_assert(oc);
> +
>  #if defined(TARGET_PPC64)
>      type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
>      type_info.parent = TYPE_SPAPR_CPU_CORE,
> @@ -2474,7 +2478,6 @@ static int kvm_ppc_register_host_cpu_type(void)
>      dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
>      for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>          if (strcmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
> -            ObjectClass *oc = OBJECT_CLASS(pvr_pcc);
>              char *suffix;
>  
>              ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
> 

A far better solution :)

Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
