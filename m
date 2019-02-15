Received: from eggs.gnu.org ([209.51.188.92]:40307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guZRe-0008C5-Ac
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guZRd-0006sB-9X
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:06:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1guZRd-0006qw-1S
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:06:05 -0500
References: <20190214171128.24093-1-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e3a0a9ed-3edb-80a2-8ccd-ff0ed189d304@redhat.com>
Date: Fri, 15 Feb 2019 10:05:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190214171128.24093-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 14/02/2019 18.11, David Hildenbrand wrote:
> The issue with testing asynchronous unplug requests it that they usuall=
y
> require a running guest to handle the request. However, to test if
> unplug of PCI devices works, we can apply a nice little trick on some
> architectures:
>=20
> On system reset, x86 ACPI, s390x and spapr will perform the unplug,
> resulting in the device of interest to get deleted and a DEVICE_DELETED
> event getting sent.

Good idea, and thanks for writing the test! Some comments below...

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
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
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
> +    resp =3D qmp("{'execute': 'device_del', 'arguments': { 'id': %s } =
}", id);
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
> +     * Other devices might get removed along with the removed device. =
Skip
> +     * these.
> +     */
> +    for (;;) {
> +        resp =3D qtest_qmp_eventwait_ref(global_qtest, "DEVICE_DELETED=
");

Please avoid global_qtest in new code. We should get rid of that global
variable in the long run - it causes trouble each time we want to re-use
code in tests with multiple test instances.

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

Please use qtest_initf() instead and pass its return value to
wait_device_deleted_event(), so you can use it there instead of
global_qtest.

Also there is no need for the g_strdup_printf() here - simply pass the
string directly to the qtest_initf function.

> +    /*
> +     * Request device removal. As the guest is not running, the reques=
t won't
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
> +     * We need a system that will process unplug requests during syste=
m resets
> +     * and does not do PCI surprise removal. This holds for x86 ACPI,
> +     * s390x and spapr.
> +     */
> +    qtest_add_func("/device_del/pci_device_del_request",
> +                   test_pci_device_del_request);
> +
> +    return g_test_run();
> +}

When you respin, could you maybe also rename the file to
device-plug-test.c instead? ... I still have got some plans for some
device_add tests, that would likely also be a good fit here...

 Thomas
