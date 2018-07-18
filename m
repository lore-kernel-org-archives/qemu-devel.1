Received: from eggs.gnu.org ([2001:4830:134:3::10]:49302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffoNT-0002sv-Ns
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffoNT-0001Sx-1t
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:28:31 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 18 Jul 2018 17:28:23 +0200
Message-Id: <1531927703-9799-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] block/vvfat: Fix crash when reporting error
 about too many files in directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

When using the vvfat driver with a directory that contains too many files,
QEMU currently crashes. We are trying to print the wrong path variable here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/vvfat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index fc41841..6ae7458 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -975,8 +975,7 @@ static int init_directories(BDRVVVFATState* s,
         if (mapping->mode & MODE_DIRECTORY) {
             mapping->begin = cluster;
             if(read_directory(s, i)) {
-                error_setg(errp, "Could not read directory %s",
-                           mapping->path);
+                error_setg(errp, "Could not read directory \"%s\"", s->path);
                 return -1;
             }
             mapping = array_get(&(s->mapping), i);
-- 
1.8.3.1
