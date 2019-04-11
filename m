Received: from eggs.gnu.org ([209.51.188.92]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hEhzw-0004gP-Ug
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hEhzv-0002R0-Ht
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:16:44 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:39425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hEhzt-0002OR-Ke
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:16:41 -0400
Received: by mail-ed1-x544.google.com with SMTP id k45so6613600edb.6
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:16:40 -0700 (PDT)
Date: Thu, 11 Apr 2019 22:16:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190411221638.wiok2e7eik5btwq2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] q35: acpi: do not create dummy
 MCFG table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, richardw.yang@linux.intel.com, ehabkost@redhat.com, mst@redhat.com

On Tue, Apr 09, 2019 at 05:00:37PM +0200, Igor Mammedov wrote:
>Dummy table (with signature "QEMU") creation came from original SeaBIOS
>codebase. And QEMU would have to keep it around if there were Q35 machine
>that depended on keeping ACPI tables blob constant size. Luckily there
>were no versioned Q35 machine types before commit:
>  (since 2.3) a1666142db acpi-build: make ROMs RAM blocks resizeable
>which obsoleted need to keep ACPI tables blob the same size on source/destination.
>
>Considering the 1st versioned machine is pc-q35-2.4, the dummy table
>is not really necessary and it's safe to drop it without breaking
>cross version migration in both directions unconditionally.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> hw/i386/acpi-build.c | 18 ++++--------------
> 1 file changed, 4 insertions(+), 14 deletions(-)
>
>diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>index 416da31..8671e25 100644
>--- a/hw/i386/acpi-build.c
>+++ b/hw/i386/acpi-build.c
>@@ -2401,7 +2401,6 @@ static void
> build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> {
>     AcpiTableMcfg *mcfg;
>-    const char *sig;
>     int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
> 
>     mcfg = acpi_data_push(table_data, len);
>@@ -2411,19 +2410,7 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>     mcfg->allocation[0].start_bus_number = 0;
>     mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
> 
>-    /* MCFG is used for ECAM which can be enabled or disabled by guest.
>-     * To avoid table size changes (which create migration issues),
>-     * always create the table even if there are no allocations,
>-     * but set the signature to a reserved value in this case.
>-     * ACPI spec requires OSPMs to ignore such tables.
>-     */
>-    if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
>-        /* Reserved signature: ignored by OSPM */
>-        sig = "QEMU";
>-    } else {
>-        sig = "MCFG";
>-    }
>-    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
>+    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> }
> 
> /*
>@@ -2592,6 +2579,9 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>     }
>     mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
>     qobject_unref(o);
>+    if (mcfg->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
>+        return false;
>+    }
> 
>     o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
>     assert(o);
>-- 
>2.7.4
>

-- 
Wei Yang
Help you, Help me
