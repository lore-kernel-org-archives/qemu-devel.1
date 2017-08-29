Received: from eggs.gnu.org ([2001:4830:134:3::10]:49008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCv-0001rH-8d
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCs-0006IA-2u
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34270
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCr-0006HR-Tq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8wK043828
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:37 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmu3kpetr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:37 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:36 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:48 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-74-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 73/79] input: Decrement queue count on kbd delay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>

From: Alexander Graf <agraf@suse.de>

Delays in the input layer are special cased input events. Every input
event is accounted for in a global intput queue count. The special cased
delays however did not get removed from the queue, leading to queue overruns
and thus silent key drops after typing quite a few characters.

Signed-off-by: Alexander Graf <agraf@suse.de>
Message-id: 1498117318-162102-1-git-send-email-agraf@suse.de
Fixes: be1a7176 ("input: add support for kbd delays")
Cc: qemu-stable@nongnu.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 77b0359bf414ad666d1714dc9888f1017c08e283)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 ui/input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/input.c b/ui/input.c
index fb1f404..94ba3d5 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -252,6 +252,7 @@ static void qemu_input_queue_process(void *opaque)
     item = QTAILQ_FIRST(queue);
     g_assert(item->type == QEMU_INPUT_QUEUE_DELAY);
     QTAILQ_REMOVE(queue, item, node);
+    queue_count--;
     g_free(item);
 
     while (!QTAILQ_EMPTY(queue)) {
-- 
2.7.4
