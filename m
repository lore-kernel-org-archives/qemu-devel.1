Received: from eggs.gnu.org ([2001:4830:134:3::10]:33340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4PJ-0002A5-4a
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4PI-0004Ze-BP
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:20:01 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  8 May 2018 11:19:24 -0400
Message-Id: <20180508151924.18741-5-jcody@redhat.com>
In-Reply-To: <20180508151924.18741-1-jcody@redhat.com>
References: <20180508151924.18741-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] sheepdog: Fix sd_co_create_opts() memory
 leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, sheepdog@lists.wpkg.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>

From: Kevin Wolf <kwolf@redhat.com>

Both the option string for the 'redundancy' option and the
SheepdogRedundancy object that is created accordingly could be leaked in
error paths. This fixes the memory leaks.

Reported by Coverity (CID 1390614 and 1390641).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20180503153509.22223-1-kwolf@redhat.com
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 07529f4b1b..fed2a04797 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1987,6 +1987,7 @@ static SheepdogRedundancy *parse_redundancy_str(const char *opt)
     } else {
         ret = qemu_strtol(n2, NULL, 10, &parity);
         if (ret < 0) {
+            g_free(redundancy);
             return NULL;
         }
 
@@ -2183,7 +2184,7 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
     QDict *qdict, *location_qdict;
     QObject *crumpled;
     Visitor *v;
-    const char *redundancy;
+    char *redundancy;
     Error *local_err = NULL;
     int ret;
 
@@ -2253,6 +2254,7 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
 fail:
     qapi_free_BlockdevCreateOptions(create_options);
     qobject_unref(qdict);
+    g_free(redundancy);
     return ret;
 }
 
-- 
2.13.6
