Received: from eggs.gnu.org ([2001:4830:134:3::10]:40173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsv-0001Yo-Bf
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsu-00035P-Bf
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:25 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Dec 2017 19:59:51 -0500
Message-Id: <20171214005953.8898-6-jsnow@redhat.com>
In-Reply-To: <20171214005953.8898-1-jsnow@redhat.com>
References: <20171214005953.8898-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] block/commit: use block_job_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

Depending on the value of `speed` and how fast our backends are,
delay_ns might be 0 very, very often. This creates some warning
messages that spook users, but it's also pretty inefficient.

Use block_job_throttle instead to yield a little more intelligently.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 873e749d50..567064215b 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -172,7 +172,8 @@ static void coroutine_fn commit_run(void *opaque)
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
-        block_job_sleep_ns(&s->common, delay_ns);
+        block_job_throttle(&s->common, delay_ns);
+
         if (block_job_is_cancelled(&s->common)) {
             break;
         }
-- 
2.14.3
