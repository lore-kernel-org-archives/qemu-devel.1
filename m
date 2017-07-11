Received: from eggs.gnu.org ([2001:4830:134:3::10]:46755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxm1-0001mN-W6
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxln-000705-2S
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:24 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:46 +0200
Message-Id: <20170711160814.20941-58-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 57/85] iotests: chown LUKS device before qemu-io
 launches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

On some distros, whenever you close a block device file
descriptor there is a udev rule that resets the file
permissions. This can race with the test script when
we run qemu-io multiple times against the same block
device. Occasionally the second qemu-io invocation
will find udev has reset the permissions causing failure.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170626123510.20134-6-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/149     |  12 +-
 tests/qemu-iotests/149.out | 344 ++++++++++++++++++++++-----------------------
 2 files changed, 177 insertions(+), 179 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 5faf585..223cd68 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -186,7 +186,7 @@ def chown(config):
     msg = proc.communicate()[0]
 
     if proc.returncode != 0:
-        raise Exception("Cannot change owner on %s" % path)
+        raise Exception(msg)
 
 
 def cryptsetup_open(config):
@@ -271,6 +271,8 @@ def qemu_io_image_args(config, dev=False):
 def qemu_io_write_pattern(config, pattern, offset_mb, size_mb, dev=False):
     """Write a pattern of data to a LUKS image or device"""
 
+    if dev:
+        chown(config)
     args = ["-c", "write -P 0x%x %dM %dM" % (pattern, offset_mb, size_mb)]
     args.extend(qemu_io_image_args(config, dev))
     iotests.log("qemu-io " + " ".join(args), filters=[iotests.filter_test_dir])
@@ -281,6 +283,8 @@ def qemu_io_write_pattern(config, pattern, offset_mb, size_mb, dev=False):
 def qemu_io_read_pattern(config, pattern, offset_mb, size_mb, dev=False):
     """Read a pattern of data to a LUKS image or device"""
 
+    if dev:
+        chown(config)
     args = ["-c", "read -P 0x%x %dM %dM" % (pattern, offset_mb, size_mb)]
     args.extend(qemu_io_image_args(config, dev))
     iotests.log("qemu-io " + " ".join(args), filters=[iotests.filter_test_dir])
@@ -331,9 +335,6 @@ def test_once(config, qemu_img=False):
         cryptsetup_open(config)
 
         try:
-            iotests.log("# Set dev owner")
-            chown(config)
-
             iotests.log("# Write test pattern 0xa7")
             qemu_io_write_pattern(config, 0xa7, lowOffsetMB, 10, dev=True)
             iotests.log("# Write test pattern 0x13")
@@ -365,9 +366,6 @@ def test_once(config, qemu_img=False):
         cryptsetup_open(config)
 
         try:
-            iotests.log("# Set dev owner")
-            chown(config)
-
             iotests.log("# Read test pattern 0x91")
             qemu_io_read_pattern(config, 0x91, lowOffsetMB, 10, dev=True)
             iotests.log("# Read test pattern 0x5e")
diff --git a/tests/qemu-iotests/149.out b/tests/qemu-iotests/149.out
index 2f0454f..5dea00b 100644
--- a/tests/qemu-iotests/149.out
+++ b/tests/qemu-iotests/149.out
@@ -5,14 +5,14 @@ truncate TEST_DIR/luks-aes-256-xts-plain64-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -41,14 +41,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -65,14 +65,14 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha1.img', fmt=luks size=439804651
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -101,14 +101,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -125,14 +125,14 @@ truncate TEST_DIR/luks-twofish-256-xts-plain64-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher twofish-xts-plain64 --key-size 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-twofish-256-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -161,14 +161,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -185,14 +185,14 @@ Formatting 'TEST_DIR/luks-twofish-256-xts-plain64-sha1.img', fmt=luks size=43980
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -221,14 +221,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -245,14 +245,14 @@ truncate TEST_DIR/luks-serpent-256-xts-plain64-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-serpent-256-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -281,14 +281,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -305,14 +305,14 @@ Formatting 'TEST_DIR/luks-serpent-256-xts-plain64-sha1.img', fmt=luks size=43980
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -341,14 +341,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-256-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -365,14 +365,14 @@ truncate TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher cast5-cbc-plain64 --key-size 128 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -401,14 +401,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -425,14 +425,14 @@ Formatting 'TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img', fmt=luks size=4398046
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -461,14 +461,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-cast5-128-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -486,14 +486,14 @@ truncate TEST_DIR/luks-aes-256-cbc-plain-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-plain-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -522,14 +522,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -546,14 +546,14 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-plain-sha1.img', fmt=luks size=43980465111
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -582,14 +582,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -606,14 +606,14 @@ truncate TEST_DIR/luks-aes-256-cbc-plain64-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -642,14 +642,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -666,14 +666,14 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-sha1.img', fmt=luks size=439804651
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -702,14 +702,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -726,14 +726,14 @@ truncate TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -762,14 +762,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -786,14 +786,14 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img', fmt=luks size=4398
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -822,14 +822,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -846,14 +846,14 @@ truncate TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-essiv:sha256 --key-size 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -882,14 +882,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -906,14 +906,14 @@ Formatting 'TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img', fmt=luks size=4398
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -942,14 +942,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-essiv-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -966,14 +966,14 @@ truncate TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1002,14 +1002,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1026,14 +1026,14 @@ Formatting 'TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img', fmt=luks size=43
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1062,14 +1062,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-128-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1086,14 +1086,14 @@ truncate TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 384 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1122,14 +1122,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1146,14 +1146,14 @@ Formatting 'TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img', fmt=luks size=43
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1182,14 +1182,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-192-xts-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1206,14 +1206,14 @@ truncate TEST_DIR/luks-twofish-128-xts-plain64-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher twofish-xts-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-twofish-128-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1242,14 +1242,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1266,14 +1266,14 @@ Formatting 'TEST_DIR/luks-twofish-128-xts-plain64-sha1.img', fmt=luks size=43980
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1302,14 +1302,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-twofish-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1327,14 +1327,14 @@ truncate TEST_DIR/luks-serpent-128-xts-plain64-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-serpent-128-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1363,14 +1363,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1387,14 +1387,14 @@ Formatting 'TEST_DIR/luks-serpent-128-xts-plain64-sha1.img', fmt=luks size=43980
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1423,14 +1423,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-128-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1447,14 +1447,14 @@ truncate TEST_DIR/luks-serpent-192-xts-plain64-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 384 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-serpent-192-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1483,14 +1483,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1507,14 +1507,14 @@ Formatting 'TEST_DIR/luks-serpent-192-xts-plain64-sha1.img', fmt=luks size=43980
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1543,14 +1543,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-serpent-192-xts-plain64-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1569,14 +1569,14 @@ truncate TEST_DIR/luks-aes-256-xts-plain64-sha224.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha224 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha224.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1605,14 +1605,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1629,14 +1629,14 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha224.img', fmt=luks size=4398046
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1665,14 +1665,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1689,14 +1689,14 @@ truncate TEST_DIR/luks-aes-256-xts-plain64-sha256.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha256 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha256.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1725,14 +1725,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1749,14 +1749,14 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha256.img', fmt=luks size=4398046
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1785,14 +1785,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha256
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1809,14 +1809,14 @@ truncate TEST_DIR/luks-aes-256-xts-plain64-sha384.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha384 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha384.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1845,14 +1845,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1869,14 +1869,14 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha384.img', fmt=luks size=4398046
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1905,14 +1905,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1929,14 +1929,14 @@ truncate TEST_DIR/luks-aes-256-xts-plain64-sha512.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha512 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha512.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1965,14 +1965,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -1989,14 +1989,14 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha512.img', fmt=luks size=4398046
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2025,14 +2025,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2049,14 +2049,14 @@ truncate TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash ripemd160 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2085,14 +2085,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2109,14 +2109,14 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img', fmt=luks size=4398
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2145,14 +2145,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2169,14 +2169,14 @@ truncate TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain --key-size 512 --hash sha1 --key-slot 3 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img qiotest-145-aes-256-xts-plain-sha1-pwslot3
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2205,14 +2205,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img qiotest-145-aes-256-xts-plain-sha1-pwslot3
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwslot3
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2243,14 +2243,14 @@ sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots
 sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 7 --key-file - --iter-time 10 TEST_DIR/passwd.txt
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2279,14 +2279,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2303,14 +2303,14 @@ Formatting 'TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img', fmt=luks size=
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2339,14 +2339,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain-sha1-pwallslots
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2363,14 +2363,14 @@ truncate TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2399,14 +2399,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2423,14 +2423,14 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img', fmt=luks size=439804
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2459,14 +2459,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-essiv-auto-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2483,14 +2483,14 @@ truncate TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img --size 4194304MB
 sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain64:sha256 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2519,14 +2519,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2543,14 +2543,14 @@ Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img', fmt=luks size=43
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 # Write test pattern 0xa7
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Write test pattern 0x13
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 wrote 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -2579,14 +2579,14 @@ wrote 10485760/10485760 bytes at offset 3298534883328
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
-# Set dev owner
-sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 # Read test pattern 0x91
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 104857600
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 # Read test pattern 0x5e
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-cbc-plain64-sha256-sha1
 read 10485760/10485760 bytes at offset 3298534883328
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.9.4
