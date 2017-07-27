Received: from eggs.gnu.org ([2001:4830:134:3::10]:54488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlG-0005Jg-1e
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlF-0007lb-AG
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:42:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:10 -0300
Message-Id: <20170727024224.22900-6-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 05/20] qcow2: fix null pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

It seems this assert() was somehow misplaced.

block/qcow2-refcount.c:2193:42: warning: Array access (from variable 'on_disk_reftable') results in a null pointer dereference
        on_disk_reftable[refblock_index] = refblock_offset;
        ~~~~~~~~~~~~~~~~                 ^

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-refcount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index c9b0dcb4f3..168fc32e7b 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2189,6 +2189,8 @@ write_refblocks:
              * this will leak that range, but we can easily fix that by running
              * a leak-fixing check after this rebuild operation */
             reftable_offset = -1;
+        } else {
+            assert(on_disk_reftable);
         }
         on_disk_reftable[refblock_index] = refblock_offset;
 
@@ -2258,8 +2260,6 @@ write_refblocks:
         goto write_refblocks;
     }
 
-    assert(on_disk_reftable);
-
     for (refblock_index = 0; refblock_index < reftable_size; refblock_index++) {
         cpu_to_be64s(&on_disk_reftable[refblock_index]);
     }
-- 
2.13.3
