Received: from eggs.gnu.org ([2001:4830:134:3::10]:55800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSmAm-0002Si-Dx
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSmAi-0004Tk-0y
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:29:32 -0400
Received: from mail-co1nam05on0609.outbound.protection.outlook.com
	([2a01:111:f400:fe50::609]:23296
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fSmAh-0004T8-Je
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:29:27 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Tue, 12 Jun 2018 16:29:25 +0000
Message-ID: <DM5PR12MB247152846B93E574639E3AE7957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-4-git-send-email-babu.moger@amd.com>
	<20180611205030.GW7451@localhost.localdomain>
	<20180611211026.GA7451@localhost.localdomain>
In-Reply-To: <20180611211026.GA7451@localhost.localdomain>
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
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
> On Behalf Of Eduardo Habkost
> Sent: Monday, June 11, 2018 4:10 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com; Jiri
> Denemark <jdenemar@redhat.com>
> Subject: Re: [PATCH v13 3/5] i386: Enable TOPOEXT feature on AMD EPYC
> CPU
>=20
> On Mon, Jun 11, 2018 at 05:50:30PM -0300, Eduardo Habkost wrote:
> [...]
> > > +        /* TOPOEXT feature requires 0x8000001E */
> > > +        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT)
> {
> > > +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel,
> 0x8000001E);
> > > +        }
> >
> > I suggest moving this hunk to a separate patch.  I'm not 100%
> > sure yet if this will require compat_props code to disable
> > auto-xlevel-increase on older machine-types.
>=20
> The problem here is that:
>   $QEMU -machine pc-i440fx-1.3 -cpu Opteron_G4,+topoext
> currently results in xlevel=3D0x8000001A, since QEMU 1.3.
>=20
> (The same applies to all machine-types between 1.3 and 2.12)
>=20
> I was hoping that we could declare topoext as non-migration-safe,
> but I believe libvirt will already include "topoext" when using
> "host-model" if the host CPU supports TOPOEXT.  Jiri, can you
> confirm that?
>=20
> We can address that with a "x-topoext-auto-xlevel" property, set
> to true on all CPU models by default, and disabled by
> PC_COMPAT_2_12.
>=20
> The code would become:
>=20
>     if (cpu->topoext_auto_xlevel && env->features[FEAT_8000_0001_ECX] &
> CPUID_EXT3_TOPOEXT) {
>         x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
>     }
>=20
> Or, we could simply declare that "-cpu Opteron_G4,+topoext" will
> never increase xlevel automatically (on any machine-type), and
> change the code above to:
>=20
>     if (cpu->auto_topoext && env->features[FEAT_8000_0001_ECX] &
> CPUID_EXT3_TOPOEXT) {
>         x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
>     }

I was going to do this.  But there is one problem.  We don't set the CPUID_=
EXT3_TOPOEXT in CPU model table. So this won't work.
One more thing I noticed that feature setting should happen much before x86=
_cpu_realizefn.

Couple of options.=20
First option.
1. Set both feature and xlevel here(in x86_cpu_expand_features).
 if (cpu->x_auto_topoext {
        env->features[FEAT_8000_0001_ECX]  |=3D CPUID_EXT3_TOPOEXT;
        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
 }
2. And remove feature setting in x86_cpu_realizefn.

Or=20

Second option
1.Set the feature bit in CPU model table.
2. Set xlevel in x86_cpu_expand_features using cpu->x_auto_topoext
3. And remove feature setting in x86_cpu_realizefn.
=20
I  prefer the second option.=20

>=20
> --
> Eduardo
