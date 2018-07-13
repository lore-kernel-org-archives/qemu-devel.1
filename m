Received: from eggs.gnu.org ([2001:4830:134:3::10]:47565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fdliK-0008Oy-Vx
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 20:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fdliJ-0000FS-N1
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 20:13:36 -0400
Date: Fri, 13 Jul 2018 10:10:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180713001023.GT22363@umbus.fritz.box>
References: <153138970964.331720.14349788349972574256.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vru7fAags9pVPvn5"
Content-Disposition: inline
In-Reply-To: <153138970964.331720.14349788349972574256.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH] ppc/xics: fix ICP reset path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>


--vru7fAags9pVPvn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018 at 12:01:49PM +0200, Greg Kurz wrote:
> Recent cleanup in commit a028dd423ee6 dropped the ICPStateClass::reset
> handler. It is now up to child ICP classes to call the DeviceClass::reset
> handler of the parent class, thanks to device_class_set_parent_reset().
> This is a better object programming pattern, but unfortunately it causes
> QEMU to crash during CPU hotplug:
>=20
> (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
> Segmentation fault (core dumped)
>=20
> When the hotplug path tries to reset the ICP device, we end up calling:
>=20
> static void icp_kvm_reset(DeviceState *dev)
> {
>     ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
>=20
>     icpc->parent_reset(dev);
>=20
> but icpc->parent_reset is NULL... This happens because icp_kvm_class_init=
()
> calls:
>=20
>     device_class_set_parent_reset(dc, icp_kvm_reset,
>                                   &icpc->parent_reset);
>=20
> but dc->reset, ie, DeviceClass::reset for the TYPE_ICP type, is
> itself NULL.
>=20
> This patch hence sets DeviceClass::reset for the TYPE_ICP type to
> point to icp_reset(). It then registers a reset handler that calls
> DeviceClass::reset. If the ICP subtype has configured its own reset
> handler with device_class_set_parent_reset(), this ensures it will
> be called first and it can then call ICPStateClass::parent_reset
> safely. This fixes the reset path for the TYPE_KVM_ICP type, which
> is the only subtype that defines its own reset function.
>=20
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Fixes: a028dd423ee6dfd091a8c63028240832bf10f671
> Signed-off-by: Greg Kurz <groug@kaod.org>

Much simpler than the previous version, thanks.

Applied to ppc-for-3.0.

> ---
>  hw/intc/xics.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index b9f1a3c97214..c90c893228dc 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -291,7 +291,7 @@ static const VMStateDescription vmstate_icp_server =
=3D {
>      },
>  };
> =20
> -static void icp_reset(void *dev)
> +static void icp_reset(DeviceState *dev)
>  {
>      ICPState *icp =3D ICP(dev);
> =20
> @@ -303,6 +303,13 @@ static void icp_reset(void *dev)
>      qemu_set_irq(icp->output, 0);
>  }
> =20
> +static void icp_reset_handler(void *dev)
> +{
> +    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
> +
> +    dc->reset(dev);
> +}
> +
>  static void icp_realize(DeviceState *dev, Error **errp)
>  {
>      ICPState *icp =3D ICP(dev);
> @@ -345,7 +352,7 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
>          return;
>      }
> =20
> -    qemu_register_reset(icp_reset, dev);
> +    qemu_register_reset(icp_reset_handler, dev);
>      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
>  }
> =20
> @@ -354,7 +361,7 @@ static void icp_unrealize(DeviceState *dev, Error **e=
rrp)
>      ICPState *icp =3D ICP(dev);
> =20
>      vmstate_unregister(NULL, &vmstate_icp_server, icp);
> -    qemu_unregister_reset(icp_reset, dev);
> +    qemu_unregister_reset(icp_reset_handler, dev);
>  }
> =20
>  static void icp_class_init(ObjectClass *klass, void *data)
> @@ -363,6 +370,7 @@ static void icp_class_init(ObjectClass *klass, void *=
data)
> =20
>      dc->realize =3D icp_realize;
>      dc->unrealize =3D icp_unrealize;
> +    dc->reset =3D icp_reset;
>  }
> =20
>  static const TypeInfo icp_info =3D {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vru7fAags9pVPvn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltH7e0ACgkQbDjKyiDZ
s5L1NRAAwrIeCdglSqYW6pXWe7Ymz8spgslJ5/WBrwuN29Mvd3YlTiKmBVRbomI9
kuuB0KfVvERmeHmrhUmkfR6vNz9GgVFkS3v+xn36pNWP9OQJ6iY2uinKqkYvMnly
32trXEUcPiKQBFsCgTocneSxgkKwv+TJQI8q7HPG9X5bit1lFQN4/zi2WXlHNzkX
/dOuBnY7YRiNCcEsD3yM8QxbXLxk/Pa9i9UueA3MKnMzT9t2I2Hp3/mDXRVhBM5s
C4CpdFUahm/4iu4BQPzyRGrmmoo0Ep8nnI0Saw3tTp0ovBhIj7iGUXzbgGbyDTfM
UzjXKHESROaGKYJsIDY6IUXtQQ7pAlhwyjzSLLn4Gl0D3mG7vvXHJODeLGR8S7MO
GgmX4mb+Zn9rCIEFWmqM8qsQwa8wraLCFqKg/0S/gWkZpMvk5OjAn6qiNKICffS6
oMSVwwWb7tbfx8h+wTeyG5WnRHYbuicq4/GBa4dvFsAsgaRizvcWFYdJFeZDcCwm
G1tZVW6zmJipnNEvOLKmH5wOAJhcO76enS7LmhZO96tnbH3efHMQhCiHPIWCdRns
nNDUZSMAqms++Eb3VIzZ+zdL33u8MAw6fdmZncX0u/0Vq/wl+Pyf4TsJ7YzQ93Xe
MKs865lqbFXsj99+/OVn8AQOQgFRGrNWjeU7hYPguFyr6CAHMtE=
=3jeC
-----END PGP SIGNATURE-----

--vru7fAags9pVPvn5--
