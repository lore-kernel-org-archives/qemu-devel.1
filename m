Received: from eggs.gnu.org ([2001:4830:134:3::10]:42379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJu-0003Ad-JI
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJt-0004rW-K1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:38 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:07 -0500
Message-Id: <20180723201748.25573-59-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 58/99] block/mirror: Make cancel always cancel
 pre-READY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Commit b76e4458b1eb3c32e9824fe6aa51f67d2b251748 made the mirror block
job respect block-job-cancel's @force flag: With that flag set, it would
now always really cancel, even post-READY.

Unfortunately, it had a side effect: Without that flag set, it would now
never cancel, not even before READY.  Considering that is an
incompatible change and not noted anywhere in the commit or the
description of block-job-cancel's @force parameter, this seems
unintentional and we should revert to the previous behavior, which is to
immediately cancel the job when block-job-cancel is called before source
and target are in sync (i.e. before the READY event).

Cc: qemu-stable@nongnu.org
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1572856
Reported-by: Yanan Fu <yfu@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180501220509.14152-2-mreitz@redhat.com
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit eb36639f7bbc16055e551593b81365e8ae3b0b05)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/mirror.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 9436a8d5ee..99da9c0858 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -874,7 +874,9 @@ static void coroutine_fn mirror_run(void *opaque)
         }
         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
         block_job_sleep_ns(&s->common, delay_ns);
-        if (block_job_is_cancelled(&s->common) && s->common.force) {
+        if (block_job_is_cancelled(&s->common) &&
+            (!s->synced || s->common.force))
+        {
             break;
         }
         s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-- 
2.17.1
