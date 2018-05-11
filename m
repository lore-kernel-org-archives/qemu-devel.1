Received: from eggs.gnu.org ([2001:4830:134:3::10]:33429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fH9HN-0000Cj-TO
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fH9HK-0000CM-NZ
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:44:17 -0400
Received: from mail-sn1nam01on0066.outbound.protection.outlook.com
	([104.47.32.66]:63927
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fH9HK-0000Ak-8A
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:44:14 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Fri, 11 May 2018 14:44:11 +0000
Message-ID: <BL0PR12MB2468AFEB39A2BDF45C8BDCD2959F0@BL0PR12MB2468.namprd12.prod.outlook.com>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-8-git-send-email-babu.moger@amd.com>
	<20180507193944.GF13350@localhost.localdomain>
	<BL0PR12MB2468B701C4DF796ABF9EAD3D959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
	<20180508141632.GJ25013@localhost.localdomain>
	<SN1PR12MB24774FAF36327C67C2B46FB1959A0@SN1PR12MB2477.namprd12.prod.outlook.com>
	<20180511141201.GK25013@localhost.localdomain>
In-Reply-To: <20180511141201.GK25013@localhost.localdomain>
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
> Sent: Friday, May 11, 2018 9:12 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel@redhat.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> Subject: Re: [Qemu-devel] [PATCH v7 7/9] i386: Add support for
> CPUID_8000_001E for AMD
>=20
> On Tue, May 08, 2018 at 03:02:07PM +0000, Moger, Babu wrote:
> >
> > > -----Original Message-----
> > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > Sent: Tuesday, May 8, 2018 9:17 AM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: mst@redhat.com; marcel@redhat.com; pbonzini@redhat.com;
> > > rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> > > kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> > > Subject: Re: [Qemu-devel] [PATCH v7 7/9] i386: Add support for
> > > CPUID_8000_001E for AMD
> > >
> > > On Mon, May 07, 2018 at 11:44:31PM +0000, Moger, Babu wrote:
> > > [...]
> > > > > > +
> > > > > >  /*
> > > > > >   * Encode cache info for CPUID[0x80000006].ECX and
> > > > > CPUID[0x80000006].EDX
> > > > > >   * @l3 can be NULL.
> > > > > > @@ -4105,6 +4111,14 @@ void cpu_x86_cpuid(CPUX86State *env,
> > > > > uint32_t index, uint32_t count,
> > > > > >              break;
> > > > > >          }
> > > > > >          break;
> > > > > > +    case 0x8000001E:
> > > > > > +        assert(cpu->core_id <=3D 255);
> > > > >
> > > > > Where's the code that ensures this assert() line can't be
> > > > > triggered by any command-line configuration?
> > > >
> > > > I did not understand this. Can you please elaborate. Thanks
> > >
> > > The user must not be able to trigger an assert(), so we need to
> > > ensure that core_id will never be larger than 255.  Is there
> > > existing code that ensures that?
> >
> > I see that max_cpus is set to 255 and also there are checks to make sur=
e
> core_id does not go above 255.
> > I verified it while testing.  So, probably we don't need assert here.  =
Radim
> asked me to add this assert.
> > I can remove it if no abjections.
>=20
> Sorry for not replying to this before: no objection to the
> assert(), especially considering it will trigger very early on
> initialization if we break it one day.

Ok. No problem.  I will add it back and send a v9 version.=20
Please let me know if you have any other feedback for v8 version(sent yeste=
rday).
=20
>=20
> --
> Eduardo
