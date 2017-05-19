Received: from eggs.gnu.org ([2001:4830:134:3::10]:48178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBcQl-0001XA-FQ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBcQh-0004S3-BO
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:34:35 -0400
Date: Fri, 19 May 2017 17:33:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170519073303.GK12284@umbus.fritz.box>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-2-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LHvWgpbS7VDUdu2f"
Content-Disposition: inline
In-Reply-To: <1495172439-1504-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/4] migration: Introduce
 unregister_savevm_live()
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


--LHvWgpbS7VDUdu2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 11:10:36AM +0530, Bharata B Rao wrote:
> Introduce a new function unregister_savevm_live() to unregister the vmsta=
te
> handlers registered via register_savevm_live().
>=20
> register_savevm() allocates SaveVMHandlers while register_savevm_live()
> gets passed with SaveVMHandlers. During unregistration, we  want to
> free SaveVMHandlers in the former case but not free in the latter case.
> Hence this new API is needed to differentiate this.
>=20
> This new API will be needed by PowerPC to unregister the HTAB savevm
> handlers.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I could take this through my tree, but it would need an ACK from Dave
Gilbert or Juan Quintela.

> ---
>  include/migration/vmstate.h |  1 +
>  migration/savevm.c          | 17 +++++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 8489659..02a1bac 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -79,6 +79,7 @@ int register_savevm_live(DeviceState *dev,
>                           void *opaque);
> =20
>  void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque=
);
> +void unregister_savevm_live(DeviceState *dev, const char *idstr, void *o=
paque);
> =20
>  typedef struct VMStateInfo VMStateInfo;
>  typedef struct VMStateDescription VMStateDescription;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f5e8194..4ef6fdc 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -630,7 +630,8 @@ int register_savevm(DeviceState *dev,
>                                  ops, opaque);
>  }
> =20
> -void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
> +static void unregister_savevm_common(DeviceState *dev, const char *idstr,
> +                                     void *opaque, bool free_savevmhandl=
ers)
>  {
>      SaveStateEntry *se, *new_se;
>      char id[256] =3D "";
> @@ -649,12 +650,24 @@ void unregister_savevm(DeviceState *dev, const char=
 *idstr, void *opaque)
>          if (strcmp(se->idstr, id) =3D=3D 0 && se->opaque =3D=3D opaque) {
>              QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
>              g_free(se->compat);
> -            g_free(se->ops);
> +            if (free_savevmhandlers) {
> +                g_free(se->ops);
> +            }
>              g_free(se);
>          }
>      }
>  }
> =20
> +void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
> +{
> +    unregister_savevm_common(dev, idstr, opaque, true);
> +}
> +
> +void unregister_savevm_live(DeviceState *dev, const char *idstr, void *o=
paque)
> +{
> +    unregister_savevm_common(dev, idstr, opaque, false);
> +}
> +
>  int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
>                                     const VMStateDescription *vmsd,
>                                     void *opaque, int alias_id,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LHvWgpbS7VDUdu2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHp+sAAoJEGw4ysog2bOS260P+gP5NksLsPBHcDLqQeQfYqj3
HSfeBV/X1EOVTbsa6AGxlNvLSOtzy2cPaLafBmKiUXzkhIUzRHQf/TG+zNjFIcN6
ij6LAwb23NVAWFr+UELhyg5/8bRDLzar/WxmpgRH6Qf6qnEZn7MTkMBGipmRtNTL
1j2NVKXBmvbJ+LEfZzrm7Hqh3MvD70Yd3BGt82qh75gaD4WjG6x1aL4vAF7ffQ3d
pbae2o7TtgdQ3PK4xkHu7Mg2FJ4VRIfFcLW7PCku7dDpfV/+4YL4wNoJFvQbv72r
xbr9IOHyFYxhRaZoLgbq7eL5cBtgJZU3CokGtJngPcMPakbAl6h+x91YSEAU1kBg
eyMiyFo+0pX0zKBdLeomM2iBzPkTKPADBC8xei5SzXhONZzq36gYxNn/Q2rXDqO9
tYzl2vzOR6exuqAk8pEyhJDR0oPhBOvmqW98jqeP1xnKcwQpVVIDob7OoQg6Isb6
Jr/sHzRZaM9z+aTRWBDRRH2MMIaCbQqC8ejH1kAzbCmDzMnBnUUv9DwfeRdhNZKr
zpOTWDPKWNhuNO7BYao+7Dsvhf/lF69NBiXMJE/LcSXokOyFt5fsSQAUayBau8Ly
OkTX9JT5nLvz6wZPaoeADNQ45kI0olo95XD9V05E0H18Ij/ikYVEvtI3TySnrl4m
oB4+a0VAlv/44jhVV9JV
=ejMi
-----END PGP SIGNATURE-----

--LHvWgpbS7VDUdu2f--
