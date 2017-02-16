Received: from eggs.gnu.org ([2001:4830:134:3::10]:55110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ceNHZ-00066f-5V
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ceNHU-000476-3T
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:43:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ceNHT-00046m-Q0
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:43:36 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1GEdUwQ112478
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:43:32 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28nd69apca-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:43:32 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 16 Feb 2017 07:43:30 -0700
References: <20170116195452.23532-1-ehabkost@redhat.com>
	<0503ac26-e660-325c-8257-59227c41021d@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 16 Feb 2017 15:43:16 +0100
MIME-Version: 1.0
In-Reply-To: <0503ac26-e660-325c-8257-59227c41021d@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <1daa0992-e594-d870-f264-923bf1cb9673@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

On 01/17/2017 06:43 PM, David Hildenbrand wrote:
> Am 16.01.2017 um 20:54 schrieb Eduardo Habkost:
>> Change the meaning of "-cpu host" to "enable all features
>> supported by the accelerator in the current host", so that it can
>> be used to enable/query all features supported by TCG.
>>
>> To make sure "host" is still at the end of the list in "-cpu
>> help", add a "ordering" field that will be used when sorting the
>> CPU model list.
>>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> I also had the same thing in mind when working on s390x models but
> decided to do it like x86. Now that x86 changes ...
> 
> Something like that should work for s390x (and I don't think it will break any concept). Most probably cleaner to handle this the same
> way on all architectures and to not disable tests for s390x.
> 
> Uncompiled and untested.
> 
> @Conny and Christian, feel free to pick up and modify if this makes
> sense
> 
Looks sane to me. Can you resend properly, it looks like whitespace
got damaged all over the place.

Thanks


> From 4a2af1ca47421b68eb7677cd91af350dd9be4e0e Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 17 Jan 2017 18:34:45 +0100
> Subject: [PATCH] s390x/cpumodel: allow the "host" model also for tcg
> 
> Let's also allow the host model for tcg, therefore meaning
> "enable all features supported by the selected accelerator in the current
> host".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  qapi-schema.json          |  4 ++--
>  target/s390x/cpu-qom.h    |  1 -
>  target/s390x/cpu_models.c | 34 ++++++++--------------------------
>  3 files changed, 10 insertions(+), 29 deletions(-)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index ddc8783..f14d343 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4334,8 +4334,8 @@
>  # CPU model has to be created by baselining.
>  #
>  # Usually, a CPU model is compared against the maximum possible CPU model
> -# of a certain configuration (e.g. the "host" model for KVM). If that CPU
> -# model is identical or a subset, it will run in that configuration.
> +# of a certain configuration (the "host" model). If that CPU model is
> +# identical or a subset, it will run in that configuration.
>  #
>  # The result returned by this command may be affected by:
>  #
> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> index 4e936e7..71322a5 100644
> --- a/target/s390x/cpu-qom.h
> +++ b/target/s390x/cpu-qom.h
> @@ -47,7 +47,6 @@ typedef struct S390CPUClass {
>      CPUClass parent_class;
>      /*< public >*/
>      const S390CPUDef *cpu_def;
> -    bool kvm_required;
>      bool is_static;
>      bool is_migration_safe;
>      const char *desc;
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 5b66d33..2994a7b 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -331,10 +331,6 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
>          error_setg(errp, "The CPU definition \'%s\' is unknown.", info->name);
>          return;
>      }
> -    if (S390_CPU_CLASS(oc)->kvm_required && !kvm_enabled()) {
> -        error_setg(errp, "The CPU definition '%s' requires KVM", info->name);
> -        return;
> -    }
>      obj = object_new(object_class_get_name(oc));
>      cpu = S390_CPU(obj);
> 
> @@ -718,15 +714,9 @@ static inline void apply_cpu_model(const S390CPUModel *model, Error **errp)
> 
>  void s390_realize_cpu_model(CPUState *cs, Error **errp)
>  {
> -    S390CPUClass *xcc = S390_CPU_GET_CLASS(cs);
>      S390CPU *cpu = S390_CPU(cs);
>      const S390CPUModel *max_model;
> 
> -    if (xcc->kvm_required && !kvm_enabled()) {
> -        error_setg(errp, "CPU definition requires KVM");
> -        return;
> -    }
> -
>      if (!cpu->model) {
>          /* no host model support -> perform compatibility stuff */
>          apply_cpu_model(NULL, errp);
> @@ -904,26 +894,25 @@ static void s390_cpu_model_initfn(Object *obj)
>      }
>  }
> 
> -#ifdef CONFIG_KVM
>  static void s390_host_cpu_model_initfn(Object *obj)
>  {
> +    S390CPUModel *max_model;
>      S390CPU *cpu = S390_CPU(obj);
>      Error *err = NULL;
> 
> -    if (!kvm_enabled() || !kvm_s390_cpu_models_supported()) {
> +    if (kvm_enabled() && !kvm_s390_cpu_models_supported()) {
>          return;
>      }
> 
> -    cpu->model = g_malloc0(sizeof(*cpu->model));
> -    kvm_s390_get_host_cpu_model(cpu->model, &err);
> -    if (err) {
> +    max_model = get_max_cpu_model(&err);
> +    if (err || !max_model) {
>          error_report_err(err);
> -        g_free(cpu->model);
>          /* fallback to unsupported cpu models */
> -        cpu->model = NULL;
> +        return;
>      }
> +    /* copy the host model so it can be modified */
> +    cpu->model = g_memdup(max_model, sizeof(*cpu->model));
>  }
> -#endif
> 
>  static void s390_qemu_cpu_model_initfn(Object *obj)
>  {
> @@ -969,15 +958,12 @@ void s390_cpu_model_class_register_props(ObjectClass *oc)
>                                    NULL);
>  }
> 
> -#ifdef CONFIG_KVM
>  static void s390_host_cpu_model_class_init(ObjectClass *oc, void *data)
>  {
>      S390CPUClass *xcc = S390_CPU_CLASS(oc);
> 
> -    xcc->kvm_required = true;
> -    xcc->desc = "KVM only: All recognized features";
> +    xcc->desc = "All supported and available features";
>  }
> -#endif
> 
>  static void s390_base_cpu_model_class_init(ObjectClass *oc, void *data)
>  {
> @@ -1042,7 +1028,6 @@ static const TypeInfo qemu_s390_cpu_type_info = {
>      .class_init = s390_qemu_cpu_model_class_init,
>  };
> 
> -#ifdef CONFIG_KVM
>  static const TypeInfo host_s390_cpu_type_info = {
>      .name = S390_CPU_TYPE_NAME("host"),
>      .parent = TYPE_S390_CPU,
> @@ -1050,7 +1035,6 @@ static const TypeInfo host_s390_cpu_type_info = {
>      .instance_finalize = s390_cpu_model_finalize,
>      .class_init = s390_host_cpu_model_class_init,
>  };
> -#endif
> 
>  static void register_types(void)
>  {
> @@ -1093,9 +1077,7 @@ static void register_types(void)
>      }
> 
>      type_register_static(&qemu_s390_cpu_type_info);
> -#ifdef CONFIG_KVM
>      type_register_static(&host_s390_cpu_type_info);
> -#endif
>  }
> 
>  type_init(register_types)
