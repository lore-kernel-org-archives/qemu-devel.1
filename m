Received: from eggs.gnu.org ([2001:4830:134:3::10]:46040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iD-0001op-Ln
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iC-0008Uk-Ph
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:37 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:07 -0500
Message-Id: <20180619014319.28272-42-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 041/113] multiboot: Check validity of
 mh_header_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

I couldn't find a case where this prevents something bad from happening
that isn't already caught by other checks, but let's err on the safe
side and check that mh_header_addr is as expected.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>
(cherry picked from commit dbf2dce7aabb7723542bd182175904846d70b0f9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/multiboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 775aa5bfd0..36b22832cd 100644
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
2.11.0
