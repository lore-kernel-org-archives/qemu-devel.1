Received: from eggs.gnu.org ([2001:4830:134:3::10]:49186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJE-0007XH-1o
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIx-00041d-NI
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:53 +0200
Message-Id: <1502117160-24655-50-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 49/56] block: Make ImageCheck file offset
 unsigned in QAPI
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

File offsets should use QAPI type 'size' (uint64_t).  ImageCheck
member @image-end-offset is 'int' (int64_t).  collect_image_check()
gets it from BdrvCheckResult member @image_end_offset (also int64_t,
should never be negative).

Change the ImageCheck member to 'size', for QAPI/QMP consistency.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 2 +-
 qemu-img.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 51caee9..3c6d448 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -208,7 +208,7 @@
 ##
 { 'struct': 'ImageCheck',
   'data': {'filename': 'str', 'format': 'str', 'check-errors': 'int',
-           '*image-end-offset': 'int', '*corruptions': 'int', '*leaks': 'int',
+           '*image-end-offset': 'size', '*corruptions': 'int', '*leaks': 'int',
            '*corruptions-fixed': 'int', '*leaks-fixed': 'int',
            '*total-clusters': 'int', '*allocated-clusters': 'int',
            '*fragmented-clusters': 'int', '*compressed-clusters': 'int' } }
diff --git a/qemu-img.c b/qemu-img.c
index f4d5f0d..3ae5fe3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -604,7 +604,7 @@ static void dump_human_image_check(ImageCheck *check, bool quiet)
 
     if (check->image_end_offset) {
         qprintf(quiet,
-                "Image end offset: %" PRId64 "\n", check->image_end_offset);
+                "Image end offset: %" PRIu64 "\n", check->image_end_offset);
     }
 }
 
-- 
2.7.5
