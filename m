Received: from eggs.gnu.org ([2001:4830:134:3::10]:57673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8ZjC-0003w7-Ur
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zj7-0000sX-W9
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:41:50 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat,  6 Oct 2018 01:40:22 +0200
Message-Id: <20181005234023.8104-31-mreitz@redhat.com>
In-Reply-To: <20181005234023.8104-1-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 30/31] block: BDS options may lack the
 "driver" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

When BDSs are created by qemu itself (e.g. as filters in block jobs),
they may not have a "driver" option in their options QDict.  When
generating a json:{} filename, however, it must always be present.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block.c b/block.c
index 041adb90d1..ecb228b8f8 100644
--- a/block.c
+++ b/block.c
@@ -5306,6 +5306,12 @@ static bool append_strong_runtime_options(QDict *d, BlockDriverState *bs)
         }
     }
 
+    if (!qdict_haskey(d, "driver")) {
+        /* Drivers created with bdrv_new_open_driver() may not have a
+         * @driver option.  Add it here. */
+        qdict_put_str(d, "driver", bs->drv->format_name);
+    }
+
     return found_any;
 }
 
-- 
2.17.1
