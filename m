Received: from eggs.gnu.org ([209.51.188.92]:57017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gvhFw-0006uk-E2
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gvhFq-0004Du-Rv
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:38:38 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:56401)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gvhFl-00047y-Cm
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:38:30 -0500
Received: from player692.ha.ovh.net (unknown [10.109.160.93])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 45310184540
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 12:38:20 +0100 (CET)
Date: Mon, 18 Feb 2019 12:38:11 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190218123811.5b7a1d61@bahia.lan>
In-Reply-To: <20190218101218.4177-1-ppandit@redhat.com>
References: <20190218101218.4177-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] ppc: add host-serial and
 host-model machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On Mon, 18 Feb 2019 15:42:18 +0530
P J P <ppandit@redhat.com> wrote:

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
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Fix-suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ppc/spapr.c         | 79 ++++++++++++++++++++++++++++++++++++++----
>  include/hw/ppc/spapr.h |  2 ++
>  2 files changed, 75 insertions(+), 6 deletions(-)
>=20
> Update v3: move host-serial,host-model options to ppc sPAPR machine
>   -> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg03182.html =
=20
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0942f35bf8..666e500376 100644
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
> @@ -3183,6 +3230,20 @@ static void spapr_instance_init(Object *obj)
>      object_property_set_description(obj, "ic-mode",
>                   "Specifies the interrupt controller mode (xics, xive, d=
ual)",
>                   NULL);
> +
> +    spapr->host_model =3D NULL;

This isn't needed since object_initialize_with_type() already takes care
of zeroing the instance for us.

> +    object_property_add_str(obj, "host-model",
> +        spapr_get_host_model, spapr_set_host_model,
> +        &error_abort);
> +    object_property_set_description(obj, "host-model",
> +        "Set host's model-id to use - none|passthrough|string", &error_a=
bort);
> +
> +    spapr->host_serial =3D NULL;

Same here.

> +    object_property_add_str(obj, "host-serial",
> +        spapr_get_host_serial, spapr_set_host_serial,
> +        &error_abort);
> +    object_property_set_description(obj, "host-serial",
> +        "Set host's system-id to use - none|passthrough|string", &error_=
abort);
>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> @@ -4080,9 +4141,15 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_SPAPR_MACHINE, "host-model", "passthrough" },
> +        { TYPE_SPAPR_MACHINE, "host-serial", "passthrough" },
> +    };
> =20

So... we don't fix the information leak for older machines by default ? From
previous discussions, I understand it is for the sake of compatibility, but
leaving the burden of securing the host to downstream or to the user still
looks unsecure to me FWIW.

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
