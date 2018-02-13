Received: from eggs.gnu.org ([2001:4830:134:3::10]:42170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI2-0004fj-CP
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHy-0007sm-FT
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:26 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHy-0007sT-92
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:22 -0500
Received: by mail-wm0-x242.google.com with SMTP id i186so15521978wmi.4
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:22 -0800 (PST)
Received: from 640k.lan ([82.84.102.245])
	by smtp.gmail.com with ESMTPSA id f9sm6870298wmf.12.2018.02.13.04.02.19
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Feb 2018 04:02:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:48 +0100
Message-Id: <1518523252-49106-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 44/48] g364fb: switch to using
 DirtyBitmapSnapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This removes the last user of memory_region_test_and_clear_dirty
outside memory.c.

Tested-by: Hervé Poussineau <hpoussin@reactos.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/g364fb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 86557d1..86452de 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -62,15 +62,15 @@ typedef struct G364State {
 
 #define G364_PAGE_SIZE 4096
 
-static inline int check_dirty(G364State *s, ram_addr_t page)
+static inline int check_dirty(G364State *s, DirtyBitmapSnapshot *snap, ram_addr_t page)
 {
-    return memory_region_test_and_clear_dirty(&s->mem_vram, page, G364_PAGE_SIZE,
-                                              DIRTY_MEMORY_VGA);
+    return memory_region_snapshot_get_dirty(&s->mem_vram, snap, page, G364_PAGE_SIZE);
 }
 
 static void g364fb_draw_graphic8(G364State *s)
 {
     DisplaySurface *surface = qemu_console_surface(s->con);
+    DirtyBitmapSnapshot *snap;
     int i, w;
     uint8_t *vram;
     uint8_t *data_display, *dd;
@@ -122,8 +122,10 @@ static void g364fb_draw_graphic8(G364State *s)
     vram = s->vram + s->top_of_screen;
     /* XXX: out of range in vram? */
     data_display = dd = surface_data(surface);
+    snap = memory_region_snapshot_and_clear_dirty(&s->mem_vram, 0, s->vram_size,
+                                                  DIRTY_MEMORY_VGA);
     while (y < s->height) {
-        if (check_dirty(s, page)) {
+        if (check_dirty(s, snap, page)) {
             if (y < ymin)
                 ymin = ymax = y;
             if (x < xmin)
-- 
1.8.3.1
