Received: from eggs.gnu.org ([2001:4830:134:3::10]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6H-0003hL-Ac
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6F-0003bk-Rh
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:32 +0200
Message-Id: <20180629140959.6690-3-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/29] block/crypto: Pacify Coverity after
 commit f853465aacb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

Coverity can't see that qobject_input_visitor_new_flat_confused()
returns non-null when it doesn't set @local_err.  Check the return
value instead, like all the other callers do.

Fixes: CID 1393615
Fixes: CID 1393616
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 82091c5f70..aaa8fb7530 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -160,7 +160,7 @@ block_crypto_open_opts_init(QCryptoBlockFormat format,
     ret->format = format;
 
     v = qobject_input_visitor_new_flat_confused(opts, &local_err);
-    if (local_err) {
+    if (!v) {
         goto out;
     }
 
@@ -214,7 +214,7 @@ block_crypto_create_opts_init(QCryptoBlockFormat format,
     ret->format = format;
 
     v = qobject_input_visitor_new_flat_confused(opts, &local_err);
-    if (local_err) {
+    if (!v) {
         goto out;
     }
 
-- 
2.13.6
