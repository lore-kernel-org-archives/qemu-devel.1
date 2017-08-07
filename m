Received: from eggs.gnu.org ([2001:4830:134:3::10]:49240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJF-0007ZI-Mz
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ0-00044D-T4
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:58 +0200
Message-Id: <1502117160-24655-55-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 54/56] qemu-img: blk_getlength() can fail,
 fix img_map() to check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-img.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 3ae5fe3..cf3ef3e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2838,6 +2838,10 @@ static int img_map(int argc, char **argv)
     }
 
     length = blk_getlength(blk);
+    if (length < 0) {
+        error_report("Couldn't get length of image '%s': %s",
+                     filename, strerror(-length));
+    }
     while (curr.start + curr.length < length) {
         int64_t nsectors_left;
         int64_t sector_num;
-- 
2.7.5
