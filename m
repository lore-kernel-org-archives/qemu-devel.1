Received: from eggs.gnu.org ([2001:4830:134:3::10]:60226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhX-0006TF-96
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhT-0002Id-DJ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsVhT-0002Hm-81
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:07 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Sep 2017 16:04:43 +0100
Message-Id: <20170914150447.19352-4-dgilbert@redhat.com>
In-Reply-To: <20170914150447.19352-1-dgilbert@redhat.com>
References: <20170914150447.19352-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] dump: do not dump non-existent guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com, cohuck@redhat.com, vadim.galitsyn@profitbricks.com
Cc: imammedo@redhat.com, thuth@redhat.com, peterx@redhat.com, groug@kaod.org

From: Cornelia Huck <cohuck@redhat.com>

It does not really make sense to dump memory that is not there.

Moreover, that fixes a segmentation fault when calling dump-guest-memory
with no filter for a machine with no memory defined.

New behaviour is:

(qemu) dump-guest-memory /dev/null
dump: no guest memory to dump
(qemu) dump-guest-memory /dev/null 0 4096
dump: no guest memory to dump

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20170913142036.2469-4-lvivier@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 dump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dump.c b/dump.c
index a79773d0f7..d2093e141b 100644
--- a/dump.c
+++ b/dump.c
@@ -1536,6 +1536,12 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size);
 #endif
 
+    /* it does not make sense to dump non-existent memory */
+    if (!s->total_size) {
+        error_setg(errp, "dump: no guest memory to dump");
+        goto cleanup;
+    }
+
     s->start = get_start_block(s);
     if (s->start == -1) {
         error_setg(errp, QERR_INVALID_PARAMETER, "begin");
-- 
2.13.5
