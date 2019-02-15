Received: from eggs.gnu.org ([209.51.188.92]:46308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guVGP-0005uJ-KU
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guV1u-0006Z9-07
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:23:15 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:39101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1guV1r-0006If-FP
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:23:13 -0500
Date: Fri, 15 Feb 2019 15:10:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215041056.GK4573@umbus.fritz.box>
References: <20190214171128.24093-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYjDATHXTWnytHRU"
Content-Disposition: inline
In-Reply-To: <20190214171128.24093-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] tests: Add a simple device_del test for
 PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--zYjDATHXTWnytHRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 06:11:28PM +0100, David Hildenbrand wrote:
> The issue with testing asynchronous unplug requests it that they usually
> require a running guest to handle the request. However, to test if
> unplug of PCI devices works, we can apply a nice little trick on some
> architectures:
>=20
> On system reset, x86 ACPI, s390x and spapr will perform the unplug,
> resulting in the device of interest to get deleted and a DEVICE_DELETED
> event getting sent.
>=20
> On s390x, we still get a warning
>     qemu-system-s390x: -device virtio-mouse-pci,id=3Ddev0:
>     warning: Plugging a PCI/zPCI device without the 'zpci' CPU feature
>     enabled; the guest will not be able to see/use this device
>=20
> This will be fixed soon, when we enable the zpci CPU feature always
> (Conny already has a patch for this queued).
>=20
> Cc: Collin Walling <walling@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Pierre Morel <pmorel@linux.ibm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Nice trick.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Tested-by: David Gibson <david@gibson.dropbear.id.au>

(on both x86 and ppc64le host)

> ---
>  tests/Makefile.include  |   4 ++
>  tests/device_del-test.c | 103 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 tests/device_del-test.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b39e989f72..713e5e23a7 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -192,6 +192,7 @@ check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D tests/ip=
mi-kcs-test$(EXESUF)
>  # check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D tests/ipmi-bt-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/i440fx-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/fw_cfg-test$(EXESUF)
> +check-qtest-i386-y +=3D tests/device_del-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/drive_del-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_WDT_IB700) +=3D tests/wdt_ib700-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/tco-test$(EXESUF)
> @@ -256,6 +257,7 @@ check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-te=
st$(EXESUF)
> =20
>  check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
>  check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/spapr-phb-test$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device_del-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_POWERNV) +=3D tests/pnv-xscom-test$(EXESUF)
>  check-qtest-ppc64-y +=3D tests/migration-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/rtas-test$(EXESUF)
> @@ -310,6 +312,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) +=3D tests/test-net=
filter$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(EXE=
SUF)
>  check-qtest-s390x-y +=3D tests/drive_del-test$(EXESUF)
> +check-qtest-s390x-y +=3D tests/device_del-test$(EXESUF)
>  check-qtest-s390x-y +=3D tests/virtio-ccw-test$(EXESUF)
>  check-qtest-s390x-y +=3D tests/cpu-plug-test$(EXESUF)
>  check-qtest-s390x-y +=3D tests/migration-test$(EXESUF)
> @@ -750,6 +753,7 @@ tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test=
=2Eo
>  tests/qom-test$(EXESUF): tests/qom-test.o
>  tests/test-hmp$(EXESUF): tests/test-hmp.o
>  tests/machine-none-test$(EXESUF): tests/machine-none-test.o
> +tests/device_del-test$(EXESUF): tests/device_del-test.o
>  tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-ob=
j-y)
>  tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
>  tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
> diff --git a/tests/device_del-test.c b/tests/device_del-test.c
> new file mode 100644
> index 0000000000..cbc3e78e56
> --- /dev/null
> +++ b/tests/device_del-test.c
> @@ -0,0 +1,103 @@
> +/*
> + * QEMU device_del handling
> + *
> + * Copyright (C) 2019 Red Hat Inc.
> + *
> + * Authors:
> + *  David Hildenbrand <david@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qstring.h"
> +
> +static void device_del_request(const char *id)
> +{
> +    QDict *resp;
> +
> +    resp =3D qmp("{'execute': 'device_del', 'arguments': { 'id': %s } }"=
, id);
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +}
> +
> +static void system_reset(void)
> +{
> +    QDict *resp;
> +
> +    resp =3D qmp("{'execute': 'system_reset'}");
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +}
> +
> +static void wait_device_deleted_event(const char *id)
> +{
> +    QDict *resp, *data;
> +    QObject *device;
> +    QString *qstr;
> +
> +    /*
> +     * Other devices might get removed along with the removed device. Sk=
ip
> +     * these.
> +     */
> +    for (;;) {
> +        resp =3D qtest_qmp_eventwait_ref(global_qtest, "DEVICE_DELETED");
> +        data =3D qdict_get_qdict(resp, "data");
> +        if (!data) {
> +            qobject_unref(resp);
> +            continue;
> +        }
> +        device =3D qdict_get(data, "device");
> +        if (!device) {
> +            qobject_unref(resp);
> +            continue;
> +        }
> +        qstr =3D qobject_to(QString, device);
> +        g_assert(qstr);
> +        if (!strcmp(qstring_get_str(qstr), id)) {
> +            qobject_unref(data);
> +            qobject_unref(resp);
> +            break;
> +        }
> +        qobject_unref(data);
> +        qobject_unref(resp);
> +    }
> +}
> +
> +static void test_pci_device_del_request(void)
> +{
> +    char *args;
> +
> +    args =3D g_strdup_printf("-device virtio-mouse-pci,id=3Ddev0");
> +    qtest_start(args);
> +
> +    /*
> +     * Request device removal. As the guest is not running, the request =
won't
> +     * be processed. However during system reset, the removal will be
> +     * handled, removing the device.
> +     */
> +    device_del_request("dev0");
> +    system_reset();
> +    wait_device_deleted_event("dev0");
> +
> +    qtest_end();
> +    g_free(args);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    /*
> +     * We need a system that will process unplug requests during system =
resets
> +     * and does not do PCI surprise removal. This holds for x86 ACPI,
> +     * s390x and spapr.
> +     */
> +    qtest_add_func("/device_del/pci_device_del_request",
> +                   test_pci_device_del_request);
> +
> +    return g_test_run();
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zYjDATHXTWnytHRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmO84ACgkQbDjKyiDZ
s5LaHw/9GtFKctuOumIxCpZkVKRqGCEzAWwVg3aXyCTL+k1x42laif3PrCYKVBGk
sg7XdMqkGauFmDRJXB7O77XA3mccAYtSPRoNnflt4NbyitTFiQ5phqur5sho2rsK
GrOMpP3iUhNHKgTARROjQLMdeJL/vsob9jRjbKAp/uwyUlXiacqSpczhwSrVSbOU
E1J2ngZyQcdVh1bOTepyoQJHJhzRxtYxkZDAyw46AIJWlcPJpwCtNV814vOTablK
GgzgZIFxDClVWv3HV23e9B0nPk24PrzRk/xqkekI8a3S6VN+tAv7x9TooZy3F9iT
4pT4hk7f+b/FLVk5ALF9YJqGLti04ATj6BNPioGtqEeQBGpsjmVa57Pl/eIeXVPI
3Vl1KxRsdzhKBb8nl78w3FbGRVPDlcKncXv+P73OtS/dzM583agGQbC7DTfCAdHN
U3Eyquz0rZB6UoZyIbSVPyd+omJvXI3EkpySG9SbPSTitfS6oaoIdeE1hEdF2jFR
HBiKvjTJ/oT9DH25XGnhnDHCUcL92492myw+nqqAHBbV0HUlE8TKHzhMqIJt5fED
wQwNBZJ0KgxD5ZZ51UOvJLSl5KKRsPIyd92ZBSNkQCavksOmd3kcLqX6IMTEoSf7
L86t+E8yjPM2wn4RUlY806i1VsZafwScGGJQ0BVIlQqEDF6b42s=
=33/k
-----END PGP SIGNATURE-----

--zYjDATHXTWnytHRU--
