Received: from eggs.gnu.org ([209.51.188.92]:42010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gjNh7-00005y-RQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gjNh6-00046T-VP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:19:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gjNh6-00045t-Oj
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:19:48 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Tue, 15 Jan 2019 12:18:07 +0000
Message-Id: <1547554687-12687-6-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>
References: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v3 5/5] pvh: load initrd and expose it through
 fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, stefanha@redhat.com, maran.wilson@oracle.com, george.kennedy@oracle.com, boris.ostrovsky@oracle.com, liam.merwick@oracle.com

From: Stefano Garzarella <sgarzare@redhat.com>

When initrd is specified, load and expose it to the guest firmware
through fw_cfg. The firmware will fill the hvm_start_info for the
kernel.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Based-on: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 hw/i386/pc.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6d549950a044..9ed5063de8f8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1213,25 +1213,45 @@ static void load_linux(PCMachineState *pcms,
          */
         if (load_elfboot(kernel_filename, kernel_size,
                          header, pvh_start_addr, fw_cfg)) {
-            struct hvm_modlist_entry ramdisk_mod = { 0 };
-
             fclose(f);
 
             fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
                 strlen(kernel_cmdline) + 1);
             fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
 
-            assert(machine->device_memory != NULL);
-            ramdisk_mod.paddr = machine->device_memory->base;
-            ramdisk_mod.size =
-                memory_region_size(&machine->device_memory->mr);
-
-            fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, &ramdisk_mod,
-                             sizeof(ramdisk_mod));
             fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
             fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
                              header, sizeof(header));
 
+            /* load initrd */
+            if (initrd_filename) {
+                gsize initrd_size;
+                gchar *initrd_data;
+                GError *gerr = NULL;
+
+                if (!g_file_get_contents(initrd_filename, &initrd_data,
+                            &initrd_size, &gerr)) {
+                    fprintf(stderr, "qemu: error reading initrd %s: %s\n",
+                            initrd_filename, gerr->message);
+                    exit(1);
+                }
+
+                initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
+                if (initrd_size >= initrd_max) {
+                    fprintf(stderr, "qemu: initrd is too large, cannot support."
+                            "(max: %"PRIu32", need %"PRId64")\n",
+                            initrd_max, (uint64_t)initrd_size);
+                    exit(1);
+                }
+
+                initrd_addr = (initrd_max - initrd_size) & ~4095;
+
+                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
+                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
+                fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data,
+                                 initrd_size);
+            }
+
             return;
         }
         /* This looks like a multiboot kernel. If it is, let's stop
-- 
1.8.3.1
