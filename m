Received: from eggs.gnu.org ([2001:4830:134:3::10]:52653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkjHe-0006tz-37
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkjHb-0004Fd-1e
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:58:18 -0400
Date: Thu, 24 Aug 2017 13:57:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824035730.GE5379@umbus.fritz.box>
References: <1503546752-24569-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3rxX7Uty8SZY8iU1"
Content-Disposition: inline
In-Reply-To: <1503546752-24569-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] hw/ppc/spapr_cpu_core: Add a
 proper check for spapr machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--3rxX7Uty8SZY8iU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 05:52:32AM +0200, Thomas Huth wrote:
> QEMU currently crashes when the user tries to add a spapr-cpu-core
> on a non-pseries machine:
>=20
> $ qemu-system-ppc64 -S -machine ppce500,accel=3Dtcg \
>                     -device POWER5+_v2.1-spapr-cpu-core
> hw/ppc/spapr_cpu_core.c:178:spapr_cpu_core_realize_child:
> Object 0x55cee1f55160 is not an instance of type spapr-machine
> Aborted (core dumped)
>=20
> So let's add a proper check for the correct machine time with
> a more friendly error message here.
>=20
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.11, thanks.

> ---
>  v2:
>  - Add the check to spapr_cpu_core_realize() instead of adding it to
>    spapr_cpu_core_realize_child()
>  - Use device/machine whitelist for the device-crash-test instead of
>    adding a log entry there
>=20
>  hw/ppc/spapr_cpu_core.c   | 5 +++++
>  scripts/device-crash-test | 3 +++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ea278ce..dd92326 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -220,6 +220,11 @@ static void spapr_cpu_core_realize(DeviceState *dev,=
 Error **errp)
>      void *obj;
>      int i, j;
> =20
> +    if (!object_dynamic_cast(qdev_get_machine(), TYPE_SPAPR_MACHINE)) {
> +        error_setg(errp, "spapr-cpu-core needs a pseries machine");
> +        return;
> +    }
> +
>      sc->threads =3D g_malloc0(size * cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
>          char id[32];
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index 81d65b9..043b24a 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -160,6 +160,9 @@ ERROR_WHITELIST =3D [
>      {'machine':'q35|pc.*', 'device':'kvm-ioapic', 'expected':True}, # On=
ly 1 ioapics allowed
>      {'machine':'q35|pc.*', 'device':'ioapic', 'expected':True},     # On=
ly 1 ioapics allowed
> =20
> +    # "spapr-cpu-core needs a pseries machine"
> +    {'machine':'(?!pseries).*', 'device':'.*-spapr-cpu-core', 'expected'=
:True},
> +
>      # KVM-specific devices shouldn't be tried without accel=3Dkvm:
>      {'accel':'(?!kvm).*', 'device':'kvmclock', 'expected':True},
>      {'accel':'(?!kvm).*', 'device':'kvm-pci-assign', 'expected':True},

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3rxX7Uty8SZY8iU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmeTqkACgkQbDjKyiDZ
s5JsLw//SIo9RhGjcbj9yN9Myx/9a19Fx5okMYAIup0vt/0dd3tVYYOLz2Jj4N8G
z07RqgiRnU5KsIr9YNOQq/4fhm+6U/uWzIZkqwNENUFPdUjyQbUYxthqkXcERsiz
Mz5N+Ytlmv5ppw1Kbd+cf3wtrFyBTiFedcICv7sH9T6goVeaC9OmGc0Q1rN6JXUo
mrhkKFkuDI8DRzP/b0XFGSaAuD0BEWEv1YfPnah3EvPy6ZXhtBAp/FDq11F1jHQ+
z8BI69kCURhsC+WQ/HOmlqgK+MtOvqYc2pKrxk3xydR0d0BLVzay0iVf+fspNr3I
l5MenA52PIXHUbv9cHxOe+Tn5a813PDfNMicOsOt7MHiBHxgFFYxtC+StbXFigHB
KrdGlvkO5IqElh1om3zvaKbZifVTVggj8E9Lewlq3x7nQHdcSOKguq61KCrRxSvw
BW4rAOBi9JWzY2m978ZnsLM87uRgj53k4wLm8jdmhK1VaL1WTZvz4MT6z8qkFtXu
TefNeHq7/WJ5ruz9U5Un469IUKpgKN1CxGK6aHQoFB7eicnkwE+Zd6F9vhOVT3ZG
HpQIAg1/XUso1Mxj16h5UQOqQAcoomzOySQNGLPS8yTrTvxxsQsUnB8TL/GumsOC
Dpi9GBZdrw8w3fsiWk0bwdKkviLOHOZJjtGU6drdWZujD5eEvyw=
=m1N2
-----END PGP SIGNATURE-----

--3rxX7Uty8SZY8iU1--
