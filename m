Received: from eggs.gnu.org ([2001:4830:134:3::10]:35643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8XJ-0004jW-NB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8XG-0003bN-Qj
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:21:05 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 13 Sep 2017 16:20:35 +0200
Message-Id: <20170913142036.2469-4-lvivier@redhat.com>
In-Reply-To: <20170913142036.2469-1-lvivier@redhat.com>
References: <20170913142036.2469-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/4] dump: do not dump non-existent guest
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

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
