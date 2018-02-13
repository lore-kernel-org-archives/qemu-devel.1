Received: from eggs.gnu.org ([2001:4830:134:3::10]:55713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elclo-0006Z0-6R
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elcll-0004fq-Ru
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:45:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elclk-0004cD-Vy
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:45:21 -0500
Date: Tue, 13 Feb 2018 15:45:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180213154508.GK2378@work-vm>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
	<20180212153715.87555-6-brijesh.singh@amd.com>
	<20180212183803.GR13981@localhost.localdomain>
	<4a1f22d9-da2e-618b-1423-629817389948@amd.com>
	<20180212211948.GK14422@pd.tnic>
	<CA+HCGMYvh081neh=aF45qG0WF2vpJwkZ4unnLPLwhEkDNPWZsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CA+HCGMYvh081neh=aF45qG0WF2vpJwkZ4unnLPLwhEkDNPWZsQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 05/28] target/i386: add memory
 encryption feature cpuid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.ksingh@gmail.com>
Cc: Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Stefan Hajnoczi <stefanha@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Alistair Francis <alistair.francis@xilinx.com>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

* Brijesh Singh (brijesh.ksingh@gmail.com) wrote:
> On Mon, Feb 12, 2018 at 3:19 PM, Borislav Petkov <bp@suse.de> wrote:
>=20
> > On Mon, Feb 12, 2018 at 03:07:26PM -0600, Brijesh Singh wrote:
> > > In current implementation, when -cpu ...,+sev is passed without
> > > appropriate SEV configuration then we populate the Fn8000_001F CPUI=
D but
> > > VMCB will not have SEV bit set hence a guest will be launched as
> > > non-SEV.
> >
> > I think we should fail the guest init if sev is not really supported =
by
> > the host. Otherwise people might get mislead.
> >
> >
>=20
> Sure I will do that. We can simplify this patch if we don't fill the CP=
UID
> for non SEV guest. I am thinking of doing something like this:
>=20
> "If SEV configration is provided in QEMU command line then
> automatically increase xlevel to 0x8000_001F and populate the EAX and E=
BX
> registers"
>=20
>=20
>=20
> > > > Changing existing CPU models is possible only on very specific
> > > > circumstances (where VMs that are currently runnable would always
> > > > stay runnable), and would require compat_props entries to keep
> > > > compatibility on existing machine-types.
> > >
> > > Ah I didn't consider that case. What is recommendation, should we c=
reate
> > > a new CPU Model (EPYC-SEV) ?
> >
> > Can we please stop creating a new CPU model with every new CPUID feat=
ure
> > support added? This is just ridiculous.
> >
> > If this is about live migration, then by all means, fail the migratio=
n
> > if the feature bits are not compatible. But replicating CPU models an=
d
> > then adding one new differing feature doesn't make any sense.
> >
> >
> Yes, I think we should be able to avoid creating new CPU model to handl=
e
> this case.
> I am leaning towards dropping this patch and implement logic to populat=
e the
> CPUID 0x8000_001F only when SEV is enabled. This should not require any
> changes
> in existing CPU model feature flag and live migration of existing guest
> should work fine.

Take care that a non-SEV guest works migrating from a SEV-enabled host
back to a non-SEV-enabled host.  Similarly a guest that understands SEV
but you aren't going to enable it for this VM.

Dave

>=20
>=20
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Graham Norto=
n, HRB
> > 21284 (AG N=FCrnberg)
> > --
> >
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
