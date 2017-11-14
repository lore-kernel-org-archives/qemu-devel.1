Received: from eggs.gnu.org ([2001:4830:134:3::10]:38369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eEVNI-0005Ge-0s
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eEVND-0004SK-Nx
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:11:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eEVND-0004P2-3s
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:11:07 -0500
From: fangying <fangying1@huawei.com>
Message-ID: <212a9227-5a56-7a0e-1149-2d1bc884b4f0@huawei.com>
Date: Tue, 14 Nov 2017 15:09:20 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU abort when network serivce is restarted during
 live migration with vhost-user as the network backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, stefanha@redhat.com, quintela@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Cc: arei.gonglei@huawei.com, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, king.wang@huawei.com

Hi all,

We have a vm running migration with vhost-user as network backend, we notice that qemu will abort when openvswitch is restarted
when MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward) is called. The reasion is clear that vhost_dev_set_log returns -1 because
the network connection is temporarily lost due to the restart of openvswitch service.

Below is the trace of the call stack.

#0  0x00007f868ed971d7 in raise() from /usr/lib64/libc.so.6
#1  0x00007f868ed988c8 in abort() from /usr/lib64/libc.so.6
#2  0x00000000004d0d35 in vhost_log_global_start (listener=<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/hw/virtio/vhost.c:794
#2  0x0000000000486bd2 in memory_global_dirty_log_start at /usr/src/debug/qemu-kvm-2.8.1/memory.c:2304
#3  0x0000000000486dcd in ram_save_init_globals at /usr/src/debug/qemu-kvm-2.8.1/migration/ram.c:2072
#4  0x000000000048c185 in ram_save_setup (f=0x25e6ac0, opaque=<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/migration/ram.c:2093
#5  0x00000000004fbee2 in qemu_savevm_state_begin at /usr/src/debug/qemu-kvm-2.8.1/migration/savevm.c:956
#6  0x000000000083d8f8 in migration_thread at migration/migration.c:2198

static void vhost_log_global_start(MemoryListener *listener)
{
    int r;

    r = vhost_migration_log(listener, true);
    if (r < 0) {
        abort();   /* branch taken */
    }
}

What confuse me is that
1. do we really need to abort here ?
2. all member of callbacks in MemoryListener returned with type void, we cannot judge in any upper function on the call stack.
Can we just cancel migration here instead of calling abort ? like:

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ddc42f0..27ae4a2 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
+#include "qmp-commands.h"

 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -885,7 +886,7 @@ static void vhost_log_global_start(MemoryListener *listener)

     r = vhost_migration_log(listener, true);
     if (r < 0) {
-        abort();
+        qmp_migrate_cancel(NULL);
     }
 }

@@ -895,7 +896,7 @@ static void vhost_log_global_stop(MemoryListener *listener)

     r = vhost_migration_log(listener, false);
     if (r < 0) {
-        abort();
+        qmp_migrate_cancel(NULL);
     }
 }
