Received: from eggs.gnu.org ([2001:4830:134:3::10]:46213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcav-0006m2-VC
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcau-0001Zx-Re
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  1 May 2018 16:13:33 -0500
Message-Id: <20180501211336.986372-2-eblake@redhat.com>
In-Reply-To: <20180501211336.986372-1-eblake@redhat.com>
References: <20180501211336.986372-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] nbd: Prepare for additional block sizing
 info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The NBD spec is clarifying [1] that a server may want to advertise
different limits for READ/WRITE (in our case, 32M) than for
TRIM/ZERO (in our case, nearly 4G).  Add the constants and name
lookups for new NBD_INFO_ fields used during handshake to convey
this additional information.  Note that the NBD spec already
requires servers to ignore unknown requests from the client, and
for clients to ignore unknown gratuitous responses sent from
the server.

[1] https://lists.debian.org/nbd/2018/03/msg00048.html

Signed-off-by: Eric Blake <eblake@redhat.com>

---

The given URL for the NBD spec was v3; it will change to be a v4
version of that patch in part to point back to this qemu commit
as a proof of implementation.
---
 include/block/nbd.h | 4 +++-
 nbd/common.c        | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index fcdcd545023..cbf51628f78 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2017 Red Hat, Inc.
+ *  Copyright (C) 2016-2018 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -180,6 +180,8 @@ typedef struct NBDExtent {
 #define NBD_INFO_NAME           1
 #define NBD_INFO_DESCRIPTION    2
 #define NBD_INFO_BLOCK_SIZE     3
+#define NBD_INFO_TRIM_SIZE      4
+#define NBD_INFO_ZERO_SIZE      5

 /* Request flags, sent from client to server during transmission phase */
 #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during write */
diff --git a/nbd/common.c b/nbd/common.c
index 8c95c1d606e..840c91d5ca4 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -129,6 +129,10 @@ const char *nbd_info_lookup(uint16_t info)
         return "description";
     case NBD_INFO_BLOCK_SIZE:
         return "block size";
+    case NBD_INFO_TRIM_SIZE:
+        return "trim size";
+    case NBD_INFO_ZERO_SIZE:
+        return "zero size";
     default:
         return "<unknown>";
     }
-- 
2.14.3
