Received: from eggs.gnu.org ([2001:4830:134:3::10]:46119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eiiCj-0006Ol-Kp
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eiiCg-0005JY-ER
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:57:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:20501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1eiiCg-0005Hq-4Q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:57:06 -0500
From: Jianfeng Tan <jianfeng.tan@intel.com>
Date: Mon,  5 Feb 2018 14:58:55 +0000
Message-Id: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
Subject: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jianfeng Tan <jianfeng.tan@intel.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Existing VMs with virtio devices and vhost-kernel as the backend
are always started with mem config:

  "-m xG"
  (with a ram block named "pc.ram")

while new VMs with virtio devices and vhost-user as the backend
are always started with mem config:

  "-m xG -numa node,memdev=pc.ram -object memory-backend-file,id=pc.ram,..."
  (with a ram block named "/object/pc.ram")

As we migrate from vhost-kernel to vhost-user, it failes as:

  Unknown ramblock "pc.ram", cannot accept migration
  error while loading state for instance 0x0 of device 'ram'
  load of migration failed: Invalid argument

Here are some options to fix this:

1. When we do ram name comparison, we truncate the prefix as this patch shows.
It cannot cover the corner case: the source VM could have two ram blocks
with name of "pc.ram" and "/object/pc.ram".

2. We add an alias name to RAMBlock; when we do name comparison, not only
idstr is compared, but also compared to the alias. But this will add more
complexity to upper layer stack OpenStack/libvirt.

Any thoughts?

Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jianfeng Tan <jianfeng.tan@intel.com>
---
 exec.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 4722e52..d294e5c 100644
--- a/exec.c
+++ b/exec.c
@@ -2334,13 +2334,24 @@ found:
 RAMBlock *qemu_ram_block_by_name(const char *name)
 {
     RAMBlock *block;
+    char *name1, *id1;
+    char *name2, *id2;
+
+    name1 = strdup(name);
+    id1 = basename(name1);
 
     RAMBLOCK_FOREACH(block) {
-        if (!strcmp(name, block->idstr)) {
+        name2 = strdup(block->idstr);
+	id2 = basename(name2);
+        if (!strcmp(id1, id2)) {
+            free(name1);
+	    free(name2);
             return block;
         }
+	free(name2);
     }
 
+    free(name1);
     return NULL;
 }
 
-- 
2.7.4
