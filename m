Received: from eggs.gnu.org ([2001:4830:134:3::10]:56180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXSXF-0000WA-5j
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXSXC-0000Fu-1Y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dXSXB-0000FF-OV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:27:29 -0400
Date: Tue, 18 Jul 2017 15:27:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170718152726.1f1b0bff@nial.brq.redhat.com>
In-Reply-To: <20170712162058.10538-5-ehabkost@redhat.com>
References: <20170712162058.10538-1-ehabkost@redhat.com>
	<20170712162058.10538-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] target/i386: Don't use
 x86_cpu_load_def() on "max" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 12 Jul 2017 13:20:58 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> When commit 0bacd8b3046f ('i386: Don't set CPUClass::cpu_def on
> "max" model') removed the CPUClass::cpu_def field, we kept using
> the x86_cpu_load_def() helper directly in max_x86_cpu_initfn(),
> emulating the previous behavior when CPUClass::cpu_def was set.
> 
> However, x86_cpu_load_def() is intended to help initialization of
> CPU models from the builtin_x86_defs table, and does lots of
> other steps that are not necessary for "max".
> 
> One of the things x86_cpu_load_def() do is to set the properties
> listed at tcg_default_props/kvm_default_props.  We must not do
> that on the "max" CPU model, otherwise under KVM we will
> incorrectly report all KVM features as always available, and the
> "svm" feature as always unavailable.  The latter caused the bug
> reported at:
Maybe add that all available features for 'max' are set later at realize() time
to ones actually supported by host.

Also while looking at it, I've noticed that:
x86_cpu_load_def()
  ...
      if (kvm_enabled()) {                                                         
        if (!kvm_irqchip_in_kernel()) {                                          
            x86_cpu_change_kvm_default("x2apic", "off");                         
        }

and

kvm_arch_get_supported_cpuid() also having
        if (!kvm_irqchip_in_kernel()) {                                          
            ret &= ~CPUID_EXT_X2APIC;                                            
        } 

so do we really need this duplication in x86_cpu_load_def()?

> 
>   https://bugzilla.redhat.com/show_bug.cgi?id=1467599
>   ("Unable to start domain: the CPU is incompatible with host CPU:
>   Host CPU does not provide required features: svm")
> 
> Replace x86_cpu_load_def() with simple object_property_set*()
> calls.  In addition to fixing the above bug, this makes the KVM
> branch in max_x86_cpu_initfn() very similar to the existing TCG
> branch.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index e2cd157..62d8021 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1596,15 +1596,21 @@ static void max_x86_cpu_initfn(Object *obj)
>      cpu->max_features = true;
>  
>      if (kvm_enabled()) {
> -        X86CPUDefinition host_cpudef = { };
> -        uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
> +        char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
> +        char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
> +        int family, model, stepping;
>  
> -        host_vendor_fms(host_cpudef.vendor, &host_cpudef.family,
> -                        &host_cpudef.model, &host_cpudef.stepping);
> +        host_vendor_fms(vendor, &family, &model, &stepping);
>  
> -        cpu_x86_fill_model_id(host_cpudef.model_id);
> +        cpu_x86_fill_model_id(model_id);
>  
> -        x86_cpu_load_def(cpu, &host_cpudef, &error_abort);
this looses 
   env->features[FEAT_1_ECX] |= CPUID_EXT_HYPERVISOR;
but it looks like kvm_arch_get_supported_cpuid() will take care of it later
at realize() time.

> +        object_property_set_str(OBJECT(cpu), vendor, "vendor", &error_abort);
> +        object_property_set_int(OBJECT(cpu), family, "family", &error_abort);
> +        object_property_set_int(OBJECT(cpu), model, "model", &error_abort);
> +        object_property_set_int(OBJECT(cpu), stepping, "stepping",
> +                                &error_abort);
> +        object_property_set_str(OBJECT(cpu), model_id, "model-id",
> +                                &error_abort);
>  
>          env->cpuid_min_level =
>              kvm_arch_get_supported_cpuid(s, 0x0, 0, R_EAX);
