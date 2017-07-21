Received: from eggs.gnu.org ([2001:4830:134:3::10]:55993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dYTBa-0002Db-BR
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dYTBW-0007Be-9O
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:21:22 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33004
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dYTBW-0007Az-3L
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:21:18 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 21 Jul 2017 09:21:05 +0100
Message-Id: <1500625265-23844-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] block/vpc: fix uninitialised variable compiler
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

Since commit cfc87e00 "block/vpc.c: Handle write failures in
get_image_offset()" older versions of gcc (in this case 4.7) incorrectly
warn that "ret" can be used uninitialised in vpc_co_pwritev().

Setting ret to 0 at the start of vpc_co_pwritev() prevents the warning
in gcc 4.7 and enables compilation with -Werror to succeed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 block/vpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vpc.c b/block/vpc.c
index 10e6519..574879b 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -649,7 +649,7 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int64_t image_offset;
     int64_t n_bytes;
     int64_t bytes_done = 0;
-    int ret;
+    int ret = 0;
     VHDFooter *footer =  (VHDFooter *) s->footer_buf;
     QEMUIOVector local_qiov;
 
-- 
1.7.10.4
