Received: from eggs.gnu.org ([2001:4830:134:3::10]:60229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fpDEZ-0001xc-SX
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 09:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fpDEV-0004kq-49
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 09:50:11 -0400
Received: from mail-co1nam03on0088.outbound.protection.outlook.com
	([104.47.40.88]:29423
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fpDEU-0004jJ-Ni
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 09:50:07 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 13 Aug 2018 13:50:02 +0000
Message-ID: <DM5PR12MB247147E820E5998C265B104295390@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20180809221852.15285-1-ehabkost@redhat.com>
	<20180810074110.GD1455@redhat.com>
In-Reply-To: <20180810074110.GD1455@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: Disable TOPOEXT by default on "-cpu
 host"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Looks good. Did some basic testing.

Reviewed-by: Babu Moger <babu.moger@amd.com>

> -----Original Message-----
> From: Richard W.M. Jones <rjones@redhat.com>
> Sent: Friday, August 10, 2018 2:41 AM
> To: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org; Paolo Bonzini <pbonzini@redhat.com>;
> Richard Henderson <rth@twiddle.net>; Moger, Babu
> <Babu.Moger@amd.com>
> Subject: Re: [PATCH] i386: Disable TOPOEXT by default on "-cpu host"
>=20
> On Thu, Aug 09, 2018 at 07:18:52PM -0300, Eduardo Habkost wrote:
> > Enabling TOPOEXT is always allowed, but it can't be enabled
> > blindly by "-cpu host" because it may make guests crash if the
> > rest of the cache topology information isn't provided or isn't
> > consistent.
> >
> > This addresses the bug reported at:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1613277
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  target/i386/cpu.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 723e02221e..3ac627978f 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -849,6 +849,12 @@ static FeatureWordInfo
> feature_word_info[FEATURE_WORDS] =3D {
> >          },
> >          .cpuid_eax =3D 0x80000001, .cpuid_reg =3D R_ECX,
> >          .tcg_features =3D TCG_EXT3_FEATURES,
> > +        /*
> > +         * TOPOEXT is always allowed but can't be enabled blindly by
> > +         * "-cpu host", as it requires consistent cache topology info
> > +         * to be provided so it doesn't confuse guests.
> > +         */
> > +        .no_autoenable_flags =3D CPUID_EXT3_TOPOEXT,
> >      },
> >      [FEAT_C000_0001_EDX] =3D {
> >          .feat_names =3D {
>=20
> Can confirm that this fixes the problem observed on the original AMD
> Phenom machine, using qemu from git (@6ad908053) + your patch.
> Therefore:
>=20
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
>=20
> Thanks,
>=20
> Rich.
>=20
> --
> Richard Jones, Virtualization Group, Red Hat
> http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> virt-p2v converts physical machines to virtual machines.  Boot with a
> live CD or over the network (PXE) and turn machines into KVM guests.
> http://libguestfs.org/virt-v2v
