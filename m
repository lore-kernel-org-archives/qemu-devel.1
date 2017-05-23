Received: from eggs.gnu.org ([2001:4830:134:3::10]:42432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dD1lL-0005P7-LU
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dD1lI-00027E-G2
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:49:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53679
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dD1lI-000274-A0
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:49:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4N4hiAn109372
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 00:49:34 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2am8nh3p69-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 00:49:34 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 23 May 2017 14:49:31 +1000
Date: Tue, 23 May 2017 10:18:36 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
	<1495434650.2205.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1495434650.2205.1.camel@gmail.com>
Message-Id: <20170523044836.GI3446@in.ibm.com>
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

On Mon, May 22, 2017 at 04:30:50PM +1000, Suraj Jitindar Singh wrote:
> On Fri, 2017-05-19 at 11:10 +0530, Bharata B Rao wrote:
> > Fix migration of radix guests by ensuring that we issue
> > KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> >=20
> > Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > ---
> > =A0hw/ppc/spapr.c | 12 ++++++++++++
> > =A01 file changed, 12 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index daf335c..8f20f14 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int
> > version_id)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D spapr_rtc_import_offset(&spapr->rt=
c, spapr-
> > >rtc_offset);
> > =A0=A0=A0=A0=A0}
>=20
> This will break migration for tcg radix guests.
>=20
> Given that there is essentially nothing special we need to do on
> incoming tcg migration, I suggest we make it:
>=20
> if (spapr->patb_entry && kvm_enabled()) {
>     [snip]
> }
>=20
> > =A0
> > +=A0=A0=A0=A0if (spapr->patb_entry) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (kvmppc_has_cap_mmu_radix() && kvm_enable=
d()) {
>=20
> Why not make this a bit more generic? Something like:
>=20
> err =3D kvmppc_configure_v3_mmu(cpu, !!(spapr->patb_entry & PATBE1_GR),
> !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE), spapr->patb_entry);
> if (err) {
>     error_report("Process table config unsupported by the host");
>     return -EINVAL;
> }
>=20
> return err;
>=20
> While I don't think it's possible currently, there is nothing
> inherently incorrect about having a non-zero process table entry for a
> hash guest. And this saves a future update.

How about having this logic in spapr_post_load() ?

    if (spapr->patb_entry) {
        /* Can be Hash(in future?) or Radix guest (current) */
        PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
        bool radix =3D !!(spapr->patb_entry & PATBE1_GR);
        bool gtse =3D !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);

        if (radix) {
            /* Radix guest, configure MMU */
            /* kvmppc_configure_v3_mmu() is NOP for TCG */
            err =3D kvmppc_configure_v3_mmu(cpu, radix, gtse, spapr->patb=
_entry);
            if (err) {
                error_report("Process table config unsupported by the hos=
t");
                return -EINVAL;
            }
        } else {
            /* Can be Hash guest (in future ?), nothing to do */
        }
    } else {
        /* Hash guest (current), nothing to do */
    }

Regards,
Bharata.
