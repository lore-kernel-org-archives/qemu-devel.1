Received: from eggs.gnu.org ([209.51.188.92]:59902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvv-0003H4-RO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvs-0005CA-Fa
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:03 -0500
Date: Wed, 13 Feb 2019 12:38:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213013850.GX1884@umbus.fritz.box>
References: <20190212113929.31390-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XCIqNWEteo88hZlY"
Content-Disposition: inline
In-Reply-To: <20190212113929.31390-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ppc: add host-serial and host-model
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>


--XCIqNWEteo88hZlY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 05:09:29PM +0530, P J P wrote:
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
> ---
>  hw/core/machine.c   | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr.c      | 36 +++++++++++++++++++++++++++++------
>  include/hw/boards.h |  2 ++
>  qemu-options.hx     | 10 +++++++++-
>  util/qemu-config.c  |  8 ++++++++
>  5 files changed, 95 insertions(+), 7 deletions(-)
>=20
> Update v2: add backward compatible properties
>   -> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00593.html
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2629515363..2d5a52476a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -476,6 +476,38 @@ static void machine_set_memory_encryption(Object *ob=
j, const char *value,
>      ms->memory_encryption =3D g_strdup(value);
>  }
> =20
> +static char *machine_get_host_serial(Object *obj, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    return g_strdup(ms->host_serial);
> +}
> +
> +static void machine_set_host_serial(Object *obj, const char *value,
> +                                    Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    g_free(ms->host_serial);
> +    ms->host_serial =3D g_strdup(value);
> +}
> +
> +static char *machine_get_host_model(Object *obj, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    return g_strdup(ms->host_model);
> +}
> +
> +static void machine_set_host_model(Object *obj, const char *value,
> +                                   Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(obj);
> +
> +    g_free(ms->host_model);
> +    ms->host_model =3D g_strdup(value);
> +}
> +
>  void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char=
 *type)
>  {
>      strList *item =3D g_new0(strList, 1);
> @@ -760,6 +792,18 @@ static void machine_class_init(ObjectClass *oc, void=
 *data)
>          &error_abort);
>      object_class_property_set_description(oc, "memory-encryption",
>          "Set memory encryption object to use", &error_abort);
> +
> +    object_class_property_add_str(oc, "host-serial",
> +        machine_get_host_serial, machine_set_host_serial,
> +        &error_abort);
> +    object_class_property_set_description(oc, "host-serial",
> +        "Set host's system-id to use", &error_abort);
> +
> +    object_class_property_add_str(oc, "host-model",
> +        machine_get_host_model, machine_set_host_model,
> +        &error_abort);
> +    object_class_property_set_description(oc, "host-model",
> +        "Set host's model-id to use", &error_abort);

You're adding properties to *all* machines, for something that's only
used on the PAPR machine.  That doesn't seem right.

>  }
> =20
>  static void machine_class_base_init(ObjectClass *oc, void *data)
> @@ -785,6 +829,8 @@ static void machine_initfn(Object *obj)
>      ms->dump_guest_core =3D true;
>      ms->mem_merge =3D true;
>      ms->enable_graphics =3D true;
> +    ms->host_serial =3D NULL;
> +    ms->host_model =3D NULL;
> =20
>      /* Register notifier when init is done for sysbus sanity checks */
>      ms->sysbus_notifier.notify =3D machine_init_notify;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0942f35bf8..a70667d72d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1249,13 +1249,31 @@ static void *spapr_build_fdt(sPAPRMachineState *s=
papr,
>       * Add info to guest to indentify which host is it being run on
>       * and what is the uuid of the guest
>       */
> -    if (kvmppc_get_host_model(&buf)) {
> -        _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
> -        g_free(buf);
> +    if (machine->host_model && !g_str_equal(machine->host_model, "none")=
) {
> +        if (g_str_equal(machine->host_model, "passthrough")) {
> +            /* -M host-model=3Dpassthrough */
> +            if (kvmppc_get_host_model(&buf)) {
> +                _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
> +                g_free(buf);
> +            }
> +        } else {
> +            /* -M host-model=3D<user-string> */
> +            _FDT(fdt_setprop_string(fdt, 0, "host-model", machine->host_=
model));
> +        }
>      }
> -    if (kvmppc_get_host_serial(&buf)) {
> -        _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
> -        g_free(buf);
> +
> +    if (machine->host_serial && !g_str_equal(machine->host_serial, "none=
")) {
> +        if (g_str_equal(machine->host_serial, "passthrough")) {
> +            /* -M host-serial=3Dpassthrough */
> +            if (kvmppc_get_host_serial(&buf)) {
> +                _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
> +                g_free(buf);
> +            }
> +        } else {
> +            /* -M host-serial=3D<user-string> */
> +            _FDT(fdt_setprop_string(fdt, 0,
> +                                    "host-serial", machine->host_serial)=
);
> +        }
>      }
> =20
>      buf =3D qemu_uuid_unparse_strdup(&qemu_uuid);
> @@ -4080,9 +4098,15 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
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

I'm still not convinced maintaining super-strict backwards compat at
the expense of security is a good tradeoff here, but since the code's
already written, let's run with it.

> +
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      smc->update_dt_enabled =3D false;
>  }
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 02f114085f..3e63dc4501 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -257,6 +257,8 @@ struct MachineState {
>      bool enforce_config_section;
>      bool enable_graphics;
>      char *memory_encryption;
> +    char *host_serial;
> +    char *host_model;
>      DeviceMemoryState *device_memory;
> =20
>      ram_addr_t ram_size;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 521511ec13..67ac1a9959 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -43,7 +43,9 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                suppress-vmdesc=3Don|off disables self-describing m=
igration (default=3Doff)\n"
>      "                nvdimm=3Don|off controls NVDIMM support (default=3D=
off)\n"
>      "                enforce-config-section=3Don|off enforce configurati=
on section migration (default=3Doff)\n"
> -    "                memory-encryption=3D@var{} memory encryption object=
 to use (default=3Dnone)\n",
> +    "                memory-encryption=3D@var{} memory encryption object=
 to use (default=3Dnone)\n"
> +    "                host-serial=3Dnone|passthrough|string controls host=
 systemd-id (default=3Dpassthrough)\n"
> +    "                host-model=3Dnone|passthrough|string controls host =
model-id (default=3Dpassthrough)\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -machine [type=3D]@var{name}[,prop=3D@var{value}[,...]]
> @@ -103,6 +105,12 @@ NOTE: this parameter is deprecated. Please use @opti=
on{-global}
>  @option{migration.send-configuration}=3D@var{on|off} instead.
>  @item memory-encryption=3D@var{}
>  Memory encryption object to use. The default is none.
> +@item host-serial=3Dnone|passthrough|string
> +Pass 'system-id' parameter from host's device-tree to a guest. A user may
> +disable it with 'none' or define a custom string for a guest.
> +@item host-model=3Dnone|passthrough|string
> +Pass 'model' paramter from host's device-tree to a guest. A user may dis=
able
> +it with 'none' or define a custom string for a guest.
>  @end table
>  ETEXI
> =20
> diff --git a/util/qemu-config.c b/util/qemu-config.c
> index 9d2e278e29..86483ded34 100644
> --- a/util/qemu-config.c
> +++ b/util/qemu-config.c
> @@ -238,6 +238,14 @@ static QemuOptsList machine_opts =3D {
>              .help =3D "Up to 8 chars in set of [A-Za-z0-9. ](lower case =
chars"
>                      " converted to upper case) to pass to machine"
>                      " loader, boot manager, and guest kernel",
> +        },{
> +            .name =3D "host-serial",
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "host's system-id seen by guest",
> +        },{
> +            .name =3D "host-model",
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "host's model-id seen by guest",
>          },
>          { /* End of list */ }
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XCIqNWEteo88hZlY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjdSoACgkQbDjKyiDZ
s5KLYA/+LOwHEMgsqIw0nBYX+MBbilVl0KUes4bVHMJ2k+/cSoT2Crf4Nws74slR
qBasli2sxPeJwLyiiRbrmrDfTlsslgQNHwCdtqz58O1QpCdEwYV1qzoEinElN+7W
H17paygSiDGXwQNNDhG3Ac9ldPoUc1pcyBAHS3LlpxzFfRRNwOUV5RUmR2RWYUmK
0v8xmsd/xrZkFTvZ9lFissAicFOsZ+JGkDU8IjnSCd6LOMVWE/6GCHuQJfrJOY4N
IGyFRyaSM47vGHF63pwIslRY+Yb60ty0sV6Ik7OfkgI1C6GSzGOncSwLoIx17wC0
Z4MXXR6TNq8CUM3NF/hJYz1+O+qOYpnZN0pcEqpfmigzK5h1Y81usBSvaCHDliSP
DnVl8WssT1VwvrMEoX9t7LHlot8X5Lzgno1ibrkuJIHLB+5YVqJmLZKWrl+6nUbq
uPjEnIeOkzfHZlPmM3b5v6t2ixxKj0RzUpclyQsW6ezGHvLytV+fdST1Y43a3Vds
78utHt0vjTPBrgyCwECOXihh9qj8qco8698mmPFIHpjgLOSqyzaKwghUvqBGM5l+
UtdfFfK5iVx1T4ZzQBgSVEiAkGq4tIf09DW6C7O2CQipN/sD1qJXyqe5PaKafuuT
cAyZ+mTfig3Kc6+gXAwti0aEuPs8DbmJrVN4b+JJ5e9OHY+rEk8=
=aYRj
-----END PGP SIGNATURE-----

--XCIqNWEteo88hZlY--
