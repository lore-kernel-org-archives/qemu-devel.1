Received: from eggs.gnu.org ([2001:4830:134:3::10]:40920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@localhost.localdomain>) id 1gNApi-0007PH-TD
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 01:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <root@localhost.localdomain>) id 1gNApe-0007Ho-WC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 01:08:54 -0500
From: root <root@localhost.localdomain>
Date: Wed, 14 Nov 2018 22:00:14 -0800
Message-Id: <1542261614-2606-1-git-send-email-root@localhost.localdomain>
Subject: [Qemu-devel] [PATCH] target: hax: replace g_malloc with g_malloc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

And also the g_malloc doesn't need check return value,
remove it.

Cc: qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 target/i386/hax-all.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index d2e512856b..a460c605af 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -154,13 +154,7 @@ int hax_vcpu_create(int id)
         return 0;
     }
 
-    vcpu = g_malloc(sizeof(struct hax_vcpu_state));
-    if (!vcpu) {
-        fprintf(stderr, "Failed to alloc vcpu state\n");
-        return -ENOMEM;
-    }
-
-    memset(vcpu, 0, sizeof(struct hax_vcpu_state));
+    vcpu = g_malloc0(sizeof(struct hax_vcpu_state));
 
     ret = hax_host_create_vcpu(hax_global.vm->fd, id);
     if (ret) {
@@ -250,11 +244,8 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
         return hax->vm;
     }
 
-    vm = g_malloc(sizeof(struct hax_vm));
-    if (!vm) {
-        return NULL;
-    }
-    memset(vm, 0, sizeof(struct hax_vm));
+    vm = g_malloc0(sizeof(struct hax_vm));
+
     ret = hax_host_create_vm(hax, &vm_id);
     if (ret) {
         fprintf(stderr, "Failed to create vm %x\n", ret);
-- 
2.11.0
