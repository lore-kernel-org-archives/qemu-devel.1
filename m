Received: from eggs.gnu.org ([2001:4830:134:3::10]:37851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cdz6I-0003rc-1R
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cdz6D-0008KW-6a
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:54:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cdz6C-0008Ju-TA
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:54:21 -0500
Date: Wed, 15 Feb 2017 13:54:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170215135416.1a686fe2@nial.brq.redhat.com>
In-Reply-To: <96c621a0c1588234e473bf0c0d068af8812f3225.1487139038.git.ben@skyportsystems.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<96c621a0c1588234e473bf0c0d068af8812f3225.1487139038.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 6/7] tests: Move reusable ACPI macros
 into a new header file
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

On Tue, 14 Feb 2017 22:15:48 -0800
ben@skyportsystems.com wrote:

> From: Ben Warren <ben@skyportsystems.com>
> 
> Also usable by upcoming VM Generation ID tests
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  tests/acpi-utils.h       | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/bios-tables-test.c | 72 +---------------------------------------------
>  2 files changed, 76 insertions(+), 71 deletions(-)
>  create mode 100644 tests/acpi-utils.h
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> new file mode 100644
> index 0000000..d5e5eff
> --- /dev/null
> +++ b/tests/acpi-utils.h
> @@ -0,0 +1,75 @@
> +#ifndef TEST_ACPI_UTILS_H
> +#define TEST_ACPI_UTILS_H
here should be includes for types/functions used within this file

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
> +#endif  /* TEST_ACPI_UTILS_H */
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 5404805..c642f7f 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -17,6 +17,7 @@
>  #include "hw/acpi/acpi-defs.h"
>  #include "hw/smbios/smbios.h"
>  #include "qemu/bitmap.h"
> +#include "acpi-utils.h"
>  #include "boot-sector.h"
>  
>  #define MACHINE_PC "pc"
> @@ -24,18 +25,6 @@
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
> @@ -53,65 +42,6 @@ typedef struct {
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
