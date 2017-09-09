Received: from eggs.gnu.org ([2001:4830:134:3::10]:48249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dqmeD-0005KN-DK
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 16:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dqmeA-0002bE-96
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 16:46:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dqmeA-0002aZ-05
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 16:46:34 -0400
Date: Sat, 9 Sep 2017 17:46:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170909204629.GI7570@localhost.localdomain>
References: <1504603805-180240-1-git-send-email-arei.gonglei@huawei.com>
	<1504603805-180240-3-git-send-email-arei.gonglei@huawei.com>
	<20170905131648.GW7570@localhost.localdomain>
	<33183CC9F5247A488A2544077AF19020DA3A2534@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA3A2534@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] i386/cpu/hyperv: support over 64 vcpus
 for windows guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "vrozenfe@redhat.com" <vrozenfe@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

On Thu, Sep 07, 2017 at 01:05:33AM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > Sent: Tuesday, September 05, 2017 9:17 PM
> > To: Gonglei (Arei)
> > Cc: qemu-devel@nongnu.org; mst@redhat.com; pbonzini@redhat.com;
> > rth@twiddle.net; mtosatti@redhat.com; vrozenfe@redhat.com;
> > Huangweidong (C)
> > Subject: Re: [PATCH 2/2] i386/cpu/hyperv: support over 64 vcpus for windows
> > guests
> > 
> > On Tue, Sep 05, 2017 at 05:30:05PM +0800, Gonglei wrote:
> > > Starting with Windows Server 2012 and Windows 8, if
> > > CPUID.40000005.EAX contains a value of -1, Windows assumes specific
> > > limit to the number of VPs. In this case, Windows Server 2012
> > > guest VMs may use more than 64 VPs, up to the maximum supported
> > > number of processors applicable to the specific Windows
> > > version being used.
> > >
> > >
> > https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/referenc
> > e/tlfs
> > >
> > > For compatibility, Let's introduce a new property for X86CPU,
> > > named "hv-cpuid-limits-eax" as Paolo's suggestion, and set it
> > > to "on" before machine 2.10.
> > >
> > > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > > ---
> > >  include/hw/i386/pc.h |  5 +++++
> > >  target/i386/cpu.c    |  1 +
> > >  target/i386/cpu.h    |  2 ++
> > >  target/i386/kvm.c    | 18 +++++++++++++++++-
> > >  4 files changed, 25 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > index 8226904..db32e58 100644
> > > --- a/include/hw/i386/pc.h
> > > +++ b/include/hw/i386/pc.h
> > > @@ -371,6 +371,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *,
> > uint64_t *);
> > >
> > >  #define PC_COMPAT_2_10 \
> > >      HW_COMPAT_2_10 \
> > > +    {\
> > > +        .driver   = TYPE_X86_CPU,\
> > > +        .property = "hv_cpuid_limits_eax",\
> > 
> > The property name is hv-cpuid-limits-eax.
> > 
> Make sense to me.
> 
> > > +        .value    = "on",\
> > > +    },\
> > >
> > >  #define PC_COMPAT_2_9 \
> > >      HW_COMPAT_2_9 \
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 69676e1..0d47bdd 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -4145,6 +4145,7 @@ static Property x86_cpu_properties[] = {
> > >                       false),
> > >      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU,
> > vmware_cpuid_freq, true),
> > >      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
> > > +    DEFINE_PROP_BOOL("hv-cpuid-limits-eax", X86CPU,
> > hv_cpuid_limits_eax, false),
> > 
> > The property name "hv-cpuid-limits-eax" doesn't say anything
> > about what it does exactly when set to true.
> > 
> > What about just making it int32?  e.g.:
> > 
> >     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1)
> > [...]
> >     {\
> >         .driver   = TYPE_X86_CPU,\
> >         .property = "x-hv-max-vps",\
> >         .value    = "0x40",\
> >     },\
> > [...]
> >     c->function = HYPERV_CPUID_IMPLEMENT_LIMITS;
> >     c->eax = cpu->hv_max_vps;
> > 
> > 
> > (The "x-" prefix indicates that the property is not supposed to
> > be a stable user interface.)
> > 
> I thought about this as well.
> but actually we can't assure that users set the x-hv-max-vps an invalid value if
> we use this method. Do we really need to expose eax directly?

We don't really need to expose eax directly and I'm not against a
boolean property, but I think an integer property with the actual
CPUID value makes the compat code simpler and the purpose of the
entry at PC_COMPAT_* more obvious.

Properties prefixed with "x-" are for internal QEMU usage or
debugging, if users want to fiddle with it, they do it at their
own risk.  I don't see a problem with that.

> 
> > 
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > >
> > > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > > index 525d35d..f8b455a 100644
> > > --- a/target/i386/cpu.h
> > > +++ b/target/i386/cpu.h
> > > @@ -1282,6 +1282,8 @@ struct X86CPU {
> > >      int32_t socket_id;
> > >      int32_t core_id;
> > >      int32_t thread_id;
> > > +
> > > +    bool hv_cpuid_limits_eax;
> > >  };
> > >
> > >  static inline X86CPU *x86_env_get_cpu(CPUX86State *env)
> > > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > > index 6db7783..cf6ef96 100644
> > > --- a/target/i386/kvm.c
> > > +++ b/target/i386/kvm.c
> > > @@ -751,7 +751,23 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > >
> > >          c = &cpuid_data.entries[cpuid_i++];
> > >          c->function = HYPERV_CPUID_IMPLEMENT_LIMITS;
> > > -        c->eax = 0x40;
> > > +
> > > +        if (!cpu->hv_cpuid_limits_eax) {
> > > +            /*
> > > +             * Starting with Windows Server 2012 and Windows 8, if
> > > +             * CPUID.40000005.EAX contains a value of -1, Windows
> > > +             * assumes specific limit to the number of VPs. In this case,
> > > +             * Windows Server 2012 guest VMs may use more than 64
> > VPs,
> > > +             * up to the maximum supported number of processors
> > > +             * applicable to the specific Windows version being used.
> > 
> > That was a direct quote from a document, so I recommend citing
> > the specific document you quoted.  e.g.:
> > 
> >     /*
> >      * From "Requirements for Implementing the Microsoft
> >      * Hypervisor Interface":
> >      *
> > https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/referenc
> > e/tlfs
> >      *
> >      * "Starting with Windows Server 2012 and Windows 8, if
> >      * CPUID.40000005.EAX contains a value of -1, Windows assumes
> >      * specific limit to the number of VPs. In this case, Windows
> >      * Server 2012 guest VMs may use more than 64 VPs, up to the
> >      * maximum supported number of processors applicable to the
> >      * specific Windows version being used."
> >      */
> > 
> > 
> > > +             *
> > > +             * https://docs.microsoft.com/en-us/virtualization/
> > > +             *    hyper-v-on-windows/reference/tlfs
> > 
> > IMO a long line is preferable to a broken URL.
> > 
> Make sense to me.
> 
> Thanks,
> -Gonglei
> 

-- 
Eduardo
