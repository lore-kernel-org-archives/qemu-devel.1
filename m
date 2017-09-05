Received: from eggs.gnu.org ([2001:4830:134:3::10]:43016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpFar-0008Ht-9P
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpFah-0002sc-Rr
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:16:49 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Sep 2017 17:16:13 +0200
Message-Id: <20170905151614.31303-3-cohuck@redhat.com>
In-Reply-To: <20170905151614.31303-1-cohuck@redhat.com>
References: <20170905151614.31303-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] iotests: use -ccw on s390x for 051
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, haoqf@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

The default cpu model on s390x does not provide zPCI, which is
not yet wired up on tcg. Moreover, virtio-ccw is the standard
on s390x, so use the -ccw instead of the -pci versions of virtio
devices on s390x.

Provide an output file for s390x.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/qemu-iotests/051                     |   9 +-
 tests/qemu-iotests/051.s390-ccw-virtio.out | 434 +++++++++++++++++++++++++++++
 2 files changed, 442 insertions(+), 1 deletion(-)
 create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index c8cfc764bc..f6ad0f4f0b 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -103,7 +103,14 @@ echo
 echo === Device without drive ===
 echo
 
-run_qemu -device virtio-scsi-pci -device scsi-hd
+case "$QEMU_DEFAULT_MACHINE" in
+  s390-ccw-virtio)
+      run_qemu -device virtio-scsi-ccw -device scsi-hd
+      ;;
+  *)
+      run_qemu -device virtio-scsi-pci -device scsi-hd
+      ;;
+esac
 
 echo
 echo === Overriding backing file ===
diff --git a/tests/qemu-iotests/051.s390-ccw-virtio.out b/tests/qemu-iotests/051.s390-ccw-virtio.out
new file mode 100644
index 0000000000..7555f0b73e
--- /dev/null
+++ b/tests/qemu-iotests/051.s390-ccw-virtio.out
@@ -0,0 +1,434 @@
+QA output created by 051
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+
+=== Unknown option ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,unknown_opt=,if=none,id=drive0
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,unknown_opt=,if=none,id=drive0: Block format 'qcow2' does not support the option 'unknown_opt'
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,unknown_opt=on,if=none,id=drive0
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,unknown_opt=on,if=none,id=drive0: Block format 'qcow2' does not support the option 'unknown_opt'
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,unknown_opt=1234,if=none,id=drive0
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,unknown_opt=1234,if=none,id=drive0: Block format 'qcow2' does not support the option 'unknown_opt'
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,unknown_opt=foo,if=none,id=drive0
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,unknown_opt=foo,if=none,id=drive0: Block format 'qcow2' does not support the option 'unknown_opt'
+
+
+=== Unknown protocol option ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,file.unknown_opt=
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,file.unknown_opt=: Block protocol 'file' doesn't support the option 'unknown_opt'
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,file.unknown_opt=on
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,file.unknown_opt=on: Block protocol 'file' doesn't support the option 'unknown_opt'
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,file.unknown_opt=1234
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,file.unknown_opt=1234: Block protocol 'file' doesn't support the option 'unknown_opt'
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,file.unknown_opt=foo
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,file.unknown_opt=foo: Block protocol 'file' doesn't support the option 'unknown_opt'
+
+
+=== Invalid format ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=foo
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=foo: Unknown driver 'foo'
+
+Testing: -drive file=TEST_DIR/t.qcow2,driver=foo
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=foo: Unknown driver 'foo'
+
+Testing: -drive file=TEST_DIR/t.qcow2,driver=raw,format=qcow2
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=raw,format=qcow2: Cannot specify both 'driver' and 'format'
+
+Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2: Cannot specify both 'driver' and 'format'
+
+
+=== Device without drive ===
+
+Testing: -device virtio-scsi-ccw -device scsi-hd
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) QEMU_PROG: -device scsi-hd: drive property not set
+
+
+=== Overriding backing file ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,backing.file.filename=TEST_DIR/t.qcow2.orig,if=none,id=drive0 -nodefaults
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+    Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig: Driver doesn't support backing files
+
+Testing: -drive file=TEST_DIR/t.qcow2,file.backing.driver=file,file.backing.filename=TEST_DIR/t.qcow2.orig
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,file.backing.driver=file,file.backing.filename=TEST_DIR/t.qcow2.orig: Driver doesn't support backing files
+
+Testing: -drive file=TEST_DIR/t.qcow2,file.backing.driver=qcow2,file.backing.file.filename=TEST_DIR/t.qcow2.orig
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,file.backing.driver=qcow2,file.backing.file.filename=TEST_DIR/t.qcow2.orig: Driver doesn't support backing files
+
+
+=== Enable and disable lazy refcounting on the command line, plus some invalid values ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=: Parameter 'lazy-refcounts' expects 'on' or 'off'
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=42
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=42: Parameter 'lazy-refcounts' expects 'on' or 'off'
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=foo
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=foo: Parameter 'lazy-refcounts' expects 'on' or 'off'
+
+
+=== With version 2 images enabling lazy refcounts must fail ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on: Lazy refcounts require a qcow2 image with at least qemu 1.1 compatibility level
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+
+=== No medium ===
+
+Testing: -drive if=virtio
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
+
+
+=== Read-only ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+
+=== Cache modes ===
+
+Testing: -drive driver=null-co,cache=none
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive driver=null-co,cache=directsync
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive driver=null-co,cache=writeback
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive driver=null-co,cache=writethrough
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive driver=null-co,cache=unsafe
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive driver=null-co,cache=invalid_value
+QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
+
+Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback
+    Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
+(qemu) info block file
+
+file: TEST_DIR/t.qcow2 (file)
+    Cache mode:       writeback
+(qemu) info block backing
+backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
+    Cache mode:       writeback, ignore flushes
+(qemu) info block backing-file
+
+backing-file: TEST_DIR/t.qcow2.base (file, read-only)
+    Cache mode:       writeback, ignore flushes
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+    Removable device: not locked, tray closed
+    Cache mode:       writethrough
+    Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
+(qemu) info block file
+
+file: TEST_DIR/t.qcow2 (file)
+    Cache mode:       writeback
+(qemu) info block backing
+backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
+    Cache mode:       writeback, ignore flushes
+(qemu) info block backing-file
+
+backing-file: TEST_DIR/t.qcow2.base (file, read-only)
+    Cache mode:       writeback, ignore flushes
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+drive0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
+    Removable device: not locked, tray closed
+    Cache mode:       writeback, ignore flushes
+    Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
+(qemu) info block file
+
+file: TEST_DIR/t.qcow2 (file)
+    Cache mode:       writeback, ignore flushes
+(qemu) info block backing
+backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
+    Cache mode:       writeback, ignore flushes
+(qemu) info block backing-file
+
+backing-file: TEST_DIR/t.qcow2.base (file, read-only)
+    Cache mode:       writeback, ignore flushes
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0: invalid cache option
+
+
+=== Specifying the protocol layer ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,file.driver=file
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+
+=== Leaving out required options ===
+
+Testing: -drive driver=file
+QEMU_PROG: -drive driver=file: The 'file' block driver requires a file name
+
+Testing: -drive driver=file,filename=
+QEMU_PROG: -drive driver=file,filename=: The 'file' block driver requires a file name
+
+Testing: -drive driver=nbd
+QEMU_PROG: -drive driver=nbd: NBD server address missing
+
+Testing: -drive driver=raw
+QEMU_PROG: -drive driver=raw: A block device must be specified for "file"
+
+Testing: -drive file.driver=file
+QEMU_PROG: -drive file.driver=file: The 'file' block driver requires a file name
+
+Testing: -drive file.driver=nbd
+QEMU_PROG: -drive file.driver=nbd: NBD server address missing
+
+Testing: -drive file.driver=raw
+QEMU_PROG: -drive file.driver=raw: A block device must be specified for "file"
+
+Testing: -drive foo=bar
+QEMU_PROG: -drive foo=bar: Must specify either driver or file
+
+
+=== Specifying both an option and its legacy alias ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,iops=1234,throttling.iops-total=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,iops=1234,throttling.iops-total=5678: 'throttling.iops-total' and its alias 'iops' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,iops_rd=1234,throttling.iops-read=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,iops_rd=1234,throttling.iops-read=5678: 'throttling.iops-read' and its alias 'iops_rd' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,iops_wr=1234,throttling.iops-write=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,iops_wr=1234,throttling.iops-write=5678: 'throttling.iops-write' and its alias 'iops_wr' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps=1234,throttling.bps-total=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps=1234,throttling.bps-total=5678: 'throttling.bps-total' and its alias 'bps' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps_rd=1234,throttling.bps-read=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps_rd=1234,throttling.bps-read=5678: 'throttling.bps-read' and its alias 'bps_rd' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps_wr=1234,throttling.bps-write=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps_wr=1234,throttling.bps-write=5678: 'throttling.bps-write' and its alias 'bps_wr' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,iops_max=1234,throttling.iops-total-max=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,iops_max=1234,throttling.iops-total-max=5678: 'throttling.iops-total-max' and its alias 'iops_max' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,iops_rd_max=1234,throttling.iops-read-max=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,iops_rd_max=1234,throttling.iops-read-max=5678: 'throttling.iops-read-max' and its alias 'iops_rd_max' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,iops_wr_max=1234,throttling.iops-write-max=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,iops_wr_max=1234,throttling.iops-write-max=5678: 'throttling.iops-write-max' and its alias 'iops_wr_max' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps_max=1234,throttling.bps-total-max=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps_max=1234,throttling.bps-total-max=5678: 'throttling.bps-total-max' and its alias 'bps_max' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps_rd_max=1234,throttling.bps-read-max=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps_rd_max=1234,throttling.bps-read-max=5678: 'throttling.bps-read-max' and its alias 'bps_rd_max' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps_wr_max=1234,throttling.bps-write-max=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps_wr_max=1234,throttling.bps-write-max=5678: 'throttling.bps-write-max' and its alias 'bps_wr_max' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,iops_size=1234,throttling.iops-size=5678
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,iops_size=1234,throttling.iops-size=5678: 'throttling.iops-size' and its alias 'iops_size' can't be used at the same time
+
+Testing: -drive file=TEST_DIR/t.qcow2,readonly=on,read-only=off
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,readonly=on,read-only=off: 'read-only' and its alias 'readonly' can't be used at the same time
+
+
+=== Catching negative/large throttling values ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,iops=-1
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,iops=-1: bps/iops/max values must be within [0, 1000000000000000]
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps=-2
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps=-2: bps/iops/max values must be within [0, 1000000000000000]
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps_rd=-3
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps_rd=-3: bps/iops/max values must be within [0, 1000000000000000]
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps_rd_max=-3
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps_rd_max=-3: bps/iops/max values must be within [0, 1000000000000000]
+
+Testing: -drive file=TEST_DIR/t.qcow2,throttling.iops-total=-4
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,throttling.iops-total=-4: bps/iops/max values must be within [0, 1000000000000000]
+
+Testing: -drive file=TEST_DIR/t.qcow2,throttling.bps-total=-5
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,throttling.bps-total=-5: bps/iops/max values must be within [0, 1000000000000000]
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps=0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps=1
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000000
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001: bps/iops/max values must be within [0, 1000000000000000]
+
+Testing: -drive file=TEST_DIR/t.qcow2,bps=9999999999999999
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps=9999999999999999: bps/iops/max values must be within [0, 1000000000000000]
+
+
+=== Parsing protocol from file name ===
+
+Testing: -hda foo:bar
+QEMU_PROG: -hda foo:bar: Unknown protocol 'foo'
+
+Testing: -drive file=foo:bar
+QEMU_PROG: -drive file=foo:bar: Unknown protocol 'foo'
+
+Testing: -drive file.filename=foo:bar
+QEMU_PROG: -drive file.filename=foo:bar: Could not open 'foo:bar': No such file or directory
+
+Testing: -hda file:TEST_DIR/t.qcow2
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=file:TEST_DIR/t.qcow2
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file.filename=file:TEST_DIR/t.qcow2
+QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST_DIR/t.qcow2': No such file or directory
+
+
+=== Snapshot mode ===
+
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,snapshot=on,if=none,id=drive0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,if=none,id=drive0 -snapshot
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+Testing: -drive file=file:TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+Testing: -drive file=file:TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Testing: -drive file=TEST_DIR/t.qcow2,snapshot=off,if=none,id=drive0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x22 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io drive0 "write -P 0x33 0 4k"
+wrote 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) commit drive0
+(qemu) quit
+
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
-- 
2.13.5
