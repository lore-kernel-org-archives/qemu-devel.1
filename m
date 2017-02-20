Received: from eggs.gnu.org ([2001:4830:134:3::10]:56146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfpHr-0006Rw-Lz
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfpHp-00064z-0u
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:49:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cfpHo-00064t-Op
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:49:56 -0500
Date: Mon, 20 Feb 2017 15:49:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170220154953.58325d35@nial.brq.redhat.com>
In-Reply-To: <0349b18610175568b72545bcd1e2b476c93477ac.1487286467.git.ben@skyportsystems.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<0349b18610175568b72545bcd1e2b476c93477ac.1487286467.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 6/8] tests: Move reusable ACPI code into
 a utility file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com

On Thu, 16 Feb 2017 15:15:38 -0800
ben@skyportsystems.com wrote:

> From: Ben Warren <ben@skyportsystems.com>
> 
> Also usable by upcoming VM Generation ID tests
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  MAINTAINERS              |   2 +
>  tests/Makefile.include   |   2 +-
>  tests/acpi-utils.c       |  65 +++++++++++++++++++++++
>  tests/acpi-utils.h       |  94 +++++++++++++++++++++++++++++++++
>  tests/bios-tables-test.c | 132 ++++++-----------------------------------------
>  5 files changed, 177 insertions(+), 118 deletions(-)
>  create mode 100644 tests/acpi-utils.c
>  create mode 100644 tests/acpi-utils.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb57d8e..81d4baf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -909,6 +909,8 @@ F: hw/acpi/*
>  F: hw/smbios/*
>  F: hw/i386/acpi-build.[hc]
>  F: hw/arm/virt-acpi-build.c
> +F: tests/bios-tables-test.c
> +F: tests/acpi-utils.[hc]
>  
>  ppc4xx
>  M: Alexander Graf <agraf@suse.de>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 634394a..143507e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -667,7 +667,7 @@ tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
>  tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
>  tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
>  tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
> -	tests/boot-sector.o $(libqos-obj-y)
> +	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
>  tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
>  tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
>  tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> new file mode 100644
> index 0000000..41dc1ea
> --- /dev/null
> +++ b/tests/acpi-utils.c
> @@ -0,0 +1,65 @@
> +/*
> + * ACPI Utility Functions
> + *
> + * Copyright (c) 2013 Red Hat Inc.
> + * Copyright (c) 2017 Skyport Systems
> + *
> + * Authors:
> + *  Michael S. Tsirkin <mst@redhat.com>,
> + *  Ben Warren <ben@skyportsystems.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +#include "qemu-common.h"
> +#include "hw/smbios/smbios.h"
> +#include "qemu/bitmap.h"
> +#include "acpi-utils.h"
> +#include "boot-sector.h"
> +
> +uint8_t acpi_calc_checksum(const uint8_t *data, int len)
> +{
> +    int i;
> +    uint8_t sum = 0;
> +
> +    for (i = 0; i < len; i++) {
> +        sum += data[i];
> +    }
> +
> +    return sum;
> +}
> +
> +uint32_t acpi_find_rsdp_address(void)
> +{
> +    uint32_t off;
> +
> +    /* RSDP location can vary across a narrow range */
> +    for (off = 0xf0000; off < 0x100000; off += 0x10) {
> +        uint8_t sig[] = "RSD PTR ";
> +        int i;
> +
> +        for (i = 0; i < sizeof sig - 1; ++i) {
> +            sig[i] = readb(off + i);
> +        }
> +
> +        if (!memcmp(sig, "RSD PTR ", sizeof sig)) {
> +            break;
> +        }
> +    }
> +    return off;
> +}
> +
> +void acpi_parse_rsdp_table(uint32_t addr, AcpiRsdpDescriptor *rsdp_table)
> +{
> +    ACPI_READ_FIELD(rsdp_table->signature, addr);
> +    ACPI_ASSERT_CMP64(rsdp_table->signature, "RSD PTR ");
> +
> +    ACPI_READ_FIELD(rsdp_table->checksum, addr);
> +    ACPI_READ_ARRAY(rsdp_table->oem_id, addr);
> +    ACPI_READ_FIELD(rsdp_table->revision, addr);
> +    ACPI_READ_FIELD(rsdp_table->rsdt_physical_address, addr);
> +    ACPI_READ_FIELD(rsdp_table->length, addr);
> +}
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> new file mode 100644
> index 0000000..9f9a2d5
> --- /dev/null
> +++ b/tests/acpi-utils.h
> @@ -0,0 +1,94 @@
> +/*
> + * Utilities for working with ACPI tables
> + *
> + * Copyright (c) 2013 Red Hat Inc.
> + *
> + * Authors:
> + *  Michael S. Tsirkin <mst@redhat.com>,
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef TEST_ACPI_UTILS_H
> +#define TEST_ACPI_UTILS_H
> +
> +#include "hw/acpi/acpi-defs.h"
> +#include "libqtest.h"
> +
> +/* DSDT and SSDTs format */
> +typedef struct {
> +    AcpiTableHeader header;
> +    gchar *aml;            /* aml bytecode from guest */
> +    gsize aml_len;
> +    gchar *aml_file;
> +    gchar *asl;            /* asl code generated from aml */
> +    gsize asl_len;
> +    gchar *asl_file;
> +    bool tmp_files_retain;   /* do not delete the temp asl/aml */
> +} QEMU_PACKED AcpiSdtTable;
> +
> +#define ACPI_READ_FIELD(field, addr)           \
> +    do {                                       \
> +        switch (sizeof(field)) {               \
> +        case 1:                                \
> +            field = readb(addr);               \
> +            break;                             \
> +        case 2:                                \
> +            field = readw(addr);               \
> +            break;                             \
> +        case 4:                                \
> +            field = readl(addr);               \
> +            break;                             \
> +        case 8:                                \
> +            field = readq(addr);               \
> +            break;                             \
> +        default:                               \
> +            g_assert(false);                   \
> +        }                                      \
> +        addr += sizeof(field);                  \
> +    } while (0);
> +
> +#define ACPI_READ_ARRAY_PTR(arr, length, addr)  \
> +    do {                                        \
> +        int idx;                                \
> +        for (idx = 0; idx < length; ++idx) {    \
> +            ACPI_READ_FIELD(arr[idx], addr);    \
> +        }                                       \
> +    } while (0);
> +
> +#define ACPI_READ_ARRAY(arr, addr)                               \
> +    ACPI_READ_ARRAY_PTR(arr, sizeof(arr) / sizeof(arr[0]), addr)
> +
> +#define ACPI_READ_TABLE_HEADER(table, addr)                      \
> +    do {                                                         \
> +        ACPI_READ_FIELD((table)->signature, addr);               \
> +        ACPI_READ_FIELD((table)->length, addr);                  \
> +        ACPI_READ_FIELD((table)->revision, addr);                \
> +        ACPI_READ_FIELD((table)->checksum, addr);                \
> +        ACPI_READ_ARRAY((table)->oem_id, addr);                  \
> +        ACPI_READ_ARRAY((table)->oem_table_id, addr);            \
> +        ACPI_READ_FIELD((table)->oem_revision, addr);            \
> +        ACPI_READ_ARRAY((table)->asl_compiler_id, addr);         \
> +        ACPI_READ_FIELD((table)->asl_compiler_revision, addr);   \
> +    } while (0);
> +
> +#define ACPI_ASSERT_CMP(actual, expected) do { \
> +    uint32_t ACPI_ASSERT_CMP_le = cpu_to_le32(actual); \
> +    char ACPI_ASSERT_CMP_str[5] = {}; \
> +    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 4); \
> +    g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
> +} while (0)
> +
> +#define ACPI_ASSERT_CMP64(actual, expected) do { \
> +    uint64_t ACPI_ASSERT_CMP_le = cpu_to_le64(actual); \
> +    char ACPI_ASSERT_CMP_str[9] = {}; \
> +    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 8); \
> +    g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
> +} while (0)
> +
> +uint8_t acpi_calc_checksum(const uint8_t *data, int len);
> +uint32_t acpi_find_rsdp_address(void);
> +void acpi_parse_rsdp_table(uint32_t addr, AcpiRsdpDescriptor *rsdp_table);
> +
> +#endif  /* TEST_ACPI_UTILS_H */
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 5404805..423a6f5 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -13,10 +13,9 @@
>  #include "qemu/osdep.h"
>  #include <glib/gstdio.h>
>  #include "qemu-common.h"
> -#include "libqtest.h"
> -#include "hw/acpi/acpi-defs.h"
>  #include "hw/smbios/smbios.h"
>  #include "qemu/bitmap.h"
> +#include "acpi-utils.h"
>  #include "boot-sector.h"
>  
>  #define MACHINE_PC "pc"
> @@ -24,18 +23,6 @@
>  
>  #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
>  
> -/* DSDT and SSDTs format */
> -typedef struct {
> -    AcpiTableHeader header;
> -    gchar *aml;            /* aml bytecode from guest */
> -    gsize aml_len;
> -    gchar *aml_file;
> -    gchar *asl;            /* asl code generated from aml */
> -    gsize asl_len;
> -    gchar *asl_file;
> -    bool tmp_files_retain;   /* do not delete the temp asl/aml */
> -} QEMU_PACKED AcpiSdtTable;
> -
>  typedef struct {
>      const char *machine;
>      const char *variant;
> @@ -53,65 +40,6 @@ typedef struct {
>      int required_struct_types_len;
>  } test_data;
>  
> -#define ACPI_READ_FIELD(field, addr)           \
> -    do {                                       \
> -        switch (sizeof(field)) {               \
> -        case 1:                                \
> -            field = readb(addr);               \
> -            break;                             \
> -        case 2:                                \
> -            field = readw(addr);               \
> -            break;                             \
> -        case 4:                                \
> -            field = readl(addr);               \
> -            break;                             \
> -        case 8:                                \
> -            field = readq(addr);               \
> -            break;                             \
> -        default:                               \
> -            g_assert(false);                   \
> -        }                                      \
> -        addr += sizeof(field);                  \
> -    } while (0);
> -
> -#define ACPI_READ_ARRAY_PTR(arr, length, addr)  \
> -    do {                                        \
> -        int idx;                                \
> -        for (idx = 0; idx < length; ++idx) {    \
> -            ACPI_READ_FIELD(arr[idx], addr);    \
> -        }                                       \
> -    } while (0);
> -
> -#define ACPI_READ_ARRAY(arr, addr)                               \
> -    ACPI_READ_ARRAY_PTR(arr, sizeof(arr)/sizeof(arr[0]), addr)
> -
> -#define ACPI_READ_TABLE_HEADER(table, addr)                      \
> -    do {                                                         \
> -        ACPI_READ_FIELD((table)->signature, addr);               \
> -        ACPI_READ_FIELD((table)->length, addr);                  \
> -        ACPI_READ_FIELD((table)->revision, addr);                \
> -        ACPI_READ_FIELD((table)->checksum, addr);                \
> -        ACPI_READ_ARRAY((table)->oem_id, addr);                  \
> -        ACPI_READ_ARRAY((table)->oem_table_id, addr);            \
> -        ACPI_READ_FIELD((table)->oem_revision, addr);            \
> -        ACPI_READ_ARRAY((table)->asl_compiler_id, addr);         \
> -        ACPI_READ_FIELD((table)->asl_compiler_revision, addr);   \
> -    } while (0);
> -
> -#define ACPI_ASSERT_CMP(actual, expected) do { \
> -    uint32_t ACPI_ASSERT_CMP_le = cpu_to_le32(actual); \
> -    char ACPI_ASSERT_CMP_str[5] = {}; \
> -    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 4); \
> -    g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
> -} while (0)
> -
> -#define ACPI_ASSERT_CMP64(actual, expected) do { \
> -    uint64_t ACPI_ASSERT_CMP_le = cpu_to_le64(actual); \
> -    char ACPI_ASSERT_CMP_str[9] = {}; \
> -    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 8); \
> -    g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
> -} while (0)
> -
>  static char disk[] = "tests/acpi-test-disk-XXXXXX";
>  static const char *data_dir = "tests/acpi-test-data";
>  #ifdef CONFIG_IASL
> @@ -147,36 +75,9 @@ static void free_test_data(test_data *data)
>      g_array_free(data->tables, false);
>  }
>  
> -static uint8_t acpi_checksum(const uint8_t *data, int len)
> -{
> -    int i;
> -    uint8_t sum = 0;
> -
> -    for (i = 0; i < len; i++) {
> -        sum += data[i];
> -    }
> -
> -    return sum;
> -}
> -
>  static void test_acpi_rsdp_address(test_data *data)
>  {
> -    uint32_t off;
> -
> -    /* OK, now find RSDP */
> -    for (off = 0xf0000; off < 0x100000; off += 0x10) {
> -        uint8_t sig[] = "RSD PTR ";
> -        int i;
> -
> -        for (i = 0; i < sizeof sig - 1; ++i) {
> -            sig[i] = readb(off + i);
> -        }
> -
> -        if (!memcmp(sig, "RSD PTR ", sizeof sig)) {
> -            break;
> -        }
> -    }
> -
> +    uint32_t off = acpi_find_rsdp_address();
>      g_assert_cmphex(off, <, 0x100000);
>      data->rsdp_addr = off;
>  }
> @@ -186,17 +87,10 @@ static void test_acpi_rsdp_table(test_data *data)
>      AcpiRsdpDescriptor *rsdp_table = &data->rsdp_table;
>      uint32_t addr = data->rsdp_addr;
>  
> -    ACPI_READ_FIELD(rsdp_table->signature, addr);
> -    ACPI_ASSERT_CMP64(rsdp_table->signature, "RSD PTR ");
> -
> -    ACPI_READ_FIELD(rsdp_table->checksum, addr);
> -    ACPI_READ_ARRAY(rsdp_table->oem_id, addr);
> -    ACPI_READ_FIELD(rsdp_table->revision, addr);
> -    ACPI_READ_FIELD(rsdp_table->rsdt_physical_address, addr);
> -    ACPI_READ_FIELD(rsdp_table->length, addr);
> +    acpi_parse_rsdp_table(addr, rsdp_table);
>  
>      /* rsdp checksum is not for the whole table, but for the first 20 bytes */
> -    g_assert(!acpi_checksum((uint8_t *)rsdp_table, 20));
> +    g_assert(!acpi_calc_checksum((uint8_t *)rsdp_table, 20));
>  }
>  
>  static void test_acpi_rsdt_table(test_data *data)
> @@ -220,8 +114,9 @@ static void test_acpi_rsdt_table(test_data *data)
>      tables = g_new0(uint32_t, tables_nr);
>      ACPI_READ_ARRAY_PTR(tables, tables_nr, addr);
>  
> -    checksum = acpi_checksum((uint8_t *)rsdt_table, rsdt_table->length) +
> -               acpi_checksum((uint8_t *)tables, tables_nr * sizeof(uint32_t));
> +    checksum = acpi_calc_checksum((uint8_t *)rsdt_table, rsdt_table->length) +
> +               acpi_calc_checksum((uint8_t *)tables,
> +                                  tables_nr * sizeof(uint32_t));
>      g_assert(!checksum);
>  
>     /* SSDT tables after FADT */
> @@ -279,7 +174,7 @@ static void test_acpi_fadt_table(test_data *data)
>      ACPI_READ_FIELD(fadt_table->flags, addr);
>  
>      ACPI_ASSERT_CMP(fadt_table->signature, "FACP");
> -    g_assert(!acpi_checksum((uint8_t *)fadt_table, fadt_table->length));
> +    g_assert(!acpi_calc_checksum((uint8_t *)fadt_table, fadt_table->length));
>  }
>  
>  static void test_acpi_facs_table(test_data *data)
> @@ -308,8 +203,10 @@ static void test_dst_table(AcpiSdtTable *sdt_table, uint32_t addr)
>      sdt_table->aml = g_malloc0(sdt_table->aml_len);
>      ACPI_READ_ARRAY_PTR(sdt_table->aml, sdt_table->aml_len, addr);
>  
> -    checksum = acpi_checksum((uint8_t *)sdt_table, sizeof(AcpiTableHeader)) +
> -               acpi_checksum((uint8_t *)sdt_table->aml, sdt_table->aml_len);
> +    checksum = acpi_calc_checksum((uint8_t *)sdt_table,
> +                                  sizeof(AcpiTableHeader)) +
> +               acpi_calc_checksum((uint8_t *)sdt_table->aml,
> +                                  sdt_table->aml_len);
>      g_assert(!checksum);
>  }
>  
> @@ -608,8 +505,9 @@ static bool smbios_ep_table_ok(test_data *data)
>          return false;
>      }
>      ACPI_READ_FIELD(ep_table->smbios_bcd_revision, addr);
> -    if (acpi_checksum((uint8_t *)ep_table, sizeof *ep_table) ||
> -        acpi_checksum((uint8_t *)ep_table + 0x10, sizeof *ep_table - 0x10)) {
> +    if (acpi_calc_checksum((uint8_t *)ep_table, sizeof *ep_table) ||
> +        acpi_calc_checksum((uint8_t *)ep_table + 0x10,
> +                           sizeof *ep_table - 0x10)) {
>          return false;
>      }
>      return true;
