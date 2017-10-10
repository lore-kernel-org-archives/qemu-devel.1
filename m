Received: from eggs.gnu.org ([2001:4830:134:3::10]:38850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kTy-0004Kn-Ji
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kTx-0004UD-94
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:22 -0400
Date: Tue, 10 Oct 2017 12:36:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010013644.GA2668@umbus.fritz.box>
References: <20171009211136.31640-1-danielhb@linux.vnet.ibm.com>
	<20171009211136.31640-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20171009211136.31640-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] hw/ppc/spapr.c: abort
 unplug_request if previous unplug isn't done
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


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon, Oct 09, 2017 at 06:11:36PM -0300, Daniel Henrique Barboza wrote:
> LMB removal is completed only when the spapr_lmb_release callback
> is called after all DRCs of the dimm are detached. During this
> time, it is possible that a unplug request for the same dimm
> arrives, trying to detach DRCs that were detached by the guest
> in the first unplug_request.
>=20
> BQL doesn't help in this case - the lock will prevent any concurrent
> removal from happening until the end of spapr_memory_unplug_request
> only. What happens is that the second unplug_request ends up calling
> spapr_drc_detach in a DRC that were detached already, causing an
> assert error in spapr_drc_detach (e.g
> https://bugs.launchpad.net/qemu/+bug/1718118).
>=20
> spapr_lmb_release uses a structure called sPAPRDIMMState, stored in the
> spapr->pending_dimm_unplugs QTAIL, to track how many LMB DRCs are left
> to be detached by the guest. When there are no more DRCs left, this
> structure is deleted and the pc-dimm unplug handler is called to
> finish the process.
>=20
> This patch reuses the sPAPRDIMMState to allow unplug_request to know
> if there is an ongoing unplug process for a given dimm, aborting the
> unplug request in this case, by doing the following changes:
>=20
> - in spapr_lmb_release callback, move the dimm state removal to the
> end, after pc-dimm unplug handler. With this change we can check for
> the existence of the dimm state to see if the unplug process is
> done.
>=20
> - use spapr_pending_dimm_unplugs_find in spapr_memory_unplug_request
> to check if the dimm state exists. If positive, there is an unplug
> operation already in progress for this dimm, meaning that we should
> abort it and warn the user about it.
>=20
> Fixes: https://bugs.launchpad.net/qemu/+bug/1718118
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Thanks for the updated description.  I've applied to ppc-for-2.11.

I'm not totally certain the first change is necessary - because each
of the pieces here should be called with the BQL, I think releasing
the DIMMState should be atomic with the rest of the stuff in
spapr_lmb_release().  But it makes it more obvious what's going on
here, so that's fine anyway.

> ---
>  hw/ppc/spapr.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ff87f155d5..7f9274d57d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3054,14 +3054,13 @@ void spapr_lmb_release(DeviceState *dev)
>          return;
>      }
> =20
> -    spapr_pending_dimm_unplugs_remove(spapr, ds);
> -
>      /*
>       * Now that all the LMBs have been removed by the guest, call the
>       * pc-dimm unplug handler to cleanup up the pc-dimm device.
>       */
>      pc_dimm_memory_unplug(dev, &spapr->hotplug_memory, mr);
>      object_unparent(OBJECT(dev));
> +    spapr_pending_dimm_unplugs_remove(spapr, ds);
>  }
> =20
>  static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
> @@ -3090,6 +3089,19 @@ static void spapr_memory_unplug_request(HotplugHan=
dler *hotplug_dev,
>          goto out;
>      }
> =20
> +    /*
> +     * An existing pending dimm state for this DIMM means that there is =
an
> +     * unplug operation in progress, waiting for the spapr_lmb_release
> +     * callback to complete the job (BQL can't cover that far). In this =
case,
> +     * bail out to avoid detaching DRCs that were already released.
> +     */
> +    if (spapr_pending_dimm_unplugs_find(spapr, dimm)) {
> +        error_setg(&local_err,
> +                   "Memory unplug already in progress for device %s",
> +                   dev->id);
> +        goto out;
> +    }
> +
>      spapr_pending_dimm_unplugs_add(spapr, nr_lmbs, dimm);
> =20
>      addr =3D addr_start;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlncJCkACgkQbDjKyiDZ
s5I5OxAAv4NWI36sztAsDtPye38XIdwL1p4pldDIzhYjiwaVPpU7yFY60ppCCLCo
MdYqGa2ot9moUn6cg1Rt96BtTRpChPeeu2JnKt7fhgnzsr2fYMfc4ukixMCDQk3C
r0k6USLDclffhqb9XNpN0XFklGRQ0oKR+h378Wy6YfEkgEpI3QZ/bMiy+fFj3X+Q
jpHHN8eBKpl9MCE64ke4fHqKmbL5zx1WKzfhYZVv6xB+7wrF4m2/Xw3c2uz9kdNM
9nmMhiUOgCIWRs03ompU1Uy8H63s/ai+2dFeECB1wk9DQDp8Pjamnk2OEpwPEavw
PvW7LluUHbVPnRNpSUc4RF2fgJyWyAZL4nUxbhLUHoDn4KNhvJ9tKzuigiV4lvyU
FMf/j7rNMO0UXYiCCd8SF22wIVNdwiMzOx8Gr1e2loYExfYMr55+lfIQuwx7hHxC
VlN9VDS+G4tM1qttp6k11OdstXzYxIIj6UaEvoTtZo35M0upxZ+w6DSpE9A7/cbg
F/b4aS7rKDYwL7LkWuKQhwLMh3NQvRJ5fxQs4tZE/TuGuzd32tdh2pkyxCkcoBox
bT6iGLGdVujIsr38W7znxKB2ZgS1Gh0v96A0ZV8K1ozAfJETa9IDg9lrcMo2vY+t
8dBu1Kv0N/+p4nx4gLum6pUz7ehQgbxEs71+6LTJZzf/mC0rHtM=
=T+6n
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
