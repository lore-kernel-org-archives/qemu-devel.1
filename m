Received: from eggs.gnu.org ([209.51.188.92]:34943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gwmDY-0002zR-BO
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gwmDS-0007Xj-Mv
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:08:40 -0500
From: yuchenlin@synology.com
Date: Thu, 21 Feb 2019 11:08:05 +0000
Message-Id: <20190221110805.28239-1-yuchenlin@synology.com>
Subject: [Qemu-devel] [PATCH] vmdk: false positive of compat6 with hwversion
 not set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, qemu-block@nongnu.org, yuchenlin <yuchenlin@synology.com>

From: yuchenlin <yuchenlin@synology.com>

In vmdk_co_create_opts, when it finds hw_version is undefined, it will
set it to 4, which misleading the compat6 and hwversion in
vmdk_co_do_create. Simply set hw_version to NULL after free, let
the logic in vmdk_co_do_create to decide the value of hw_version.

This bug can be reproduced by:

$ qemu-img convert -O vmdk -o subformat=streamOptimized,compat6
/home/yuchenlin/syno.qcow2 /home/yuchenlin/syno.vmdk

qemu-img: /home/yuchenlin/syno.vmdk: error while converting vmdk:
compat6 cannot be enabled with hwversion set

Signed-off-by: yuchenlin <yuchenlin@synology.com>
---
 block/vmdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 096e8eb662..e3bbd18803 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2260,7 +2260,7 @@ static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts
     compat6 = qemu_opt_get_bool_del(opts, BLOCK_OPT_COMPAT6, false);
     if (strcmp(hw_version, "undefined") == 0) {
         g_free(hw_version);
-        hw_version = g_strdup("4");
+        hw_version = NULL;
     }
     fmt = qemu_opt_get_del(opts, BLOCK_OPT_SUBFMT);
     zeroed_grain = qemu_opt_get_bool_del(opts, BLOCK_OPT_ZEROED_GRAIN, false);
-- 
2.17.1
