Received: from eggs.gnu.org ([2001:4830:134:3::10]:47732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCI-00012r-Gr
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCH-0005I7-Fs
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCH-0005Gu-6p
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EBYH042759
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:00 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmr8neytj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:00 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:15:59 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:03 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-29-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 28/79] curl: strengthen assertion in
 curl_clean_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

curl_clean_state should only be called after all AIOCBs have been
completed.  This is not so obvious for the call from curl_detach_aio_context,
so assert that.

Cc: qemu-stable@nongnu.org
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170515100059.15795-2-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit 675a775633e68bf8b426a896fea5b93a4f4ff1cc)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/curl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index aa6e8cc..c6dc4c0 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -532,6 +532,11 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
 
 static void curl_clean_state(CURLState *s)
 {
+    int j;
+    for (j = 0; j < CURL_NUM_ACB; j++) {
+        assert(!s->acb[j]);
+    }
+
     if (s->s->multi)
         curl_multi_remove_handle(s->s->multi, s->curl);
 
-- 
2.7.4
