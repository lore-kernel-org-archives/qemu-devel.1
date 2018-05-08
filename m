Received: from eggs.gnu.org ([2001:4830:134:3::10]:33337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4PJ-00029y-2D
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4PI-0004ZJ-0w
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:20:01 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  8 May 2018 11:19:22 -0400
Message-Id: <20180508151924.18741-3-jcody@redhat.com>
In-Reply-To: <20180508151924.18741-1-jcody@redhat.com>
References: <20180508151924.18741-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] block/mirror: Make cancel always cancel
 pre-READY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, sheepdog@lists.wpkg.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>, qemu-stable@nongnu.org

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
2.13.6
