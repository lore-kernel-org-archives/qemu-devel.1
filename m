Received: from eggs.gnu.org ([2001:4830:134:3::10]:43281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbk-00038w-8l
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbj-0000L1-Je
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:36 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:27 +0200
Message-Id: <20180809213528.14738-31-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 30/31] block: BDS options may lack
 the "driver" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

When BDSs are created by qemu itself (e.g. as filters in block jobs),
they may not have a "driver" option in their options QDict.  When
generating a json:{} filename, however, it must always be present.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block.c b/block.c
index c4aec7ea65..5118d992c3 100644
--- a/block.c
+++ b/block.c
@@ -5242,6 +5242,12 @@ static bool append_strong_runtime_options(QDict *d, BlockDriverState *bs)
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
