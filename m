Received: from eggs.gnu.org ([2001:4830:134:3::10]:46112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzjt-0003QZ-Ui
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzjq-0005XX-Az
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:58:18 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 11:57:46 +0000
Message-Id: <20170124115748.21473-4-berrange@redhat.com>
In-Reply-To: <20170124115748.21473-1-berrange@redhat.com>
References: <20170124115748.21473-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/5] iotests: reduce PBKDF iterations when
 testing LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

By default the PBKDF algorithm used with LUKS is tuned
based on the number of iterations to produce 1 second
of running time. This makes running the I/O test with
the LUKS format orders of magnitude slower than with
qcow2/raw formats.

When creating LUKS images, set the iteration time to
a 10ms to reduce the time overhead for LUKS, since
security does not matter in I/O tests.

Previously a full 'check -luks' would take

  $ time ./check -luks
  Passed all 22 tests

  real  23m9.988s
  user  21m46.223s
  sys   0m22.841s

Now it takes

  $ time ./check -luks
  Passed all 22 tests

  real  4m39.235s
  user  3m29.590s
  sys   0m24.234s

Still slow compared to qcow2/raw, but much improved
none the less.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/qemu-iotests/149           |   3 +
 tests/qemu-iotests/149.out       | 118 +++++++++++++++++++--------------------
 tests/qemu-iotests/common.filter |   3 +-
 tests/qemu-iotests/common.rc     |   3 +
 4 files changed, 67 insertions(+), 60 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 8407251..f62e618 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -136,6 +136,7 @@ def cryptsetup_add_password(config, slot):
         args = ["luksAddKey", config.image_path(),
                 "--key-slot", slot,
                 "--key-file", "-",
+                "--iter-time", "10",
                 pwfile]
 
         cryptsetup(args, password)
@@ -164,6 +165,7 @@ def cryptsetup_format(config):
         args.extend(["--hash", config.hash])
     args.extend(["--key-slot", slot])
     args.extend(["--key-file", "-"])
+    args.extend(["--iter-time", "10"])
     args.append(config.image_path())
 
     cryptsetup(args, password)
@@ -230,6 +232,7 @@ def qemu_img_create(config, size_mb):
 
     opts = [
         "key-secret=sec0",
+        "iter-time=10",
         "cipher-alg=%s-%d" % (config.cipher, config.keylen),
         "cipher-mode=%s" % config.mode,
         "ivgen-alg=%s" % config.ivgen,
diff --git a/tests/qemu-iotests/149.out b/tests/qemu-iotests/149.out
index 90b5b55..b18c4e4 100644
--- a/tests/qemu-iotests/149.out
+++ b/tests/qemu-iotests/149.out
@@ -2,7 +2,7 @@
 # Create image
 truncate TEST_DIR/luks-aes-256-xts-plain64-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-256-xts-plain64-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
 # Set dev owner
@@ -60,8 +60,8 @@ unlink TEST_DIR/luks-aes-256-xts-plain64-sha1.img
 
 # ================= qemu-img aes-256-xts-plain64-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-aes-256-xts-plain64-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-aes-256-xts-plain64-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha1.img qiotest-145-aes-256-xts-plain64-sha1
@@ -122,7 +122,7 @@ unlink TEST_DIR/luks-aes-256-xts-plain64-sha1.img
 # Create image
 truncate TEST_DIR/luks-twofish-256-xts-plain64-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher twofish-xts-plain64 --key-size 512 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-twofish-256-xts-plain64-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher twofish-xts-plain64 --key-size 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-twofish-256-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
 # Set dev owner
@@ -180,8 +180,8 @@ unlink TEST_DIR/luks-twofish-256-xts-plain64-sha1.img
 
 # ================= qemu-img twofish-256-xts-plain64-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=twofish-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-twofish-256-xts-plain64-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-twofish-256-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=twofish-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=twofish-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-twofish-256-xts-plain64-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-twofish-256-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=twofish-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-256-xts-plain64-sha1.img qiotest-145-twofish-256-xts-plain64-sha1
@@ -242,7 +242,7 @@ unlink TEST_DIR/luks-twofish-256-xts-plain64-sha1.img
 # Create image
 truncate TEST_DIR/luks-serpent-256-xts-plain64-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 512 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-serpent-256-xts-plain64-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-serpent-256-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
 # Set dev owner
@@ -300,8 +300,8 @@ unlink TEST_DIR/luks-serpent-256-xts-plain64-sha1.img
 
 # ================= qemu-img serpent-256-xts-plain64-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=serpent-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-serpent-256-xts-plain64-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-serpent-256-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=serpent-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=serpent-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-serpent-256-xts-plain64-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-serpent-256-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=serpent-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-256-xts-plain64-sha1.img qiotest-145-serpent-256-xts-plain64-sha1
@@ -362,7 +362,7 @@ unlink TEST_DIR/luks-serpent-256-xts-plain64-sha1.img
 # Create image
 truncate TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher cast5-cbc-plain64 --key-size 128 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher cast5-cbc-plain64 --key-size 128 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
 # Set dev owner
@@ -420,8 +420,8 @@ unlink TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img
 
 # ================= qemu-img cast5-128-cbc-plain64-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=cast5-128,cipher-mode=cbc,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=cast5-128 cipher-mode=cbc ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=cast5-128,cipher-mode=cbc,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=cast5-128 cipher-mode=cbc ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img qiotest-145-cast5-128-cbc-plain64-sha1
@@ -483,7 +483,7 @@ Skipping cast6-256-xts-plain64-sha1 in blacklist
 # Create image
 truncate TEST_DIR/luks-aes-256-cbc-plain-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain --key-size 256 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-256-cbc-plain-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-plain-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
 # Set dev owner
@@ -541,8 +541,8 @@ unlink TEST_DIR/luks-aes-256-cbc-plain-sha1.img
 
 # ================= qemu-img aes-256-cbc-plain-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=plain,hash-alg=sha1 TEST_DIR/luks-aes-256-cbc-plain-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-aes-256-cbc-plain-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=plain hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=plain,hash-alg=sha1 TEST_DIR/luks-aes-256-cbc-plain-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-cbc-plain-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=plain hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain-sha1.img qiotest-145-aes-256-cbc-plain-sha1
@@ -603,7 +603,7 @@ unlink TEST_DIR/luks-aes-256-cbc-plain-sha1.img
 # Create image
 truncate TEST_DIR/luks-aes-256-cbc-plain64-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-256-cbc-plain64-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
 # Set dev owner
@@ -661,8 +661,8 @@ unlink TEST_DIR/luks-aes-256-cbc-plain64-sha1.img
 
 # ================= qemu-img aes-256-cbc-plain64-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-aes-256-cbc-plain64-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-aes-256-cbc-plain64-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha1.img qiotest-145-aes-256-cbc-plain64-sha1
@@ -723,7 +723,7 @@ unlink TEST_DIR/luks-aes-256-cbc-plain64-sha1.img
 # Create image
 truncate TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
 # Set dev owner
@@ -781,8 +781,8 @@ unlink TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img
 
 # ================= qemu-img aes-256-cbc-essiv-sha256-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=essiv,hash-alg=sha1,ivgen-hash-alg=sha256 TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=essiv ivgen-hash-alg=sha256 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=essiv,hash-alg=sha1,ivgen-hash-alg=sha256 TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=essiv ivgen-hash-alg=sha256 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img qiotest-145-aes-256-cbc-essiv-sha256-sha1
@@ -843,7 +843,7 @@ unlink TEST_DIR/luks-aes-256-cbc-essiv-sha256-sha1.img
 # Create image
 truncate TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-xts-essiv:sha256 --key-size 512 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-essiv:sha256 --key-size 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
 # Set dev owner
@@ -901,8 +901,8 @@ unlink TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img
 
 # ================= qemu-img aes-256-xts-essiv-sha256-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=essiv,hash-alg=sha1,ivgen-hash-alg=sha256 TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=essiv ivgen-hash-alg=sha256 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=essiv,hash-alg=sha1,ivgen-hash-alg=sha256 TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=essiv ivgen-hash-alg=sha256 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img qiotest-145-aes-256-xts-essiv-sha256-sha1
@@ -963,7 +963,7 @@ unlink TEST_DIR/luks-aes-256-xts-essiv-sha256-sha1.img
 # Create image
 truncate TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
 # Set dev owner
@@ -1021,8 +1021,8 @@ unlink TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img
 
 # ================= qemu-img aes-128-xts-plain64-sha256-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-128,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-128 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-128,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-128 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img qiotest-145-aes-128-xts-plain64-sha256-sha1
@@ -1083,7 +1083,7 @@ unlink TEST_DIR/luks-aes-128-xts-plain64-sha256-sha1.img
 # Create image
 truncate TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 384 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 384 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
 # Set dev owner
@@ -1141,8 +1141,8 @@ unlink TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img
 
 # ================= qemu-img aes-192-xts-plain64-sha256-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-192,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-192 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-192,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-192 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img qiotest-145-aes-192-xts-plain64-sha256-sha1
@@ -1203,7 +1203,7 @@ unlink TEST_DIR/luks-aes-192-xts-plain64-sha256-sha1.img
 # Create image
 truncate TEST_DIR/luks-twofish-128-xts-plain64-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher twofish-xts-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-twofish-128-xts-plain64-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher twofish-xts-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-twofish-128-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
 # Set dev owner
@@ -1261,8 +1261,8 @@ unlink TEST_DIR/luks-twofish-128-xts-plain64-sha1.img
 
 # ================= qemu-img twofish-128-xts-plain64-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=twofish-128,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-twofish-128-xts-plain64-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-twofish-128-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=twofish-128 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=twofish-128,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-twofish-128-xts-plain64-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-twofish-128-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=twofish-128 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-twofish-128-xts-plain64-sha1.img qiotest-145-twofish-128-xts-plain64-sha1
@@ -1324,7 +1324,7 @@ Skipping twofish-192-xts-plain64-sha1 in blacklist
 # Create image
 truncate TEST_DIR/luks-serpent-128-xts-plain64-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-serpent-128-xts-plain64-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-serpent-128-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
 # Set dev owner
@@ -1382,8 +1382,8 @@ unlink TEST_DIR/luks-serpent-128-xts-plain64-sha1.img
 
 # ================= qemu-img serpent-128-xts-plain64-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=serpent-128,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-serpent-128-xts-plain64-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-serpent-128-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=serpent-128 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=serpent-128,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-serpent-128-xts-plain64-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-serpent-128-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=serpent-128 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-128-xts-plain64-sha1.img qiotest-145-serpent-128-xts-plain64-sha1
@@ -1444,7 +1444,7 @@ unlink TEST_DIR/luks-serpent-128-xts-plain64-sha1.img
 # Create image
 truncate TEST_DIR/luks-serpent-192-xts-plain64-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 384 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-serpent-192-xts-plain64-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher serpent-xts-plain64 --key-size 384 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-serpent-192-xts-plain64-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
 # Set dev owner
@@ -1502,8 +1502,8 @@ unlink TEST_DIR/luks-serpent-192-xts-plain64-sha1.img
 
 # ================= qemu-img serpent-192-xts-plain64-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=serpent-192,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-serpent-192-xts-plain64-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-serpent-192-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=serpent-192 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=serpent-192,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha1 TEST_DIR/luks-serpent-192-xts-plain64-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-serpent-192-xts-plain64-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=serpent-192 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-serpent-192-xts-plain64-sha1.img qiotest-145-serpent-192-xts-plain64-sha1
@@ -1566,7 +1566,7 @@ Skipping cast6-192-xts-plain64-sha1 in blacklist
 # Create image
 truncate TEST_DIR/luks-aes-256-xts-plain64-sha256.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha256 --key-slot 0 --key-file - TEST_DIR/luks-aes-256-xts-plain64-sha256.img
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain64 --key-size 512 --hash sha256 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain64-sha256.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
 # Set dev owner
@@ -1624,8 +1624,8 @@ unlink TEST_DIR/luks-aes-256-xts-plain64-sha256.img
 
 # ================= qemu-img aes-256-xts-plain64-sha256 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha256 TEST_DIR/luks-aes-256-xts-plain64-sha256.img 4194304M
-Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha256.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha256
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain64,hash-alg=sha256 TEST_DIR/luks-aes-256-xts-plain64-sha256.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-xts-plain64-sha256.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain64 hash-alg=sha256 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain64-sha256.img qiotest-145-aes-256-xts-plain64-sha256
@@ -1688,7 +1688,7 @@ Skipping aes-256-xts-plain64-ripemd160 in blacklist
 # Create image
 truncate TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain --key-size 512 --hash sha1 --key-slot 3 --key-file - TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain --key-size 512 --hash sha1 --key-slot 3 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img qiotest-145-aes-256-xts-plain-sha1-pwslot3
 # Set dev owner
@@ -1748,21 +1748,21 @@ unlink TEST_DIR/luks-aes-256-xts-plain-sha1-pwslot3.img
 # Create image
 truncate TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain --key-size 512 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img
+sudo cryptsetup -q -v luksFormat --cipher aes-xts-plain --key-size 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img
 # Add password slot 1
-sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 1 --key-file - TEST_DIR/passwd.txt
+sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 1 --key-file - --iter-time 10 TEST_DIR/passwd.txt
 # Add password slot 2
-sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 2 --key-file - TEST_DIR/passwd.txt
+sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 2 --key-file - --iter-time 10 TEST_DIR/passwd.txt
 # Add password slot 3
-sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 3 --key-file - TEST_DIR/passwd.txt
+sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 3 --key-file - --iter-time 10 TEST_DIR/passwd.txt
 # Add password slot 4
-sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 4 --key-file - TEST_DIR/passwd.txt
+sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 4 --key-file - --iter-time 10 TEST_DIR/passwd.txt
 # Add password slot 5
-sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 5 --key-file - TEST_DIR/passwd.txt
+sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 5 --key-file - --iter-time 10 TEST_DIR/passwd.txt
 # Add password slot 6
-sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 6 --key-file - TEST_DIR/passwd.txt
+sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 6 --key-file - --iter-time 10 TEST_DIR/passwd.txt
 # Add password slot 7
-sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 7 --key-file - TEST_DIR/passwd.txt
+sudo cryptsetup -q -v luksAddKey TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img --key-slot 7 --key-file - --iter-time 10 TEST_DIR/passwd.txt
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
 # Set dev owner
@@ -1820,8 +1820,8 @@ unlink TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img
 
 # ================= qemu-img aes-256-xts-plain-sha1-pwallslots =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=c2xvdDE=,format=base64 -o key-secret=sec0,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain,hash-alg=sha1 TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img 4194304M
-Formatting 'TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=c2xvdDE=,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=xts,ivgen-alg=plain,hash-alg=sha1 TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=xts ivgen-alg=plain hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img qiotest-145-aes-256-xts-plain-sha1-pwallslots
@@ -1882,7 +1882,7 @@ unlink TEST_DIR/luks-aes-256-xts-plain-sha1-pwallslots.img
 # Create image
 truncate TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher aes-cbc-essiv:sha256 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
 # Set dev owner
@@ -1940,8 +1940,8 @@ unlink TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img
 
 # ================= qemu-img aes-256-cbc-essiv-auto-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=essiv,hash-alg=sha1 TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=essiv hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=essiv,hash-alg=sha1 TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=essiv hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img qiotest-145-aes-256-cbc-essiv-auto-sha1
@@ -2002,7 +2002,7 @@ unlink TEST_DIR/luks-aes-256-cbc-essiv-auto-sha1.img
 # Create image
 truncate TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img --size 4194304MB
 # Format image
-sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain64:sha256 --key-size 256 --hash sha1 --key-slot 0 --key-file - TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img
+sudo cryptsetup -q -v luksFormat --cipher aes-cbc-plain64:sha256 --key-size 256 --hash sha1 --key-slot 0 --key-file - --iter-time 10 TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
 # Set dev owner
@@ -2060,8 +2060,8 @@ unlink TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img
 
 # ================= qemu-img aes-256-cbc-plain64-sha256-sha1 =================
 # Create image
-qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=plain64,hash-alg=sha1,ivgen-hash-alg=sha256 TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img 4194304M
-Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=plain64 ivgen-hash-alg=sha256 hash-alg=sha1
+qemu-img create -f luks --object secret,id=sec0,data=MTIzNDU2,format=base64 -o key-secret=sec0,iter-time=10,cipher-alg=aes-256,cipher-mode=cbc,ivgen-alg=plain64,hash-alg=sha1,ivgen-hash-alg=sha256 TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img 4194304M
+Formatting 'TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img', fmt=luks size=4398046511104 key-secret=sec0 cipher-alg=aes-256 cipher-mode=cbc ivgen-alg=plain64 ivgen-hash-alg=sha256 hash-alg=sha1 iter-time=10
 
 # Open dev
 sudo cryptsetup -q -v luksOpen TEST_DIR/luks-aes-256-cbc-plain64-sha256-sha1.img qiotest-145-aes-256-cbc-plain64-sha256-sha1
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 240ed06..7f99f5e 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -114,7 +114,8 @@ _filter_img_create()
         -e "s# log_size=[0-9]\\+##g" \
         -e "s/archipelago:a/TEST_DIR\//g" \
         -e "s# refcount_bits=[0-9]\\+##g" \
-        -e "s# key-secret=[a-zA-Z0-9]\\+##g"
+        -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
+        -e "s# iter-time=[0-9]\\+##g"
 }
 
 _filter_img_info()
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 3213765..b242518 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -108,6 +108,9 @@ _set_default_imgopts()
     if [ "$IMGFMT" == "qcow2" ] && ! (echo "$IMGOPTS" | grep "compat=" > /dev/null); then
         IMGOPTS=$(_optstr_add "$IMGOPTS" "compat=1.1")
     fi
+    if [ "$IMGFMT" == "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=" > /dev/null); then
+        IMGOPTS=$(_optstr_add "$IMGOPTS" "iter-time=10")
+    fi
 }
 
 _use_sample_img()
-- 
2.9.3
