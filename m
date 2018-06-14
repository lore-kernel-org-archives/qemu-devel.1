Received: from eggs.gnu.org ([2001:4830:134:3::10]:37956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTaZz-00039l-Qu
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTaZw-00038v-HU
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:18:55 -0400
Received: from mail-dm3nam03on0080.outbound.protection.outlook.com
	([104.47.41.80]:22020
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTaZw-000384-5Q
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:18:52 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Thu, 14 Jun 2018 22:18:49 +0000
Message-ID: <BL0PR12MB2468B28832BA657B1C9340E9957D0@BL0PR12MB2468.namprd12.prod.outlook.com>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
	<1528939107-17193-6-git-send-email-babu.moger@amd.com>
	<20180614191317.GY7451@localhost.localdomain>
In-Reply-To: <20180614191317.GY7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v14 5/6] i386: Disable TOPOEXT feature if
 it cannot be supported
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
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Thursday, June 14, 2018 2:13 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v14 5/6] i386: Disable TOPOEXT feature if it cannot b=
e
> supported
>=20
> On Wed, Jun 13, 2018 at 09:18:26PM -0400, Babu Moger wrote:
> > Disable the TOPOEXT feature if it cannot be supported.
> > We cannot support this feature with more than 2 nr_threads
> > or more than 32 cores in a socket.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  target/i386/cpu.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 2eb26da..637d8eb 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -4765,7 +4765,7 @@ static void x86_cpu_realizefn(DeviceState *dev,
> Error **errp)
> >      X86CPUClass *xcc =3D X86_CPU_GET_CLASS(dev);
> >      CPUX86State *env =3D &cpu->env;
> >      Error *local_err =3D NULL;
> > -    static bool ht_warned;
> > +    static bool ht_warned, topo_warned;
> >
> >      if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
> >          char *name =3D x86_cpu_class_get_model_name(xcc);
> > @@ -4779,6 +4779,21 @@ static void x86_cpu_realizefn(DeviceState *dev,
> Error **errp)
> >          return;
> >      }
> >
> > +    /* Disable TOPOEXT if topology cannot be supported */
> > +    if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> > +        if (!topology_supports_topoext(MAX_CORES_IN_NODE *
> MAX_NODES_PER_SOCKET,
> > +                                      2)) {
>=20
> I understand you stopped using cpu->nr_cores/cpu->nr_threads
> because it was not filled yet.
>=20
> But why exactly do you need to do this before calling
> x86_cpu_expand_features()?

We extend the xlevel in x86_cpu_expand_features based on the TOPOEXT featur=
e.
So, I thought it would be right to do that way. =20
>=20
> If you really need nr_cores and nr_threads to be available
> earlier, we could simply move their initialization to
> cpu_exec_initfn() instead of the solution you implemented in
> patch 4/6.
>=20
> > +            env->features[FEAT_8000_0001_ECX] &=3D !CPUID_EXT3_TOPOEXT=
;
>=20
> !CPUID_EXT3_TOPOEXT is 0, this will clear all bits in
> env->features[FEAT_8000_0001_ECX].  Did you mean
> ~CPUID_EXT3_TOPOEXT?

Yes. That is correct.  Sorry.. I missed it.
>=20
>=20
> > +            if (!topo_warned) {
> > +                error_report("TOPOEXT feature cannot be supported with=
 more"
> > +                             " than %d cores or more than 2 threads pe=
r socket."
> > +                             " Disabling the feature.",
> > +                             (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET=
));
> > +                topo_warned =3D true;
>=20
> This will print a warning for "-cpu EPYC -smp 64,cores=3D64".
> We shouldn't.
>=20
> I'm starting to believe we shouldn't add TOPOEXT to EPYC unless
> we're ready to make the TOPOEXT CPUID leaves work for all valid
> -smp configurations.  If the feature will work only on a few
> specific cases, the feature should be enabled explicitly using
> "-cpu ...,+topoext".
>=20
> Is it really impossible to make CPUID return reasonable topology
> data for larger nr_cores and nr_threads values?  It would make
> everything much simpler.

I am starting to think about this.  We tried to limit the configuration bas=
ed on the actual hardware configuration.
If we leave that decision to the user then we might allow the config whatev=
er the user wants.=20
I need to make some changes in for topology(0x80000001e) information to mak=
e this work.

>=20
> --
> Eduardo
