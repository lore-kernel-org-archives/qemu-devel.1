Received: from eggs.gnu.org ([2001:4830:134:3::10]:57593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSoBa-0003Qi-Fc
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSoBW-0000vS-FW
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:38:30 -0400
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com
	([104.47.37.71]:45184
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fSoBW-0000uz-4T
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:38:26 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Tue, 12 Jun 2018 18:38:08 +0000
Message-ID: <DM5PR12MB2471F6EA1525A824A9A94545957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-4-git-send-email-babu.moger@amd.com>
	<20180611205030.GW7451@localhost.localdomain>
	<20180611211026.GA7451@localhost.localdomain>
	<DM5PR12MB247152846B93E574639E3AE7957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180612174021.GL7451@localhost.localdomain>
In-Reply-To: <20180612174021.GL7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v13 3/5] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>, Jiri Denemark <jdenemar@redhat.com>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Tuesday, June 12, 2018 12:40 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com; Jiri
> Denemark <jdenemar@redhat.com>
> Subject: Re: [PATCH v13 3/5] i386: Enable TOPOEXT feature on AMD EPYC
> CPU
>=20
> On Tue, Jun 12, 2018 at 04:29:25PM +0000, Moger, Babu wrote:
> > > [...]
> > > > > +        /* TOPOEXT feature requires 0x8000001E */
> > > > > +        if (env->features[FEAT_8000_0001_ECX] &
> CPUID_EXT3_TOPOEXT)
> > > {
> > > > > +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel,
> > > 0x8000001E);
> > > > > +        }
> > > >
> > > > I suggest moving this hunk to a separate patch.  I'm not 100%
> > > > sure yet if this will require compat_props code to disable
> > > > auto-xlevel-increase on older machine-types.
> > >
> > > The problem here is that:
> > >   $QEMU -machine pc-i440fx-1.3 -cpu Opteron_G4,+topoext
> > > currently results in xlevel=3D0x8000001A, since QEMU 1.3.
> > >
> > > (The same applies to all machine-types between 1.3 and 2.12)
> > >
> > > I was hoping that we could declare topoext as non-migration-safe,
> > > but I believe libvirt will already include "topoext" when using
> > > "host-model" if the host CPU supports TOPOEXT.  Jiri, can you
> > > confirm that?
> > >
> > > We can address that with a "x-topoext-auto-xlevel" property, set
> > > to true on all CPU models by default, and disabled by
> > > PC_COMPAT_2_12.
> > >
> > > The code would become:
> > >
> > >     if (cpu->topoext_auto_xlevel && env-
> >features[FEAT_8000_0001_ECX] &
> > > CPUID_EXT3_TOPOEXT) {
> > >         x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E)=
;
> > >     }
> > >
> > > Or, we could simply declare that "-cpu Opteron_G4,+topoext" will
> > > never increase xlevel automatically (on any machine-type), and
> > > change the code above to:
> > >
> > >     if (cpu->auto_topoext && env->features[FEAT_8000_0001_ECX] &
> > > CPUID_EXT3_TOPOEXT) {
> > >         x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E)=
;
> > >     }
> >
> > I was going to do this.  But there is one problem.  We don't
> > set the CPUID_EXT3_TOPOEXT in CPU model table. So this won't
> > work.
>=20
> Won't this work if the auto_topoext handling is done before
> x86_cpu_expand_features() is called?

Yes. That works. We can go with this approach.

>=20
>=20
> > One more thing I noticed that feature setting should happen
> > much before x86_cpu_realizefn.
>=20
> Why?

I was wrong here.  It should be done before x86_cpu_expand_features.

>=20
> >
> > Couple of options.
> > First option.
> > 1. Set both feature and xlevel here(in x86_cpu_expand_features).
> >  if (cpu->x_auto_topoext {
> >         env->features[FEAT_8000_0001_ECX]  |=3D CPUID_EXT3_TOPOEXT;
> >         x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
> >  }
> > 2. And remove feature setting in x86_cpu_realizefn.
>=20
> This would make TOPOEXT be included in 'query-cpu-model-expansion
> model=3DEPYC', which would be incorrect because TOPOEXT won't
> always be enabled when using EPYC.
>=20
>=20
> >
> > Or
> >
> > Second option
> > 1.Set the feature bit in CPU model table.
> > 2. Set xlevel in x86_cpu_expand_features using cpu->x_auto_topoext
> > 3. And remove feature setting in x86_cpu_realizefn.
> >
> > I  prefer the second option.
>=20
> Same here: TOPOEXT would be included in
> 'query-cpu-model-expansion model=3DEPYC', and this would be
> incorrect.
>=20
>=20
> I'm starting to think that enabling TOPOEXT automatically is
> adding too much complexity and compatibility problems, and it's
> better to leave this task to management software.
>=20
> The main problem here is:
>=20
> This works today with QEMU 2.12 + Linux <=3D 4.15:
>   $ $QEMU -machine pc -cpu EPYC,enforce -smp
> 8,sockets=3D2,cores=3D2,threads=3D2"
> and must keep working with QEMU 3.0 and Linux <=3D 4.15.
>=20
> In addition to that, the results for:
>   $ $QEMU -machine pc-q35-3.0 -cpu EPYC,enforce [...]
> must be deterministic and expose exactly the same CPUID data even
> if host hardware or software changes, as long as the QEMU
> command-line is the same.
>=20
> Do you see a way to fulfill those two constraints while making
> "-machine pc-q35-3.0 -cpu EPYC" enable TOPOEXT automatically?
>=20

Now(setting feature before x86_cpu_expand_features), enabling TOPOEXT appea=
rs to work fine.

> --
> Eduardo
