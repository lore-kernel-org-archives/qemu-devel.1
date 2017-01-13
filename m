Received: from eggs.gnu.org ([2001:4830:134:3::10]:53941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cS5Up-0004Eo-R4
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cS5Uk-0004KR-O8
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:18:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cS5Uk-0004KH-E2
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:18:30 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0DH9Hgl020217
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 12:18:29 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27y1jfm1pr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 12:18:28 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 13 Jan 2017 10:18:28 -0700
From: Greg Kurz <groug@kaod.org>
Date: Fri, 13 Jan 2017 18:18:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148432790018.21615.8366831585737978346.stgit@bahia>
Subject: [Qemu-devel] [PATCH] 9pfs: fix off-by-one error in PDU free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: v9fs-developer@lists.sourceforge.net, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The server can handle MAX_REQ - 1 PDUs at a time and the virtio-9p
device has a MAX_REQ sized virtqueue. If the client manages to fill
up the virtqueue, pdu_alloc() will fail and the request won't be
processed without any notice to the client (it actually causes the
linux 9p client to hang).

This has been there since the beginning (commit 9f10751365b2 "virtio-9p:
Add a virtio 9p device to qemu"), but it needs an agressive workload to
run in the guest to show up.

We actually allocate MAX_REQ PDUs and I see no reason not to link them
all into the free list, so let's fix the init loop.

Reported-by: Tuomas Tynkkynen <tuomas@tuxera.com>
Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index fa58877570f6..965c8edc8030 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3454,7 +3454,7 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
     /* initialize pdu allocator */
     QLIST_INIT(&s->free_list);
     QLIST_INIT(&s->active_list);
-    for (i = 0; i < (MAX_REQ - 1); i++) {
+    for (i = 0; i < MAX_REQ; i++) {
         QLIST_INSERT_HEAD(&s->free_list, &s->pdus[i], next);
         s->pdus[i].s = s;
         s->pdus[i].idx = i;
