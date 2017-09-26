Received: from eggs.gnu.org ([2001:4830:134:3::10]:33095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqki-0001ju-PR
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkc-0005Yj-Ow
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:20 +0200
Message-Id: <20170926142133.2498-12-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/24] block: Clean up some bad code in the
 vvfat driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Remove the unnecessary home-grown redefinition of the assert() macro here,
and remove the unusable debug code at the end of the checkpoint() function.
The code there uses assert() with side-effects (assignment to the "mapping"
variable), which should be avoided. Looking more closely, it seems as it is
apparently also only usable for one certain directory layout (with a file
named USB.H in it) and thus is of no use for the rest of the world.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index cbabb36f62..1d6e7087a8 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -57,15 +57,6 @@
 
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
@@ -3270,24 +3261,11 @@ static void bdrv_vvfat_init(void)
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
2.13.5
