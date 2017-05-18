Received: from eggs.gnu.org ([2001:4830:134:3::10]:48891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEkC-0008UF-H0
	for qemu-devel@nongnu.org; Thu, 18 May 2017 02:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEk8-0002Vj-CZ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 02:17:04 -0400
Date: Thu, 18 May 2017 15:50:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170518055020.GA13465@umbus.fritz.box>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-7-git-send-email-bharata@linux.vnet.ibm.com>
	<20170517070049.GN15596@umbus.fritz.box>
	<20170517071539.GB3446@in.ibm.com>
	<20170517072031.GO15596@umbus.fritz.box>
	<20170518050305.GF3446@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20170518050305.GF3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 6/6] spapr: Fix migration of Radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 10:33:05AM +0530, Bharata B Rao wrote:
> On Wed, May 17, 2017 at 05:20:31PM +1000, David Gibson wrote:
> > On Wed, May 17, 2017 at 12:45:39PM +0530, Bharata B Rao wrote:
> > > On Wed, May 17, 2017 at 05:00:49PM +1000, David Gibson wrote:
> > > > On Wed, May 17, 2017 at 09:19:22AM +0530, Bharata B Rao wrote:
> > > > > Fix migration of radix guests by ensuring that we issue
> > > > > KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> > > > >=20
> > > > > Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> > > > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > > > ---
> > > > >  hw/ppc/spapr.c         | 15 +++++++++++++++
> > > > >  hw/ppc/spapr_hcall.c   |  1 +
> > > > >  include/hw/ppc/spapr.h |  1 +
> > > > >  3 files changed, 17 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > > index 05abfc1..dd1d687 100644
> > > > > --- a/hw/ppc/spapr.c
> > > > > +++ b/hw/ppc/spapr.c
> > > > > @@ -1443,6 +1443,20 @@ static int spapr_post_load(void *opaque, i=
nt version_id)
> > > > >          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_=
offset);
> > > > >      }
> > > > > =20
> > > > > +    if (spapr->patb_entry) {
> > > > > +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> > > > > +            err =3D kvmppc_configure_v3_mmu(POWERPC_CPU(first_cp=
u),
> > > > > +                                          spapr->patb_flags &
> > > > > +                                          SPAPR_PROC_TABLE_RADIX,
> > > > > +                                          spapr->patb_flags &
> > > > > +                                          SPAPR_PROC_TABLE_GTSE,
> > > >=20
> > > > You should be able to work out the things you need here from
> > > > patb_entry without adding the new patb_flags field.
> > >=20
> > > kvmppc_configure_v3_mmu() needs two bools: radix and gtse. The radix
> > > bit can be implied from patb_entry, I needed patb_flags to get the
> > > gtse value. Not immediately obvious of how to get gtse bit from patb_=
entry,
> > > but let me take a relook.
> >=20
> > Oh, sorry, you can't get GTSE from the patb_entry, but you can get it
> > from the LPCR.
>=20
> So I need to get GTSE from LPCR at the target after the LPCR has been upd=
ated
> from the incoming stream (via vmstate_ppc_cpu vmsd). However we are also
> in the middle of processing the incoming stream here (via spapr_post_load=
).
> Can we be sure that spapr_post_load() processing happens after all
> SPRs (and hence LPCR) have been updated via vmstate_ppc_cpu vmsd handlers=
 ?

Yes, you can.  An object's post_load is called after all that object's
state - and that of all objects below it in the QOM composition tree -
is transferred.  Since the CPUs are below the machine in the
composition tree, you can rely on the LPCR being correct in the
machine post_load handler.

> Also, in addition to issuing KVM_PPC_CONFIGURE_V3_MMU, should we be
> walking all the CPUs and setting the LPCR_UPRT and LPCR_GTSE bits like how
> H_REGISTER_PROC_TBL does ?

Shouldn't be necessary - the LPCR state should already be transferred,
along with the rest of the SPRs.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHTYaAAoJEGw4ysog2bOSKg0QANQ5mMqceKBUemsnk+4BBzgo
kmUmXCGS3CMS/V7Qq9PUcjU2XPSoZkPQIqtLTRYgahN5lUNFJK8O07knpfD66PVW
AXgA61WvX9dxH2lBk1746LW8AAFKVfXl0peOinETfivksGx74d+VBkMILOd7qw4H
QlmHQA1h1Nny5U3pG4eXkY9JwDe66h2LeYLlbnhKWz9SXnHALz0l71RCvZ9C03hn
ujh3wf6Z8Febm4Uq0EqoA6RSNHK2jft6ynLoLP3dd1sZ75UMUspbQz6hlQpG2o6o
m8PX6A/wJB3pWiFb0l3wtHQ33L6Mrom0/aT5ZJZGaDv0ic0pz8zG8/J87WUbbNBO
GLAuveQ7JUsT9O0w4YY+LBzMa1fUEycqUWUY6pIHUq7u9Ojsa7ImxLMxJfC4Wre4
p4PxV6l2SQjSuJXYUk4idbdONiYzdipXa0yTSmpl1cXachsew7xLlW97eIixf8ya
/WWOunwgjAHK/59uLRS1nmSw3s/33IDVIEvvsFD18vhwZoVSM1qNiyh2Hr2eud32
yh30igLBIS3dS5tqozjWeWj+636T9WB7BWRJ7sxGQF1W6mg2cu5iH9YBmoCQIEnP
IsI1PJcxS+PkxBMlkCA0ateWOZQE6x9tTT74kSJT5UHvZQJ7AJ70kr+13QFmga1k
XALd7aaE3SFyTfcTo0B2
=eI3V
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
