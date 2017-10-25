Received: from eggs.gnu.org ([2001:4830:134:3::10]:33707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e7VCp-0005e7-0C
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 19:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e7VCl-0001Md-R2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 19:35:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e7VCl-0001L5-F2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 19:35:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PNYYta115642
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 19:35:17 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2du0k094wm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 19:35:16 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 00:35:14 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
Date: Thu, 26 Oct 2017 01:35:11 +0200
MIME-Version: 1.0
In-Reply-To: <20171020145437.18549-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <46a65cf7-8c60-3aac-de93-95be25360f11@linux.vnet.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Jiri Denemark <jdenemar@redhat.com>



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

I've tried to review this patch. Unfortunately I don't have access to a
z14, so I could not try the most interesting scenarios out.

The idea of the patch is very clear, but I don't understand the bigger gs
feature context fully.

>From what I read in the code, the attempt to enable the gs capability in
the kernel is made regardless of the cpu model. If the attempt was
successful kvm_s390_get_gs will keep returning true. That would in turn
affect migration, as far as I see (usages of kvm_s390_get_gs). I could
not figure out how does gs being turned off via cpu-model (-cpu
z14,gs=off) does turn of gs support -- at least not the details. I wanted
to give a timely review, so I've limited myself there. 

>From what I see, this patch does what it advertises, and since I think
it's the right thing to do in the current situation I gonna give it an:
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>

At the same time, I would prefer the commit message being reworded. IMHO
this patch is a good stop-gap measure, but essentially it trades an
annoying and obvious bug for a subtle and hopefully painless one.

Let me explain this last statement. For starters, I  do share some of the
concerns Boris has voiced.  I won't repeat those. Same goes for the
example Christian paraphrased previously, and the the fear of an implicit
requirement for having to support a Cartesian product of the advertised
machine-types and cpu-models (for each qemu binary).

In my eyes, a cpu isn't all that different from the other devices which
get attached to a board (represented by machine-type). So I don't see why
should it be exempt from the usual compatibility requirements tied to
machine-types (for the sake of stability and compatibility). (I basically
mean: no new features are added to a device in the context of a given
(fully qualified) machine-type (with new QEMU -- binary -- versions). As
far as I understand all (other) devices shall respect these requirements.
Or am I wrong? If I'm not, please enlighten me, how is a CPU
fundamentally different than let's say a FLIC.

A related thing is, that to implement some features indicated/controlled
via cpu-model features, we need to add capabilities to certain devices.
Now if the devices shall obey the 'no new features for the same
machine-type' rule, but the cpu-model feature shall obey our new
'retroactively introduce/enable for all machines supporting cpu-models'
rule, I think we have a conflict.  An example for what I'm talking about
is zPCI, AIS and FLIC. In case of the AIS and the FLIC, AFAIK the
conflict was resolved so that the AIS feature/code of the FLIC is not
subject to usual compat-macro mechanism. Another example, AP facility in
not just about the CPU instructions, but also about a device.

It's also true for the last paragraph: I might very well be wrong, and if
I am please do tell (where is the hole in  my reasoning). I will try to
re-check my statements tomorrow -- again trying to deliver today along
the lines better a small bird today than a big one tomorrow).

And another question. If we adopt this introducing features for
machine-types retroactively, how should the machine-type versions be
understood like? My current understanding is, that the machine-type
(version) is supposed to limit the observable changes when upgrading
the binary to the bare minimum (basically possibly modified timings -- which
can't be avoided -- and bug-fixes) for the sake of updating the
binary being as safe as possible.

Last but not least, I have to say, I'm neither an domain expert for
cpu-models nor for libvirt and it's models. For that reason, I've
personally asked Jason to do a more detailed review on this -- and am
hoping to wiggle out with an weak ack. I do intend to keep on following
the discussion (despite of not feeling to be entitled to make any calls)
and contribute where I can.

Regards,
Halil

 

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
