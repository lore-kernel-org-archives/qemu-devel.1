Received: from eggs.gnu.org ([2001:4830:134:3::10]:48853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIy-0007Ew-Np
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIi-0003pe-V7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:52 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:25 +0200
Message-Id: <1502117160-24655-22-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 21/56] block: Clean up
 get_human_readable_size()
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

get_human_readable_size() formats all negative numbers as if they were
small.

The previous two commits changed all callers to pass unsigned
arguments.  Change the parameter type to from int64_t to uint64_t.

Also change the buffer size parameter from int (ahem!) to size_t.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/qapi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 1c6123c..0f6620e 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -566,10 +566,11 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
 
 #define NB_SUFFIXES 4
 
-static char *get_human_readable_size(char *buf, int buf_size, int64_t size)
+static char *get_human_readable_size(char *buf, size_t buf_size,
+                                     uint64_t size)
 {
     static const char suffixes[NB_SUFFIXES] = {'K', 'M', 'G', 'T'};
-    int64_t base;
+    uint64_t base;
     int i;
 
     if (size <= 999) {
-- 
2.7.5
