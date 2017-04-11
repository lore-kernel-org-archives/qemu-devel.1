Received: from eggs.gnu.org ([2001:4830:134:3::10]:39251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxut4-0004Lb-JC
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxut3-00046C-Q6
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cxut3-00045b-KQ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:27:09 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 11 Apr 2017 20:26:32 +0800
Message-Id: <20170411122632.14050-12-famz@redhat.com>
In-Reply-To: <20170411122632.14050-1-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] sheepdog: Use bdrv_coroutine_enter before
 BDRV_POLL_WHILE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, famz@redhat.com

When called from main thread, the coroutine should run in the context of
bs. Use bdrv_coroutine_enter to ensure that.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/sheepdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 1b71fc8..14d6327 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -736,7 +736,7 @@ static int do_req(int sockfd, BlockDriverState *bs, SheepdogReq *hdr,
     } else {
         co = qemu_coroutine_create(do_co_req, &srco);
         if (bs) {
-            qemu_coroutine_enter(co);
+            bdrv_coroutine_enter(bs, co);
             BDRV_POLL_WHILE(bs, !srco.finished);
         } else {
             qemu_coroutine_enter(co);
-- 
2.9.3
