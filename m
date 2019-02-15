Received: from eggs.gnu.org ([209.51.188.92]:41027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1guZTc-0000Sd-I8
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1guZTY-0000Lu-Rw
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:08:08 -0500
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:52616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1guZTY-00084t-I8
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:08:04 -0500
Received: from player759.ha.ovh.net (unknown [10.109.159.140])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id DC479E3901
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 10:07:30 +0100 (CET)
Date: Fri, 15 Feb 2019 10:07:16 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190215100716.7d789b8e@bahia.lan>
In-Reply-To: <20190214171128.24093-1-david@redhat.com>
References: <20190214171128.24093-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S .
	Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 14 Feb 2019 18:11:28 +0100
David Hildenbrand <david@redhat.com> wrote:

> The issue with testing asynchronous unplug requests it that they usually
> require a running guest to handle the request. However, to test if
> unplug of PCI devices works, we can apply a nice little trick on some
> architectures:
> 
> On system reset, x86 ACPI, s390x and spapr will perform the unplug,
> resulting in the device of interest to get deleted and a DEVICE_DELETED
> event getting sent.
> 
> On s390x, we still get a warning
>     qemu-system-s390x: -device virtio-mouse-pci,id=dev0:
>     warning: Plugging a PCI/zPCI device without the 'zpci' CPU feature
>     enabled; the guest will not be able to see/use this device
> 
> This will be fixed soon, when we enable the zpci CPU feature always
> (Conny already has a patch for this queued).
> 
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
> ---

Nice trick indeed, but...

>  tests/Makefile.include  |   4 ++
>  tests/device_del-test.c | 103 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 tests/device_del-test.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b39e989f72..713e5e23a7 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -192,6 +192,7 @@ check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
>  # check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
>  check-qtest-i386-y += tests/i440fx-test$(EXESUF)
>  check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
> +check-qtest-i386-y += tests/device_del-test$(EXESUF)
>  check-qtest-i386-y += tests/drive_del-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_WDT_IB700) += tests/wdt_ib700-test$(EXESUF)
>  check-qtest-i386-y += tests/tco-test$(EXESUF)
> @@ -256,6 +257,7 @@ check-qtest-ppc-$(CONFIG_M48T59) += tests/m48t59-test$(EXESUF)
>  
>  check-qtest-ppc64-y += $(check-qtest-ppc-y)
>  check-qtest-ppc64-$(CONFIG_PSERIES) += tests/spapr-phb-test$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_PSERIES) += tests/device_del-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_POWERNV) += tests/pnv-xscom-test$(EXESUF)
>  check-qtest-ppc64-y += tests/migration-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_PSERIES) += tests/rtas-test$(EXESUF)
> @@ -310,6 +312,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
>  check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
> +check-qtest-s390x-y += tests/device_del-test$(EXESUF)
>  check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
>  check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
>  check-qtest-s390x-y += tests/migration-test$(EXESUF)
> @@ -750,6 +753,7 @@ tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
>  tests/qom-test$(EXESUF): tests/qom-test.o
>  tests/test-hmp$(EXESUF): tests/test-hmp.o
>  tests/machine-none-test$(EXESUF): tests/machine-none-test.o
> +tests/device_del-test$(EXESUF): tests/device_del-test.o
>  tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
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
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
> +    resp = qmp("{'execute': 'device_del', 'arguments': { 'id': %s } }", id);
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +}
> +
> +static void system_reset(void)
> +{
> +    QDict *resp;
> +
> +    resp = qmp("{'execute': 'system_reset'}");
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
> +     * Other devices might get removed along with the removed device. Skip
> +     * these.
> +     */
> +    for (;;) {
> +        resp = qtest_qmp_eventwait_ref(global_qtest, "DEVICE_DELETED");
> +        data = qdict_get_qdict(resp, "data");
> +        if (!data) {
> +            qobject_unref(resp);
> +            continue;
> +        }
> +        device = qdict_get(data, "device");
> +        if (!device) {
> +            qobject_unref(resp);
> +            continue;
> +        }
> +        qstr = qobject_to(QString, device);
> +        g_assert(qstr);
> +        if (!strcmp(qstring_get_str(qstr), id)) {
> +            qobject_unref(data);

... this ^^ causes...


> +            qobject_unref(resp);

... this ^^ to crash with:

/ppc64/device_del/pci_device_del_request: *** Error in `tests/device_del-test': corrupted double-linked list: 0x0000010021d58c10 ***

IIUC, qobject_unref(resp) eventually calls qobject_unref(data) internally,
so you shouldn't do it. If I drop the  line, the test passes like a charm.

> +            break;
> +        }
> +        qobject_unref(data);

I couldn't have the test executing this path but I guess it has the
very same problem.

> +        qobject_unref(resp);
> +    }
> +}
> +
> +static void test_pci_device_del_request(void)
> +{
> +    char *args;
> +
> +    args = g_strdup_printf("-device virtio-mouse-pci,id=dev0");
> +    qtest_start(args);
> +
> +    /*
> +     * Request device removal. As the guest is not running, the request won't
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
> +     * We need a system that will process unplug requests during system resets
> +     * and does not do PCI surprise removal. This holds for x86 ACPI,
> +     * s390x and spapr.
> +     */
> +    qtest_add_func("/device_del/pci_device_del_request",
> +                   test_pci_device_del_request);
> +
> +    return g_test_run();
> +}
