Received: from eggs.gnu.org ([2001:4830:134:3::10]:46590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chDzQ-0002kA-2k
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chDzM-0004uk-27
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:24:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1chDzL-0004tN-Ox
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:24:39 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8AA680467
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:24:39 +0000 (UTC)
References: <20170222190029.17243-1-ehabkost@redhat.com>
	<20170222190029.17243-2-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0409eedf-7956-7edd-2ad0-b7a0be377ade@redhat.com>
Date: Fri, 24 Feb 2017 12:24:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170222190029.17243-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] target-i386: Define static "base"
 CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

Am 22.02.2017 um 20:00 schrieb Eduardo Habkost:
> The query-cpu-model-expand QMP command needs at least one static
> model, to allow the "static" expansion mode to be implemented.
> Instead of defining static versions of every CPU model, define a
> "base" CPU model that has absolutely no feature flag enabled.
> 
> Despite having no CPUID data set at all, "-cpu base" is even a
> functional CPU:
> 
> * It can boot a Slackware Linux 1.01 image with a Linux 0.99.12
>   kernel[1].
> * It is even possible to boot[2] a modern Fedora x86_64 guest by
>   manually enabling the following CPU features:
>   -cpu base,+lm,+msr,+pae,+fpu,+cx8,+cmov,+sse,+sse2,+fxsr
> 
> [1] http://www.qemu-advent-calendar.org/2014/#day-1
> [2] This is what can be seen in the guest:
>     [root@localhost ~]# cat /proc/cpuinfo
>     processor       : 0
>     vendor_id       : unknown
>     cpu family      : 0
>     model           : 0
>     model name      : 00/00
>     stepping        : 0
>     physical id     : 0
>     siblings        : 1
>     core id         : 0
>     cpu cores       : 1
>     apicid          : 0
>     initial apicid  : 0
>     fpu             : yes
>     fpu_exception   : yes
>     cpuid level     : 1
>     wp              : yes
>     flags           : fpu msr pae cx8 cmov fxsr sse sse2 lm nopl
>     bugs            :
>     bogomips        : 5832.70
>     clflush size    : 64
>     cache_alignment : 64
>     address sizes   : 36 bits physical, 48 bits virtual
>     power management:
> 
>     [root@localhost ~]# x86info -v -a
>     x86info v1.30.  Dave Jones 2001-2011
>     Feedback to <davej@redhat.com>.
> 
>     No TSC, MHz calculation cannot be performed.
>     Unknown vendor (0)
>     MP Table:
> 
>     Family: 0 Model: 0 Stepping: 0
>     CPU Model (x86info's best guess):
> 
>     eax in: 0x00000000, eax = 00000001 ebx = 00000000 ecx = 00000000 edx = 00000000
>     eax in: 0x00000001, eax = 00000000 ebx = 00000800 ecx = 00000000 edx = 07008161
> 
>     eax in: 0x80000000, eax = 80000001 ebx = 00000000 ecx = 00000000 edx = 00000000
>     eax in: 0x80000001, eax = 00000000 ebx = 00000000 ecx = 00000000 edx = 20000000
> 
>     Feature flags:
>      fpu            Onboard FPU
>      msr            Model-Specific Registers
>      pae            Physical Address Extensions
>      cx8            CMPXCHG8 instruction
>      cmov           CMOV instruction
>      fxsr           FXSAVE and FXRSTOR instructions
>      sse            SSE support
>      sse2           SSE2 support
> 
>     Long NOPs supported: yes
> 
>     Address sizes : 0 bits physical, 0 bits virtual
>     0MHz processor (estimate).
> 
>      running at an estimated 0MHz
>     [root@localhost ~]#
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu-qom.h |  2 ++
>  target/i386/cpu.c     | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
> index f6c704c3a9..c2205e6077 100644
> --- a/target/i386/cpu-qom.h
> +++ b/target/i386/cpu-qom.h
> @@ -50,6 +50,7 @@ typedef struct X86CPUDefinition X86CPUDefinition;
>   * @kvm_required: Whether CPU model requires KVM to be enabled.
>   * @ordering: Ordering on the "-cpu help" CPU model list.
>   * @migration_safe: See CpuDefinitionInfo::migration_safe
> + * @static_model: See CpuDefinitionInfo::static
>   * @parent_realize: The parent class' realize handler.
>   * @parent_reset: The parent class' reset handler.
>   *
> @@ -68,6 +69,7 @@ typedef struct X86CPUClass {
>      bool kvm_required;
>      int ordering;
>      bool migration_safe;
> +    bool static_model;
>  
>      /* Optional description of CPU model.
>       * If unavailable, cpu_def->model_id is used */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c6f62367b0..4241f56e8a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2230,6 +2230,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>      info->q_typename = g_strdup(object_class_get_name(oc));
>      info->migration_safe = cc->migration_safe;
>      info->has_migration_safe = true;
> +    info->q_static = cc->static_model;
>  
>      entry = g_malloc0(sizeof(*entry));
>      entry->value = info;
> @@ -3836,6 +3837,24 @@ static const TypeInfo x86_cpu_type_info = {
>      .class_init = x86_cpu_common_class_init,
>  };
>  
> +
> +/* "base" CPU model, used by query-cpu-model-expansion */
> +static void x86_cpu_base_class_init(ObjectClass *oc, void *data)
> +{
> +    X86CPUClass *xcc = X86_CPU_CLASS(oc);
> +
> +    xcc->static_model = true;
> +    xcc->migration_safe = true;
> +    xcc->model_description = "base CPU model type with no feature enabled";

s/feature/features/ ? (no native speaker ;) )

> +    xcc->ordering = 8;
> +}
> +
> +static const TypeInfo x86_base_cpu_type_info = {
> +        .name = X86_CPU_TYPE_NAME("base"),
> +        .parent = TYPE_X86_CPU,
> +        .class_init = x86_cpu_base_class_init,
> +};
> +
>  static void x86_cpu_register_types(void)
>  {
>      int i;
> @@ -3845,6 +3864,7 @@ static void x86_cpu_register_types(void)
>          x86_register_cpudef_type(&builtin_x86_defs[i]);
>      }
>      type_register_static(&max_x86_cpu_type_info);
> +    type_register_static(&x86_base_cpu_type_info);
>  #ifdef CONFIG_KVM
>      type_register_static(&host_x86_cpu_type_info);
>  #endif
> 

Looks sane to me!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David
