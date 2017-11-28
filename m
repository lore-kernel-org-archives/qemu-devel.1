Received: from eggs.gnu.org ([2001:4830:134:3::10]:37154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eJejF-00063K-GX
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eJejE-0005Ri-Nl
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:11:09 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Tue, 28 Nov 2017 15:10:54 +0300
Message-Id: <20171128121055.6954-2-den@openvz.org>
In-Reply-To: <20171128121055.6954-1-den@openvz.org>
References: <20171128121055.6954-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/2] hmp: block qemu-io command for device
 without media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

In this case blk->bs == NULL and the code will just crash. Emulate error
on that path.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 hmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hmp.c b/hmp.c
index 35a7041824..cfd1d9ab29 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2336,6 +2336,9 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
         } else {
             goto fail;
         }
+    } else if (!blk_is_available(blk)) {
+        error_setg(&err, "No media in the device '%s'", device);
+        goto fail;
     }
 
     aio_context = blk_get_aio_context(blk);
-- 
2.11.0
