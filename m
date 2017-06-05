Received: from eggs.gnu.org ([2001:4830:134:3::10]:33586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dHsUL-0008Qh-9T
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dHsUK-0003bm-H1
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:56:09 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dHsUK-0003RT-5x
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:56:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Jun 2017 14:55:54 +0100
Message-Id: <1496670954-664-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] block/qcow.c: Fix memory leak in qcow_create()
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

Coverity points out that the code path in qcow_create() for
the magic "fat:" backing file name leaks the memory used to
store the filename (CID 1307771). Free the memory before
we overwrite the pointer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/qcow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow.c b/block/qcow.c
index 95ab123..7bd94dc 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -852,6 +852,7 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
             header_size += backing_filename_len;
         } else {
             /* special backing file for vvfat */
+            g_free(backing_file);
             backing_file = NULL;
         }
         header.cluster_bits = 9; /* 512 byte cluster to avoid copying
-- 
2.7.4
