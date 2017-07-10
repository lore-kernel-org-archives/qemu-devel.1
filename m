Received: from eggs.gnu.org ([2001:4830:134:3::10]:53022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUSMN-0002sN-GX
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUSMK-0003R9-Cl
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:39:55 -0400
Date: Mon, 10 Jul 2017 16:39:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170710063910.GB4083@umbus.fritz.box>
References: <20170707212037.24642-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20170707212037.24642-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC drcVI PATCH] spapr: reset DRCs on migration
 pre_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2017 at 06:20:37PM -0300, Daniel Henrique Barboza wrote:
> "spapr: Remove 'awaiting_allocation' DRC flag" removed the flag that
> was originally was being used to prevent a race condition between
> hot unplug and hotplug. The DRC code base got simplified and more
> robust over time, eliminating the conditions that led to this race.
> Thus the awaiting_allocation existence wasn't justifiable anymore.
>=20
> A side effect of the flag removal was seen when testing the Libvirt
> hotplug-migration-unplug scenario, where a device is hotplugged in both
> source and target using device_add prior to the migration, then the
> device is removed after migration in the target. Before that cleanup, the
> hot unplug at the target fails in both QEMU and guest kernel because
> the DRC state at the target is inconsistent. After removing that flag,
> the hot unplug works at QEMU but the guest kernel hungs on the middle
> of the unplug process.
>=20
> It turns out that the awaiting_allocation logic was preventing the hot
> unplug from happening at the target because the DRC state, at this specif=
ic
> hot unplug scenario, was matching the race condition the flag was
> originally designed to avoid. Removing the flag allowed the device
> to be removed from QEMU, leading to this new behavior.
>=20
> The root cause of those problems is, in fact, the inconsistent state of t=
he
> target DRCs after migration is completed. Doing device_add in the
> INMIGRATE status leaves the DRC in a state that isn't recognized as a
> valid hotplugged device in the guest OS.
>=20
> This patch fixes the problem by using the recently modified 'drc_reset'
> function, that now forces the DRC to a known state by checking its device
> status, to reset all DRCs in the pre_load hook of the migration. Resetting
> the DRCs in pre_load allows the DRCs to be in a predictable state when
> we load the migration at the target, allowing for hot unplugs to work
> as expected.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Ok, so the fact this works is pretty promising.  However, I'm still
trying to fully understand what's going on here.  I have a suspicion
that this is only necessary because something isn't quite right with
the reset / inmigrate sequencing in the generic code, which we should
fix instead of hacking around.

IIUC, in the problem case, on the source the hotplug has fully
completed, so the DRC will be in CONFIGURED state.  Since the device
is CONFIGURED and attached, no DRC info is sent in the migration
stream.  On the destination what seems to be happening is:

1. qemu is started with "-incoming defer", and cpu *not* present

    DRC is uninitialized

2. qemu_system_reset() is called in vl.c

    DRC is in UNALLOCATED / detached state

3. libvirt device_adds the cpu

    DRC is in UNALLOCATED / attached state

4. libvirt initiates incoming migration

    DRC remains in UNALLOCATED / attached state

5. Guest resumes on the destination

    DRC still in UNALLOCATED / attached state

Which mismatches what we had on the source so =3D> bug.

BUT, AFAIK the libvirt coldplug case below *is* working.  Which
tracing through the code I'd expect:

1. qemu is started with -S and cpu not present

   DRC is uninitialized

2. qemu_system_reset() is called in vl.c

   DRC is in UNALLOCATED / detached state

3. libvirt device_adds in prelaunch phase

   DRC is in UNALLOCATED / attached state

4. Guest is started

   DRC is in UNALLOCATED / attached state

Which is also incorrect: the device was present when the guest
started, so it should be in CONFIGURED state.  IIUC this case is
working, so I think it is must actually be in CONFIGURED state.

So, I'm trying to understand why we get different results in these two
cases.

[Aside:

If we do need to manually trigger a reset, code like the below is
basically what we need.  Just putting a reset in each DRC's pre_load
looks neater, but won't work - the pre_load won't be called unless the
object actually appears in the migration stream, and IIUC the case
which isn't working is exactly the case where the object is omitted
=66rom the migration stream.]

> ---
>  hw/ppc/spapr.c             |  7 +++++++
>  hw/ppc/spapr_drc.c         | 17 +++++++++++++++++
>  include/hw/ppc/spapr_drc.h |  1 +
>  3 files changed, 25 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 089d41d..aea85b0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1473,6 +1473,12 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error =
**errp)
>      }
>  }
> =20
> +static int spapr_pre_load(void *opaque)
> +{
> +    spapr_reset_all_drcs();
> +    return 0;
> +}
> +
>  static int spapr_post_load(void *opaque, int version_id)
>  {
>      sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> @@ -1598,6 +1604,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
>      .minimum_version_id =3D 1,
> +    .pre_load =3D spapr_pre_load,
>      .post_load =3D spapr_post_load,
>      .fields =3D (VMStateField[]) {
>          /* used to be @next_irq */
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 63637d8..74f3957 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -449,6 +449,23 @@ static void drc_reset(void *opaque)
>      drc->ccs_depth =3D -1;
>  }
> =20
> +void spapr_reset_all_drcs(void)
> +{
> +    Object *drc_container, *obj;
> +    ObjectProperty *prop;
> +    ObjectPropertyIterator iter;
> +
> +    drc_container =3D container_get(object_get_root(), DRC_CONTAINER_PAT=
H);
> +    object_property_iter_init(&iter, drc_container);
> +    while ((prop =3D object_property_iter_next(&iter))) {
> +        if (!strstart(prop->type, "link<", NULL)) {
> +            continue;
> +        }
> +        obj =3D object_property_get_link(drc_container, prop->name, NULL=
);
> +        drc_reset(SPAPR_DR_CONNECTOR(obj));
> +    }
> +}
> +
>  static bool spapr_drc_needed(void *opaque)
>  {
>      sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 4c54864..c7553e6 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -250,4 +250,5 @@ static inline bool spapr_drc_unplug_requested(sPAPRDR=
Connector *drc)
>      return drc->unplug_requested;
>  }
> =20
> +void spapr_reset_all_drcs(void);
>  #endif /* HW_SPAPR_DRC_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZYyEIAAoJEGw4ysog2bOSBZ0QALJQDytsrdcH2CHSC8lE0izT
DttDtzs69Y7ZBENf15vv1LAaKkPgOJjM/9QhjXu0giEeJWEIEOEEKUYU+0nr1Hzs
GNIHZokAPo2wcSTSl+GQv7H6DKgnKqYHy66WfdOkWXgfC8vNj5XmwvCfWxteKgZO
uBcUdPlzzko6ayimZ4gGMZEdtvAW6u7Lg2/3PeCdMb5n65voJxBdnIwKlmOOyRwC
xMqa8sGaB7OCZ8PKvZC3QBh/hFwTIeHydqR5YBq6ma/m71KkH5yal5zWIRapTJoc
JrHHgyb+pFCYnGggpC9ark1yVvKROc/qy3NZ95h+5nrc8BUF65FTJqZNwm3AaC2k
4D6Nor0fG1KUp/HJ00KELOV+3+MJWkGjpoj3+JvK6zJ/Z0Zxrc7dF9gcgjQijK3T
KlXnnZ5SAy4+kxyaHQ4BFVqRAhggEW5jPjjM4QI3hcDSdD6fY0inXr/sARTN1nAC
PnKBq4KdHUlHBSH5FBdSDQaxItr/2SYRJd8TG26QYO7CQXe5fgrC+A5tAGgGQhKb
MUsU6/9KKQG2AM+JHfx4yOdXVtOkmxZLTZeL9nPqH8FDUbhYblNgX4NFaykO4NZm
JPm14ml4s9RG214dRiSw74/i73WDWBr/v///HH6H9jGgOalYq2VhaUg/dLyZ1Q91
pHDuzns0CRc5Br2e42u4
=Dy3M
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
