Received: from eggs.gnu.org ([2001:4830:134:3::10]:34606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1clR8s-0007ID-H0
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1clR8n-0005D8-7V
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:15:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53290
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1clR8n-0005Cw-0o
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:15:49 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v282Eaww040185
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 21:15:48 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29272v4gs9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 21:15:48 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 7 Mar 2017 21:15:47 -0500
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Wed,  8 Mar 2017 03:15:33 +0100
In-Reply-To: <20170308021533.78292-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170308021533.78292-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170308021533.78292-2-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC 1/1] block: Handle NULL options correctly
 in raw_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com

A normal call for raw_open should always pass in a non-NULL @options,
but for some certain cases (e.g. trying to applying snapshot on a RBD
image), they call raw_open with a NULL @options right after the calling
for raw_close.

Let's take the NULL @options as a sign of trying to do raw_open again,
and just simply return a success code.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 block/raw-format.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/raw-format.c b/block/raw-format.c
index 86fbc65..ee05730 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -384,6 +384,14 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVRawState *s = bs->opaque;
     int ret;
 
+    /*
+     * Notice:
+     * NULL options is only sensible when applying a snapshot.
+     */
+    if (!options) {
+        return 0;
+    }
+
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
                                false, errp);
     if (!bs->file) {
-- 
2.8.4
