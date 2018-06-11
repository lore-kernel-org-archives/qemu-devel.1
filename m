Received: from eggs.gnu.org ([2001:4830:134:3::10]:46020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSTw8-00017z-Fm
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSTw5-0005bS-Dq
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:01:12 -0400
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com
	([104.47.38.72]:53152
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fSTw5-0005aq-83
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:01:09 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 11 Jun 2018 21:01:07 +0000
Message-ID: <DM5PR12MB24717AB8EE91A58057BF58C095780@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-4-git-send-email-babu.moger@amd.com>
	<20180611205030.GW7451@localhost.localdomain>
In-Reply-To: <20180611205030.GW7451@localhost.localdomain>
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
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Monday, June 11, 2018 3:51 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v13 3/5] i386: Enable TOPOEXT feature on AMD EPYC
> CPU
>=20
> On Fri, Jun 08, 2018 at 06:56:19PM -0400, Babu Moger wrote:
> > Enable TOPOEXT feature on EPYC CPU. This is required to support
> > hyperthreading on VM guests. Also extend xlevel to 0x8000001E.
> >
> > TOPOEXT feature is disabled for legacy machines.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  target/i386/cpu.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index d3411ed..4dd9a82 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2574,6 +2574,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
> >          .xlevel =3D 0x8000000A,
> >          .model_id =3D "AMD EPYC Processor",
> >          .cache_info =3D &epyc_cache_info,
> > +        .auto_topoext =3D 1,
> >      },
> >      {
> >          .name =3D "EPYC-IBPB",
> > @@ -2621,6 +2622,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
> >          .xlevel =3D 0x8000000A,
> >          .model_id =3D "AMD EPYC Processor (with IBPB)",
> >          .cache_info =3D &epyc_cache_info,
> > +        .auto_topoext =3D 1,
> >      },
> >  };
> >
> > @@ -4672,6 +4674,11 @@ static void x86_cpu_expand_features(X86CPU
> *cpu, Error **errp)
> >              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x800000=
0A);
> >          }
> >
> > +        /* TOPOEXT feature requires 0x8000001E */
> > +        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> > +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x800000=
1E);
> > +        }
>=20
> I suggest moving this hunk to a separate patch.  I'm not 100%

Sure. Will move it to separate patch.

> sure yet if this will require compat_props code to disable
> auto-xlevel-increase on older machine-types.
>=20
> --
> Eduardo
