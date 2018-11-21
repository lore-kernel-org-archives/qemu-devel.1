Received: from eggs.gnu.org ([2001:4830:134:3::10]:49916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gPHtr-0005mP-M0
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gPHtp-0002qH-Pv
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:12720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gPHtp-0002mN-EY
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:05:53 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Wed, 21 Nov 2018 10:06:05 +0800
Message-Id: <1542765966-20244-5-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1542765966-20244-4-git-send-email-lizhijian@cn.fujitsu.com>
References: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-3-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-4-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH v2 4/5] x86: exit qemu if load_image fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <zhijianx.li@intel.com>, Philip Li <philip.li@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/i386/pc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f095725..2ffe6fb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -984,7 +984,10 @@ static void load_linux(PCMachineState *pcms,
         initrd_addr = (initrd_max-initrd_size) & ~4095;
 
         initrd_data = g_malloc(initrd_size);
-        load_image(initrd_filename, initrd_data);
+        if (load_image(initrd_filename, initrd_data) < 0) {
+            fprintf(stderr, "failed to load initrd\n");
+            exit(1);
+        }
 
         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
-- 
2.7.4
