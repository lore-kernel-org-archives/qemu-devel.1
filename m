Received: from eggs.gnu.org ([2001:4830:134:3::10]:52987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAd7s-00062D-8K
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAd7o-0005iQ-GA
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:39:16 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Nov 2017 14:39:02 +0000
Message-Id: <20171103143902.18039-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] qcow2: don't permit changing encryption
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Currently if trying to change encryption parameters on a qcow2 image, qemu-img
will abort. We already explicitly check for attempt to change encrypt.format
but missed other parameters like encrypt.key-secret. Rather than list each
parameter, just blacklist changing of all parameters with a 'encrypt.' prefix.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 92cb9f9bfa..8edf8ac3c7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4062,6 +4062,9 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                 error_report("Changing the encryption format is not supported");
                 return -ENOTSUP;
             }
+        } else if (g_str_has_prefix(desc->name, "encrypt.")) {
+            error_report("Changing the encryption parameters is not supported");
+            return -ENOTSUP;
         } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
             cluster_size = qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZE,
                                              cluster_size);
-- 
2.13.6
