Received: from eggs.gnu.org ([2001:4830:134:3::10]:44624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTSEQ-0002tS-Ua
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTSEN-0004Ch-Ok
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:24:06 -0400
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com
	([104.47.32.69]:43104
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTSEN-0004BA-DV
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:24:03 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Thu, 14 Jun 2018 13:24:00 +0000
Message-ID: <DM5PR12MB2471A1008A90567505C61410957D0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
	<1528939107-17193-2-git-send-email-babu.moger@amd.com>
	<20180614022139.GS7451@localhost.localdomain>
In-Reply-To: <20180614022139.GS7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v14 1/6] i386: Set TOPOEXT unconditionally
 for comapatibility
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
> Sent: Wednesday, June 13, 2018 9:22 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v14 1/6] i386: Set TOPOEXT unconditionally for
> comapatibility
>=20
> On Wed, Jun 13, 2018 at 09:18:22PM -0400, Babu Moger wrote:
> > Enabling TOPOEXT feature might cause compatibility issues if
> > older kernels does not set this feature. Lets set this feature
> > unconditionally.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  target/i386/kvm.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index 445e0e0..6f2cca7 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -372,6 +372,12 @@ uint32_t
> kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
> >          if (host_tsx_blacklisted()) {
> >              ret &=3D ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
> >          }
> > +    } else if (function =3D=3D 0x80000001 && reg =3D=3D R_ECX) {
> > +        /* Enabling topoext feature might cause compatibility issues i=
f
> > +         * older kernel does not set this feature. Lets set this featu=
re
> > +         * unconditionally.
> > +         */
>=20
> Thanks.  I will apply and rewrite the comment as:
Sure. Thanks
>=20
>         /*
>          * It's safe to enable TOPOEXT even if it's not returned
>          * by GET_SUPPORTED_CPUID.  Unconditionally enabling
>          * TOPOEXT here let us keep CPU models runnable on
>          * older kernels even when TOPOEXT is enabled.
>          */
>=20
> > +        ret |=3D CPUID_EXT3_TOPOEXT;
> >      } else if (function =3D=3D 0x80000001 && reg =3D=3D R_EDX) {
> >          /* On Intel, kvm returns cpuid according to the Intel spec,
> >           * so add missing bits according to the AMD spec:
> > --
> > 1.8.3.1
> >
>=20
> --
> Eduardo
