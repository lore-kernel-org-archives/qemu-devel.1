Received: from eggs.gnu.org ([2001:4830:134:3::10]:42831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx6Yx-00081m-2E
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx6Yv-0005Co-6F
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:15:19 -0400
Date: Wed, 27 Sep 2017 17:15:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170927071508.GP12504@umbus>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287474187.9760.12052550430995757993.stgit@aravinda>
	<20170817013934.GC5509@umbus.fritz.box>
	<555e187e-38af-d897-85b7-f08364b264fd@linux.vnet.ibm.com>
	<20170822020854.GY12356@umbus.fritz.box>
	<98ef38a4-9c09-adec-6f0c-b280e5349d64@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uQ3BaAlxDi9XKvis"
Content-Disposition: inline
In-Reply-To: <98ef38a4-9c09-adec-6f0c-b280e5349d64@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--uQ3BaAlxDi9XKvis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 02:39:06PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Tuesday 22 August 2017 07:38 AM, David Gibson wrote:
>=20
> [ . . . ]
>=20
> >>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>>> index 46012b3..eee8d33 100644
> >>>> --- a/include/hw/ppc/spapr.h
> >>>> +++ b/include/hw/ppc/spapr.h
> >>>> @@ -123,6 +123,12 @@ struct sPAPRMachineState {
> >>>>       * occurs during the unplug process. */
> >>>>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> >>>> =20
> >>>> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" =
calls */
> >>>> +    target_ulong guest_machine_check_addr;
> >>>> +    bool mc_in_progress;
> >>>> +    int mc_cpu;
> >>>
> >>> mc_cpu isn't actually used yet in this patch.  In any case it and
> >>> mc_in_progress could probably be folded together, no?
> >>
> >> It is possible to fold mc_cpu and mc_in_progress together with the
> >> convention that if it is set to -1 mc is not in progress otherwise it =
is
> >> set to the CPU handling the mc.
> >>
> >>>
> >>> These values will also need to be migrated, AFAICT.
> >>
> >> I am thinking of how to handle the migration when machine check handli=
ng
> >> is in progress. Probably wait for machine check handling to complete
> >> before migrating as the error could be irrelevant once migrated to a n=
ew
> >> hardware. If that is the case we don't need to migrate these values.
> >=20
> > Ok.
>=20
> This is what I think about handling machine check during migration based
> on my understanding of the VM migration code.
>=20
> There are two possibilities here. First, migration can be initiated
> while the machine check handling is in progress. Second, A machine check
> error can happen when the migration is in progress.
>=20
> To handle the first case we can add migrate_add_blocker() call when we
> start handling the machine check error and issue migrate_del_blocker()
> when done. I think this should solve the issue.
>=20
> The second case is bit tricky. The migration has already started and
> hence migrate_add_blocker() call will fail. We also cannot wait till the
> completion of the migration to handle machine check error as the VM's
> data could be corrupt.
>=20
> Machine check errors should not be an issue when the migration is in the
> RAM copy phase as VM is still active with vCPUs running. The problem is
> when we hit a machine check when the migration is about to complete. For
> example,
>=20
> 1. vCPU2 hits a machine check error during migration.
>=20
> 2. KVM causes VM exit on vCPU2 and the NIP of vCPU2 is changed to the
> guest registered machine check handler.
>=20
> 3. The migration_completion() issues vm_stop() and hence either vCPU2 is
> never scheduled again on the source hardware or vCPU2 is preempted while
> executing the machine check handler.
>=20
> 4. vCPU2 is resumed on the target hardware and either starts or
> continues processing the machine check error. This could be a problem as
> these errors are specific to the source hardware. For instance, when the
> the guest issues memory poisoning upon such error, a clean page on the
> target hardware is poisoned while the corrupt page on source hardware is
> not poisoned.
>=20
> The second case of hitting machine check during the final phase of
> migration is rare but wanted to check what others think about it.

So, I've had a bit of a think about this.  I don't recall if these
fwnmi machine checks are expected on guest RAM, or guest IO addresses.

1) If RAM

  What exactly is the guest's notification for?  Even without
  migration, the host's free to move guest memory around in host
  memory, so it seems any hardware level poking should be done on the
  host side.

  Is it just to notify the guest that we weren't able to fully recover
  on the host side and that page may contain corrupted data?  If
  that's so then it seems resuming the handling on the destination is
  still right.  It may be new good RAM, but the contents we migrated
  could still be corrupt from the machine check event on the source.

2) If IO

  AFAICT this could only happen with VFIO passthrough devices.. but it
  shouldn't be possible to migrate if there are any of those.

Or have I missed something..

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uQ3BaAlxDi9XKvis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnLT/wACgkQbDjKyiDZ
s5IjpA/9GBZ2UIV8J9MFaZbn8wdU6MXwv/z8CvuSOx4XJj4lac5NMwIS3sXRSynp
zKCpQYcLqReVuYPpw0an4kFAscfVr3iwNVZQRlxxcHQSM65t5KJFY83NaCmI9LSA
SgDZys2To8C+0GtwtmKtBbdaeD/IArYy9aFuEXgQqzF0cU400Ubnn10dg01xKrjg
i9082eot4mKZZ6k/BAKvKTvSag3vyLYffuEsjsGtHoTicAoNC/JIG3F593WacjZP
Mqo4U55msx90KxQ3uPdoJqYLgwiXPuWUlSJg5tJJQ/Hxcyf+zM9TbrOLl9TnddT4
gXdl4s+a/IoHx/ahv/w9LsdQJIrvwlLPaP1KzcaHA0t7T7Ct74j5gTy/fUGrAJ70
p/DfqINansRjJGgeZ94Zx/v0EyoNpjLlTo7HfGklU54zionxANaBxRvjY0mFpvhI
SIwi114VlBuoauj/W3ef+Auc4jSkJ3DyG3qi0DyxMXiMdgkJux5N2b3NNYYOAVB5
coWaWhwfz+Y/SmdvHaxE8F0241UljD3CPZAl3o6UFXc0cg35mNdlJ1ShIe+IjwFA
CxgGeX6sYYZrpQmsV2np+OWDjgiXNjyNSEmTpf31XhEc+BhbfI0agLe01I1frQl/
7PksN8nHXWAkQ0GqEiNfS0p0bfwtutd8S9mxF4k8/ghpeoedpz0=
=QOkm
-----END PGP SIGNATURE-----

--uQ3BaAlxDi9XKvis--
