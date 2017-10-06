Received: from eggs.gnu.org ([2001:4830:134:3::10]:40831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOk-0007DC-Rj
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOk-00051v-4I
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:08 -0300
Message-Id: <20171006235023.11952-14-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/88] Dirty Bitmaps: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-block@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: squashed tests/test-hbitmap.c changes]
---
 tests/test-hbitmap.c | 2 +-
 util/hbitmap.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index af41642346..fea3a64712 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -122,7 +122,7 @@ static void hbitmap_test_truncate_impl(TestHBitmapData *data,
 
     n = hbitmap_test_array_size(size);
     m = hbitmap_test_array_size(data->old_size);
-    data->bits = g_realloc(data->bits, sizeof(unsigned long) * n);
+    data->bits = g_renew(unsigned long, data->bits, n);
     if (n > m) {
         memset(&data->bits[m], 0x00, sizeof(unsigned long) * (n - m));
     }
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 2f9d0fdbd0..4eb0188836 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -668,7 +668,7 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
         }
         old = hb->sizes[i];
         hb->sizes[i] = size;
-        hb->levels[i] = g_realloc(hb->levels[i], size * sizeof(unsigned long));
+        hb->levels[i] = g_renew(unsigned long, hb->levels[i], size);
         if (!shrink) {
             memset(&hb->levels[i][old], 0x00,
                    (size - old) * sizeof(*hb->levels[i]));
-- 
2.14.2
