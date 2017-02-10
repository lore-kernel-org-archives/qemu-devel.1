Received: from eggs.gnu.org ([2001:4830:134:3::10]:50138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccE3j-0007ky-Ph
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccE3i-0004Q6-R6
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:28:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccE3i-0004Q0-Hp
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:28:30 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 16:28:24 +0000
Message-Id: <1486744104-15590-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
References: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] qemu-img: Avoid setting ret to unused
 value in img_convert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Coverity points out that we assign the return value from
bdrv_snapshot_load_tmp() to 'ret' in img_convert(), but then
never use that variable. (We check for failure by looking
at local_err instead.) Drop the unused assignment, bringing
the call into line with the following call to
bdrv_snapshot_laod_tmp_by_id_or_name().

(Fixes CID 1247240.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-img.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index aa71588..9227d3a 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1966,10 +1966,10 @@ static int img_convert(int argc, char **argv)
     }
 
     if (sn_opts) {
-        ret = bdrv_snapshot_load_tmp(bs[0],
-                                     qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
-                                     qemu_opt_get(sn_opts, SNAPSHOT_OPT_NAME),
-                                     &local_err);
+        bdrv_snapshot_load_tmp(bs[0],
+                               qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
+                               qemu_opt_get(sn_opts, SNAPSHOT_OPT_NAME),
+                               &local_err);
     } else if (snapshot_name != NULL) {
         if (bs_n > 1) {
             error_report("No support for concatenating multiple snapshot");
-- 
2.7.4
