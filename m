Received: from eggs.gnu.org ([2001:4830:134:3::10]:57900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eu4Gv-0001we-4o
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eu4Gq-0006Y9-Mm
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:44:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eu4Gq-0006Xy-Ej
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:44:20 -0500
Date: Thu, 8 Mar 2018 19:44:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180308224412.GF3417@localhost.localdomain>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-9-brijesh.singh@amd.com>
	<20180308164910.GF4718@redhat.com>
	<e39191c3-9c83-8c44-f1d2-9fa7a2f7695d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e39191c3-9c83-8c44-f1d2-9fa7a2f7695d@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 08/28] target/i386: add Secure
 Encrypted Virtulization (SEV) object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 08, 2018 at 04:22:52PM -0600, Brijesh Singh wrote:
>=20
>=20
> On 3/8/18 10:49 AM, Daniel P. Berrang=E9 wrote:
> > On Thu, Mar 08, 2018 at 06:48:41AM -0600, Brijesh Singh wrote:
> >> Add a new memory encryption object 'sev-guest'. The object will be u=
sed
> >> to create enrypted VMs on AMD EPYC CPU. The object provides the prop=
erties
> >> to pass guest owner's public Diffie-hellman key, guest policy and se=
ssion
> >> information required to create the memory encryption context within =
the
> >> SEV firmware.
> >>
> >> e.g to launch SEV guest
> >>  # $QEMU \
> >>     -object sev-guest,id=3Dsev0 \
> >>     -machine ....,memory-encryption=3Dsev0
> >>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Richard Henderson <rth@twiddle.net>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> >
> >> diff --git a/qemu-options.hx b/qemu-options.hx
> >> index 4c280142c52c..6113bce08a8c 100644
> >> --- a/qemu-options.hx
> >> +++ b/qemu-options.hx
> >> @@ -4353,6 +4353,50 @@ contents of @code{iv.b64} to the second secre=
t
> >>           data=3D$SECRET,iv=3D$(<iv.b64)
> >>  @end example
> >> =20
> >> +@item -object sev-guest,id=3D@var{id},cbitpos=3D@var{cbitpos},reduc=
ed-phys-bits=3D@var{val},[sev-device=3D@var{string},policy=3D@var{policy}=
,handle=3D@var{handle},dh-cert-file=3D@var{file},session-file=3D@var{file=
}]
> >> +
> >> +Create a Secure Encrypted Virtualization (SEV) guest object, which =
can be used
> >> +to provide the guest memory encryption support on AMD processors.
> >> +
> >> +When memory encryption is enabled, one of the physical address bit =
(aka the
> >> +C-bit) is utilized to mark if a memory page is protected. The @opti=
on{cbitpos}
> >> +is used to provide the C-bit position. The C-bit position is Host f=
amily dependent
> >> +hence user must provide this value. On EPYC, the value should be 47=
.
> >> +
> >> +When memory encryption is enabled, we loose certain bits in physica=
l address space.
> >> +The @option{reduced-phys-bits} is used to provide the number of bit=
s we loose in
> >> +physical address space. Similar to C-bit, the value is Host family =
dependent.
> >> +On EPYC, the value should be 5.
> > Is it valid to specify a different value for either of these properti=
es ?
> > eg what happens if I pass cbitpos=3D45 instead of 47 on an EPYC host =
?
>=20
> On EPYC, passing anything other than 47 will trigger error during SEV
> guest initialization. The value of Cbit position is host dependent, the
> value is readonly and can be obtained through the host CPUID.=A0 The
> cbitpos must be same between guest and host. Please note that the pte's
> in guest page table will need to use the cbitpos=A0 information to mark
> the pages as encrypted. If cbit position given to the guest is differen=
t
> from the host then guest will fail to execute.
>=20
> >
> > In particular I thinking about possible migration scenario, where EPY=
C
> > uses 47 by default but some $NEXT AMD CPU uses 48 by default. In that
> > case we might want to use '47' on both CPUs if we need ability to liv=
e
> > migrate between different host CPU generations. Would that be valid ?
>=20
> We will not be able to migrate SEV guests if cbit position does not
> match between the source and destination hosts. Since during migration,
> the destination guest is launched with same QEMU cli as source hence
> cbitpos check in QEMU will catch it and fail the new launch. Optionally=
,
> user can call query-sev-capabilities on both source and destination to
> see if cbitpos is compatible before attempting to migrate the guest.
>=20
> > On the flip side, if the value really it strictly tied to the host
> > CPU family and no deviation is permitted, could the kernel not just
> > pick the right value automatically avoiding the config option ?
> >
>=20
> I think doing so will be an issue for the migration. Consider your abov=
e
> use case, a SEV guest is running on EPYC with cbitpos=3D47 and if we
> migrate to some $NEXT AMD CPU which uses need to use cbitpos=3D48 and w=
e
> will fail to resume the guest on destination after migrating.

Exactly, in other words these two options are part of the guest
ABI, and QEMU promises to never make the guest ABI depend on the
host hardware unless you're using "-cpu host".

In theory we could make QEMU choose the right values
automatically if we document very clearly that the default
behavior is unsafe.  But I would rather not take that risk and
force management software to be aware of the gotchas involved in
using SEV + live-migration.

--=20
Eduardo
