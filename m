Received: from eggs.gnu.org ([2001:4830:134:3::10]:54359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYl6-0005CV-Qp
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYl5-0007dT-S7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:42:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:07 -0300
Message-Id: <20170727024224.22900-3-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 02/20] loader: check
 get_image_size() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

since a negative value means it errored.

hw/core/loader.c:149:9: warning: Loss of sign in implicit conversion
    if (size > max_sz) {
        ^~~~
hw/core/loader.c:171:9: warning: Loss of sign in implicit conversion
    if (size > memory_region_size(mr)) {
        ^~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/core/loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index c17ace0a2e..4bb176f284 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -146,7 +146,7 @@ int load_image_targphys_as(const char *filename,
     int size;
 
     size = get_image_size(filename);
-    if (size > max_sz) {
+    if (size < 0 || size > max_sz) {
         return -1;
     }
     if (size > 0) {
@@ -168,7 +168,7 @@ int load_image_mr(const char *filename, MemoryRegion *mr)
 
     size = get_image_size(filename);
 
-    if (size > memory_region_size(mr)) {
+    if (size < 0 || size > memory_region_size(mr)) {
         return -1;
     }
     if (size > 0) {
-- 
2.13.3
