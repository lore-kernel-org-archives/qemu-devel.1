Received: from eggs.gnu.org ([2001:4830:134:3::10]:46603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAenv-0003FM-Mc
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAenu-0001WY-VC
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:31 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 16 May 2017 11:54:14 -0400
Message-Id: <20170516155420.10106-3-jcody@redhat.com>
In-Reply-To: <20170516155420.10106-1-jcody@redhat.com>
References: <20170516155420.10106-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] curl: strengthen assertion in
 curl_clean_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

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
---
 block/curl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 4382234..562340f 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -533,6 +533,11 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
 
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
2.9.3
