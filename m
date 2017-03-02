Received: from eggs.gnu.org ([2001:4830:134:3::10]:35056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWF-0005Uv-EB
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWE-0002q9-FF
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:15 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  2 Mar 2017 22:43:54 +0100
Message-Id: <1488491046-2549-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 03/15] sheepdog: Fix error handling sd_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

As a bdrv_create() method, sd_create() must set an error and return
negative errno on failure.  It prints the error instead of setting it
when connect_to_sdog() fails.  Fix that.

While there, return the value of connect_to_sdog() like we do
elsewhere, instead of -EIO.  No functional change, as
connect_to_sdog() returns no other error code.

Many more suspicious uses of error_report() and error_report_err()
remain in other functions.  Left for another day.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/sheepdog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index e4e5345..abfaa95 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1830,14 +1830,12 @@ static int sd_create(const char *filename, QemuOpts *opts,
     if (s->inode.block_size_shift == 0) {
         SheepdogVdiReq hdr;
         SheepdogClusterRsp *rsp = (SheepdogClusterRsp *)&hdr;
-        Error *local_err = NULL;
         int fd;
         unsigned int wlen = 0, rlen = 0;
 
-        fd = connect_to_sdog(s, &local_err);
+        fd = connect_to_sdog(s, errp);
         if (fd < 0) {
-            error_report_err(local_err);
-            ret = -EIO;
+            ret = fd;
             goto out;
         }
 
-- 
2.7.4
