Received: from eggs.gnu.org ([2001:4830:134:3::10]:54003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duzNF-0002t6-77
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duzNA-0008HA-Li
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:10:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duzNA-0008FE-DL
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:10:24 -0400
Date: Thu, 21 Sep 2017 13:10:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170921131017.01d88156.cohuck@redhat.com>
In-Reply-To: <1505991234-246759-1-git-send-email-imammedo@redhat.com>
References: <1505991234-246759-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

On Thu, 21 Sep 2017 12:53:54 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

cc: David

> define default CPU type in generic way in machine class_init
> and let common machine code to handle cpu_model parsing.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> tested under TCG booting debian kernel,
> and compile tested on s390 host
> 
> CC: Cornelia Huck <cohuck@redhat.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: Alexander Graf <agraf@suse.de>
> CC: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/cpu.h         |  6 ++++--
>  hw/s390x/s390-virtio-ccw.c | 29 ++++-------------------------
>  target/s390x/cpu_models.c  | 11 -----------
>  target/s390x/kvm.c         |  3 +++
>  4 files changed, 11 insertions(+), 38 deletions(-)

At least, that's a nice diffstat :)

> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 9b549dc..6cc96ae 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -684,12 +684,14 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
>  /* cpu_models.c */
>  void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>  #define cpu_list s390_cpu_list
> -const char *s390_default_cpu_model_name(void);
> -
>  
>  /* helper.c */
>  #define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
>  S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp);
> +
> +#define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
> +#define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
> +
>  /* you can call this signal handler from your SIGBUS and SIGSEGV
>     signal handlers to inform the virtual CPU of exceptions. non zero
>     is returned if the signal was handled by the virtual CPU.  */
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fafbc6d..5546d6a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -55,15 +55,8 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  static void s390_init_cpus(MachineState *machine)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
> -    const char *typename;
> -    gchar **model_pieces;
> -    ObjectClass *oc;
> -    CPUClass *cc;
>      int i;
>  
> -    if (machine->cpu_model == NULL) {
> -        machine->cpu_model = s390_default_cpu_model_name();
> -    }
>      if (tcg_enabled() && max_cpus > 1) {
>          error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
>                       "supported by TCG (1) on s390x", max_cpus);
> @@ -73,25 +66,8 @@ static void s390_init_cpus(MachineState *machine)
>      /* initialize possible_cpus */
>      mc->possible_cpu_arch_ids(machine);
>  
> -    model_pieces = g_strsplit(machine->cpu_model, ",", 2);
> -    if (!model_pieces[0]) {
> -        error_report("Invalid/empty CPU model name");
> -        exit(1);
> -    }
> -
> -    oc = cpu_class_by_name(TYPE_S390_CPU, model_pieces[0]);
> -    if (!oc) {
> -        error_report("Unable to find CPU definition: %s", model_pieces[0]);
> -        exit(1);
> -    }
> -    typename = object_class_get_name(oc);
> -    cc = CPU_CLASS(oc);
> -    /* after parsing, properties will be applied to all *typename* instances */
> -    cc->parse_features(typename, model_pieces[1], &error_fatal);
> -    g_strfreev(model_pieces);
> -
>      for (i = 0; i < smp_cpus; i++) {
> -        s390x_new_cpu(typename, i, &error_fatal);
> +        s390x_new_cpu(machine->cpu_type, i, &error_fatal);
>      }
>  }
>  
> @@ -446,6 +422,9 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      mc->get_hotplug_handler = s390_get_hotplug_handler;
>      mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
>      mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
> +    /* it is overrriden with 'host' cpu type when accel=kvm
> +     * i.e. when kvm_arch_init() is executed */
> +    mc->default_cpu_type = S390_CPU_TYPE_NAME("qemu");
>      hc->plug = s390_machine_device_plug;
>      hc->unplug_request = s390_machine_device_unplug_request;
>      nc->nmi_monitor_handler = s390_nmi;
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 5169379..0bf7e14 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -1207,9 +1207,6 @@ static void s390_qemu_cpu_model_class_init(ObjectClass *oc, void *data)
>                                  qemu_hw_version());
>  }
>  
> -#define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
> -#define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
> -
>  /* Generate type name for a cpu model. Caller has to free the string. */
>  static char *s390_cpu_type_name(const char *model_name)
>  {
> @@ -1232,14 +1229,6 @@ ObjectClass *s390_cpu_class_by_name(const char *name)
>      return oc;
>  }
>  
> -const char *s390_default_cpu_model_name(void)
> -{
> -     if (kvm_enabled()) {
> -        return "host";
> -     }
> -     return "qemu";
> -}
> -
>  static const TypeInfo qemu_s390_cpu_type_info = {
>      .name = S390_CPU_TYPE_NAME("qemu"),
>      .parent = TYPE_S390_CPU,
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 720cb1d..5dfdd96 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -287,6 +287,9 @@ void kvm_s390_crypto_reset(void)
>  
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
> +    mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
>      cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
>      cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>      cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
