Received: from eggs.gnu.org ([2001:4830:134:3::10]:54536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfV-000148-Vp
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfS-0002yq-0Y
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:17 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 25 May 2018 18:33:21 +0200
Message-Id: <20180525163327.23097-9-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-1-kwolf@redhat.com>
References: <20180525163327.23097-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 08/14] qemu-iotests: Rewrite 206 for
 blockdev-create job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This rewrites the test case 206 to work with the new x-blockdev-create
job rather than the old synchronous version of the command.

All of the test cases stay the same as before, but in order to be able
to implement proper job handling, the test case is rewritten in Python.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/206        | 705 +++++++++++++++++-------------------------
 tests/qemu-iotests/206.out    | 241 +++++++++------
 tests/qemu-iotests/group      |   2 +-
 tests/qemu-iotests/iotests.py |  15 +
 4 files changed, 448 insertions(+), 515 deletions(-)

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 0a18b2b19a..9a305302d1 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -1,9 +1,11 @@
-#!/bin/bash
+#!/usr/bin/env python
 #
 # Test qcow2 and file image creation
 #
 # Copyright (C) 2018 Red Hat, Inc.
 #
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
@@ -18,419 +20,288 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-# creator
-owner=kwolf@redhat.com
-
-seq=`basename $0`
-echo "QA output created by $seq"
-
-here=`pwd`
-status=1	# failure is the default!
-
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.filter
-
-_supported_fmt qcow2
-_supported_proto file
-_supported_os Linux
-
-function do_run_qemu()
-{
-    echo Testing: "$@"
-    $QEMU -nographic -qmp stdio -serial none "$@"
-    echo
-}
-
-function run_qemu()
-{
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
-                          | _filter_qemu | _filter_imgfmt \
-                          | _filter_actual_image_size
-}
-
-echo
-echo "=== Successful image creation (defaults) ==="
-echo
-
-size=$((128 * 1024 * 1024))
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "file",
-      "filename": "$TEST_IMG",
-      "size": 0
-  }
-}
-{ "execute": "blockdev-add",
-  "arguments": {
-      "driver": "file",
-      "node-name": "imgfile",
-      "filename": "$TEST_IMG"
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "imgfile",
-      "size": $size
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info --format-specific
-
-echo
-echo "=== Successful image creation (inline blockdev-add, explicit defaults) ==="
-echo
-
-# Choose a different size to show that we got a new image
-size=$((64 * 1024 * 1024))
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "file",
-      "filename": "$TEST_IMG",
-      "size": 0,
-      "preallocation": "off",
-      "nocow": false
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": {
-          "driver": "file",
-          "filename": "$TEST_IMG"
-      },
-      "size": $size,
-      "version": "v3",
-      "cluster-size": 65536,
-      "preallocation": "off",
-      "lazy-refcounts": false,
-      "refcount-bits": 16
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info --format-specific
-
-echo
-echo "=== Successful image creation (v3 non-default options) ==="
-echo
-
-# Choose a different size to show that we got a new image
-size=$((32 * 1024 * 1024))
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "file",
-      "filename": "$TEST_IMG",
-      "size": 0,
-      "preallocation": "falloc",
-      "nocow": true
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": {
-          "driver": "file",
-          "filename": "$TEST_IMG"
-      },
-      "size": $size,
-      "version": "v3",
-      "cluster-size": 2097152,
-      "preallocation": "metadata",
-      "lazy-refcounts": true,
-      "refcount-bits": 1
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info --format-specific
-
-echo
-echo "=== Successful image creation (v2 non-default options) ==="
-echo
-
-mv $TEST_IMG $TEST_IMG.base
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "file",
-      "filename": "$TEST_IMG",
-      "size": 0
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": {
-          "driver": "file",
-          "filename": "$TEST_IMG"
-      },
-      "size": $size,
-      "backing-file": "$TEST_IMG.base",
-      "backing-fmt": "qcow2",
-      "version": "v2",
-      "cluster-size": 512
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info --format-specific
-
-echo
-echo "=== Successful image creation (encrypted) ==="
-echo
-
-run_qemu -object secret,id=keysec0,data="foo" <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": {
-          "driver": "file",
-          "filename": "$TEST_IMG"
-      },
-      "size": $size,
-      "encrypt": {
-          "format": "luks",
-          "key-secret": "keysec0",
-          "cipher-alg": "twofish-128",
-          "cipher-mode": "ctr",
-          "ivgen-alg": "plain64",
-          "ivgen-hash-alg": "md5",
-          "hash-alg": "sha1",
-          "iter-time": 10
-      }
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info --format-specific | _filter_img_info --format-specific
-
-echo
-echo "=== Invalid BlockdevRef ==="
-echo
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "this doesn't exist",
-      "size": $size
-  }
-}
-{ "execute": "quit" }
-EOF
-
-
-echo
-echo "=== Invalid sizes ==="
-echo
-
-# TODO Negative image sizes aren't handled correctly, but this is a problem
-# with QAPI's implementation of the 'size' type and affects other commands as
-# well. Once this is fixed, we may want to add a test case here.
-
-# 1. Misaligned image size
-# 2. 2^64 - 512
-# 3. 2^63 = 8 EB (qemu-img enforces image sizes less than this)
-# 4. 2^63 - 512 (generally valid, but qcow2 can't handle images this size)
-
-run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 1234
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 18446744073709551104
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 9223372036854775808
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 9223372036854775296
-  }
-}
-{ "execute": "quit" }
-EOF
-
-echo
-echo "=== Invalid version ==="
-echo
-
-run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "version": "v1"
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "version": "v2",
-      "lazy-refcounts": true
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "version": "v2",
-      "refcount-bits": 8
-  }
-}
-{ "execute": "quit" }
-EOF
-
-echo
-echo "=== Invalid backing file options ==="
-echo
-
-run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "backing-file": "/dev/null",
-      "preallocation": "full"
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "backing-fmt": "$IMGFMT"
-  }
-}
-{ "execute": "quit" }
-EOF
-
-echo
-echo "=== Invalid cluster size ==="
-echo
-
-run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "cluster-size": 1234
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "cluster-size": 128
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "cluster-size": 4194304
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "cluster-size": 0
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 281474976710656,
-      "cluster-size": 512
-  }
-}
-{ "execute": "quit" }
-EOF
-
-echo
-echo "=== Invalid refcount width ==="
-echo
-
-run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "refcount-bits": 128
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "refcount-bits": 0
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "$IMGFMT",
-      "file": "node0",
-      "size": 67108864,
-      "refcount-bits": 7
-  }
-}
-{ "execute": "quit" }
-EOF
-
-# success, all done
-echo "*** done"
-rm -f $seq.full
-status=0
+import iotests
+from iotests import imgfmt
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+
+def blockdev_create(vm, options):
+    result = vm.qmp_log('x-blockdev-create', job_id='job0', options=options)
+
+    if 'return' in result:
+        assert result['return'] == {}
+        vm.run_job('job0')
+    iotests.log("")
+
+with iotests.FilePath('t.qcow2') as disk_path, \
+     iotests.FilePath('t.qcow2.base') as backing_path, \
+     iotests.VM() as vm:
+
+    vm.add_object('secret,id=keysec0,data="foo"')
+
+    #
+    # Successful image creation (defaults)
+    #
+    iotests.log("=== Successful image creation (defaults) ===")
+    iotests.log("")
+
+    size = 128 * 1024 * 1024
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'file',
+                          'filename': disk_path,
+                          'size': 0 })
+
+    vm.qmp_log('blockdev-add', driver='file', filename=disk_path,
+               node_name='imgfile')
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'imgfile',
+                          'size': size })
+    vm.shutdown()
+
+    iotests.img_info_log(disk_path)
+
+    #
+    # Successful image creation (inline blockdev-add, explicit defaults)
+    #
+    iotests.log("=== Successful image creation (inline blockdev-add, explicit defaults) ===")
+    iotests.log("")
+
+    # Choose a different size to show that we got a new image
+    size = 64 * 1024 * 1024
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'file',
+                          'filename': disk_path,
+                          'size': 0,
+                          'preallocation': 'off',
+                          'nocow': False })
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': {
+                              'driver': 'file',
+                              'filename': disk_path,
+                          },
+                          'size': size,
+                          'version': 'v3',
+                          'cluster-size': 65536,
+                          'preallocation': 'off',
+                          'lazy-refcounts': False,
+                          'refcount-bits': 16 })
+    vm.shutdown()
+
+    iotests.img_info_log(disk_path)
+
+    #
+    # Successful image creation (v3 non-default options)
+    #
+    iotests.log("=== Successful image creation (v3 non-default options) ===")
+    iotests.log("")
+
+    # Choose a different size to show that we got a new image
+    size = 32 * 1024 * 1024
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'file',
+                          'filename': disk_path,
+                          'size': 0,
+                          'preallocation': 'falloc',
+                          'nocow': True })
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': {
+                              'driver': 'file',
+                              'filename': disk_path,
+                          },
+                          'size': size,
+                          'version': 'v3',
+                          'cluster-size': 2097152,
+                          'preallocation': 'metadata',
+                          'lazy-refcounts': True,
+                          'refcount-bits': 1 })
+    vm.shutdown()
+
+    iotests.img_info_log(disk_path)
+
+    #
+    # Successful image creation (v2 non-default options)
+    #
+    iotests.log("=== Successful image creation (v2 non-default options) ===")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'file',
+                          'filename': disk_path,
+                          'size': 0 })
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': {
+                              'driver': 'file',
+                              'filename': disk_path,
+                          },
+                          'size': size,
+                          'backing-file': backing_path,
+                          'backing-fmt': 'qcow2',
+                          'version': 'v2',
+                          'cluster-size': 512 })
+    vm.shutdown()
+
+    iotests.img_info_log(disk_path)
+
+    #
+    # Successful image creation (encrypted)
+    #
+    iotests.log("=== Successful image creation (encrypted) ===")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': {
+                              'driver': 'file',
+                              'filename': disk_path,
+                          },
+                          'size': size,
+                          'encrypt': {
+                              'format': 'luks',
+                              'key-secret': 'keysec0',
+                              'cipher-alg': 'twofish-128',
+                              'cipher-mode': 'ctr',
+                              'ivgen-alg': 'plain64',
+                              'ivgen-hash-alg': 'md5',
+                              'hash-alg': 'sha1',
+                              'iter-time': 10,
+                          }})
+    vm.shutdown()
+
+    iotests.img_info_log(disk_path)
+
+    #
+    # Invalid BlockdevRef
+    #
+    iotests.log("=== Invalid BlockdevRef ===")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': "this doesn't exist",
+                          'size': size })
+    vm.shutdown()
+
+    #
+    # Invalid sizes
+    #
+    iotests.log("=== Invalid sizes ===")
+
+    # TODO Negative image sizes aren't handled correctly, but this is a problem
+    # with QAPI's implementation of the 'size' type and affects other commands
+    # as well. Once this is fixed, we may want to add a test case here.
+    #
+    # 1. Misaligned image size
+    # 2. 2^64 - 512
+    # 3. 2^63 = 8 EB (qemu-img enforces image sizes less than this)
+    # 4. 2^63 - 512 (generally valid, but qcow2 can't handle images this size)
+
+    vm.add_blockdev('driver=file,filename=%s,node-name=node0' % (disk_path))
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 1234  })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 18446744073709551104 })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 9223372036854775808 })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 9223372036854775296})
+    vm.shutdown()
+
+    #
+    # Invalid version
+    #
+    iotests.log("=== Invalid version ===")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'version': 'v1' })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'version': 'v2',
+                          'lazy-refcounts': True })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'version': 'v2',
+                          'refcount-bits': 8 })
+    vm.shutdown()
+
+    #
+    # Invalid backing file options
+    #
+    iotests.log("=== Invalid backing file options ===")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'backing-file': '/dev/null',
+                          'preallocation': 'full' })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'backing-fmt': imgfmt })
+    vm.shutdown()
+
+    #
+    # Invalid cluster size
+    #
+    iotests.log("=== Invalid cluster size ===")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'cluster-size': 1234 })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'cluster-size': 128 })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'cluster-size': 4194304 })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'cluster-size': 0 })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 281474976710656,
+                          'cluster-size': 512 })
+    vm.shutdown()
+
+    #
+    # Invalid refcount width
+    #
+    iotests.log("=== Invalid refcount width ===")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'refcount-bits': 128 })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'refcount-bits': 0 })
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'node0',
+                          'size': 67108864,
+                          'refcount-bits': 7 })
+    vm.shutdown()
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 042342ae9d..45367270e8 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -1,15 +1,16 @@
-QA output created by 206
-
 === Successful image creation (defaults) ===
 
-Testing:
-QMP_VERSION
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/t.qcow2'}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'blockdev-add', 'arguments': {'node_name': 'imgfile', 'driver': 'file', 'filename': 'TEST_DIR/t.qcow2'}}
+{u'return': {}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'imgfile', 'size': 134217728}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -23,13 +24,15 @@ Format specific information:
 
 === Successful image creation (inline blockdev-add, explicit defaults) ===
 
-Testing:
-QMP_VERSION
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'nocow': False, 'preallocation': 'off', 'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/t.qcow2'}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 65536, 'refcount-bits': 16, 'version': 'v3', 'preallocation': 'off', 'file': {'driver': 'file', 'filename': 'TEST_DIR/t.qcow2'}, 'lazy-refcounts': False, 'driver': 'qcow2', 'size': 67108864}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -43,13 +46,15 @@ Format specific information:
 
 === Successful image creation (v3 non-default options) ===
 
-Testing:
-QMP_VERSION
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'nocow': True, 'preallocation': 'falloc', 'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/t.qcow2'}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 2097152, 'refcount-bits': 1, 'version': 'v3', 'preallocation': 'metadata', 'file': {'driver': 'file', 'filename': 'TEST_DIR/t.qcow2'}, 'lazy-refcounts': True, 'driver': 'qcow2', 'size': 33554432}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -63,13 +68,15 @@ Format specific information:
 
 === Successful image creation (v2 non-default options) ===
 
-Testing:
-QMP_VERSION
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/t.qcow2'}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 512, 'backing-fmt': 'qcow2', 'driver': 'qcow2', 'version': 'v2', 'file': {'driver': 'file', 'filename': 'TEST_DIR/t.qcow2'}, 'backing-file': 'TEST_DIR/t.qcow2.base', 'size': 33554432}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -83,16 +90,16 @@ Format specific information:
 
 === Successful image creation (encrypted) ===
 
-Testing: -object secret,id=keysec0,data=foo
-QMP_VERSION
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'encrypt': {'key-secret': 'keysec0', 'iter-time': 10, 'cipher-mode': 'ctr', 'ivgen-hash-alg': 'md5', 'cipher-alg': 'twofish-128', 'format': 'luks', 'ivgen-alg': 'plain64', 'hash-alg': 'sha1'}, 'driver': 'qcow2', 'file': {'driver': 'file', 'filename': 'TEST_DIR/t.qcow2'}, 'size': 33554432}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 32M (33554432 bytes)
+encrypted: yes
+cluster_size: 65536
 Format specific information:
     compat: 1.1
     lazy refcounts: false
@@ -101,13 +108,13 @@ Format specific information:
         ivgen alg: plain64
         hash alg: sha1
         cipher alg: twofish-128
-        uuid: 00000000-0000-0000-0000-000000000000
+        uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
         format: luks
         cipher mode: ctr
         slots:
             [0]:
                 active: true
-                iters: 1024
+                iters: XXX
                 key offset: 4096
                 stripes: 4000
             [1]:
@@ -132,78 +139,118 @@ Format specific information:
                 active: false
                 key offset: 462848
         payload offset: 528384
-        master key iters: 1024
+        master key iters: XXX
     corrupt: false
 
 === Invalid BlockdevRef ===
 
-Testing:
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "Cannot find device=this doesn't exist nor node_name=this doesn't exist"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': "this doesn't exist", 'size': 33554432}}}
+{u'return': {}}
+Job failed: Cannot find device=this doesn't exist nor node_name=this doesn't exist
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 === Invalid sizes ===
-
-Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "Image size must be a multiple of 512 bytes"}}
-{"error": {"class": "GenericError", "desc": "Could not resize image: Image size cannot be negative"}}
-{"error": {"class": "GenericError", "desc": "Could not resize image: Image size cannot be negative"}}
-{"error": {"class": "GenericError", "desc": "Could not resize image: Failed to grow the L1 table: File too large"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 1234}}}
+{u'return': {}}
+Job failed: Image size must be a multiple of 512 bytes
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 18446744073709551104L}}}
+{u'return': {}}
+Job failed: Could not resize image: Image size cannot be negative
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 9223372036854775808L}}}
+{u'return': {}}
+Job failed: Could not resize image: Image size cannot be negative
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 9223372036854775296}}}
+{u'return': {}}
+Job failed: Could not resize image: Failed to grow the L1 table: File too large
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 === Invalid version ===
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'version': 'v1', 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'error': {u'class': u'GenericError', u'desc': u"Invalid parameter 'v1'"}}
 
-Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "Invalid parameter 'v1'"}}
-{"error": {"class": "GenericError", "desc": "Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)"}}
-{"error": {"class": "GenericError", "desc": "Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'lazy-refcounts': True, 'version': 'v2', 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'refcount-bits': 8, 'version': 'v2', 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 === Invalid backing file options ===
-
-Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "Backing file and preallocation cannot be used at the same time"}}
-{"error": {"class": "GenericError", "desc": "Backing format cannot be used without backing file"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'preallocation': 'full', 'driver': 'qcow2', 'backing-file': '/dev/null', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Backing file and preallocation cannot be used at the same time
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'backing-fmt': 'qcow2', 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Backing format cannot be used without backing file
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 === Invalid cluster size ===
-
-Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "Cluster size must be a power of two between 512 and 2048k"}}
-{"error": {"class": "GenericError", "desc": "Cluster size must be a power of two between 512 and 2048k"}}
-{"error": {"class": "GenericError", "desc": "Cluster size must be a power of two between 512 and 2048k"}}
-{"error": {"class": "GenericError", "desc": "Cluster size must be a power of two between 512 and 2048k"}}
-{"error": {"class": "GenericError", "desc": "Could not resize image: Failed to grow the L1 table: File too large"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 1234, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Cluster size must be a power of two between 512 and 2048k
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 128, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Cluster size must be a power of two between 512 and 2048k
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 4194304, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Cluster size must be a power of two between 512 and 2048k
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 0, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Cluster size must be a power of two between 512 and 2048k
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 512, 'driver': 'qcow2', 'file': 'node0', 'size': 281474976710656}}}
+{u'return': {}}
+Job failed: Could not resize image: Failed to grow the L1 table: File too large
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 === Invalid refcount width ===
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'refcount-bits': 128, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Refcount width must be a power of two and may not exceed 64 bits
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'refcount-bits': 0, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Refcount width must be a power of two and may not exceed 64 bits
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'refcount-bits': 7, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
+{u'return': {}}
+Job failed: Refcount width must be a power of two and may not exceed 64 bits
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
-Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=node0
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "Refcount width must be a power of two and may not exceed 64 bits"}}
-{"error": {"class": "GenericError", "desc": "Refcount width must be a power of two and may not exceed 64 bits"}}
-{"error": {"class": "GenericError", "desc": "Refcount width must be a power of two and may not exceed 64 bits"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-
-*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 22b0082db3..be157e7679 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -204,9 +204,9 @@
 203 rw auto migration
 204 rw auto quick
 205 rw auto quick
+206 rw auto
 # TODO The following commented out tests need to be reworked to work
 # with the x-blockdev-create job
-#206 rw auto
 #207 rw auto
 208 rw auto quick
 209 rw auto quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 20ce5a0cf0..f0f4ef32f0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -416,6 +416,21 @@ class VM(qtest.QEMUQtestMachine):
         log(result)
         return result
 
+    def run_job(self, job):
+        while True:
+            for ev in self.get_qmp_events_filtered(wait=True):
+                if ev['event'] == 'JOB_STATUS_CHANGE':
+                    if ev['data']['status'] == 'aborting':
+                        result = self.qmp('query-jobs')
+                        for j in result['return']:
+                            log('Job failed: %s' % (j.get('error', None)))
+                    elif ev['data']['status'] == 'concluded':
+                        self.qmp_log('job-dismiss', id=job)
+                    elif ev['data']['status'] == 'null':
+                        return
+                else:
+                    iotests.log(ev)
+
 
 index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
 
-- 
2.13.6
