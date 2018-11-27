Received: from eggs.gnu.org ([2001:4830:134:3::10]:38457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBl-0001n4-SL
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRXBi-0001L6-L7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRXBi-0001G1-Bx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:49:38 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Nov 2018 07:49:29 +0100
Message-Id: <20181127064932.7299-4-kraxel@redhat.com>
In-Reply-To: <20181127064932.7299-1-kraxel@redhat.com>
References: <20181127064932.7299-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] cirrus_vga/migration: update the bank
 offset before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Wang Xin <wangxinxin.wang@huawei.com>

From: Wang Xin <wangxinxin.wang@huawei.com>

The cirrus bank0/1 offset should be updated before we update the vram's alias
offset.

Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>
Message-id: 20181123064646.23036-1-linzhecheng@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index d9b854d74d..a0e71469f4 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2746,11 +2746,12 @@ static int cirrus_post_load(void *opaque, int version_id)
     s->vga.gr[0x00] = s->cirrus_shadow_gr0 & 0x0f;
     s->vga.gr[0x01] = s->cirrus_shadow_gr1 & 0x0f;
 
-    cirrus_update_memory_access(s);
-    /* force refresh */
-    s->vga.graphic_mode = -1;
     cirrus_update_bank_ptr(s, 0);
     cirrus_update_bank_ptr(s, 1);
+    cirrus_update_memory_access(s);
+    /* force refresh */
+    s->vga.graphic_mode = -1;
+
     return 0;
 }
 
-- 
2.9.3
