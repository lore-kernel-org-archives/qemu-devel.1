Received: from eggs.gnu.org ([2001:4830:134:3::10]:38892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dD5gs-0004V9-38
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dD5gm-0006GA-By
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:01:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46062
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dD5gm-0006Fa-6e
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:01:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4N8woR6134001
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 05:01:11 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2am7txev87-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 05:01:11 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 23 May 2017 19:01:07 +1000
Date: Tue, 23 May 2017 14:30:12 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
	<1495434650.2205.1.camel@gmail.com>
	<20170523044836.GI3446@in.ibm.com>
	<1495528948.2205.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1495528948.2205.3.camel@gmail.com>
Message-Id: <20170523090012.GJ3446@in.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH v2 4/4] spapr: Fix migration
 of Radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-devel@nongnu.org, rnsastry@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

On Tue, May 23, 2017 at 06:42:28PM +1000, Suraj Jitindar Singh wrote:
> On Tue, 2017-05-23 at 10:18 +0530, Bharata B Rao wrote:
> > On Mon, May 22, 2017 at 04:30:50PM +1000, Suraj Jitindar Singh wrote:
> > > On Fri, 2017-05-19 at 11:10 +0530, Bharata B Rao wrote:
> > > > Fix migration of radix guests by ensuring that we issue
> > > > KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> > > >=20
> > > > Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> > > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > > ---
> > > > =A0hw/ppc/spapr.c | 12 ++++++++++++
> > > > =A01 file changed, 12 insertions(+)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index daf335c..8f20f14 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque,
> > > > int
> > > > version_id)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D spapr_rtc_import_offset(&spapr=
->rtc, spapr-
> > > > > rtc_offset);
> > > >=20
> > > > =A0=A0=A0=A0=A0}
> > >=20
> > > This will break migration for tcg radix guests.
> > >=20
> > > Given that there is essentially nothing special we need to do on
> > > incoming tcg migration, I suggest we make it:
> > >=20
> > > if (spapr->patb_entry && kvm_enabled()) {
> > > =A0=A0=A0=A0[snip]
> > > }
> > >=20
> > > > =A0
> > > > +=A0=A0=A0=A0if (spapr->patb_entry) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0PowerPCCPU *cpu =3D POWERPC_CPU(first_cp=
u);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0if (kvmppc_has_cap_mmu_radix() && kvm_en=
abled()) {
> > >=20
> > > Why not make this a bit more generic? Something like:
> > >=20
> > > err =3D kvmppc_configure_v3_mmu(cpu, !!(spapr->patb_entry &
> > > PATBE1_GR),
> > > !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE), spapr->patb_entry);
> > > if (err) {
> > > =A0=A0=A0=A0error_report("Process table config unsupported by the h=
ost");
> > > =A0=A0=A0=A0return -EINVAL;
> > > }
> > >=20
> > > return err;
> > >=20
> > > While I don't think it's possible currently, there is nothing
> > > inherently incorrect about having a non-zero process table entry
> > > for a
> > > hash guest. And this saves a future update.
> >=20
> > How about having this logic in spapr_post_load() ?
>=20
> Looks a lot better :)
>=20
> >=20
> > =A0=A0=A0=A0if (spapr->patb_entry) {
> > =A0=A0=A0=A0=A0=A0=A0=A0/* Can be Hash(in future?) or Radix guest (cu=
rrent) */
> > =A0=A0=A0=A0=A0=A0=A0=A0PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> > =A0=A0=A0=A0=A0=A0=A0=A0bool radix =3D !!(spapr->patb_entry & PATBE1_=
GR);
> > =A0=A0=A0=A0=A0=A0=A0=A0bool gtse =3D !!(cpu->env.spr[SPR_LPCR] & LPC=
R_GTSE);
> >=20
>=20
> Don't think we need this if statement though. When hash with patb entry
> is possible it will still need to call kvmppc_configure_v3_mmu on
> incoming migration, that isn't radix specific.

Right.

>=20
> > =A0=A0=A0=A0=A0=A0=A0=A0if (radix) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Radix guest, configure MMU */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* kvmppc_configure_v3_mmu() is N=
OP for TCG */
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D kvmppc_configure_v3_mmu(c=
pu, radix, gtse, spapr-
> > >patb_entry);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (err) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0error_report("Process=
 table config unsupported by the
> > host");
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0} else {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Can be Hash guest (in future ?=
), nothing to do */
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0} else {
>=20
> Don't need this else statement. Can just have the comment below if you
> feel it's necessary.

Was just being verbose with empty else blocks, will not have them in the
actual patch.

Thanks for the review.

Regards,
Bharata.
