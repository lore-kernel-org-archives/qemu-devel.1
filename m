Received: from eggs.gnu.org ([2001:4830:134:3::10]:53117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT9U9-0007cf-V7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT9U6-0008Fk-Ox
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:18:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dT9U6-0008Ej-EU
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:18:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C86C34E334
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 16:18:28 +0000 (UTC)
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-4-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9d4f167c-70b1-bad7-7a87-7727f9b1ccf8@redhat.com>
Date: Thu, 6 Jul 2017 18:18:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170706101611.27031-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/7] tests: add simple vmcoreinfo test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com

I didn't look at this patch in the previous version, hoping that someone
else would. Apparently that hasn't happened, so I'll comment, purely
based on a comparison with the vmgenid test:

On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:
> This test is based off vmgenid test from Ben Warren
> <ben@skyportsystems.com>. It simply checks the vmcoreinfo ACPI device
> is present and that the memory region associated can be read.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/vmcoreinfo-test.c | 130 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/Makefile.include  |   2 +
>  2 files changed, 132 insertions(+)
>  create mode 100644 tests/vmcoreinfo-test.c
>=20
> diff --git a/tests/vmcoreinfo-test.c b/tests/vmcoreinfo-test.c
> new file mode 100644
> index 0000000000..c8b073366e
> --- /dev/null
> +++ b/tests/vmcoreinfo-test.c
> @@ -0,0 +1,130 @@
> +/*
> + * QTest testcase for VM coreinfo device
> + *
> + * Copyright (c) 2017 Red Hat, Inc.
> + * Copyright (c) 2017 Skyport Systems
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
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
> +#define VMCOREINFO_OFFSET 40     /* allow space for
> +                                  * OVMF SDT Header Probe Supressor
> +                                  */
> +#define RSDP_ADDR_INVALID 0x100000 /* RSDP must be below this address =
*/
> +#define RSDP_SLEEP_US     100000   /* Sleep for 100ms between tries */
> +#define RSDP_TRIES_MAX    100      /* Max total time is 10 seconds */
> +
> +typedef struct {
> +    AcpiTableHeader header;
> +    gchar name_op;
> +    gchar vcia[4];
> +    gchar val_op;
> +    uint32_t vcia_val;
> +} QEMU_PACKED VgidTable;

This should be called something resembling "vmcoreinfo table".

> +
> +static uint32_t acpi_find_vcia(void)
> +{
> +    uint32_t off;
> +    AcpiRsdpDescriptor rsdp_table;
> +    uint32_t rsdt;
> +    AcpiRsdtDescriptorRev1 rsdt_table;
> +    int tables_nr;
> +    uint32_t *tables;
> +    AcpiTableHeader ssdt_table;
> +    VgidTable vgid_table;

ditto.

With these fixed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

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
> +    tables_nr =3D (rsdt_table.length - sizeof(AcpiRsdtDescriptorRev1))=
 /
> +                sizeof(uint32_t);
> +    g_assert_cmpint(tables_nr, >, 0);
> +
> +    /* get the addresses of the tables pointed by rsdt */
> +    tables =3D g_new0(uint32_t, tables_nr);
> +    ACPI_READ_ARRAY_PTR(tables, tables_nr, rsdt);
> +
> +    for (i =3D 0; i < tables_nr; i++) {
> +        ACPI_READ_TABLE_HEADER(&ssdt_table, tables[i]);
> +        if (!strncmp((char *)ssdt_table.oem_table_id, "VMCOREIN", 8)) =
{
> +            /* the first entry in the table should be VCIA
> +             * That's all we need
> +             */
> +            ACPI_READ_FIELD(vgid_table.name_op, tables[i]);
> +            g_assert(vgid_table.name_op =3D=3D 0x08);  /* name */
> +            ACPI_READ_ARRAY(vgid_table.vcia, tables[i]);
> +            g_assert(memcmp(vgid_table.vcia, "VCIA", 4) =3D=3D 0);
> +            ACPI_READ_FIELD(vgid_table.val_op, tables[i]);
> +            g_assert(vgid_table.val_op =3D=3D 0x0C);  /* dword */
> +            ACPI_READ_FIELD(vgid_table.vcia_val, tables[i]);
> +            /* The GUID is written at a fixed offset into the fw_cfg f=
ile
> +             * in order to implement the "OVMF SDT Header probe suppre=
ssor"
> +             * see docs/specs/vmgenid.txt for more details
> +             */
> +            g_free(tables);
> +            return vgid_table.vcia_val;
> +        }
> +    }
> +    g_free(tables);
> +    return 0;
> +}
> +
> +static void vmcoreinfo_test(void)
> +{
> +    gchar *cmd;
> +    uint32_t vmci_addr;
> +    int i;
> +
> +    cmd =3D g_strdup_printf("-machine accel=3Dtcg -device vmcoreinfo,i=
d=3Dvmci");
> +    qtest_start(cmd);
> +
> +    vmci_addr =3D acpi_find_vcia();
> +    g_assert(vmci_addr);
> +
> +    for (i =3D 0; i < 4096; i++) {
> +        /* check the memory region can be read */
> +        readb(vmci_addr + i);
> +    }
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
> +    qtest_add_func("/vmcoreinfo/test", vmcoreinfo_test);
> +    ret =3D g_test_run();
> +
> +    return ret;
> +}
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 18cd06a6b3..f573c1d3c8 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -251,6 +251,7 @@ gcov-files-i386-y +=3D hw/usb/hcd-xhci.c
>  check-qtest-i386-y +=3D tests/pc-cpu-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
> +check-qtest-i386-y +=3D tests/vmcoreinfo-test$(EXESUF)
>  gcov-files-i386-y +=3D hw/pci-host/q35.c
>  check-qtest-i386-$(CONFIG_VHOST_NET_TEST_i386) +=3D tests/vhost-user-t=
est$(EXESUF)
>  ifeq ($(CONFIG_VHOST_NET_TEST_i386),)
> @@ -762,6 +763,7 @@ tests/test-arm-mptimer$(EXESUF): tests/test-arm-mpt=
imer.o
>  tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-=
y)
>  tests/numa-test$(EXESUF): tests/numa-test.o
>  tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/acpi-utils.o
> +tests/vmcoreinfo-test$(EXESUF): tests/vmcoreinfo-test.o tests/acpi-uti=
ls.o
> =20
>  tests/migration/stress$(EXESUF): tests/migration/stress.o
>  	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $<=
 ,"LINK","$(TARGET_DIR)$@")
>=20
