Received: from eggs.gnu.org ([2001:4830:134:3::10]:47155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds4nY-0002R7-L9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds4nX-0003RA-O2
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:21:36 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Sep 2017 12:21:28 +0200
Message-Id: <1505298088-10878-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Clean up some bad code in the vvfat
 driver
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

Remove the unnecessary home-grown redefinition of the assert() macro here,
and remove the unusable debug code at the end of the checkpoint() function.
The code there uses assert() with side-effects (assignment to the "mapping"
variable), which should be avoided. Looking more closely, it seems as it is
apparently also only usable for one certain directory layout (with a file
named USB.H in it) and thus is of no use for the rest of the world.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/vvfat.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index c54fa94..777a8cd 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -56,15 +56,6 @@
 
 static void checkpoint(void);
 
-#ifdef __MINGW32__
-void nonono(const char* file, int line, const char* msg) {
-    fprintf(stderr, "Nonono! %s:%d %s\n", file, line, msg);
-    exit(-5);
-}
-#undef assert
-#define assert(a) do {if (!(a)) nonono(__FILE__, __LINE__, #a);}while(0)
-#endif
-
 #else
 
 #define DLOG(a)
@@ -3269,24 +3260,11 @@ static void bdrv_vvfat_init(void)
 block_init(bdrv_vvfat_init);
 
 #ifdef DEBUG
-static void checkpoint(void) {
+static void checkpoint(void)
+{
     assert(((mapping_t*)array_get(&(vvv->mapping), 0))->end == 2);
     check1(vvv);
     check2(vvv);
     assert(!vvv->current_mapping || vvv->current_fd || (vvv->current_mapping->mode & MODE_DIRECTORY));
-#if 0
-    if (((direntry_t*)vvv->directory.pointer)[1].attributes != 0xf)
-        fprintf(stderr, "Nonono!\n");
-    mapping_t* mapping;
-    direntry_t* direntry;
-    assert(vvv->mapping.size >= vvv->mapping.item_size * vvv->mapping.next);
-    assert(vvv->directory.size >= vvv->directory.item_size * vvv->directory.next);
-    if (vvv->mapping.next<47)
-        return;
-    assert((mapping = array_get(&(vvv->mapping), 47)));
-    assert(mapping->dir_index < vvv->directory.next);
-    direntry = array_get(&(vvv->directory), mapping->dir_index);
-    assert(!memcmp(direntry->name, "USB     H  ", 11) || direntry->name[0]==0);
-#endif
 }
 #endif
-- 
1.8.3.1
