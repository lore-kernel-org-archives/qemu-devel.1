Received: from eggs.gnu.org ([2001:4830:134:3::10]:34013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLF-0007de-2h
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLC-00033i-O8
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:05 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:56:44 -0800
Message-ID: <7d327222a677c66a4de74f563fa9af09b87b636a.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 06/45] hw/block: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, qemu-block@nongnu.org

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-block@nongnu.org
---
V2:
 - Split hw patch into individual directories

 hw/block/dataplane/virtio-blk.c |  6 +++---
 hw/block/onenand.c              |  8 ++++----
 hw/block/tc58128.c              | 44 +++++++++++++++++++----------------------
 3 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 5556f0e64e..69dfd49191 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -178,8 +178,8 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     /* Set up guest notifier (irq) */
     r = k->set_guest_notifiers(qbus->parent, nvqs, true);
     if (r != 0) {
-        fprintf(stderr, "virtio-blk failed to set guest notifier (%d), "
-                "ensure -enable-kvm is set\n", r);
+        error_report("virtio-blk failed to set guest notifier (%d), "
+                "ensure -enable-kvm is set", r);
         goto fail_guest_notifiers;
     }
 
@@ -187,7 +187,7 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     for (i = 0; i < nvqs; i++) {
         r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, true);
         if (r != 0) {
-            fprintf(stderr, "virtio-blk failed to set host notifier (%d)\n", r);
+            error_report("virtio-blk failed to set host notifier (%d)", r);
             while (i--) {
                 virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
             }
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index ed77f859e9..9591e9e82c 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -596,7 +596,7 @@ static void onenand_command(OneNANDState *s)
     default:
         s->status |= ONEN_ERR_CMD;
         s->intstatus |= ONEN_INT;
-        fprintf(stderr, "%s: unknown OneNAND command %x\n",
+        error_report("%s: unknown OneNAND command %x",
                         __func__, s->command);
     }
 
@@ -663,7 +663,7 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
         return 0x0000;
     }
 
-    fprintf(stderr, "%s: unknown OneNAND register %x\n",
+    error_report("%s: unknown OneNAND register %x",
                     __func__, offset);
     return 0;
 }
@@ -708,7 +708,7 @@ static void onenand_write(void *opaque, hwaddr addr,
             break;
 
         default:
-            fprintf(stderr, "%s: unknown OneNAND boot command %"PRIx64"\n",
+            error_report("%s: unknown OneNAND boot command %"PRIx64"",
                             __func__, value);
         }
         break;
@@ -759,7 +759,7 @@ static void onenand_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        fprintf(stderr, "%s: unknown OneNAND register %x\n",
+        error_report("%s: unknown OneNAND register %x",
                         __func__, offset);
     }
 }
diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index 1d9f7ee000..d274c9aafe 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -50,8 +50,8 @@ static void init_dev(tc58128_dev * dev, const char *filename)
 	    dev->flash_contents[1] = (blocks >> 8) & 0xff;
 	    dev->flash_contents[2] = (blocks >> 16) & 0xff;
 	    dev->flash_contents[3] = (blocks >> 24) & 0xff;
-	    fprintf(stderr, "loaded %d bytes for %s into flash\n", ret,
-		    filename);
+        error_report("loaded %d bytes for %s into flash", ret,
+                     filename);
 	}
     }
 }
@@ -60,26 +60,26 @@ static void handle_command(tc58128_dev * dev, uint8_t command)
 {
     switch (command) {
     case 0xff:
-	fprintf(stderr, "reset flash device\n");
-	dev->state = WAIT;
-	break;
+        error_report("reset flash device");
+        dev->state = WAIT;
+        break;
     case 0x00:
-	fprintf(stderr, "read mode 1\n");
-	dev->state = READ1;
-	dev->address_cycle = 0;
-	break;
+        error_report("read mode 1");
+        dev->state = READ1;
+        dev->address_cycle = 0;
+        break;
     case 0x01:
-	fprintf(stderr, "read mode 2\n");
-	dev->state = READ2;
-	dev->address_cycle = 0;
-	break;
+        error_report("read mode 2");
+        dev->state = READ2;
+        dev->address_cycle = 0;
+        break;
     case 0x50:
-	fprintf(stderr, "read mode 3\n");
-	dev->state = READ3;
-	dev->address_cycle = 0;
-	break;
+        error_report("read mode 3");
+        dev->state = READ3;
+        dev->address_cycle = 0;
+        break;
     default:
-	fprintf(stderr, "unknown flash command 0x%02x\n", command);
+        error_report("unknown flash command 0x%02x", command);
         abort();
     }
 }
@@ -103,8 +103,8 @@ static void handle_address(tc58128_dev * dev, uint8_t data)
 	    break;
 	case 2:
 	    dev->address += data * 528;
-	    fprintf(stderr, "address pointer in flash: 0x%08x\n",
-		    dev->address);
+        error_report("address pointer in flash: 0x%08x",
+                     dev->address);
 	    break;
 	default:
 	    /* Invalid data */
@@ -119,10 +119,6 @@ static void handle_address(tc58128_dev * dev, uint8_t data)
 
 static uint8_t handle_read(tc58128_dev * dev)
 {
-#if 0
-    if (dev->address % 0x100000 == 0)
-	fprintf(stderr, "reading flash at address 0x%08x\n", dev->address);
-#endif
     return dev->flash_contents[dev->address++];
 }
 
-- 
2.14.1
