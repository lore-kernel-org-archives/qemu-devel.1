Received: from eggs.gnu.org ([2001:4830:134:3::10]:46306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcIr-0003ky-GS
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcIo-00004z-CK
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:09:21 -0400
Date: Fri, 15 Jun 2018 09:59:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614235955.GB4129@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901302718.252222.18367624313137740494.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <152901302718.252222.18367624313137740494.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/5] spapr_cpu_core: fix potential leak in
 spapr_cpu_core_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 11:50:27PM +0200, Greg Kurz wrote:
> Commit 94ad93bd97684 (QEMU 2.12) switched to instantiate CPUs separately
> but it missed to adapt the error path accordingly. If something fails in
> the CPU creation loop, then the CPU object that was just created is leake=
d.
>=20
> The error paths in this function are a bit obfuscated, and adding
> yet another label to free this CPU object makes it worse. We should
> move the block of the loop to a separate function, with a proper
> rollback path, but this is a bigger cleanup.
>=20
> For now, let's just fix the bug by adding the missing calls to
> object_unref(). This will allow easier backport to older QEMU
> versions.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/spapr_cpu_core.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 27602245fd55..003c4c5a79d2 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -201,6 +201,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>          cs->cpu_index =3D cc->core_id + i;
>          spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
>          if (local_err) {
> +            object_unref(obj);
>              goto err;
>          }
> =20
> @@ -212,6 +213,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>          object_property_add_child(OBJECT(sc), id, obj, &local_err);
>          g_free(id);
>          if (local_err) {
> +            object_unref(obj);
>              goto err;
>          }
>          object_unref(obj);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjAXoACgkQbDjKyiDZ
s5KP9BAAy0+kKqDGLgOp+JhrhZANN3U+J2YoIQF70Ld1qgu1GbCcWfyPHL8TloY0
jMiFry55v6IY/O1nByYEaWafieslKK7SAC1TzhDsjJnQu4ppttThi4bB1BGL6FaS
GxnG+1XBrPGNSl7+3U4SS71BpiKY2+mfDcsF+utlY+FvCtUtOf6aGVt0qQ6U8rSD
4i5vQJ9sqroAZyzzypeQuvbacFhbemFNMMQT2FbN7YSiU5fddsi9m42qE/iKkIy8
1dSpx4yrf6e9nejsNMbbOKF9fP9Ks5PxXoibhK7gxJ+YGd/uQnnL3bEiysQ8bAfo
jPPrGdeR8CQA4QSD0j5g5t5GaxYVM4hTA/TU0DcH5BuhV2RscaM9UfRfbMUqz6at
ZWIPr158dAaNZDpW3bDuv4i6OFUfoKfi+HOLBCgkvD5gycfpKVuqgvBKrYspRsZS
gRCvT4UERNZwrti3YqFU7aVrRBwE4jGbIM9q6ZHBIQmA4nHx8beBB5FNQv8smTG2
HKO59MwDm8FEDMruDZX+Y4HPOupghyN0RyKs1YKxG3HHf5WPWHyBk048YgEoo35I
Gn3fPUYNJIihXrAnCOVd9X8Rs+MF0BIpsAzERFKbZmTDDquP/AYo8752UAPlr2WH
Q3U36YLPWz9TwbuoFSQTebaJ3jcCIeGM3vsiDVCKHklqAgRQGa8=
=1BSf
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
