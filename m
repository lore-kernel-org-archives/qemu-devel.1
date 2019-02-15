Received: from eggs.gnu.org ([209.51.188.92]:53826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1guiN7-0003ZH-7z
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1guiN4-0000zp-Ro
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:38:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1guiN2-0000pA-Ig
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:37:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FIXmLQ005543
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:37:42 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qp1rbjm1m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:37:42 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Fri, 15 Feb 2019 18:37:39 -0000
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-4-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 15 Feb 2019 13:37:34 -0500
MIME-Version: 1.0
In-Reply-To: <20190215133005.15955-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5c74d2e9-d320-f424-6b1e-9fe70dfeef04@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 3/6] tests/device-plug: Add
 a simple PCI unplug request test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 2/15/19 8:30 AM, David Hildenbrand wrote:
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
>      qemu-system-s390x: -device virtio-mouse-pci,id=dev0:
>      warning: Plugging a PCI/zPCI device without the 'zpci' CPU feature
>      enabled; the guest will not be able to see/use this device
> 
> This will be fixed soon, when we enable the zpci CPU feature always
> (Conny already has a patch for this queued).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Looks fine from what I can tell. Ran it on my own system and passed
with no issues.

Reviewed-by: Collin Walling <walling@linux.ibm.com>

> ---
>   tests/Makefile.include   |  4 ++
>   tests/device-plug-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 97 insertions(+)
>   create mode 100644 tests/device-plug-test.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b39e989f72..f242d65ea2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -192,6 +192,7 @@ check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
>   # check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
>   check-qtest-i386-y += tests/i440fx-test$(EXESUF)
>   check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
> +check-qtest-i386-y += tests/device-plug-test$(EXESUF)
>   check-qtest-i386-y += tests/drive_del-test$(EXESUF)
>   check-qtest-i386-$(CONFIG_WDT_IB700) += tests/wdt_ib700-test$(EXESUF)
>   check-qtest-i386-y += tests/tco-test$(EXESUF)
> @@ -256,6 +257,7 @@ check-qtest-ppc-$(CONFIG_M48T59) += tests/m48t59-test$(EXESUF)
>   
>   check-qtest-ppc64-y += $(check-qtest-ppc-y)
>   check-qtest-ppc64-$(CONFIG_PSERIES) += tests/spapr-phb-test$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_PSERIES) += tests/device-plug-test$(EXESUF)
>   check-qtest-ppc64-$(CONFIG_POWERNV) += tests/pnv-xscom-test$(EXESUF)
>   check-qtest-ppc64-y += tests/migration-test$(EXESUF)
>   check-qtest-ppc64-$(CONFIG_PSERIES) += tests/rtas-test$(EXESUF)
> @@ -310,6 +312,7 @@ check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>   check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
>   check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
>   check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
> +check-qtest-s390x-y += tests/device-plug-test$(EXESUF)
>   check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
>   check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
>   check-qtest-s390x-y += tests/migration-test$(EXESUF)
> @@ -750,6 +753,7 @@ tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
>   tests/qom-test$(EXESUF): tests/qom-test.o
>   tests/test-hmp$(EXESUF): tests/test-hmp.o
>   tests/machine-none-test$(EXESUF): tests/machine-none-test.o
> +tests/device-plug-test$(EXESUF): tests/device-plug-test.o
>   tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
>   tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
>   tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
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
> 
