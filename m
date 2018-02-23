Received: from eggs.gnu.org ([2001:4830:134:3::10]:55317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8M-0005sZ-R8
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8J-0005uV-MN
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:10 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:22 -0500
Message-Id: <20180223235142.21501-2-jsnow@redhat.com>
In-Reply-To: <20180223235142.21501-1-jsnow@redhat.com>
References: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 01/21] blockjobs: fix set-speed kick
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

If speed is '0' it's not actually "less than" the previous speed.
Kick the job in this case too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 3f52f29f75..24833ef30f 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -499,7 +499,7 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     }
 
     job->speed = speed;
-    if (speed <= old_speed) {
+    if (speed && speed <= old_speed) {
         return;
     }
 
-- 
2.14.3
