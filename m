Received: from eggs.gnu.org ([2001:4830:134:3::10]:33341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gQ5FA-0003is-3M
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gQ5F6-0002Vz-31
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:47:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3110 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gQ5F5-0002LA-LU
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:47:08 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Fri, 23 Nov 2018 14:46:46 +0800
Message-ID: <20181123064646.23036-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] cirrus_vga/migration: update the bank offset
 before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, maoming.maoming@huawei.com, Wang Xin <wangxinxin.wang@huawei.com>

From: Wang Xin <wangxinxin.wang@huawei.com>

The cirrus bank0/1 offset should be updated before we update the vram's alias
offset.

Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index d9b854d..a0e7146 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2746,11 +2746,12 @@ static int cirrus_post_load(void *opaque, int version_id)
     s->vga.gr[0x00] = s->cirrus_shadow_gr0 & 0x0f;
     s->vga.gr[0x01] = s->cirrus_shadow_gr1 & 0x0f;
 
+    cirrus_update_bank_ptr(s, 0);
+    cirrus_update_bank_ptr(s, 1);
     cirrus_update_memory_access(s);
     /* force refresh */
     s->vga.graphic_mode = -1;
-    cirrus_update_bank_ptr(s, 0);
-    cirrus_update_bank_ptr(s, 1);
+
     return 0;
 }
 
-- 
2.8.1.windows.1
