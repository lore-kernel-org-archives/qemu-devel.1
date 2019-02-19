Received: from eggs.gnu.org ([209.51.188.92]:49696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvvcn-0004Aj-10
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 21:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvvcl-0001WY-4I
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 21:59:12 -0500
Date: Tue, 19 Feb 2019 13:55:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219025500.GN9345@umbus.fritz.box>
References: <20190218181349.23885-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vDEbda84Uy/oId5W"
Content-Disposition: inline
In-Reply-To: <20190218181349.23885-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Greg Kurz <groug@kaod.org>, Prasad J Pandit <pjp@fedoraproject.org>


--vDEbda84Uy/oId5W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 11:43:49PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> On ppc hosts, hypervisor shares following system attributes
>=20
>   - /proc/device-tree/system-id
>   - /proc/device-tree/model
>=20
> with a guest. This could lead to information leakage and misuse.[*]
> Add machine attributes to control such system information exposure
> to a guest.
>=20
> [*] https://wiki.openstack.org/wiki/OSSN/OSSN-0028
>=20
> Reported-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Fix-suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Applied to ppc-for-4.0, thanks.

> ---
>  hw/ppc/spapr.c         | 76 ++++++++++++++++++++++++++++++++++++++----
>  include/hw/ppc/spapr.h |  2 ++
>  2 files changed, 72 insertions(+), 6 deletions(-)
>=20
> Update v4: remove NULL initializations in spapr_instance_init()
>   -> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04554.html
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0942f35bf8..8786c4c4ca 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1249,13 +1249,30 @@ static void *spapr_build_fdt(sPAPRMachineState *s=
papr,
>       * Add info to guest to indentify which host is it being run on
>       * and what is the uuid of the guest
>       */
> -    if (kvmppc_get_host_model(&buf)) {
> -        _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
> -        g_free(buf);
> +    if (spapr->host_model && !g_str_equal(spapr->host_model, "none")) {
> +        if (g_str_equal(spapr->host_model, "passthrough")) {
> +            /* -M host-model=3Dpassthrough */
> +            if (kvmppc_get_host_model(&buf)) {
> +                _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
> +                g_free(buf);
> +            }
> +        } else {
> +            /* -M host-model=3D<user-string> */
> +            _FDT(fdt_setprop_string(fdt, 0, "host-model", spapr->host_mo=
del));
> +        }
>      }
> -    if (kvmppc_get_host_serial(&buf)) {
> -        _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
> -        g_free(buf);
> +
> +    if (spapr->host_serial && !g_str_equal(spapr->host_serial, "none")) {
> +        if (g_str_equal(spapr->host_serial, "passthrough")) {
> +            /* -M host-serial=3Dpassthrough */
> +            if (kvmppc_get_host_serial(&buf)) {
> +                _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
> +                g_free(buf);
> +            }
> +        } else {
> +            /* -M host-serial=3D<user-string> */
> +            _FDT(fdt_setprop_string(fdt, 0, "host-serial", spapr->host_s=
erial));
> +        }
>      }
> =20
>      buf =3D qemu_uuid_unparse_strdup(&qemu_uuid);
> @@ -3138,6 +3155,36 @@ static void spapr_set_ic_mode(Object *obj, const c=
har *value, Error **errp)
>      }
>  }
> =20
> +static char *spapr_get_host_model(Object *obj, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return g_strdup(spapr->host_model);
> +}
> +
> +static void spapr_set_host_model(Object *obj, const char *value, Error *=
*errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    g_free(spapr->host_model);
> +    spapr->host_model =3D g_strdup(value);
> +}
> +
> +static char *spapr_get_host_serial(Object *obj, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return g_strdup(spapr->host_serial);
> +}
> +
> +static void spapr_set_host_serial(Object *obj, const char *value, Error =
**errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    g_free(spapr->host_serial);
> +    spapr->host_serial =3D g_strdup(value);
> +}
> +
>  static void spapr_instance_init(Object *obj)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -3183,6 +3230,17 @@ static void spapr_instance_init(Object *obj)
>      object_property_set_description(obj, "ic-mode",
>                   "Specifies the interrupt controller mode (xics, xive, d=
ual)",
>                   NULL);
> +
> +    object_property_add_str(obj, "host-model",
> +        spapr_get_host_model, spapr_set_host_model,
> +        &error_abort);
> +    object_property_set_description(obj, "host-model",
> +        "Set host's model-id to use - none|passthrough|string", &error_a=
bort);
> +    object_property_add_str(obj, "host-serial",
> +        spapr_get_host_serial, spapr_set_host_serial,
> +        &error_abort);
> +    object_property_set_description(obj, "host-serial",
> +        "Set host's system-id to use - none|passthrough|string", &error_=
abort);
>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> @@ -4080,9 +4138,15 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_SPAPR_MACHINE, "host-model", "passthrough" },
> +        { TYPE_SPAPR_MACHINE, "host-serial", "passthrough" },
> +    };
> =20
>      spapr_machine_4_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> +
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      smc->update_dt_enabled =3D false;
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a947a0a0dc..e004a570d8 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -177,6 +177,8 @@ struct sPAPRMachineState {
> =20
>      /*< public >*/
>      char *kvm_type;
> +    char *host_model;
> +    char *host_serial;
> =20
>      const char *icp_type;
>      int32_t irq_map_nr;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vDEbda84Uy/oId5W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrcAQACgkQbDjKyiDZ
s5KhNg/+Nn2nck5t/4USBbzxOUoyHHhhg364TW+l7AlL4U4eMxxd+L2OZfyNvtUe
Q0KfBXaUScGwGZ4/2fySvvUqaU79tezhhlvRDHPDbTZfMWB9SXN1ZZOBt2aOjzKg
TPoYdVy43h8Ma6C1JzKcfKKew4YScJ9bn1JhGTZZl7sSnM1mWGLuSrlVf6CWdye+
/myh/dsV4HmtSmKePJ7DKZe1jXlnCXV1joCyfqYyydOJGr7IYopbKO6JGIMqPzet
Pam4KthldLcWConDF162cTFKTUqnQVeb2NxOK6YORJp86NZ9hjOLa7wc6I+MtCnd
iyea+wguj/TSRi6aIVbngcP1QdCGSuqlKeph1vjbDYPxJlpLhclEw/YTueVYJ/DZ
ouyyjKqVjIiznZI4iYGNU5EyjuUMGLZGG2pPDvVEPVwbpR+EPVQiZGNqdhSDBoW1
PK5il4smNo7VdIcTw80qbZaR6JJVHvVbLhbpsdgQ3NqTgKj2/9t0PRKPqiBQsu92
xz2Q+cvDTFptSwPeLDZkVuP+tCs27ZfnipUgCqYy6dpvhsn48kZCuboobW7UghHf
EtIwr9xbSSLHraGgcQrGliBy50kRoHAIbd6pInp0E1ioFhDPhvIJFMD5oulNJZfK
JF5g2pXR9G+HNdOSnah6UHM+XgQ/IKhLQoCjHSMXOqAIuP7W94M=
=StOi
-----END PGP SIGNATURE-----

--vDEbda84Uy/oId5W--
