Received: from eggs.gnu.org ([2001:4830:134:3::10]:47814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R4-0005fA-Fi
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R0-0006ne-JE
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:22 -0400
Date: Fri, 12 May 2017 16:11:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512061128.GG12908@umbus.fritz.box>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-4-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <20170505204746.14116-4-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v9 3/6] hw/ppc: migrating the DRC state of
 hotplugged devices
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


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 05:47:43PM -0300, Daniel Henrique Barboza wrote:
> In pseries, a firmware abstraction called Dynamic Reconfiguration
> Connector (DRC) is used to assign a particular dynamic resource
> to the guest and provide an interface to manage configuration/removal
> of the resource associated with it. In other words, DRC is the
> 'plugged state' of a device.
>=20
> Before this patch, DRC wasn't being migrated. This causes
> post-migration problems due to DRC state mismatch between source and
> target. The DRC state of a device X in the source might
> change, while in the target the DRC state of X is still fresh. When
> migrating the guest, X will not have the same hotplugged state as it
> did in the source. This means that we can't hot unplug X in the
> target after migration is completed because its DRC state is not consiste=
nt.
> https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1677552 is one
> bug that is caused by this DRC state mismatch between source and
> target.
>=20
> To migrate the DRC state, we defined the VMStateDescription struct for
> spapr_drc to enable the transmission of spapr_drc state in migration.
> Not all the elements in the DRC state are migrated - only those
> that can be modified by guest actions or device add/remove
> operations:
>=20
> - 'isolation_state', 'allocation_state' and 'indicator_state'
> are involved in the DR state transition diagram from
> PAPR+ 2.7, 13.4;
>=20
> - 'configured', 'signalled', 'awaiting_release' and 'awaiting_allocation'
> are needed in attaching and detaching devices;
>=20
> - 'indicator_state' provides users with hardware state information.
>=20
> These are the DRC elements that are migrated.
>=20
> In this patch the DRC state is migrated for PCI, LMB and CPU
> connector types. At this moment there is no support to migrate
> DRC for the PHB (PCI Host Bridge) type.
>=20
> In the 'realize' function the DRC is registered using vmstate_register,
> similar to what hw/ppc/spapr_iommu.c does in 'spapr_tce_table_realize'.
> This approach works because  DRCs are bus-less and do not sit
> on a BusClass that implements bc->get_dev_path, so as a fallback the
> VMSD gets identified via "spapr_drc"/get_index(drc).
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_drc.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 1c72160..926b945 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -519,6 +519,65 @@ static void reset(DeviceState *d)
>      }
>  }
> =20
> +static bool spapr_drc_needed(void *opaque)
> +{
> +    sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
> +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +    bool rc =3D false;
> +    sPAPRDREntitySense value;

Blank line after the declarations, please.

> +    drck->entity_sense(drc, &value);
> +    /* If no dev is plugged in there is no need to migrate the DRC state=
 */
> +    if (value !=3D SPAPR_DR_ENTITY_SENSE_PRESENT) {
> +        return false;
> +    }
> +
> +    /*
> +     * If there is dev plugged in, we need to migrate the DRC state when
> +     * it is different from cold-plugged state
> +     */
> +    switch (drc->type) {
> +

No blank line here please.

> +    case SPAPR_DR_CONNECTOR_TYPE_PCI:
> +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_U=
NISOLATED) &&
> +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
SABLE) &&
> +               drc->configured && drc->signalled && !drc->awaiting_relea=
se);

You don't do any more manipulation of the rc value, so you might as
well just 'return' directly here.


> +        break;
> +
> +    case SPAPR_DR_CONNECTOR_TYPE_LMB:
> +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_I=
SOLATED) &&
> +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
NUSABLE) &&
> +               drc->configured && drc->signalled && !drc->awaiting_relea=
se);
> +        break;
> +
> +    case SPAPR_DR_CONNECTOR_TYPE_CPU:
> +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_I=
SOLATED) &&
> +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
NUSABLE) &&
> +                drc->configured && drc->signalled && !drc->awaiting_rele=
ase);
> +        break;
> +
> +    default:
> +        ;

This should probably assert().

> +    }
> +    return rc;
> +}
> +
> +static const VMStateDescription vmstate_spapr_drc =3D {
> +    .name =3D "spapr_drc",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_drc_needed,
> +    .fields  =3D (VMStateField []) {
> +        VMSTATE_UINT32(isolation_state, sPAPRDRConnector),
> +        VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
> +        VMSTATE_UINT32(indicator_state, sPAPRDRConnector),
> +        VMSTATE_BOOL(configured, sPAPRDRConnector),
> +        VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
> +        VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
> +        VMSTATE_BOOL(signalled, sPAPRDRConnector),

Hrm.  I'm happy translation the 3 state integers, since their meaning
is in the PAPR spec.  The others are qemu local information, so it's
not as clear that they'll have a stable meaning.  Are you absolutely
sure you need all of them?

> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void realize(DeviceState *d, Error **errp)
>  {
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> @@ -547,6 +606,8 @@ static void realize(DeviceState *d, Error **errp)
>          object_unref(OBJECT(drc));
>      }
>      g_free(child_name);
> +    vmstate_register(DEVICE(drc), drck->get_index(drc), &vmstate_spapr_d=
rc,
> +                     drc);
>      trace_spapr_drc_realize_complete(drck->get_index(drc));
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFVIQAAoJEGw4ysog2bOSOwAP/Rch40LzBp6B9O2H74kRbndk
DtX7aFN2wdpNqcouQFOQKMGyykimdu/9OMJxsaDF6rVYwBH8K+5infTDo7LgnG9B
xWqkBOnlMGKd2lePVjGCNQJGAC+7lJB/o2FT2IZomdZsA9JNuUIzRC/L3UBRf16e
lykHesWk9zClTrqXgX6O6Ccd6D/iuMiKNSkvjojzC5u2b+VwvBWdoRhVIFkwXUUG
bi97N3ScI/oD+NrRyVvpWoCfc1CLa3gOxkUPNMPQ2slS3bR+3AY+Gw5tdUM9YIl2
y5zm1qjOk1pNE30l89Z9VL49/y+Xhl4rotqvOwroiUeHhsdtY6NnLM9M5bwt6czM
ozXMAnI/x7vT40MJSU3FXt7tYKcA+vdGX/wzBTEC8NVii773dY0IQwIXwIOzVq5q
F3V2SPfkOV9RhL8wxESmsxqJQP45bGMi1Y6ziwVbJN2ya7A27/5GgDSLE/HZmTKS
3w9Ymp3i/Mal3eQQihFlOF+VGbEfFzNTzrv/dQI8MlXE4UkpznbmlxbK3S1s1ozF
ZK+UTZ4JQlqtg1g8oaB+KUMXhrWU5cBg/w++T1vblgWl8nu2DD5AsUYjdBpiS3Kt
Qe2xfkKZht6BHX8EnwOBILRqKUFkGUQFy+nmC1v7uaCb/CfR7Ss++HFOQvBZr8BC
HMinjPN5YbPS67nZnyU5
=qSds
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
