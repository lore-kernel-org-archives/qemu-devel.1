Received: from eggs.gnu.org ([2001:4830:134:3::10]:58549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1erA3e-00059C-Oc
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1erA3U-00061Q-3q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:18:42 -0500
Received: from mail-cys01nam02on062d.outbound.protection.outlook.com
	([2a01:111:f400:fe45::62d]:34256
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1erA3T-0005zn-Kq
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:18:31 -0500
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Wed, 28 Feb 2018 22:18:27 +0000
Message-ID: <CY4PR12MB1768464C5ABB828EEA45166B95C70@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-4-git-send-email-babu.moger@amd.com>
	<20180228182420.GC8418@flask>
In-Reply-To: <20180228182420.GC8418@flask>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pixo@polepetko.eu" <pixo@polepetko.eu>, "Hook, Gary" <Gary.Hook@amd.com>


> -----Original Message-----
> From: Radim Kr=E8m=E1=F8 [mailto:rkrcmar@redhat.com]
> Sent: Wednesday, February 28, 2018 12:24 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> mtosatti@redhat.com; qemu-devel@nongnu.org; kvm@vger.kernel.org;
> pixo@polepetko.eu; Hook, Gary <Gary.Hook@amd.com>
> Subject: Re: [PATCH v2 3/5] target/i386: Add support for CPUID_8000_001E
> for AMD
>=20
> 2018-02-23 21:30-0500, Babu Moger:
> > From: Stanislav Lanci <pixo@polepetko.eu>
> >
> > Populate threads/core_id/apic_ids/socket_id when CPUID_EXT3_TOPOEXT
> > feature is supported. This is required to support hyperthreading
> > feature on AMD CPUS. These are supported via CPUID_8000_001E
> extended
> > functions.
> >
> > Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  target/i386/cpu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index a5a480e..191e850 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3666,6 +3666,14 @@ void cpu_x86_cpuid(CPUX86State *env,
> uint32_t index, uint32_t count,
> >              *edx =3D 0;
> >          }
> >          break;
> > +    case 0x8000001E:
> > +        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> > +            *eax =3D cpu->apic_id;
> > +            *ebx =3D (cs->nr_threads - 1) << 8 | cpu->core_id;
>=20
> Do we somewhere assert that AMD cannot have cpu->core_id > 255?
> (qemu does allow weird configurations.)

I don't see specific assert on core_id.   But, I see that qemu does not all=
ow nr_cores more than 255.
Also I see that core_id is iterated based on nr_cores.  If you strongly bel=
ieve we need to add assert here, I will add it.=20
Let me know.
=20
> Thanks.
>=20
> > +            *ecx =3D cpu->socket_id;
> > +            *edx =3D 0;
> > +        }
> > +        break;
> >      case 0xC0000000:
> >          *eax =3D env->cpuid_xlevel2;
> >          *ebx =3D 0;
> > --
> > 1.8.3.1
> >
