Received: from eggs.gnu.org ([209.51.188.92]:45333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZ7f-00061K-AQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZ7d-00023R-O6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:48:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:36762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJZ7d-00022f-Ew
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:48:45 -0400
Date: Thu, 25 Apr 2019 15:48:13 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190425074813.GC24829@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556170489-131927-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/13] tests: acpi: skip FACS table if
 board uses hw reduced ACPI profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

On Thu, Apr 25, 2019 at 07:34:41AM +0200, Igor Mammedov wrote:
>If FADT has HW_REDUCED_ACPI flag set, do not attempt to fetch
>FACS as it's not provided by the board.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> tests/bios-tables-test.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index ed62a17..e944d00 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -146,9 +146,13 @@ static void test_acpi_fadt_table(test_data *data)
>     g_assert(compare_signature(&table, "FACP"));
> 
>     /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
>-    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
>-                     fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
>-    g_array_append_val(data->tables, table);
>+    memcpy(&val, fadt_aml + 112 /* Flags */, 4);
>+    val = le32_to_cpu(val);
>+    if (!(val & 1UL << 20 /* HW_REDUCED_ACPI */)) {
>+        acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
>+                         fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
>+        g_array_append_val(data->tables, table);
>+    }
> 
>     memcpy(&val, fadt_aml + dsdt_offset, 4);
>     val = le32_to_cpu(val);
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me
