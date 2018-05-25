Received: from eggs.gnu.org ([2001:4830:134:3::10]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfT-00011U-HL
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfQ-0002xo-Rd
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 25 May 2018 18:33:22 +0200
Message-Id: <20180525163327.23097-10-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-1-kwolf@redhat.com>
References: <20180525163327.23097-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 09/14] qemu-iotests: Rewrite 207 for
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

This rewrites the test case 207 to work with the new x-blockdev-create
job rather than the old synchronous version of the command.

Most of the test cases stay the same as before (the exception being some
improved 'size' options that allow distinguishing which command created
the image), but in order to be able to implement proper job handling,
the test case is rewritten in Python.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/207        | 435 +++++++++++++++++++-----------------------
 tests/qemu-iotests/207.out    |  89 +++++----
 tests/qemu-iotests/group      |   6 +-
 tests/qemu-iotests/iotests.py |  23 ++-
 4 files changed, 264 insertions(+), 289 deletions(-)

diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index f5c77852d1..91c1f7e811 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -1,9 +1,11 @@
-#!/bin/bash
+#!/usr/bin/env python
 #
 # Test ssh image creation
 #
 # Copyright (C) 2018 Red Hat, Inc.
 #
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
@@ -18,244 +20,193 @@
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
-_supported_fmt raw
-_supported_proto ssh
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
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "ssh",
-      "location": {
-          "path": "$TEST_IMG_FILE",
-          "server": {
-              "host": "127.0.0.1",
-              "port": "22"
-          }
-      },
-      "size": 4194304
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info | _filter_img_info
-echo
-TEST_IMG=$TEST_IMG_FILE _img_info | _filter_img_info
-
-echo
-echo "=== Test host-key-check options ==="
-echo
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "ssh",
-      "location": {
-          "path": "$TEST_IMG_FILE",
-          "server": {
-              "host": "127.0.0.1",
-              "port": "22"
-          },
-          "host-key-check": {
-              "mode": "none"
-          }
-      },
-      "size": 8388608
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info | _filter_img_info
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "ssh",
-      "location": {
-          "path": "$TEST_IMG_FILE",
-          "server": {
-              "host": "127.0.0.1",
-              "port": "22"
-          },
-          "host-key-check": {
-              "mode": "known_hosts"
-          }
-      },
-      "size": 4194304
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info | _filter_img_info
-
-
-key=$(ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" |
-      cut -d" " -f3 | base64 -d | md5sum -b | cut -d" " -f1)
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "ssh",
-      "location": {
-          "path": "$TEST_IMG_FILE",
-          "server": {
-              "host": "127.0.0.1",
-              "port": "22"
-          },
-          "host-key-check": {
-              "mode": "hash",
-              "type": "md5",
-              "hash": "wrong"
-          }
-      },
-      "size": 8388608
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "ssh",
-      "location": {
-          "path": "$TEST_IMG_FILE",
-          "server": {
-              "host": "127.0.0.1",
-              "port": "22"
-          },
-          "host-key-check": {
-              "mode": "hash",
-              "type": "md5",
-              "hash": "$key"
-          }
-      },
-      "size": 8388608
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info | _filter_img_info
-
-
-key=$(ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" |
-      cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1)
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "ssh",
-      "location": {
-          "path": "$TEST_IMG_FILE",
-          "server": {
-              "host": "127.0.0.1",
-              "port": "22"
-          },
-          "host-key-check": {
-              "mode": "hash",
-              "type": "sha1",
-              "hash": "wrong"
-          }
-      },
-      "size": 4194304
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "ssh",
-      "location": {
-          "path": "$TEST_IMG_FILE",
-          "server": {
-              "host": "127.0.0.1",
-              "port": "22"
-          },
-          "host-key-check": {
-              "mode": "hash",
-              "type": "sha1",
-              "hash": "$key"
-          }
-      },
-      "size": 4194304
-  }
-}
-{ "execute": "quit" }
-EOF
-
-_img_info | _filter_img_info
-
-echo
-echo "=== Invalid path and user ==="
-echo
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "ssh",
-      "location": {
-          "path": "/this/is/not/an/existing/path",
-          "server": {
-              "host": "127.0.0.1",
-              "port": "22"
-          }
-      },
-      "size": 4194304
-  }
-}
-{ "execute": "x-blockdev-create",
-  "arguments": {
-      "driver": "ssh",
-      "location": {
-          "path": "$TEST_IMG_FILE",
-          "user": "invalid user",
-          "server": {
-              "host": "127.0.0.1",
-              "port": "22"
-          }
-      },
-      "size": 4194304
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
+import subprocess
+
+iotests.verify_image_format(supported_fmts=['raw'])
+iotests.verify_protocol(supported=['ssh'])
+
+def blockdev_create(vm, options):
+    result = vm.qmp_log('x-blockdev-create', job_id='job0', options=options)
+
+    if 'return' in result:
+        assert result['return'] == {}
+        vm.run_job('job0')
+    iotests.log("")
+
+with iotests.FilePath('t.img') as disk_path, \
+     iotests.VM() as vm:
+
+    remote_path = iotests.remote_filename(disk_path)
+
+    #
+    # Successful image creation (defaults)
+    #
+    iotests.log("=== Successful image creation (defaults) ===")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'ssh',
+                          'location': {
+                              'path': disk_path,
+                              'server': {
+                                  'host': '127.0.0.1',
+                                  'port': '22'
+                              }
+                          },
+                          'size': 4194304 })
+    vm.shutdown()
+
+    iotests.img_info_log(remote_path, filter_path=disk_path)
+    iotests.log("")
+    iotests.img_info_log(disk_path)
+
+    #
+    # Test host-key-check options
+    #
+    iotests.log("=== Test host-key-check options ===")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'ssh',
+                          'location': {
+                              'path': disk_path,
+                              'server': {
+                                  'host': '127.0.0.1',
+                                  'port': '22'
+                              },
+                              'host-key-check': {
+                                  'mode': 'none'
+                              }
+                          },
+                          'size': 8388608 })
+    vm.shutdown()
+
+    iotests.img_info_log(remote_path, filter_path=disk_path)
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'ssh',
+                          'location': {
+                              'path': disk_path,
+                              'server': {
+                                  'host': '127.0.0.1',
+                                  'port': '22'
+                              },
+                              'host-key-check': {
+                                  'mode': 'known_hosts'
+                              }
+                          },
+                          'size': 4194304 })
+    vm.shutdown()
+
+    iotests.img_info_log(remote_path, filter_path=disk_path)
+
+    md5_key = subprocess.check_output(
+        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
+        'cut -d" " -f3 | base64 -d | md5sum -b | cut -d" " -f1',
+        shell=True).rstrip()
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'ssh',
+                          'location': {
+                              'path': disk_path,
+                              'server': {
+                                  'host': '127.0.0.1',
+                                  'port': '22'
+                              },
+                              'host-key-check': {
+                                  'mode': 'hash',
+                                  'type': 'md5',
+                                  'hash': 'wrong',
+                              }
+                          },
+                          'size': 2097152 })
+    blockdev_create(vm, { 'driver': 'ssh',
+                          'location': {
+                              'path': disk_path,
+                              'server': {
+                                  'host': '127.0.0.1',
+                                  'port': '22'
+                              },
+                              'host-key-check': {
+                                  'mode': 'hash',
+                                  'type': 'md5',
+                                  'hash': md5_key,
+                              }
+                          },
+                          'size': 8388608 })
+    vm.shutdown()
+
+    iotests.img_info_log(remote_path, filter_path=disk_path)
+
+    sha1_key = subprocess.check_output(
+        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
+        'cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1',
+        shell=True).rstrip()
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'ssh',
+                          'location': {
+                              'path': disk_path,
+                              'server': {
+                                  'host': '127.0.0.1',
+                                  'port': '22'
+                              },
+                              'host-key-check': {
+                                  'mode': 'hash',
+                                  'type': 'sha1',
+                                  'hash': 'wrong',
+                              }
+                          },
+                          'size': 2097152 })
+    blockdev_create(vm, { 'driver': 'ssh',
+                          'location': {
+                              'path': disk_path,
+                              'server': {
+                                  'host': '127.0.0.1',
+                                  'port': '22'
+                              },
+                              'host-key-check': {
+                                  'mode': 'hash',
+                                  'type': 'sha1',
+                                  'hash': sha1_key,
+                              }
+                          },
+                          'size': 4194304 })
+    vm.shutdown()
+
+    iotests.img_info_log(remote_path, filter_path=disk_path)
+
+    #
+    # Invalid path and user
+    #
+    iotests.log("=== Invalid path and user ===")
+    iotests.log("")
+
+    vm.launch()
+    blockdev_create(vm, { 'driver': 'ssh',
+                          'location': {
+                              'path': '/this/is/not/an/existing/path',
+                              'server': {
+                                  'host': '127.0.0.1',
+                                  'port': '22'
+                              },
+                              'host-key-check': {
+                                  'mode': 'none'
+                              }
+                          },
+                          'size': 4194304 })
+    blockdev_create(vm, { 'driver': 'ssh',
+                          'location': {
+                              'path': disk_path,
+                              'user': 'invalid user',
+                              'server': {
+                                  'host': '127.0.0.1',
+                                  'port': '22'
+                              },
+                              'host-key-check': {
+                                  'mode': 'none'
+                              }
+                          },
+                          'size': 4194304 })
+    vm.shutdown()
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 417deee970..299650872c 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -1,62 +1,64 @@
-QA output created by 207
-
 === Successful image creation (defaults) ===
 
-Testing:
-QMP_VERSION
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/t.img', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
 
+
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
 
 === Test host-key-check options ===
 
-Testing:
-QMP_VERSION
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/t.img', 'host-key-check': {'mode': 'none'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 8388608}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
-Testing:
-QMP_VERSION
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/t.img', 'host-key-check': {'mode': 'known_hosts'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
-Testing:
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "remote host key does not match host_key_check 'wrong'"}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/t.img', 'host-key-check': {'hash': 'wrong', 'type': 'md5', 'mode': 'hash'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 2097152}}}
+{u'return': {}}
+Job failed: remote host key does not match host_key_check 'wrong'
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/t.img', 'host-key-check': {'hash': 'f3386a5742ddc4a04244118e59a1f92b', 'type': 'md5', 'mode': 'hash'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 8388608}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
-Testing:
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "remote host key does not match host_key_check 'wrong'"}}
-{"return": {}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/t.img', 'host-key-check': {'hash': 'wrong', 'type': 'sha1', 'mode': 'hash'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 2097152}}}
+{u'return': {}}
+Job failed: remote host key does not match host_key_check 'wrong'
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/t.img', 'host-key-check': {'hash': 'c6142e54650531177fa3d88ac52501ae00ccff69', 'type': 'sha1', 'mode': 'hash'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
+{u'return': {}}
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
 file format: IMGFMT
@@ -64,12 +66,15 @@ virtual size: 4.0M (4194304 bytes)
 
 === Invalid path and user ===
 
-Testing:
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "failed to open remote file '/this/is/not/an/existing/path': Failed opening remote file (libssh2 error code: -31)"}}
-{"error": {"class": "GenericError", "desc": "failed to authenticate using publickey authentication and the identities held by your ssh-agent"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': '/this/is/not/an/existing/path', 'host-key-check': {'mode': 'none'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
+{u'return': {}}
+Job failed: failed to open remote file '/this/is/not/an/existing/path': Failed opening remote file (libssh2 error code: -31)
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
+
+{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/t.img', 'host-key-check': {'mode': 'none'}, 'user': 'invalid user', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
+{u'return': {}}
+Job failed: failed to authenticate using publickey authentication and the identities held by your ssh-agent
+{'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
+{u'return': {}}
 
-*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index be157e7679..8a84bf057d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -205,11 +205,11 @@
 204 rw auto quick
 205 rw auto quick
 206 rw auto
-# TODO The following commented out tests need to be reworked to work
-# with the x-blockdev-create job
-#207 rw auto
+207 rw auto
 208 rw auto quick
 209 rw auto quick
+# TODO The following commented out tests need to be reworked to work
+# with the x-blockdev-create job
 #210 rw auto
 #211 rw auto quick
 #212 rw auto quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index f0f4ef32f0..e945caa6bb 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -109,9 +109,11 @@ def qemu_img_pipe(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
     return subp.communicate()[0]
 
-def img_info_log(filename):
+def img_info_log(filename, filter_path=None):
     output = qemu_img_pipe('info', '-f', imgfmt, filename)
-    log(filter_img_info(output, filename))
+    if not filter_path:
+        filter_path = filename
+    log(filter_img_info(output, filter_path))
 
 def qemu_io(*args):
     '''Run qemu-io and return the stdout data'''
@@ -301,6 +303,13 @@ def file_path(*names):
 
     return paths[0] if len(paths) == 1 else paths
 
+def remote_filename(path):
+    if imgproto == 'file':
+        return imgproto
+    elif imgproto == 'ssh':
+        return "ssh://127.0.0.1%s" % (path)
+    else:
+        raise Exception("Protocol %s not supported" % (imgproto))
 
 class VM(qtest.QEMUQtestMachine):
     '''A QEMU VM'''
@@ -595,6 +604,16 @@ def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
     if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
 
+def verify_protocol(supported=[], unsupported=[]):
+    assert not (supported and unsupported)
+
+    if 'generic' in supported:
+        return
+
+    not_sup = supported and (imgproto not in supported)
+    if not_sup or (imgproto in unsupported):
+        notrun('not suitable for this protocol: %s' % imgproto)
+
 def verify_platform(supported_oses=['linux']):
     if True not in [sys.platform.startswith(x) for x in supported_oses]:
         notrun('not suitable for this OS: %s' % sys.platform)
-- 
2.13.6
