Received: from eggs.gnu.org ([2001:4830:134:3::10]:48443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1evJQt-00031c-U0
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1evJQo-00058a-Rx
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:07:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:26985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luwei.kang@intel.com>)
	id 1evJQo-00054G-Is
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:07:46 -0400
From: "Kang, Luwei" <luwei.kang@intel.com>
Date: Mon, 12 Mar 2018 09:07:41 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167EF4877@SHSMSX101.ccr.corp.intel.com>
References: <1520182116-16485-1-git-send-email-luwei.kang@intel.com>
	<20180309191048.GA28578@localhost.localdomain>
In-Reply-To: <20180309191048.GA28578@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 1/2] i386: Add Intel Processor Trace
 feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

> > +
> > +        if (!eax_0 ||
> > +           ((ebx_0 & INTEL_PT_MINIMAL_EBX) !=3D INTEL_PT_MINIMAL_EBX) =
||
> > +           ((ecx_0 & INTEL_PT_MINIMAL_ECX) !=3D INTEL_PT_MINIMAL_ECX) =
||
> > +           ((eax_1 & INTEL_PT_MTC_BITMAP) !=3D INTEL_PT_MTC_BITMAP) ||
> > +           ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) <
> > +                                           INTEL_PT_ADDR_RANGES_NUM) |=
|
> > +           ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=
=3D
> > +                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP))) {
>=20
> I still don't see a check to ensure the host has bit 31 on ecx_0 set to 0=
, as I mentioned when reviewing v3.

Hi Eduardo,
    Thanks for the code review. I don't quite understand here why bit31 mus=
t same with host (meaning we must reject a host
where ecx_0 & (1 << 31) is set).
    Do you mean PT must be disabled in guest when host bit31 is set?=20
    Bit 31: If 1, generated packets which contain IP payloads have LIP valu=
es, which include the CS base component.
    I can't find any special on this bit. Could you help clarify?

Thanks,
Luwei Kang

>=20
> The rest of the patch looks good.
>=20
> > +            /*
> > +             * Processor Trace capabilities aren't configurable, so if=
 the
> > +             * host can't emulate the capabilities we report on
> > +             * cpu_x86_cpuid(), intel-pt can't be enabled on the curre=
nt host.
> > +             */
> > +            env->features[FEAT_7_0_EBX] &=3D ~CPUID_7_0_EBX_INTEL_PT;
> > +            cpu->filtered_features[FEAT_7_0_EBX] |=3D CPUID_7_0_EBX_IN=
TEL_PT;
> > +            rv =3D 1;
> > +        }
> > +    }
> > +
> >      return rv;
> >  }
> >
> [...]
>=20
> --
> Eduardo
