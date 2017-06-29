Received: from eggs.gnu.org ([2001:4830:134:3::10]:60055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dQdb0-0008R8-Ds
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dQdaw-0001OL-GR
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:51:14 -0400
Received: from mail-db5eur03hn0236.outbound.protection.outlook.com
	([104.47.10.236]:29504
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dQdav-0001NQ-KM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:51:10 -0400
Date: Thu, 29 Jun 2017 20:51:01 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170629175100.GB13435@rkaganb.sw.ru>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
	<20170621162424.10462-15-rkagan@virtuozzo.com>
	<20170629170546.6450586d@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629170546.6450586d@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/23] hyperv: qom-ify SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Thu, Jun 29, 2017 at 05:05:46PM +0200, Igor Mammedov wrote:
> On Wed, 21 Jun 2017 19:24:15 +0300
> Roman Kagan <rkagan@virtuozzo.com> wrote:
> > +static void synic_realize(DeviceState *dev, Error **errp)
> > +{
> > +    Object *obj = OBJECT(dev);
> > +    SynICState *synic = SYNIC(dev);
> > +
> > +    synic->cpu = X86_CPU(obj->parent);
> usually devices shouldn't access parent this way
> 
> [...]
> > +void hyperv_synic_add(X86CPU *cpu)
> this helper is called by/from parent so something like below should do
> 
> > +{
> > +    Object *obj;
> > +
> > +    obj = object_new(TYPE_SYNIC);
> > +    object_property_add_child(OBJECT(cpu), "synic", obj, &error_abort);
> > +    object_unref(obj);
> 
> SynICState *synic = SYNIC(obj)
> synic->cpu = cpu;

Indeed, this is better.

> or even make synic->cpu a link (object_property_add_link) and set it
> here, benefit will be when synic is introspected via QOM it will show
> that it refers back/uses the cpu + proper reference counting of CPU object.

Good point, will look into it, thanks.

> > +    if (cpu->hyperv_synic) {
> > +        if (kvm_vcpu_enable_cap(CPU(cpu), KVM_CAP_HYPERV_SYNIC, 0)) {
> > +            fprintf(stderr, "failed to enable Hyper-V SynIC\n");
> > +            return -ENOSYS;
> > +        }
> > +
> > +        hyperv_synic_add(cpu);
> is synic KVM specific or may it work with TCG accel?

No, it's exclusively KVM.  Actually most of it sits in the kernel.

> in either case, looks like hyperv_synic_add() should be called from
> x86_cpu_realizefn(), the same like we do with APIC creating it
> depending feature being enabled.

I'm not sure I understand the reason, in view of it being exclusively
KVM.

> > +    }
> > +
> >      return 0;
> >  }
> >  
> > @@ -1084,6 +1092,8 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
> >          for (i = 0; i < ARRAY_SIZE(env->msr_hv_synic_sint); i++) {
> >              env->msr_hv_synic_sint[i] = HV_SINT_MASKED;
> >          }
> > +
> > +        hyperv_synic_reset(cpu);
> ditto, could go to x86_cpu_machine_reset_cb()
> also calling it unconditionally will crash QEMU if
> get_synic() returns NULL (i.e. when feature is not enabled).

The context is not visibile in the patch, but this is actually called
inside

    if (cpu->hyperv_synic) {
    ...
    }

so no, it won't return NULL.

Thanks,
Roman.
