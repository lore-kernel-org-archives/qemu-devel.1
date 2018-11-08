Received: from eggs.gnu.org ([2001:4830:134:3::10]:40134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKhRx-0005CN-LR
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKhI8-0008VK-AU
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:12:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:7256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gKhI7-0008Tr-UV
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:12:00 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Thu,  8 Nov 2018 18:59:42 +0800
Message-Id: <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1 to
 allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>

x86/x86_64 has alredy supported 4G initrd.

linux/arch/x86/boot/header.S:
 # (Header version 0x0203 or later) the highest safe address for the contents
 # of an initrd. The current kernel allows up to 4 GB, but leave it at 2 GB to
 # avoid possible bootloader bugs.

CC: Philip Li <philip.li@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/i386/pc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cd5029c..e1b910f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -913,6 +913,12 @@ static void load_linux(PCMachineState *pcms,
     /* highest address for loading the initrd */
     if (protocol >= 0x203) {
         initrd_max = ldl_p(header+0x22c);
+        if (initrd_max == 0x7fffffff) {
+            /* for some reasons, initrd_max is hard code with 0x7fffffff
+             * hard code to 4G - 1 to allow 4G initrd
+             */
+            initrd_max = UINT32_MAX - 1;
+        }
     } else {
         initrd_max = 0x37ffffff;
     }
-- 
2.7.4
