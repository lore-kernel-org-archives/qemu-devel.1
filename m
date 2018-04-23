Received: from eggs.gnu.org ([2001:4830:134:3::10]:46533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fAkUB-0003vo-N9
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 19:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fAkU8-0007Pn-Fj
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 19:03:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fAkU8-0007Pf-C4
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 19:03:00 -0400
Date: Tue, 24 Apr 2018 02:02:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1524524398-41342-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] acpi/nvdimm: remove forward name references
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Schmauss, Erik" <erik.schmauss@intel.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

NVDIMM SSDT table references a name ("MEMA") before
it is defined. This is reported to no longer be supported
since Linux 4.17-rc1.

While arguably Linux needs to keep working on old hypervisors, and other
OSes seem fine with our behaviour, it seems cleaner to have the
definition appear in the SSDT before use.

Suggested-by: "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Hi Erik,
could you pls test the issue and report whether it addresses
your concern? I can't do much to fix past releases which IIUC
shipped this code since 2.6.0 about a year ago.

Lightly tested with Linux only.

 hw/acpi/nvdimm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 59d6e42..fadebbd 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1234,6 +1234,10 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
     ssdt = init_aml_allocator();
     acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
 
+    /* Storage for the memory address */
+    mem_addr_offset = table_data->len +
+        build_append_named_dword(ssdt->buf, NVDIMM_ACPI_MEM_ADDR);
+
     sb_scope = aml_scope("\\_SB");
 
     dev = aml_device("NVDR");
@@ -1266,8 +1270,6 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
 
     /* copy AML table into ACPI tables blob and patch header there */
     g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
-    mem_addr_offset = build_append_named_dword(table_data,
-                                               NVDIMM_ACPI_MEM_ADDR);
 
     bios_linker_loader_alloc(linker,
                              NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,
-- 
MST
