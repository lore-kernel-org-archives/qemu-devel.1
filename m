Received: from eggs.gnu.org ([2001:4830:134:3::10]:48865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fG488-0003bI-9c
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fG483-0004As-IZ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:02:16 -0400
Received: from mail-cys01nam02on0060.outbound.protection.outlook.com
	([104.47.37.60]:56293
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fG483-00049A-28
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:02:11 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Tue, 8 May 2018 15:02:07 +0000
Message-ID: <SN1PR12MB24774FAF36327C67C2B46FB1959A0@SN1PR12MB2477.namprd12.prod.outlook.com>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-8-git-send-email-babu.moger@amd.com>
	<20180507193944.GF13350@localhost.localdomain>
	<BL0PR12MB2468B701C4DF796ABF9EAD3D959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
	<20180508141632.GJ25013@localhost.localdomain>
In-Reply-To: <20180508141632.GJ25013@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 7/9] i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "geoff@hostfission.com" <geoff@hostfission.com>, "kash@tripleback.net" <kash@tripleback.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>


> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Tuesday, May 8, 2018 9:17 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel@redhat.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> Subject: Re: [Qemu-devel] [PATCH v7 7/9] i386: Add support for
> CPUID_8000_001E for AMD
>=20
> On Mon, May 07, 2018 at 11:44:31PM +0000, Moger, Babu wrote:
> [...]
> > > > +
> > > >  /*
> > > >   * Encode cache info for CPUID[0x80000006].ECX and
> > > CPUID[0x80000006].EDX
> > > >   * @l3 can be NULL.
> > > > @@ -4105,6 +4111,14 @@ void cpu_x86_cpuid(CPUX86State *env,
> > > uint32_t index, uint32_t count,
> > > >              break;
> > > >          }
> > > >          break;
> > > > +    case 0x8000001E:
> > > > +        assert(cpu->core_id <=3D 255);
> > >
> > > Where's the code that ensures this assert() line can't be
> > > triggered by any command-line configuration?
> >
> > I did not understand this. Can you please elaborate. Thanks
>=20
> The user must not be able to trigger an assert(), so we need to
> ensure that core_id will never be larger than 255.  Is there
> existing code that ensures that?

I see that max_cpus is set to 255 and also there are checks to make sure co=
re_id does not go above 255.
I verified it while testing.  So, probably we don't need assert here.  Radi=
m asked me to add this assert.
I can remove it if no abjections.=20
=20
>=20
> >
> > >
> > > > +        *eax =3D EXTENDED_APIC_ID((cs->nr_threads - 1),
> > > > +               cpu->socket_id, cpu->core_id, cpu->thread_id);
> > > > +        *ebx =3D (cs->nr_threads - 1) << 8 | cpu->core_id;
> > > > +        *ecx =3D cpu->socket_id;
> > > > +        *edx =3D 0;
> > > > +        break;
> > > >      case 0xC0000000:
> > > >          *eax =3D env->cpuid_xlevel2;
> > > >          *ebx =3D 0;
> > > > --
> > > > 2.7.4
> > > >
> > > >
> > >
> > > --
> > > Eduardo
>=20
> --
> Eduardo
