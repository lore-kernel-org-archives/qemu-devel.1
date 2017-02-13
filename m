Received: from eggs.gnu.org ([2001:4830:134:3::10]:59474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKM6-0003QQ-8I
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKM2-0006BS-Q5
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:42 +0100
Message-Id: <1487006583-24350-21-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 20/41] hw/block: Introduce share-rw qdev
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

By default, don't allow another writer for block devices that are
attached to a guest device. For the cases where this setup is intended
(e.g. using a cluster filesystem on the disk), the new option can be
used to allow it.

This change affects only devices using DEFINE_BLOCK_PROPERTIES().
Devices directly using DEFINE_PROP_DRIVE() still accept writers
unconditionally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/block.c           | 14 ++++++------
 include/hw/block/block.h   |  4 +++-
 tests/qemu-iotests/172.out | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index c3d3901..3c218eb 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -56,7 +56,7 @@ void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
 {
     BlockBackend *blk = conf->blk;
     BlockdevOnError rerror, werror;
-    uint64_t perm;
+    uint64_t perm, shared_perm;
     bool wce;
     int ret;
 
@@ -65,11 +65,13 @@ void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
         perm |= BLK_PERM_WRITE;
     }
 
-    /* TODO Remove BLK_PERM_WRITE unless explicitly configured so */
-    ret = blk_set_perm(blk, perm,
-                       BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                       BLK_PERM_GRAPH_MOD | BLK_PERM_RESIZE | BLK_PERM_WRITE,
-                       errp);
+    shared_perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                  BLK_PERM_GRAPH_MOD | BLK_PERM_RESIZE;
+    if (conf->share_rw) {
+        shared_perm |= BLK_PERM_WRITE;
+    }
+
+    ret = blk_set_perm(blk, perm, shared_perm, errp);
     if (ret < 0) {
         return;
     }
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 3daccf1..ff78f12 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -26,6 +26,7 @@ typedef struct BlockConf {
     /* geometry, not all devices use this */
     uint32_t cyls, heads, secs;
     OnOffAuto wce;
+    bool share_rw;
     BlockdevOnError rerror;
     BlockdevOnError werror;
 } BlockConf;
@@ -53,7 +54,8 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
     DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
     DEFINE_PROP_UINT32("discard_granularity", _state, \
                        _conf.discard_granularity, -1), \
-    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce, ON_OFF_AUTO_AUTO)
+    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce, ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false)
 
 #define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)      \
     DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),  \
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 6b7edaf..54b5329 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -28,6 +28,7 @@ Testing:
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "288"
 
 
@@ -57,6 +58,7 @@ Testing: -fda TEST_DIR/t.qcow2
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -fdb TEST_DIR/t.qcow2
@@ -83,6 +85,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -93,6 +96,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "288"
 
 Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2
@@ -119,6 +123,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -129,6 +134,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 
@@ -158,6 +164,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
@@ -184,6 +191,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -194,6 +202,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "288"
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
@@ -220,6 +229,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -230,6 +240,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 
@@ -259,6 +270,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
@@ -285,6 +297,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0 -global isa-fdc.driveB=none1
@@ -311,6 +324,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -321,6 +335,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 
@@ -350,6 +365,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
@@ -376,6 +392,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0 -device floppy,drive=none1,unit=1
@@ -402,6 +419,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -412,6 +430,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 
@@ -441,6 +460,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -451,6 +471,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
@@ -477,6 +498,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -487,6 +509,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
@@ -513,6 +536,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
@@ -539,6 +563,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 
@@ -568,6 +593,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -578,6 +604,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
@@ -604,6 +631,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -614,6 +642,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
@@ -640,6 +669,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -650,6 +680,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=0
@@ -676,6 +707,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -686,6 +718,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device flop
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=0
@@ -723,6 +756,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -733,6 +767,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
@@ -759,6 +794,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -769,6 +805,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=0
@@ -802,6 +839,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -812,6 +850,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=1
@@ -838,6 +877,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -848,6 +888,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0 -device floppy,drive=none1
@@ -874,6 +915,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -884,6 +926,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=0
@@ -910,6 +953,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -920,6 +964,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=0
@@ -964,6 +1009,7 @@ Testing: -device floppy
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "288"
 
 Testing: -device floppy,drive-type=120
@@ -990,6 +1036,7 @@ Testing: -device floppy,drive-type=120
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "120"
 
 Testing: -device floppy,drive-type=144
@@ -1016,6 +1063,7 @@ Testing: -device floppy,drive-type=144
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -device floppy,drive-type=288
@@ -1042,6 +1090,7 @@ Testing: -device floppy,drive-type=288
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "288"
 
 
@@ -1071,6 +1120,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "120"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-type=288
@@ -1097,6 +1147,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "288"
 
 
@@ -1126,6 +1177,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physical_block_size=512
@@ -1152,6 +1204,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
                 opt_io_size = 0 (0x0)
                 discard_granularity = 4294967295 (0xffffffff)
                 write-cache = "auto"
+                share-rw = false
                 drive-type = "144"
 
 Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical_block_size=4096
-- 
1.8.3.1
