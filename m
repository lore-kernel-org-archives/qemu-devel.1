Received: from eggs.gnu.org ([2001:4830:134:3::10]:42724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCM-0000kI-AM
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCL-0002AQ-EP
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:32 +0100
Message-Id: <20171117181653.20651-5-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/25] qcow2: don't permit changing encryption
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

Currently if trying to change encryption parameters on a qcow2 image, qemu-img
will abort. We already explicitly check for attempt to change encrypt.format
but missed other parameters like encrypt.key-secret. Rather than list each
parameter, just blacklist changing of all parameters with a 'encrypt.' prefix.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index b3d66a0e88..92e5d548e3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4069,6 +4069,9 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
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
