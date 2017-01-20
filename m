Received: from eggs.gnu.org ([2001:4830:134:3::10]:39320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUYHV-0005NP-7T
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUYHS-0005jM-3f
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:27:01 -0500
References: <1484914681-2986-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6d36159-b69e-9d44-9cc3-d2b6482945a4@redhat.com>
Date: Fri, 20 Jan 2017 13:26:54 +0100
MIME-Version: 1.0
In-Reply-To: <1484914681-2986-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Introduce DEVICE_CATEGORY_CPU for CPU
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 20/01/2017 13:18, Thomas Huth wrote:
> Now that the hot-pluggable CPUs show up in the help text of
> "-device ?", we should group them into an appropriate category.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/ppc/pnv_core.c       | 1 +
>  hw/ppc/spapr_cpu_core.c | 1 +
>  include/hw/qdev-core.h  | 1 +
>  qdev-monitor.c          | 1 +
>  target/i386/cpu.c       | 2 ++
>  5 files changed, 6 insertions(+)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index d79d530..a9c981e 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -190,6 +190,7 @@ static void pnv_core_class_init(ObjectClass *oc, void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
>  
> +    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
>      dc->realize = pnv_core_realize;
>      dc->props = pnv_core_properties;
>      pcc->cpu_oc = cpu_class_by_name(TYPE_POWERPC_CPU, data);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c18632b..dd0028e 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -365,6 +365,7 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
>  
> +    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
>      dc->realize = spapr_cpu_core_realize;
>      scc->cpu_class = cpu_class_by_name(TYPE_POWERPC_CPU, data);
>      g_assert(scc->cpu_class);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 2c97347..b44b476 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -26,6 +26,7 @@ typedef enum DeviceCategory {
>      DEVICE_CATEGORY_DISPLAY,
>      DEVICE_CATEGORY_SOUND,
>      DEVICE_CATEGORY_MISC,
> +    DEVICE_CATEGORY_CPU,
>      DEVICE_CATEGORY_MAX
>  } DeviceCategory;
>  
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index c73410c..5f2fcdf 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -136,6 +136,7 @@ static void qdev_print_devinfos(bool show_no_user)
>          [DEVICE_CATEGORY_DISPLAY] = "Display",
>          [DEVICE_CATEGORY_SOUND]   = "Sound",
>          [DEVICE_CATEGORY_MISC]    = "Misc",
> +        [DEVICE_CATEGORY_CPU]     = "CPU",
>          [DEVICE_CATEGORY_MAX]     = "Uncategorized",
>      };
>      GSList *list, *elt;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index aba11ae..7b8ca5f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2381,8 +2381,10 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
>  {
>      X86CPUDefinition *cpudef = data;
>      X86CPUClass *xcc = X86_CPU_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
>  
>      xcc->cpu_def = cpudef;
> +    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
>  }
>  
>  static void x86_register_cpudef_type(X86CPUDefinition *def)
> 

Queued, thanks.

Paolo
