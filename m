Received: from eggs.gnu.org ([2001:4830:134:3::10]:34747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGI-00038k-11
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGH-0004CZ-CC
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 14 Mar 2018 18:32:10 +0100
Message-Id: <20180314173213.18563-3-kwolf@redhat.com>
In-Reply-To: <20180314173213.18563-1-kwolf@redhat.com>
References: <20180314173213.18563-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] multiboot: Check validity of mh_header_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, jack.schwartz@oracle.com, anatol.pomozov@gmail.com, ppandit@redhat.com

I couldn't find a case where this prevents something bad from happening
that isn't already caught by other checks, but let's err on the safe
side and check that mh_header_addr is as expected.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
