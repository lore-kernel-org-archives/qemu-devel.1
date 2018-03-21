Received: from eggs.gnu.org ([2001:4830:134:3::10]:37458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyevc-0006qN-V0
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyevb-0002D8-NY
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46718 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eyevb-0002Cz-Ir
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Mar 2018 15:41:04 +0100
Message-Id: <20180321144107.22770-3-kwolf@redhat.com>
In-Reply-To: <20180321144107.22770-1-kwolf@redhat.com>
References: <20180321144107.22770-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] multiboot: Check validity of mh_header_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org

I couldn't find a case where this prevents something bad from happening
that isn't already caught by other checks, but let's err on the safe
side and check that mh_header_addr is as expected.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>
---
 hw/i386/multiboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 1e215bf8d3..5bc0a2cddb 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -229,6 +229,10 @@ int load_multiboot(FWCfgState *fw_cfg,
             error_report("invalid load_addr address");
             exit(1);
         }
+        if (mh_header_addr - mh_load_addr > i) {
+            error_report("invalid header_addr address");
+            exit(1);
+        }
 
         uint32_t mb_kernel_text_offset = i - (mh_header_addr - mh_load_addr);
         uint32_t mb_load_size = 0;
-- 
2.13.6
