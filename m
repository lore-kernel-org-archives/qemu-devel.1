Received: from eggs.gnu.org ([2001:4830:134:3::10]:50340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1draDT-0001PQ-EM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 21:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1draDQ-0004ge-BQ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 21:42:19 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1draDP-0004bd-E7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 21:42:16 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 12 Sep 2017 01:41:52 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA3AAD3B@DGGEMA505-MBX.china.huawei.com>
References: <1505143227-14324-1-git-send-email-arei.gonglei@huawei.com>
	<20170911183748.GS7570@localhost.localdomain>
In-Reply-To: <20170911183748.GS7570@localhost.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386/cpu/hyperv: support over 64 vcpus for
 windows guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "vrozenfe@redhat.com" <vrozenfe@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>


> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Tuesday, September 12, 2017 2:38 AM
> To: Gonglei (Arei)
> Cc: qemu-devel@nongnu.org; mst@redhat.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; vrozenfe@redhat.com;
> Huangweidong (C)
> Subject: Re: [PATCH] i386/cpu/hyperv: support over 64 vcpus for windows
> guests
>=20
> On Mon, Sep 11, 2017 at 11:20:27PM +0800, Gonglei wrote:
> > Starting with Windows Server 2012 and Windows 8, if
> > CPUID.40000005.EAX contains a value of -1, Windows assumes specific
> > limit to the number of VPs. In this case, Windows Server 2012
> > guest VMs may use more than 64 VPs, up to the maximum supported
> > number of processors applicable to the specific Windows
> > version being used.
> >
> >
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/refere=
nc
> e/tlfs
> >
> > For compatibility, Let's introduce a new property for X86CPU,
> > named "x-hv-max-vps" as Eduardo's suggestion, and set it
> > to 0x40 before machine 2.10.
> >
> > (The "x-" prefix indicates that the property is not supposed to
> > be a stable user interface.)
> >
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > ---
> >  include/hw/i386/pc.h |  5 +++++
> >  target/i386/cpu.c    |  1 +
> >  target/i386/cpu.h    |  2 ++
> >  target/i386/kvm.c    | 15 ++++++++++++++-
> >  4 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 8226904..087d184 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -371,6 +371,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *,
> uint64_t *);
> >
> >  #define PC_COMPAT_2_10 \
> >      HW_COMPAT_2_10 \
> > +    {\
> > +        .driver   =3D TYPE_X86_CPU,\
> > +        .property =3D "x-hv-max-vps",\
> > +        .value    =3D "0x40",\
> > +    },
> >
> >  #define PC_COMPAT_2_9 \
> >      HW_COMPAT_2_9 \
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 69676e1..2702485 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -4145,6 +4145,7 @@ static Property x86_cpu_properties[] =3D {
> >                       false),
> >      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU,
> vmware_cpuid_freq, true),
> >      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
> > +    DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 525d35d..5c726f3 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1282,6 +1282,8 @@ struct X86CPU {
> >      int32_t socket_id;
> >      int32_t core_id;
> >      int32_t thread_id;
> > +
> > +    int32_t hv_max_vps;
> >  };
> >
> >  static inline X86CPU *x86_env_get_cpu(CPUX86State *env)
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index 6db7783..a898bef 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -751,7 +751,20 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >
> >          c =3D &cpuid_data.entries[cpuid_i++];
> >          c->function =3D HYPERV_CPUID_IMPLEMENT_LIMITS;
> > -        c->eax =3D 0x40;
> > +
> > +        /*
> > +         * From "Requirements for Implementing the Microsoft
> > +         * Hypervisor Interface":
> > +         *
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/refere=
nc
> e/tlfs
> > +         *
> > +         * "Starting with Windows Server 2012 and Windows 8, if
> > +         * CPUID.40000005.EAX contains a value of -1, Windows assumes
> > +         * specific limit to the number of VPs. In this case, Windows
> > +         * Server 2012 guest VMs may use more than 64 VPs, up to the
> > +         * maximum supported number of processors applicable to the
> > +         * specific Windows version being used."
> > +         */
>=20
> I would place this comment above the DEFINE_PROP_INT32
> declaration, as its purpose is to explain the -1 default.
>=20
Fine, do I need to send v2? Or you adjust it directly?

Thanks,
-Gonglei
>=20
> > +        c->eax =3D cpu->hv_max_vps;
> >          c->ebx =3D 0x40;
> >
> >          kvm_base =3D KVM_CPUID_SIGNATURE_NEXT;
> > --
> > 1.8.3.1
> >
> >
>=20
> --
> Eduardo
