Received: from eggs.gnu.org ([2001:4830:134:3::10]:60904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotjs-0007Aa-Fb
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cotjr-0006Ub-Gq
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:24:24 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Mar 2017 16:24:12 +0100
Message-Id: <20170317152412.8472-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] curl: fix compilation on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org

EPROTO is not found in OpenBSD.   We usually use EIO when no better
errno is available, do that here too.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index e83dcd8..34dbd33 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -377,7 +377,7 @@ static void curl_multi_check_completion(BDRVCURLState *s)
                     }
 
                     qemu_mutex_unlock(&s->mutex);
-                    acb->common.cb(acb->common.opaque, -EPROTO);
+                    acb->common.cb(acb->common.opaque, -EIO);
                     qemu_mutex_lock(&s->mutex);
                     qemu_aio_unref(acb);
                     state->acb[i] = NULL;
-- 
2.9.3
