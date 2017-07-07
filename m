Received: from eggs.gnu.org ([2001:4830:134:3::10]:43828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmu-00075Z-8u
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmq-0001KQ-FI
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:51 +0200
Message-Id: <1499447335-6125-97-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 096/100] iotests: add more LUKS hash combination
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

Add tests for sha224, sha512, sha384 and ripemd160 hash
algorithms.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170626123510.20134-5-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/149     |  10 +-
 tests/qemu-iotests/149.out | 482 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 484 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index f62e618..5faf585 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -457,8 +457,12 @@ configs = [
 
 
     # LUKS default but diff hash
+    LUKSConfig("aes-256-xts-plain64-sha224",
+               "aes", 256, "xts", "plain64", None, "sha224"),
     LUKSConfig("aes-256-xts-plain64-sha256",
                "aes", 256, "xts", "plain64", None, "sha256"),
+    LUKSConfig("aes-256-xts-plain64-sha384",
+               "aes", 256, "xts", "plain64", None, "sha384"),
     LUKSConfig("aes-256-xts-plain64-sha512",
                "aes", 256, "xts", "plain64", None, "sha512"),
     LUKSConfig("aes-256-xts-plain64-ripemd160",
@@ -504,12 +508,6 @@ blacklist = [
 
     # GCrypt doesn't support Twofish with 192 bit key
     "twofish-192-xts-plain64-sha1",
-
-    # We don't have sha512 hash wired up yet
-    "aes-256-xts-plain64-sha512",
-
-    # We don't have ripemd160 hash wired up yet
-    "aes-256-xts-plain64-ripemd160",
 ]
 
 whitelist = []
diff --git a/tests/qemu-iotests/149.out b/tests/qemu-iotests/149.out
index b18c4e4..2f0454f 100644
--- a/tests/qemu-iotests/149.out
+++ b/tests/qemu-iotests/149.out
@@ -1562,6 +1562,126 @@ unlink TEST_DIR/luks-serpent-192-xts-plain64-sha1.img
 
 Skipping cast6-128-xts-plain64-sha1 in blacklist
 Skipping cast6-192-xts-plain64-sha1 in blacklist
+# ================= dm-crypt aes-256-xts-plain64-sha224 =================
+# Create image
+truncate TEST_DIR/luks-aes-256-xts-plain64-sha224.img --size 4194304MB
+# Format image
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha224 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+# Write test pattern 0xa7
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x13
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha224
+# Read test pattern 0xa7
+qemu-io -c read -P 0xa7 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x13
+qemu-io -c read -P 0x13 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x91
+qemu-io -c write -P 0x91 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x5e
+qemu-io -c write -P 0x5e 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+# Read test pattern 0x91
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x5e
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha224
+# Delete image
+unlink TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+
+# ================= qemu-img aes-256-xts-plain64-sha224 =================
+# Create image
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha224 TEST_DIR/luks-aes-256-xts-plain64-sha224.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha224.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha224 iter-time=10
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+# Write test pattern 0xa7
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x13
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha224
+# Read test pattern 0xa7
+qemu-io -c read -P 0xa7 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x13
+qemu-io -c read -P 0x13 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x91
+qemu-io -c write -P 0x91 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x5e
+qemu-io -c write -P 0x5e 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha224.img qiotest-145-aes-256-xts-plain64-sha224
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+# Read test pattern 0x91
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x5e
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha224
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha224
+# Delete image
+unlink TEST_DIR/luks-aes-256-xts-plain64-sha224.img
+
 # ================= dm-crypt aes-256-xts-plain64-sha256 =================
 # Create image
 truncate TEST_DIR/luks-aes-256-xts-plain64-sha256.img --size 4194304MB
@@ -1682,8 +1802,366 @@ sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha256
 # Delete image
 unlink TEST_DIR/luks-aes-256-xts-plain64-sha256.img
 
-Skipping aes-256-xts-plain64-sha512 in blacklist
-Skipping aes-256-xts-plain64-ripemd160 in blacklist
+# ================= dm-crypt aes-256-xts-plain64-sha384 =================
+# Create image
+truncate TEST_DIR/luks-aes-256-xts-plain64-sha384.img --size 4194304MB
+# Format image
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha384 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+# Write test pattern 0xa7
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x13
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha384
+# Read test pattern 0xa7
+qemu-io -c read -P 0xa7 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x13
+qemu-io -c read -P 0x13 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x91
+qemu-io -c write -P 0x91 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x5e
+qemu-io -c write -P 0x5e 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+# Read test pattern 0x91
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x5e
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha384
+# Delete image
+unlink TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+
+# ================= qemu-img aes-256-xts-plain64-sha384 =================
+# Create image
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha384 TEST_DIR/luks-aes-256-xts-plain64-sha384.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha384.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha384 iter-time=10
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+# Write test pattern 0xa7
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x13
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha384
+# Read test pattern 0xa7
+qemu-io -c read -P 0xa7 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x13
+qemu-io -c read -P 0x13 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x91
+qemu-io -c write -P 0x91 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x5e
+qemu-io -c write -P 0x5e 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha384.img qiotest-145-aes-256-xts-plain64-sha384
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+# Read test pattern 0x91
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x5e
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha384
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha384
+# Delete image
+unlink TEST_DIR/luks-aes-256-xts-plain64-sha384.img
+
+# ================= dm-crypt aes-256-xts-plain64-sha512 =================
+# Create image
+truncate TEST_DIR/luks-aes-256-xts-plain64-sha512.img --size 4194304MB
+# Format image
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha512 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+# Write test pattern 0xa7
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x13
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha512
+# Read test pattern 0xa7
+qemu-io -c read -P 0xa7 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x13
+qemu-io -c read -P 0x13 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x91
+qemu-io -c write -P 0x91 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x5e
+qemu-io -c write -P 0x5e 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+# Read test pattern 0x91
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x5e
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha512
+# Delete image
+unlink TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+
+# ================= qemu-img aes-256-xts-plain64-sha512 =================
+# Create image
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha512 TEST_DIR/luks-aes-256-xts-plain64-sha512.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha512.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha512 iter-time=10
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+# Write test pattern 0xa7
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x13
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha512
+# Read test pattern 0xa7
+qemu-io -c read -P 0xa7 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x13
+qemu-io -c read -P 0x13 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x91
+qemu-io -c write -P 0x91 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x5e
+qemu-io -c write -P 0x5e 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha512.img qiotest-145-aes-256-xts-plain64-sha512
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+# Read test pattern 0x91
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x5e
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-sha512
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-sha512
+# Delete image
+unlink TEST_DIR/luks-aes-256-xts-plain64-sha512.img
+
+# ================= dm-crypt aes-256-xts-plain64-ripemd160 =================
+# Create image
+truncate TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img --size 4194304MB
+# Format image
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash ripemd160 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+# Write test pattern 0xa7
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x13
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-ripemd160
+# Read test pattern 0xa7
+qemu-io -c read -P 0xa7 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x13
+qemu-io -c read -P 0x13 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x91
+qemu-io -c write -P 0x91 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x5e
+qemu-io -c write -P 0x5e 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+# Read test pattern 0x91
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x5e
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-ripemd160
+# Delete image
+unlink TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+
+# ================= qemu-img aes-256-xts-plain64-ripemd160 =================
+# Create image
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=ripemd160 TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=ripemd160 iter-time=10
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+# Write test pattern 0xa7
+qemu-io -c write -P 0xa7 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x13
+qemu-io -c write -P 0x13 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-ripemd160
+# Read test pattern 0xa7
+qemu-io -c read -P 0xa7 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x13
+qemu-io -c read -P 0x13 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x91
+qemu-io -c write -P 0x91 100M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+wrote 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Write test pattern 0x5e
+qemu-io -c write -P 0x5e 3145728M 10M --object secret,id=sec0,data=MTIzNDU2,format=base64 --image-opts driver=luks,key-secret=sec0,file.filename=TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+wrote 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Open dev
+sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img qiotest-145-aes-256-xts-plain64-ripemd160
+# Set dev owner
+sudo chown UID:GID /dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+# Read test pattern 0x91
+qemu-io -c read -P 0x91 100M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+read 10485760/10485760 bytes at offset 104857600
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Read test pattern 0x5e
+qemu-io -c read -P 0x5e 3145728M 10M --image-opts driver=file,filename=/dev/mapper/qiotest-145-aes-256-xts-plain64-ripemd160
+read 10485760/10485760 bytes at offset 3298534883328
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Close dev
+sudo cryptsetup -q -v luksClose qiotest-145-aes-256-xts-plain64-ripemd160
+# Delete image
+unlink TEST_DIR/luks-aes-256-xts-plain64-ripemd160.img
+
 # ================= dm-crypt aes-256-xts-plain-sha1-pwslot3 =================
 # Create image
 truncate TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img --size 4194304MB
-- 
1.8.3.1
