Received: from eggs.gnu.org ([2001:4830:134:3::10]:46231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSTws-0001g7-6H
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSTwp-00064B-47
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:01:58 -0400
Received: from mail-dm3nam03on0086.outbound.protection.outlook.com
	([104.47.41.86]:43952
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fSTwo-00063j-Sf
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:01:55 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 11 Jun 2018 21:01:52 +0000
Message-ID: <DM5PR12MB2471597D66535EA6905F48E895780@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-5-git-send-email-babu.moger@amd.com>
	<20180611205159.GX7451@localhost.localdomain>
In-Reply-To: <20180611205159.GX7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v13 4/5] i386: Verify and enable topoext
 feature if supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>



> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
> On Behalf Of Eduardo Habkost
> Sent: Monday, June 11, 2018 3:52 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v13 4/5] i386: Verify and enable topoext feature if
> supported
>=20
> On Fri, Jun 08, 2018 at 06:56:20PM -0400, Babu Moger wrote:
> > If the CPU model supports topoext feature, enabled the
> > feature automatically if it can be supported.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  target/i386/cpu.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 4dd9a82..88bc73d 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -4763,6 +4763,33 @@ static int x86_cpu_filter_features(X86CPU *cpu)
> >  #define IS_AMD_CPU(env) ((env)->cpuid_vendor1 =3D=3D
> CPUID_VENDOR_AMD_1 && \
> >                           (env)->cpuid_vendor2 =3D=3D CPUID_VENDOR_AMD_=
2 && \
> >                           (env)->cpuid_vendor3 =3D=3D CPUID_VENDOR_AMD_=
3)
> > +/*
> > + * Check if we can support this topology
> > + * Fail if number of cores are beyond the supported config
> > + * or nr_threads is more than 2
> > + */
> > +static int topology_supports_topoext(int nr_cores, int nr_threads,
> > +            Error **errp)
> > +{
> > +    if (nr_cores > (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET)) {
> > +        error_setg(errp, "TOPOEXT unsupported with %d cores per socket=
",
> > +                   nr_cores);
> > +        error_append_hint(errp, "TOPOEXT supports only up to %d cores
> per"
> > +                          " socket\n",
> > +                          (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
> > +        return false;
> > +    }
> > +
> > +    if (nr_threads > 2) {
> > +        error_setg(errp, "TOPOEXT unsupported with %d threads per core=
",
> > +                   nr_threads);
> > +        error_append_hint(errp, "TOPOEXT supports only up to 2 threads=
"
> > +                          " per core\n");
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> >  static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> >  {
> >      CPUState *cs =3D CPU(dev);
> > @@ -4953,6 +4980,19 @@ static void x86_cpu_realizefn(DeviceState *dev,
> Error **errp)
> >
> >      qemu_init_vcpu(cs);
> >
> > +    if (cpu->auto_topoext &&
> > +        !(env->user_features[FEAT_8000_0001_ECX] &
> CPUID_EXT3_TOPOEXT)) {
> > +        if (cs->nr_cores <=3D (MAX_CORES_IN_NODE *
> MAX_NODES_PER_SOCKET) &&
> > +            (cs->nr_threads <=3D 2)) {
>=20
> This duplicates the logic from topology_supports_topoext().  Why
> not just call
>   topology_supports_topoext(cs->nr_cores, cs->nr_threads, NULL)
> here?

Ok. Will do it.

>=20
> > +            env->features[FEAT_8000_0001_ECX] |=3D CPUID_EXT3_TOPOEXT;
> > +        }
> > +    }
> > +
> > +    if ((env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
> > +        !topology_supports_topoext(cs->nr_cores, cs->nr_threads, errp)=
) {
> > +        return;
> > +    }
> > +
> >      /* Only Intel CPUs support hyperthreading. Even though QEMU fixes =
this
> >       * issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
> >       * based on inputs (sockets,cores,threads), it is still better to =
gives
> > --
> > 1.8.3.1
> >
>=20
> --
> Eduardo
