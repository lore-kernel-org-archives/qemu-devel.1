Received: from eggs.gnu.org ([2001:4830:134:3::10]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cGrM0-0000Z3-Va
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cGrLw-0008PS-W0
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:59:05 -0500
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:57819)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cGrLw-0008P8-Mw
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:59:00 -0500
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1AAF827BCC
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 18:58:57 +0100 (CET)
Date: Tue, 13 Dec 2016 18:58:48 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161213185848.5e574a88@bahia.lan>
In-Reply-To: <20161205040916.GB32366@umbus.fritz.box>
References: <1479248275-18889-1-git-send-email-david@gibson.dropbear.id.au>
	<1479248275-18889-13-git-send-email-david@gibson.dropbear.id.au>
	<20161202154825.613bc4ad@bahia>
	<20161205040916.GB32366@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/otiJcc8O7QYb2MGMTJEOIqr";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFCv2 12/12] ppc: Rework CPU
 compatibility testing across migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, abologna@redhat.com

--Sig_/otiJcc8O7QYb2MGMTJEOIqr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Dec 2016 15:09:16 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Dec 02, 2016 at 03:48:25PM +0100, Greg Kurz wrote:
> > On Wed, 16 Nov 2016 09:17:55 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > Migrating between different CPU versions is quite complicated for ppc.
> > > A long time ago, we ensure identical CPU versions at either end by ch=
ecking
> > > the PVR had the same value.  However, this breaks under KVM HV, becau=
se
> > > we always have to use the host's PVR - it's not virtualized.  That wo=
uld
> > > mean we couldn't migrate between hosts with different PVRs, even if t=
he
> > > CPUs are close enough to compatible in practice (sometimes identical =
cores
> > > with different surrounding logic have different PVRs, so this happens=
 in
> > > practice quite often).
> > >=20
> > > So, we removed the PVR check, but instead checked that several flags
> > > indicating supported instructions matched.  This turns out to be a bad
> > > idea, because those instruction masks are not architected information=
, but
> > > essentially a TCG implementation detail.  So changes to qemu internal=
 CPU
> > > modelling can break migration - this happened between qemu-2.6 and
> > > qemu-2.7.
> > >=20
> > > Modern server-class CPUs can be placed into compatibility modes.  Now=
 that
> > > we're handling those properly, we finally have the information to san=
ely
> > > deal with CPU compatibility across migration.
> > >=20
> > > This patch bumps the migration version number for the ppc CPU removin=
g the
> > > instruction mask field (and some other unwise VMSTATE_EQUAL checks), =
and
> > > adding the compatibility PVR to the migration stream.
> > >  =20
> >=20
> > Things have changed since you posted this RFC:
> >=20
> > commit 16a2497bd44cac1856e259654fd304079bd1dcdc
> > Author: David Gibson <david@gibson.dropbear.id.au>
> > Date:   Mon Nov 21 16:28:12 2016 +1100
> >=20
> >     target-ppc: Fix CPU migration from qemu-2.6 <-> later versions
> >=20
> > and
> >=20
> > commit 146c11f16f12dbfea62cbd7f865614bb6fcbc6b5
> > Author: David Gibson <david@gibson.dropbear.id.au>
> > Date:   Mon Nov 21 16:29:30 2016 +1100
> >=20
> >     target-ppc: Allow eventual removal of old migration mistakes
> >=20
> > I guess that the version bumping isn't necessary anymore if we keep the=
se.
> >=20
> > I'll assume yes and rebase this patch against current master, simply dr=
opping
> > the version bumping and related lines. =20
>=20
> Yeah, I realised that breaking backwards migration was a bad idea, and
> with some help from Dave Gilbert worked out how to make it possible.
>=20
> I realize I'm going to have to rework my compat series in light of
> these changes.
>=20

While doing so, maybe you can fold the following in your patch, and thus
make tests/qom-test happy:

--- a/target-ppc/translate_init.c
+++ b/target-ppc/translate_init.c
@@ -32,6 +32,7 @@
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
+#include "sysemu/qtest.h"
=20
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -8442,7 +8443,9 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
 static void getset_compat_deprecated(Object *obj, Visitor *v, const char *=
name,
                                      void *opaque, Error **errp)
 {
-    error_report("CPU 'compat' property is deprecated and has no effect; u=
se max-cpu-compat machine property instead");
+    if (!qtest_enabled()) {
+        error_report("CPU 'compat' property is deprecated and has no effec=
t; use max-cpu-compat machine property instead");
+    }
     visit_type_null(v, name, errp);
 }
=20
Also a friendly reminder: cpu registers get trashed during cpu post
load (see at the end of this mail).


Cheers.

--
Greg

> > > We consider the CPUs compatible for migration if:
> > >     * The source was running in a compatibility mode which the destin=
ation
> > >       supports
> > > OR  * The source has a PVR matching the same qemu CPU class as the
> > >       destination, either an exact match or an approximate match dete=
rmined
> > >       by the cpu class's pvr_match hook.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  target-ppc/machine.c | 87 ++++++++++++++++++++++++++++++++++++++++++=
+++++-----
> > >  1 file changed, 79 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/target-ppc/machine.c b/target-ppc/machine.c
> > > index e43cb6c..25a30d5 100644
> > > --- a/target-ppc/machine.c
> > > +++ b/target-ppc/machine.c
> > > @@ -8,6 +8,7 @@
> > >  #include "helper_regs.h"
> > >  #include "mmu-hash64.h"
> > >  #include "migration/cpu.h"
> > > +#include "qapi/error.h"
> > > =20
> > >  static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
> > >  {
> > > @@ -163,6 +164,30 @@ static void cpu_pre_save(void *opaque)
> > >      }
> > >  }
> > > =20
> > > +/*
> > > + * Determine if a given PVR is a "close enough" match to the CPU
> > > + * object.  For TCG and KVM PR it would probably be sufficient to
> > > + * require an exact PVR match.  However for KVM HV the user is
> > > + * restricted to a PVR exactly matching the host CPU.  The correct w=
ay
> > > + * to handle this is to put the guest into an architected
> > > + * compatibility mode.  However, to allow a more forgiving transition
> > > + * and migration from before this was widely done, we allow migration
> > > + * between sufficiently similar PVRs, as determined by the CPU class=
's
> > > + * pvr_match() hook.
> > > + */
> > > +static bool pvr_match(PowerPCCPU *cpu, uint32_t pvr)
> > > +{
> > > +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > > +
> > > +    if (pvr =3D=3D pcc->pvr) {
> > > +        return true;
> > > +    }
> > > +    if (pcc->pvr_match) {
> > > +        return pcc->pvr_match(pcc, pvr);
> > > +    }
> > > +    return false;
> > > +}
> > > +
> > >  static int cpu_post_load(void *opaque, int version_id)
> > >  {
> > >      PowerPCCPU *cpu =3D opaque;
> > > @@ -171,10 +196,31 @@ static int cpu_post_load(void *opaque, int vers=
ion_id)
> > >      target_ulong msr;
> > > =20
> > >      /*
> > > -     * We always ignore the source PVR. The user or management
> > > -     * software has to take care of running QEMU in a compatible mod=
e.
> > > +     * If we're operating in compat mode, we should be ok as long as
> > > +     * the destination supports the same compatiblity mode.
> > > +     *
> > > +     * Otherwise, however, we require that the destination has exact=
ly
> > > +     * the same CPU model as the source.
> > >       */
> > > -    env->spr[SPR_PVR] =3D env->spr_cb[SPR_PVR].default_value;
> > > +
> > > +#if defined(TARGET_PPC64)
> > > +    if (cpu->compat_pvr) {
> > > +        Error *local_err =3D NULL;
> > > +
> > > +        ppc_set_compat(cpu, cpu->compat_pvr, &local_err); =20
> >=20
> > This calls cpu_synchronize_state(CPU(cpu)) and trashes the registers. T=
his
> > is the root cause behind the program interrupts I mentioned in another =
mail.
> >=20
> > Adding a sync_needed boolean argument to ppc_set_compat() seems to be e=
nough
> > to get this working. So I'll just do that and rerun the tests.
> >=20
> > Cheers.
> >  =20
>=20


--Sig_/otiJcc8O7QYb2MGMTJEOIqr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhQNtgACgkQAvw66wEB28LvFwCeJG4FiGoLKmC2RXbCvVIerDrH
OsgAn1DW/NXkUwDJHLrPwfJOFG5w0p1F
=WOUT
-----END PGP SIGNATURE-----

--Sig_/otiJcc8O7QYb2MGMTJEOIqr--
