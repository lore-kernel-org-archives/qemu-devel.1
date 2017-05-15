Received: from eggs.gnu.org ([2001:4830:134:3::10]:49434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dACoQ-0000RD-LK
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dACoP-0005qm-Or
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:01:10 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 May 2017 12:00:53 +0200
Message-Id: <20170515100059.15795-2-pbonzini@redhat.com>
In-Reply-To: <20170515100059.15795-1-pbonzini@redhat.com>
References: <20170515100059.15795-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/7] curl: strengthen assertion in
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
Cc: jcody@redhat.com, rjones@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org

curl_clean_state should only be called after all AIOCBs have been
completed.  This is not so obvious for the call from curl_detach_aio_context,
so assert that.

Cc: qemu-stable@nongnu.org
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index aa6e8cc0e5..010b0604c5 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -532,6 +532,11 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
 
 static void curl_clean_state(CURLState *s)
 {
+    int j;
+    for (j=0; j < CURL_NUM_ACB; j++) {
+        assert(!s->acb[j]);
+    }
+
     if (s->s->multi)
         curl_multi_remove_handle(s->s->multi, s->curl);
 
-- 
2.12.2
