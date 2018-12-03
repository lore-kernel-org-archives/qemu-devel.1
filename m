Received: from eggs.gnu.org ([2001:4830:134:3::10]:33798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gTpNv-00023M-Ex
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gTpNu-0000iN-MP
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gTpNu-0000gE-B2
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:42 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Mon,  3 Dec 2018 22:48:52 +0800
Message-Id: <1543848532-12604-5-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH for-4.0 v3 4/4] i386: allow to load initrd
 below 4G for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philip.li@intel.com, zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

a new field xloadflags was added to recent x86 linux, and BIT 1:
XLF_CAN_BE_LOADED_ABOVE_4G is used to tell bootload that where initrd can be
loaded safely.

Current QEMU/BIOS always loads initrd below below_4g_mem_size which is always
less than 4G, so here limiting initrd_max to 4G - 1 simply is enough if
this bit is set.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

---
V3: correct grammar and check XLF_CAN_BE_LOADED_ABOVE_4G first (Michael S. Tsirkin)

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/i386/pc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8db7417..ebaa65f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -897,7 +897,15 @@ static void load_linux(PCMachineState *pcms,
 #endif
 
     /* highest address for loading the initrd */
-    if (protocol >= 0x203) {
+    if (protocol >= 0x20c &&
+        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
+        /*
+         * Although kernel allows initrd loading to above 4G,
+         * it just makes it as large as possible while still staying below 4G
+         * since current BIOS always loads initrd below pcms->below_4g_mem_size
+         */
+        initrd_max = UINT32_MAX;
+    } else if (protocol >= 0x203) {
         initrd_max = ldl_p(header+0x22c);
     } else {
         initrd_max = 0x37ffffff;
-- 
2.7.4
