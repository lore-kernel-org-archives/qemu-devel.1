Received: from eggs.gnu.org ([2001:4830:134:3::10]:38055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5ZGA-0004C7-0G
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5ZG6-0001XX-TI
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:30:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e5ZG6-0001VQ-Iy
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:30:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9KFToI8034574
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 11:30:46 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dqjuvb5c6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 11:30:45 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 20 Oct 2017 16:30:43 +0100
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 20 Oct 2017 17:30:39 +0200
MIME-Version: 1.0
In-Reply-To: <20171020145437.18549-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <608195be-ea59-751a-7c9f-d18a310f0ffa@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

FWIW, this patch alone probably makes sense to fix this particular issue.

The question is do we want to have some additional interfaces between libvirt/qemu
that tell libvirt what CPUs/features are allowed for a specific machine version?

Halil just brough up an example. Imagine to have a QEMU binary that can emulate
an x86 and an s390x depending on the machine type. Should libvirt be able to detect
that -cpu pentium only makes sense for the q35 machines, but not for the s390-ccw-virtio
ones?




On 10/20/2017 04:54 PM, Christian Borntraeger wrote:
> Starting a guest with
>    <os>
>     <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
>   </os>
>   <cpu mode='host-model'/>
> 
> on an IBM z14 results in
> 
> "qemu-system-s390x: Some features requested in the CPU model are not
> available in the configuration: gs"
> 
> This is because guarded storage is fenced for compat machines that did not have
> guarded storage support, but libvirt expands the cpu model according to the
> latest available machine.
> 
> While this prevents future migration abort (by not starting the guest at all),
> not being able to start a "host-model" guest is very much unexpected.  As it
> turns out, even if we would modify libvirt to not expand the cpu model to
> contain "gs" for compat machines, it cannot guarantee that a migration will
> succeed. For example if the kernel changes its features (or the user has
> nested=1 on one host but not on the other) the migration will fail
> nevertheless.  So instead of fencing "gs" for machines <= 2.9 lets allow it for
> all machine types that support the CPU model. This will make "host-model"
> runnable all the time, while relying on the CPU model to reject invalid
> migration attempts.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 8 --------
>  include/hw/s390x/s390-virtio-ccw.h | 3 ---
>  target/s390x/kvm.c                 | 2 +-
>  3 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fabe4a6..ae5b01a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -414,7 +414,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      s390mc->ri_allowed = true;
>      s390mc->cpu_model_allowed = true;
>      s390mc->css_migration_enabled = true;
> -    s390mc->gs_allowed = true;
>      mc->init = ccw_init;
>      mc->reset = s390_machine_reset;
>      mc->hot_add_cpu = s390_hot_add_cpu;
> @@ -495,12 +494,6 @@ bool cpu_model_allowed(void)
>      return get_machine_class()->cpu_model_allowed;
>  }
> 
> -bool gs_allowed(void)
> -{
> -    /* for "none" machine this results in true */
> -    return get_machine_class()->gs_allowed;
> -}
> -
>  static char *machine_get_loadparm(Object *obj, Error **errp)
>  {
>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> @@ -740,7 +733,6 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
>  {
>      S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
> 
> -    s390mc->gs_allowed = false;
>      ccw_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
>      s390mc->css_migration_enabled = false;
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index a9a90c2..ac896e3 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -40,15 +40,12 @@ typedef struct S390CcwMachineClass {
>      bool ri_allowed;
>      bool cpu_model_allowed;
>      bool css_migration_enabled;
> -    bool gs_allowed;
>  } S390CcwMachineClass;
> 
>  /* runtime-instrumentation allowed by the machine */
>  bool ri_allowed(void);
>  /* cpu model allowed by the machine */
>  bool cpu_model_allowed(void);
> -/* guarded-storage allowed by the machine */
> -bool gs_allowed(void);
> 
>  /**
>   * Returns true if (vmstate based) migration of the channel subsystem
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 4c85ed8..020a7ea 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -363,7 +363,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>              cap_ri = 1;
>          }
>      }
> -    if (gs_allowed()) {
> +    if (cpu_model_allowed()) {
>          if (kvm_vm_enable_cap(s, KVM_CAP_S390_GS, 0) == 0) {
>              cap_gs = 1;
>          }
> 
