Received: from eggs.gnu.org ([2001:4830:134:3::10]:45821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGW-0001Wh-3O
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGS-0006Vv-Uf
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:53 +0200
Message-Id: <1496070414-6744-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] block: Fix backing paths for filenames
 with colons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

path_combine() naturally tries to preserve a protocol prefix. However,
it recognizes such a prefix by scanning for the first colon; which is
different from what path_has_protocol() does: There only is a protocol
prefix if there is a colon before the first slash.

A protocol prefix that is not recognized by path_has_protocol() is none,
and should thus not be taken as one.

Case in point, before this patch:
$ ./qemu-img create -f qcow2 -b backing.qcow2 ./top:image.qcow2
qemu-img: ./top:image.qcow2: Could not open './top:backing.qcow2':
    No such file or directory

Afterwards:
$ ./qemu-img create -f qcow2 -b backing.qcow2 ./top:image.qcow2
qemu-img: ./top:image.qcow2: Could not open './backing.qcow2':
    No such file or directory

Reported-by: yangyang <yangyang@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170522195217.12991-2-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 50ba264..b72b872 100644
--- a/block.c
+++ b/block.c
@@ -163,11 +163,16 @@ void path_combine(char *dest, int dest_size,
     if (path_is_absolute(filename)) {
         pstrcpy(dest, dest_size, filename);
     } else {
-        p = strchr(base_path, ':');
-        if (p)
-            p++;
-        else
-            p = base_path;
+        const char *protocol_stripped = NULL;
+
+        if (path_has_protocol(base_path)) {
+            protocol_stripped = strchr(base_path, ':');
+            if (protocol_stripped) {
+                protocol_stripped++;
+            }
+        }
+        p = protocol_stripped ?: base_path;
+
         p1 = strrchr(base_path, '/');
 #ifdef _WIN32
         {
-- 
1.8.3.1
