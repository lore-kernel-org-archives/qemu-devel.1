Received: from eggs.gnu.org ([2001:4830:134:3::10]:46112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eN2Y3-0007O0-Ey
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 15:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eN2Y2-0006iK-IJ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 15:13:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  7 Dec 2017 20:13:16 +0000
Message-Id: <20171207201320.19284-3-stefanha@redhat.com>
In-Reply-To: <20171207201320.19284-1-stefanha@redhat.com>
References: <20171207201320.19284-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/6] docs: mark nested AioContext locking as
 a legacy API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

See the patch for why nested AioContext locking is no longer allowed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/multiple-iothreads.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/devel/multiple-iothreads.txt b/docs/devel/multiple-iothreads.txt
index e4d340bbb7..4f9012d154 100644
--- a/docs/devel/multiple-iothreads.txt
+++ b/docs/devel/multiple-iothreads.txt
@@ -1,4 +1,4 @@
-Copyright (c) 2014 Red Hat Inc.
+Copyright (c) 2014-2017 Red Hat Inc.
 
 This work is licensed under the terms of the GNU GPL, version 2 or later.  See
 the COPYING file in the top-level directory.
@@ -92,8 +92,9 @@ aio_context_acquire()/aio_context_release() for mutual exclusion.  Once the
 context is acquired no other thread can access it or run event loop iterations
 in this AioContext.
 
-aio_context_acquire()/aio_context_release() calls may be nested.  This
-means you can call them if you're not sure whether #2 applies.
+Legacy code sometimes nests aio_context_acquire()/aio_context_release() calls.
+Do not use nesting anymore, it is incompatible with the BDRV_POLL_WHILE() macro
+used in the block layer and can lead to hangs.
 
 There is currently no lock ordering rule if a thread needs to acquire multiple
 AioContexts simultaneously.  Therefore, it is only safe for code holding the
-- 
2.14.3
