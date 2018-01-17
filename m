Received: from eggs.gnu.org ([2001:4830:134:3::10]:47390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1ebl1o-00059O-HZ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1ebl1i-0004of-Jf
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:33:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:27821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luwei.kang@intel.com>)
	id 1ebl1i-0004mF-7Z
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:33:02 -0500
From: "Kang, Luwei" <luwei.kang@intel.com>
Date: Wed, 17 Jan 2018 10:32:56 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167E79545@SHSMSX101.ccr.corp.intel.com>
References: <1515443797-10837-1-git-send-email-luwei.kang@intel.com>
	<20180112142252.GG6646@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E7630B@SHSMSX101.ccr.corp.intel.com>
	<97bf8d29-4009-6f61-f4bb-d128da5a4c9f@redhat.com>
	<20180115140455.GN6646@localhost.localdomain>
	<20180115142518.GN1602429@orkuz.home>
	<20180115143156.GO6646@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E776B5@SHSMSX101.ccr.corp.intel.com>
	<20180116115113.GA627@localhost.localdomain>
In-Reply-To: <20180116115113.GA627@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RESEND v1 1/2] i386: Add Intel Processor
 Trace feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>

> > > > On Mon, Jan 15, 2018 at 12:04:55 -0200, Eduardo Habkost wrote:
> > > > > CCing libvirt developers.
> > > > ...
> > > > > This case is slightly more problematic, however: the new feature
> > > > > is actually migratable (under very controlled circumstances)
> > > > > because of patch 2/2, but it is not migration-safe[1].  This
> > > > > means libvirt shouldn't include it in "host-model" expansion
> > > > > (which uses the query-cpu-model-expansion QMP command) until we
> > > > > make the feature migration-safe.
> > > > >
> > > > > For QEMU, this means the feature shouldn't be returned by
> > > > > "query-cpu-model-expansion type=3Dstatic model=3Dmax" (but it can=
 be
> > > > > returned by "query-cpu-model-expansion type=3Dfull model=3Dmax").
> > > > >
> > > > > Jiri, it looks like libvirt uses type=3Dfull on
> > > > > query-cpu-model-expansion on x86.  It needs to use
> > > > > type=3Dstatic[2], or it will have no way to find out if a feature
> > > > > is migration-safe or not.
> > > > ...
> > > > > [2] It looks like libvirt uses type=3Dfull because it wants to ge=
t
> > > > >     all QOM property aliases returned.  In this case, one
> > > > >     solution for libvirt is to use:
> > > > >
> > > > >     static_expansion =3D query_cpu_model_expansion(type=3Dstatic,=
 model)
> > > > >     all_props =3D query_cpu_model_expansion(type=3Dfull,
> > > > > static_expansion)
> > > >
> > > > This is exactly what libvirt is doing (with model =3D "host") ever
> > > > since query-cpu-model-expansion support was implemented for x86.
> > >
> > > Oh, now I see that the x86 code uses
> > > QEMU_MONITOR_CPU_MODEL_EXPANSION_STATIC_FULL and not just QEMU_MONITO=
R_CPU_MODEL_EXPANSION_FULL.
> Nice!
> > >
> >
> > So, I need to add Intel PT feature in "X86CPUDefinition
> > builtin_x86_defs[]" so that we can get this CPUID in specific CPU
> > model not only "-cpu host". Is that right?
>=20
> The problem is that you won't be able to add intel-pt to any CPU model un=
less the feature is made migration-safe (by not calling
> kvm_arch_get_supported_cpuid() from cpu_x86_cpuid()).

Hi Eduardo,
    Have some question need you help clear. What is "migration-safe" featur=
e mean? I find all the feature which included in CPU model (builtin_x86_def=
s[]) will make "xcc->migration_safe =3D true;" in x86_cpu_cpudef_class_init=
(). If create a Skylake guest on Skylake HW and live migrate this guest to =
another machine with old HW(e.g Haswell). Can we think the new feature or c=
pu model(Skylake guest) which only supported in Skylake HW is safe?

>=20
> What's missing here is to either: (a) make cpu_x86_cpuid() return host-in=
dependent data (it can be constant, or it can be
> configurable on the command-line); or (b) add a mechanism to skip intel-p=
t from "query-cpu-model-expansion type=3Dstatic".

=3D=3D> it can be constant:
    I think it shouldn't be constant because Intel PT virtualization can on=
ly supported in Ice Lake hardware now. Intel PT cpuid info would be mask of=
f on old platform.
=3D=3D> or it can be configurable on the command-line:
    Because of I didn't add this feature in any CPU model. We only can enab=
le this feature by "-cpu Skylake-Server,+intel-pt" at present.

What about add a new cpu model name "Icelake" and add PT in this. Is that w=
ould be migration safe?

Thanks,
Luwei Kang

> Probably
> (a) is easier to implement, and it also makes the feature more useful (by=
 making it migration-safe).
>=20
> >
> > Intel PT is first supported in Intel Core M and 5th generation Intel
> > Core processors that are based on the Intel micro-architecture code
> > name Broadwell but Intel PT use EPT is first supported in Ice Lake.
> > Intel PT virtualization depend on PT use EPT.  I will add Intel PT to
> > "Broadwell" CPU model and later to make sure a "Broadwell" guest can
> > use Intel PT if the host is Ice Lake.
>=20
> The "if the host is Ice Lake" part is problematic.  On migration-safe CPU=
 models (all of them except "max" and "host"), the data seen
> on CPUID can't depend on the host at all.  It should depend only on the m=
achine-type + command-line options.
>=20
> --
> Eduardo
