Received: from eggs.gnu.org ([209.51.188.92]:41726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1goHHx-0008Cj-Pb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1goHHw-00028S-Vb
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:30:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:46623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luwei.kang@intel.com>)
	id 1goHHu-0001xf-VZ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:30:04 -0500
From: "Kang, Luwei" <luwei.kang@intel.com>
Date: Tue, 29 Jan 2019 00:29:54 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD4781@SHSMSX101.ccr.corp.intel.com>
References: <1548381283-16688-1-git-send-email-luwei.kang@intel.com>
	<20190124183909.GA4136@habkost.net>
	<82D7661F83C1A047AF7DC287873BF1E172CCDB7C@SHSMSX101.ccr.corp.intel.com>
	<20190126025129.GN4136@habkost.net>
	<82D7661F83C1A047AF7DC287873BF1E172CD25E3@SHSMSX101.ccr.corp.intel.com>
	<20190128180316.GU4136@habkost.net>
In-Reply-To: <20190128180316.GU4136@habkost.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: extended the cpuid level when Intel
 PT is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

> > > > > > Intel Processor Trace required CPUID[0x14] but the cpuid level
> > > > > > is 0xd when create a kvm guest with e.g. "-cpu qemu64,+intel-pt=
".
> > > > > >
> > > > > > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > > > > > ---
> > > > > >  target/i386/cpu.c | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > > > > > 2f54125..da477b3 100644
> > > > > > --- a/target/i386/cpu.c
> > > > > > +++ b/target/i386/cpu.c
> > > > > > @@ -5023,6 +5023,13 @@ static void x86_cpu_expand_features(X86C=
PU *cpu, Error **errp)
> > > > > >          x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
> > > > > >          x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
> > > > > >          x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
> > > > > > +
> > > > > > +        /* Intel Processor Trace requires CPUID[0x14] */
> > > > > > +        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL=
_PT) &&
> > > > > > +             kvm_enabled()) {
> > > > > > +            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_leve=
l, 0x14);
> > > > > > +        }
> > > > >
> > > > > This will require a new machine-type compatibility flag to
> > > > > enable the new behavior, so we don't change CPUID data under the
> > > > > guest feet
> > > during live migration.
> > > >
> > > > Hi Eduardo,
> > > >     Thanks for your reply. I have some question on your comments.
> > > >     The cpuid level come from specific machine-type (e.g. qemu64,
> > > > Skylake-Server) and they are all 0xd, but Intel PT required 0x14
> > > > so I
> > > extend the cpuid level.
> > > >     I don't fully understand what is the "require a new
> > > > machine-type compatibility flag" mean, I need to add a new flag in
> > > > each machine-
> > > type?
> > > >     I try to do live migration with "-cpu qemu64,+intel-pt" and
> > > > "-cpu host" are all passed test. We didn't change the cpuid data
> > > > during live
> > > migration just initialize the cpuid data when create a new vcpu. Plea=
se correct me if anything wrong.
> > >
> > > CPUID data is not sent as part of the migration stream (it is recreat=
ed on the migration destination), so if "-cpu qemu,+intel-pt"
> > > results in different CPUID data, migration between QEMU 4.0 and
> > > 3.1 will make CPUID level change during live migration.
> >
> > Yes, CPUID data is not sent as part of migration stream. But when will
> > the "-cpu qemu,+intel-pt" result different results? I think CPU type
> > include some specific features and CPUID data of Intel PT are constant
> > value, so I think the CPUID data should not change as well.
>=20
> Before your patch, "-cpu qemu64,+intel-pt" has CPUID[0].EAX =3D 0xD, and =
guest won't see intel-pt data in CPUID[0x14].
>=20
> After your patch, "-cpu qemu64,+intel-pt" has CPUID[0].EAX =3D 0x14, and =
guest will see intel-pt data in CPUID[0x14].
>=20

Oh yes, get it. Thanks.

Luwei Kang

> --
> Eduardo
