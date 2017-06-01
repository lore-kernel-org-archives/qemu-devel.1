Received: from eggs.gnu.org ([2001:4830:134:3::10]:33055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGLBs-0003Yo-Mq
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGLBq-0006Uv-71
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:10:44 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dGLBp-0006Sd-MG
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:10:42 -0400
Received: by mail-lf0-x242.google.com with SMTP id f14so1326395lfe.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 01:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20170529151047.85390-1-ben@skyportsystems.com>
In-Reply-To: <20170529151047.85390-1-ben@skyportsystems.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 01 Jun 2017 08:10:27 +0000
Message-ID: <CAJ+F1C+QFS5YDw7He-p0eEObYbGcq6ra3wwVMVdEu88C0tRqQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, lersek@redhat.com

Hi

On Mon, May 29, 2017 at 7:18 PM Ben Warren via Qemu-devel <
qemu-devel@nongnu.org> wrote:

> From: Ben Warren <ben@skyportsystems.com>
>
> The following tests are implemented:
> * test that a GUID passed in by command line is propagated to the guest.
>   Read the GUID from guest memory
> * test that the "auto" argument to the GUID generates a valid GUID, as
>   seen by the guest.
> * test that a GUID passed in can be queried from the monitor
>
>   This patch is loosely based on a previous patch from:
>   Gal Hammer <ghammer@redhat.com>  and Igor Mammedov <imammedo@redhat.com=
>
>
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>
> Unchanged from v8, simply rebased to current top-of-tree
>
>  tests/Makefile.include |   2 +
>  tests/vmgenid-test.c   | 200
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 202 insertions(+)
>  create mode 100644 tests/vmgenid-test.c
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 75893838e5..79bf960336 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -250,6 +250,7 @@ check-qtest-i386-y +=3D tests/usb-hcd-xhci-test$(EXES=
UF)
>  gcov-files-i386-y +=3D hw/usb/hcd-xhci.c
>  check-qtest-i386-y +=3D tests/pc-cpu-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
> +check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
>  gcov-files-i386-y +=3D hw/pci-host/q35.c
>  check-qtest-i386-$(CONFIG_VHOST_NET_TEST_i386) +=3D
> tests/vhost-user-test$(EXESUF)
>  ifeq ($(CONFIG_VHOST_NET_TEST_i386),)
> @@ -758,6 +759,7 @@ tests/test-uuid$(EXESUF): tests/test-uuid.o
> $(test-util-obj-y)
>  tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
>  tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
>  tests/numa-test$(EXESUF): tests/numa-test.o
> +tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/acpi-utils.o
>
>  tests/migration/stress$(EXESUF): tests/migration/stress.o
>         $(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $=
@
> $< ,"LINK","$(TARGET_DIR)$@")
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> new file mode 100644
> index 0000000000..123beaea13
> --- /dev/null
> +++ b/tests/vmgenid-test.c
> @@ -0,0 +1,200 @@
> +/*
> + * QTest testcase for VM Generation ID
> + *
> + * Copyright (c) 2016 Red Hat, Inc.
> + * Copyright (c) 2017 Skyport Systems
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include <glib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "qemu/osdep.h"
> +#include "qemu/bitmap.h"
> +#include "qemu/uuid.h"
> +#include "hw/acpi/acpi-defs.h"
> +#include "acpi-utils.h"
> +#include "libqtest.h"
> +
> +#define VGID_GUID "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
> +#define VMGENID_GUID_OFFSET 40   /* allow space for
> +                                  * OVMF SDT Header Probe Supressor
> +                                  */
> +#define RSDP_ADDR_INVALID 0x100000 /* RSDP must be below this address */
> +#define RSDP_SLEEP_US     100000   /* Sleep for 100ms between tries */
> +#define RSDP_TRIES_MAX    100      /* Max total time is 10 seconds */
> +
> +typedef struct {
> +    AcpiTableHeader header;
> +    gchar name_op;
> +    gchar vgia[4];
> +    gchar val_op;
> +    uint32_t vgia_val;
> +} QEMU_PACKED VgidTable;
> +
> +static uint32_t acpi_find_vgia(void)
> +{
> +    uint32_t off;
> +    AcpiRsdpDescriptor rsdp_table;
> +    uint32_t rsdt;
> +    AcpiRsdtDescriptorRev1 rsdt_table;
> +    int tables_nr;
> +    uint32_t *tables;
> +    AcpiTableHeader ssdt_table;
> +    VgidTable vgid_table;
> +    int i;
> +
> +    /* Tables may take a short time to be set up by the guest */
> +    for (i =3D 0; i < RSDP_TRIES_MAX; i++) {
> +        off =3D acpi_find_rsdp_address();
> +        if (off < RSDP_ADDR_INVALID) {
> +            break;
> +        }
> +        g_usleep(RSDP_SLEEP_US);
> +    }
> +    g_assert_cmphex(off, <, RSDP_ADDR_INVALID);
> +
> +    acpi_parse_rsdp_table(off, &rsdp_table);
> +
> +    rsdt =3D rsdp_table.rsdt_physical_address;
> +    /* read the header */
> +    ACPI_READ_TABLE_HEADER(&rsdt_table, rsdt);
> +    ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
> +
> +    /* compute the table entries in rsdt */
> +    tables_nr =3D (rsdt_table.length - sizeof(AcpiRsdtDescriptorRev1)) /
> +                sizeof(uint32_t);
> +    g_assert_cmpint(tables_nr, >, 0);
> +
> +    /* get the addresses of the tables pointed by rsdt */
> +    tables =3D g_new0(uint32_t, tables_nr);
> +    ACPI_READ_ARRAY_PTR(tables, tables_nr, rsdt);
> +
> +    for (i =3D 0; i < tables_nr; i++) {
> +        ACPI_READ_TABLE_HEADER(&ssdt_table, tables[i]);
> +        if (!strncmp((char *)ssdt_table.oem_table_id, "VMGENID", 7)) {
> +            /* the first entry in the table should be VGIA
> +             * That's all we need
> +             */
> +            ACPI_READ_FIELD(vgid_table.name_op, tables[i]);
> +            g_assert(vgid_table.name_op =3D=3D 0x08);  /* name */
> +            ACPI_READ_ARRAY(vgid_table.vgia, tables[i]);
> +            g_assert(memcmp(vgid_table.vgia, "VGIA", 4) =3D=3D 0);
> +            ACPI_READ_FIELD(vgid_table.val_op, tables[i]);
> +            g_assert(vgid_table.val_op =3D=3D 0x0C);  /* dword */
> +            ACPI_READ_FIELD(vgid_table.vgia_val, tables[i]);
> +            /* The GUID is written at a fixed offset into the fw_cfg fil=
e
> +             * in order to implement the "OVMF SDT Header probe
> suppressor"
> +             * see docs/specs/vmgenid.txt for more details
> +             */
> +            return vgid_table.vgia_val + VMGENID_GUID_OFFSET;
> +        }
>

It leaks tables

Other than that:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

+    }
> +    return 0;
> +}
> +
> +static void read_guid_from_memory(QemuUUID *guid)
> +{
> +    uint32_t vmgenid_addr;
> +    int i;
> +
> +    vmgenid_addr =3D acpi_find_vgia();
> +    g_assert(vmgenid_addr);
> +
> +    /* Read the GUID directly from guest memory */
> +    for (i =3D 0; i < 16; i++) {
> +        guid->data[i] =3D readb(vmgenid_addr + i);
> +    }
> +    /* The GUID is in little-endian format in the guest, while QEMU
> +     * uses big-endian.  Swap after reading.
> +     */
> +    qemu_uuid_bswap(guid);
> +}
> +
> +static void read_guid_from_monitor(QemuUUID *guid)
> +{
> +    QDict *rsp, *rsp_ret;
> +    const char *guid_str;
> +
> +    rsp =3D qmp("{ 'execute': 'query-vm-generation-id' }");
> +    if (qdict_haskey(rsp, "return")) {
> +        rsp_ret =3D qdict_get_qdict(rsp, "return");
> +        g_assert(qdict_haskey(rsp_ret, "guid"));
> +        guid_str =3D qdict_get_str(rsp_ret, "guid");
> +        g_assert(qemu_uuid_parse(guid_str, guid) =3D=3D 0);
> +    }
> +    QDECREF(rsp);
> +}
> +
> +static void vmgenid_set_guid_test(void)
> +{
> +    QemuUUID expected, measured;
> +    gchar *cmd;
> +
> +    g_assert(qemu_uuid_parse(VGID_GUID, &expected) =3D=3D 0);
> +
> +    cmd =3D g_strdup_printf("-machine accel=3Dtcg -device
> vmgenid,id=3Dtestvgid,"
> +                          "guid=3D%s", VGID_GUID);
> +    qtest_start(cmd);
> +
> +    /* Read the GUID from accessing guest memory */
> +    read_guid_from_memory(&measured);
> +    g_assert(memcmp(measured.data, expected.data, sizeof(measured.data))
> =3D=3D 0);
> +
> +    qtest_quit(global_qtest);
> +    g_free(cmd);
> +}
> +
> +static void vmgenid_set_guid_auto_test(void)
> +{
> +    const char *cmd;
> +    QemuUUID measured;
> +
> +    cmd =3D "-machine accel=3Dtcg -device vmgenid,id=3Dtestvgid," "guid=
=3Dauto";
> +    qtest_start(cmd);
> +
> +    read_guid_from_memory(&measured);
> +
> +    /* Just check that the GUID is non-null */
> +    g_assert(!qemu_uuid_is_null(&measured));
> +
> +    qtest_quit(global_qtest);
> +}
> +
> +static void vmgenid_query_monitor_test(void)
> +{
> +    QemuUUID expected, measured;
> +    gchar *cmd;
> +
> +    g_assert(qemu_uuid_parse(VGID_GUID, &expected) =3D=3D 0);
> +
> +    cmd =3D g_strdup_printf("-machine accel=3Dtcg -device
> vmgenid,id=3Dtestvgid,"
> +                          "guid=3D%s", VGID_GUID);
> +    qtest_start(cmd);
> +
> +    /* Read the GUID via the monitor */
> +    read_guid_from_monitor(&measured);
> +    g_assert(memcmp(measured.data, expected.data, sizeof(measured.data))
> =3D=3D 0);
> +
> +    qtest_quit(global_qtest);
> +    g_free(cmd);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/vmgenid/vmgenid/set-guid",
> +                   vmgenid_set_guid_test);
> +    qtest_add_func("/vmgenid/vmgenid/set-guid-auto",
> +                   vmgenid_set_guid_auto_test);
> +    qtest_add_func("/vmgenid/vmgenid/query-monitor",
> +                   vmgenid_query_monitor_test);
> +    ret =3D g_test_run();
> +
> +    return ret;
> +}
> --
> 2.11.0 (Apple Git-81)
>
>
> --
Marc-Andr=C3=A9 Lureau
