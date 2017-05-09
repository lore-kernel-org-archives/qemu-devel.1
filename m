Received: from eggs.gnu.org ([2001:4830:134:3::10]:34883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d81Yl-0004wJ-Nu
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d81Yh-0004p0-DR
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:35:59 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 May 2017 11:35:46 +0200
Message-Id: <20170509093549.25157-2-pbonzini@redhat.com>
In-Reply-To: <20170509093549.25157-1-pbonzini@redhat.com>
References: <20170509093549.25157-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] curl: strengthen assertion in
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
Cc: qemu-stable@nongnu.org, jcody@redhat.com, rjones@redhat.com

curl_clean_state should only be called after all AIOCBs have been
completed.  This is not so obvious for the call from curl_detach_aio_context,
so assert that.

Cc: qemu-stable@nongnu.org
Cc: jcody@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 2708d57c2f..25a301e7b4 100644
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
2.12.2
