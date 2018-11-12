Received: from eggs.gnu.org ([2001:4830:134:3::10]:48300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gM694-0000mC-Jj
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gM68G-00064L-KD
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:55:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:11414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gM68F-0005pi-VS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 01:55:36 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Mon, 12 Nov 2018 15:45:30 +0800
Message-Id: <1542008730-6375-3-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1542008730-6375-2-git-send-email-lizhijian@cn.fujitsu.com>
References: <1542008730-6375-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1542008730-6375-2-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH 3/3] x86: allow load initrd below 4G for recent
 linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhijianx.li@intel.com, philip.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

a new field xloadflags was added to recent x86 linux, and BIT 1:
XLF_CAN_BE_LOADED_ABOVE_4G is used to tell bootload that where initrd can be
loaded saftly.

Current QEMU always load initrd below below_4g_mem_size which always
less than 4G, so here limit initrd_max to 4G - 1 simply is enough if
this bit is set.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/i386/pc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f095725..5e2f83c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -92,6 +92,7 @@
 #define FW_CFG_HPET (FW_CFG_ARCH_LOCAL + 4)
 
 #define E820_NR_ENTRIES		16
+#define XLF_CAN_BE_LOADED_ABOVE_4G_MASK (1 << 1)
 
 struct e820_entry {
     uint64_t address;
@@ -916,6 +917,17 @@ static void load_linux(PCMachineState *pcms,
     } else {
         initrd_max = 0x37ffffff;
     }
+    if (protocol >= 0x20c) {
+        unsigned int xloadflags = lduw_p(header+0x236);
+        if (xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G_MASK) {
+                /*
+                 * Although kernel allow initrd loading to above 4G, here we
+                 * limit initrd_max to 4G -1 due to current QEMU always loads
+                 * initrd below pcms->below_4g_mem_size
+                 */
+                initrd_max = UINT32_MAX;
+        }
+    }
 
     if (initrd_max >= pcms->below_4g_mem_size - pcmc->acpi_data_size) {
         initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
-- 
2.7.4
