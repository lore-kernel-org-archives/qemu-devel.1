Received: from eggs.gnu.org ([2001:4830:134:3::10]:47898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duhUC-0003EK-Py
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duhU8-0005Tz-BQ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1duhU7-0005SM-T3
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:04:24 -0400
Date: Wed, 20 Sep 2017 17:04:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170920160417.GB3132@work-vm>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-34-git-send-email-borntraeger@de.ibm.com>
	<5eb9a7bd-2761-bea1-738a-da7a6d3fbfcf@de.ibm.com>
	<f6da1ec7-4845-fe78-b6b8-29a71d481458@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6da1ec7-4845-fe78-b6b8-29a71d481458@de.ibm.com>
Subject: Re: [Qemu-devel] block ais migration for machines <= 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> Something like the following seems to do the tricks.
> Needs proper patch description, review, full test with different kernel versions.....

Without knowing anything about 'ais' - will this break migration from
2.10 -> 2.10+this fix?

Dave

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 1c7af39..2ff32ba 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -212,6 +212,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      s390mc->cpu_model_allowed = true;
>      s390mc->css_migration_enabled = true;
>      s390mc->gs_allowed = true;
> +    s390mc->ais_allowed = true;
>      mc->init = ccw_init;
>      mc->reset = s390_machine_reset;
>      mc->hot_add_cpu = s390_hot_add_cpu;
> @@ -305,6 +306,11 @@ bool gs_allowed(void)
>      return false;
>  }
>  
> +bool ais_allowed(void)
> +{
> +    return get_machine_class()->ais_allowed;
> +}
> +
>  static char *machine_get_loadparm(Object *obj, Error **errp)
>  {
>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> @@ -533,6 +539,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
>      S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
>  
>      s390mc->gs_allowed = false;
> +    s390mc->ais_allowed = false;
>      ccw_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
>      s390mc->css_migration_enabled = false;
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index 41a9d28..bba8660 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
>      bool cpu_model_allowed;
>      bool css_migration_enabled;
>      bool gs_allowed;
> +    bool ais_allowed;
>  } S390CcwMachineClass;
>  
>  /* runtime-instrumentation allowed by the machine */
> @@ -49,6 +50,8 @@ bool ri_allowed(void);
>  bool cpu_model_allowed(void);
>  /* guarded-storage allowed by the machine */
>  bool gs_allowed(void);
> +/* ais allowed by the machine */
> +bool ais_allowed(void);
>  
>  /**
>   * Returns true if (vmstate based) migration of the channel subsystem
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index c4c5791..531d474 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -309,7 +309,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      }
>  
>      /* Try to enable AIS facility */
> -    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> +    if (ais_allowed()) {
> +       kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> +    }
>  
>      qemu_mutex_init(&qemu_sigp_mutex);
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
