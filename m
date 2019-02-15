Received: from eggs.gnu.org ([209.51.188.92]:40062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gufIH-0007JG-AR
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gufIB-0003gV-LW
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:20:47 -0500
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:35799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gufI8-00038V-OI
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:20:41 -0500
Received: from player697.ha.ovh.net (unknown [10.109.146.106])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 89CAC21C5D3
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 16:20:29 +0100 (CET)
Date: Fri, 15 Feb 2019 16:20:10 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190215162010.19140709@bahia.lan>
In-Reply-To: <20190215133005.15955-4-david@redhat.com>
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] tests/device-plug: Add a simple PCI
 unplug request test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 15 Feb 2019 14:30:02 +0100
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
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/Makefile.include   |  4 ++
>  tests/device-plug-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 tests/device-plug-test.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b39e989f72..f242d65ea2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -192,6 +192,7 @@ check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
>  # check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
>  check-qtest-i386-y += tests/i440fx-test$(EXESUF)
>  check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
> +check-qtest-i386-y += tests/device-plug-test$(EXESUF)
>  check-qtest-i386-y += tests/drive_del-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_WDT_IB700) += tests/wdt_ib700-test$(EXESUF)
>  check-qtest-i386-y += tests/tco-test$(EXESUF)
> @@ -256,6 +257,7 @@ check-qtest-ppc-$(CONFIG_M48T59) += tests/m48t59-test$(EXESUF)
>  
>  check-qtest-ppc64-y += $(check-qtest-ppc-y)
>  check-qtest-ppc64-$(CONFIG_PSERIES) += tests/spapr-phb-test$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_PSERIES) += tests/device-plug-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_POWERNV) += tests/pnv-xscom-test$(EXESUF)
>  check-qtest-ppc64-y += tests/migration-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_PSERIES) += tests/rtas-test$(EXESUF)
> @@ -310,6 +312,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
>  check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
> +check-qtest-s390x-y += tests/device-plug-test$(EXESUF)
>  check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
>  check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
>  check-qtest-s390x-y += tests/migration-test$(EXESUF)
> @@ -750,6 +753,7 @@ tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
>  tests/qom-test$(EXESUF): tests/qom-test.o
>  tests/test-hmp$(EXESUF): tests/test-hmp.o
>  tests/machine-none-test$(EXESUF): tests/machine-none-test.o
> +tests/device-plug-test$(EXESUF): tests/device-plug-test.o
>  tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
>  tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
>  tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
> diff --git a/tests/device-plug-test.c b/tests/device-plug-test.c
> new file mode 100644
> index 0000000000..066433ebf5
> --- /dev/null
> +++ b/tests/device-plug-test.c
> @@ -0,0 +1,93 @@
> +/*
> + * QEMU device plug/unplug handling
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
> +static void device_del_request(QTestState *qtest, const char *id)
> +{
> +    QDict *resp;
> +
> +    resp = qtest_qmp(qtest,
> +                     "{'execute': 'device_del', 'arguments': { 'id': %s } }",
> +                     id);
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +}
> +
> +static void system_reset(QTestState *qtest)
> +{
> +    QDict *resp;
> +
> +    resp = qtest_qmp(qtest, "{'execute': 'system_reset'}");
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +}
> +
> +static void wait_device_deleted_event(QTestState *qtest, const char *id)
> +{
> +    QDict *resp, *data;
> +    QString *qstr;
> +
> +    /*
> +     * Other devices might get removed along with the removed device. Skip
> +     * these. The device of interest will be the last one.
> +     */
> +    for (;;) {
> +        resp = qtest_qmp_eventwait_ref(qtest, "DEVICE_DELETED");
> +        data = qdict_get_qdict(resp, "data");
> +        if (!data || !qdict_get(data, "device")) {
> +            qobject_unref(resp);
> +            continue;
> +        }
> +        qstr = qobject_to(QString, qdict_get(data, "device"));
> +        g_assert(qstr);
> +        if (!strcmp(qstring_get_str(qstr), id)) {
> +            qobject_unref(resp);
> +            break;
> +        }
> +        qobject_unref(resp);
> +    }
> +}
> +
> +static void test_pci_unplug_request(void)
> +{
> +    QTestState *qtest = qtest_initf("-device virtio-mouse-pci,id=dev0");
> +
> +    /*
> +     * Request device removal. As the guest is not running, the request won't
> +     * be processed. However during system reset, the removal will be
> +     * handled, removing the device.
> +     */
> +    device_del_request(qtest, "dev0");
> +    system_reset(qtest);
> +    wait_device_deleted_event(qtest, "dev0");
> +
> +    qtest_quit(qtest);
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
> +    qtest_add_func("/device-plug/pci_unplug_request",
> +                   test_pci_unplug_request);
> +
> +    return g_test_run();
> +}
