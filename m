Received: from eggs.gnu.org ([2001:4830:134:3::10]:57586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVnce-0005Li-TL
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 20:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVncd-0006MU-Ir
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 20:38:48 -0400
Date: Thu, 21 Jun 2018 10:36:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621003656.GA32328@umbus.fritz.box>
References: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
	<1529500053-21704-3-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1529500053-21704-3-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/6] hw/boards: Add a MachineState parameter
 to kvm_type callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, dgilbert@redhat.com, agraf@suse.de, drjones@redhat.com, wei@redhat.com, suzuki.poulose@arm.com


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 03:07:29PM +0200, Eric Auger wrote:
1;5202;0c> On ARM, the kvm_type will be resolved by querying the KVMState.
> Let's add the MachineState handle to the callback so that we
> can retrieve the  KVMState handle. in kvm_init, when the callback
> is called, the kvm_state variable is not yet set.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  accel/kvm/kvm-all.c   | 2 +-
>  hw/ppc/mac_newworld.c | 2 +-
>  hw/ppc/mac_oldworld.c | 2 +-
>  hw/ppc/spapr.c        | 2 +-
>  include/hw/boards.h   | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ffee68e..0590986 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1550,7 +1550,7 @@ static int kvm_init(MachineState *ms)
> =20
>      kvm_type =3D qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
>      if (mc->kvm_type) {
> -        type =3D mc->kvm_type(kvm_type);
> +        type =3D mc->kvm_type(ms, kvm_type);
>      } else if (kvm_type) {
>          ret =3D -EINVAL;
>          fprintf(stderr, "Invalid argument kvm-type=3D%s\n", kvm_type);
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 744acdf..1409d9e 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -492,7 +492,7 @@ static void ppc_core99_init(MachineState *machine)
>      qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
>  }
> =20
> -static int core99_kvm_type(const char *arg)
> +static int core99_kvm_type(MachineState *ms, const char *arg)
>  {
>      /* Always force PR KVM */
>      return 2;
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 4608bab..1211fcd 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -363,7 +363,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
>  }
> =20
> -static int heathrow_kvm_type(const char *arg)
> +static int heathrow_kvm_type(MachineState *ms, const char *arg)
>  {
>      /* Always force PR KVM */
>      return 2;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f59999d..faf078e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2834,7 +2834,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>      }
>  }
> =20
> -static int spapr_kvm_type(const char *vm_type)
> +static int spapr_kvm_type(MachineState *ms, const char *vm_type)
>  {
>      if (!vm_type) {
>          return 0;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ef7457f..78f90a1 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -170,7 +170,7 @@ struct MachineClass {
>      void (*init)(MachineState *state);
>      void (*reset)(void);
>      void (*hot_add_cpu)(const int64_t id, Error **errp);
> -    int (*kvm_type)(const char *arg);
> +    int (*kvm_type)(MachineState *ms, const char *arg);
> =20
>      BlockInterfaceType block_default_type;
>      int units_per_default_bus;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsq8yUACgkQbDjKyiDZ
s5Kq3g/+IxbVReMLAbG4RO+aldpkcs/GZqoDwq+QmQ08f3PWdF84Pm7yJHHmtX3G
HOOuXFEImplbWxhu3PVTvrir9MxO7uWqFwga/7s9kTjt19p+WOnsBt+7rQYaqgDp
wTxHtEmNeAjWR9Do4RQXpHq/l4NXVXiBlUQMTfmdjtia5HEB3zNbHlr6K0udt3Ey
kAu5Dy76dnKjiprucFVb1xSK9SM5ONjExgtSzFXpB4JPH7/Lq0jIqiKHApSGu6ZV
Hh1qdUpFbtNwFWRMqG5HEtw7TYAD86WXyVWfIVIxupIGH3PcaeM3Tkj0yBgL+5Sy
amorhzGquYMR3lupnKXGcZ/XX4fB5Iu3OdUmiPOCyE25O9QT5BMJEMV7kUWSotho
fki63HC2mNW6KLdphBx7a9MMmSFJYj7A4tbEXx/sMlOyVAhIbQNeEdtPrDbFEBuW
YY05U05jNuG1wQg/eH4ktnoACpqRC4Fu1fL99jmLbvCmAF1xInAeMwdH27q0kpD+
tPPWiKUXyxCxkiBNOkNXRDZGaApsA7FaDRGBh9WXww9Ol04zVGQa0IWptbsuKzJC
wCF05+gWJYuEHxLruWLb38u9L0q4X2Fw3Qj233iXrpV8JSp1W1/RE/U5O7jraFae
LBJxLSJns6oYqsxkr9ojyH5UZhO8KhjEzhPipvSFJsJ7X5XSpY4=
=xsrl
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
