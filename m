Received: from eggs.gnu.org ([209.51.188.92]:42424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46e-0003Eb-6c
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46c-0004gQ-Su
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45218
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46c-0004Y7-JA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4MY4054970
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:22 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkr97p9sb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:19 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:50 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:55 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-22-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 21/97] aio-posix: Don't count ctx->notifier as
 progress when polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

The same logic exists in fd polling. This change is especially important
to avoid busy loop once we limit aio_notify_accept() to blocking
aio_poll().

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180809132259.18402-2-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
(cherry picked from commit 70232b5253a3c4e03ed1ac47ef9246a8ac66c6fa)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 util/aio-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 118bf5784b..b5c7f463aa 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -494,7 +494,8 @@ static bool run_poll_handlers_once(AioContext *ctx)
     QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         if (!node->deleted && node->io_poll &&
             aio_node_check(ctx, node->is_external) &&
-            node->io_poll(node->opaque)) {
+            node->io_poll(node->opaque) &&
+            node->opaque != &ctx->notifier) {
             progress = true;
         }
 
-- 
2.17.1
