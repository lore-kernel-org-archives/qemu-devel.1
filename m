Received: from eggs.gnu.org ([2001:4830:134:3::10]:35752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxI-0002mN-JT
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsxB-00048y-Vl
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:01:08 -0400
Date: Wed, 17 May 2017 16:43:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517064300.GJ15596@umbus.fritz.box>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-2-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
In-Reply-To: <1494992962-6929-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 1/6] migration: Fix
 unregister_savevm()
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


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 09:19:17AM +0530, Bharata B Rao wrote:
> In unregister_savevm(), free se->compat only if it was allocated earlier.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

I don't think this is necessary.  If se->compat was never allocated,
then it should be NULL (since se is allocated with g_new0()).
g_free() is explicitly safe to call on NULL, and we already rely on
that in qemu.

> ---
>  migration/savevm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 352a8f2..7a268ec 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -648,7 +648,9 @@ void unregister_savevm(DeviceState *dev, const char *=
idstr, void *opaque)
>      QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
>          if (strcmp(se->idstr, id) =3D=3D 0 && se->opaque =3D=3D opaque) {
>              QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
> -            g_free(se->compat);
> +            if (dev) {
> +                g_free(se->compat);
> +            }
>              g_free(se->ops);
>              g_free(se);
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG/D0AAoJEGw4ysog2bOSzNMQALih28u6u0yQzNClnA4DrhPQ
h5lLjWYXGU/adaF4YTSPNQbAPq0P7QfxYvkHyNU1Xz9zdaSnVU3Yt5aDOx3zXvIl
xa4aIF3ZmGqsKR3YSgUfXLLYpKC3J33jqD97NAc3+1ZSDIeyn2pqMs1rFrF+yDQs
dCx1tO1+f+SbHoVzs5gVAgzHhgMepWPO4Dw0MPHrI0nAKaE4FF79XF56a8gik9sJ
UAPlb5N9FupTxmQpIhnsN2dPFehWgSiTR5QMmi5gmBawRPnb7WIsnbk3ndP2Gtfk
XCln0q3CqSefQGWqTvIChQH5aFsUK95vTCwzZ/E3QR6I5Q3EnBjhPAYMxi9ZewSg
W/iX+aTkJmMT9lEO33DE3w2MQJVBb5NYUAntPUcmjtGAOwCXRr9DLVABiHu5wmQU
ousLgTZqMizk86PKThJ5vZtsPgDOm6Q2E/4K0WHe6JXxfyJz37mp2h6sfwLM3lni
ft4O0YZ8sQKZJmzrpIIiblLI+ZFsJgRDGu7ZFnGJloZWzNfCOCXyxv2rpRR36FRH
RymYcRtiD6ZuDUdBPtDX0bpFrkRNnrfxnem7Zl8cn/fX3DLEKs1QGeJwwsrKWSrQ
F44wUG6D+h3towGyMdQoE8BKnPZe3+zX5LgSim2ZWiQtTQpYQpNef2VrgLPlOnyh
UqB4NjvTMGImg+g2Fmtq
=dbD8
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
