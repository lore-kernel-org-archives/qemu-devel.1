Received: from eggs.gnu.org ([2001:4830:134:3::10]:37692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7x5d-0002Mt-CS
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7x5a-00030R-BF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:49:37 -0400
References: <1488999936-16898-1-git-send-email-thuth@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a44802fe-780c-8a5d-ba1d-a9969748f19d@redhat.com>
Date: Tue, 9 May 2017 06:49:29 +0200
MIME-Version: 1.0
In-Reply-To: <1488999936-16898-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Avoid printing
 wrong aliases in CPU help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Eduardo Habkost <ehabkost@redhat.com>

On 08.03.2017 20:05, Thomas Huth wrote:
> When running with KVM, we update the "family" CPU alias to point
> to the right host CPU type, so that it is for example possible to
> use "-cpu POWER8" on a POWER8NVL host. However, the function for
> printing the list of available CPU models is called earlier than
> the KVM setup code, so the output of "-cpu help" is wrong in that
> case. Since it would be somewhat ugly anyway to have different
> help texts depending on whether "-enable-kvm" has been specified
> or not, we should better always print the same text, so fix this
> issue by printing "alias for preferred XXX CPU" instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/ppc/cpu.h            |  1 +
>  target/ppc/kvm.c            | 12 ------------
>  target/ppc/translate_init.c | 27 +++++++++++++++++++++++++--
>  3 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 7c4a1f5..21752ff 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1216,6 +1216,7 @@ static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
>  
>  PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
>  PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
> +PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
>  
>  struct PPCVirtualHypervisor {
>      Object parent;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9f1f132..585e6d3 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2304,18 +2304,6 @@ bool kvmppc_has_cap_htm(void)
>      return cap_htm;
>  }
>  
> -static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
> -{
> -    ObjectClass *oc = OBJECT_CLASS(pcc);
> -
> -    while (oc && !object_class_is_abstract(oc)) {
> -        oc = object_class_get_parent(oc);
> -    }
> -    assert(oc);
> -
> -    return POWERPC_CPU_CLASS(oc);
> -}
> -
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr = mfpvr();
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index c1a9014..9e9c37f 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10249,6 +10249,18 @@ PowerPCCPU *cpu_ppc_init(const char *cpu_model)
>      return POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
>  }
>  
> +PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
> +{
> +    ObjectClass *oc = OBJECT_CLASS(pcc);
> +
> +    while (oc && !object_class_is_abstract(oc)) {
> +        oc = object_class_get_parent(oc);
> +    }
> +    assert(oc);
> +
> +    return POWERPC_CPU_CLASS(oc);
> +}
> +
>  /* Sort by PVR, ordering special case "host" last. */
>  static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b)
>  {
> @@ -10280,6 +10292,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
>      ObjectClass *oc = data;
>      CPUListState *s = user_data;
>      PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> +    DeviceClass *family = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
>      const char *typename = object_class_get_name(oc);
>      char *name;
>      int i;
> @@ -10302,8 +10315,18 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
>          if (alias_oc != oc) {
>              continue;
>          }
> -        (*s->cpu_fprintf)(s->file, "PowerPC %-16s (alias for %s)\n",
> -                          alias->alias, name);
> +        /*
> +         * If running with KVM, we might update the family alias later, so
> +         * avoid printing the wrong alias here and use "preferred" instead
> +         */
> +        if (strcmp(alias->alias, family->desc) == 0) {
> +            (*s->cpu_fprintf)(s->file,
> +                              "PowerPC %-16s (alias for preferred %s CPU)\n",
> +                              alias->alias, family->desc);
> +        } else {
> +            (*s->cpu_fprintf)(s->file, "PowerPC %-16s (alias for %s)\n",
> +                              alias->alias, name);
> +        }
>      }
>      g_free(name);
>  }
> 

Ping!

... I think this got somehow lost in the 2.9 rush ...

 Thomas
