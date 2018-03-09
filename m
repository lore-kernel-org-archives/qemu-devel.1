Received: from eggs.gnu.org ([2001:4830:134:3::10]:34285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlN-0001bN-T0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlL-0007Ut-M1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:57 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:28 +0100
Message-Id: <20180309161933.8168-52-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 51/56] qemu-iotests: Test ssh image creation
 over QMP
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/207     | 261 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/207.out |  75 +++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 337 insertions(+)
 create mode 100755 tests/qemu-iotests/207
 create mode 100644 tests/qemu-iotests/207.out

diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
new file mode 100755
index 0000000000..f5c77852d1
--- /dev/null
+++ b/tests/qemu-iotests/207
@@ -0,0 +1,261 @@
+#!/bin/bash
+#
+# Test ssh image creation
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=kwolf@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt raw
+_supported_proto ssh
+_supported_os Linux
+
+function do_run_qemu()
+{
+    echo Testing: "$@"
+    $QEMU -nographic -qmp stdio -serial none "$@"
+    echo
+}
+
+function run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
+                          | _filter_qemu | _filter_imgfmt \
+                          | _filter_actual_image_size
+}
+
+echo
+echo "=== Successful image creation (defaults) ==="
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "ssh",
+      "location": {
+          "path": "$TEST_IMG_FILE",
+          "server": {
+              "host": "127.0.0.1",
+              "port": "22"
+          }
+      },
+      "size": 4194304
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+echo
+TEST_IMG=$TEST_IMG_FILE _img_info | _filter_img_info
+
+echo
+echo "=== Test host-key-check options ==="
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "ssh",
+      "location": {
+          "path": "$TEST_IMG_FILE",
+          "server": {
+              "host": "127.0.0.1",
+              "port": "22"
+          },
+          "host-key-check": {
+              "mode": "none"
+          }
+      },
+      "size": 8388608
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "ssh",
+      "location": {
+          "path": "$TEST_IMG_FILE",
+          "server": {
+              "host": "127.0.0.1",
+              "port": "22"
+          },
+          "host-key-check": {
+              "mode": "known_hosts"
+          }
+      },
+      "size": 4194304
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+
+
+key=$(ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" |
+      cut -d" " -f3 | base64 -d | md5sum -b | cut -d" " -f1)
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "ssh",
+      "location": {
+          "path": "$TEST_IMG_FILE",
+          "server": {
+              "host": "127.0.0.1",
+              "port": "22"
+          },
+          "host-key-check": {
+              "mode": "hash",
+              "type": "md5",
+              "hash": "wrong"
+          }
+      },
+      "size": 8388608
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "ssh",
+      "location": {
+          "path": "$TEST_IMG_FILE",
+          "server": {
+              "host": "127.0.0.1",
+              "port": "22"
+          },
+          "host-key-check": {
+              "mode": "hash",
+              "type": "md5",
+              "hash": "$key"
+          }
+      },
+      "size": 8388608
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+
+
+key=$(ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" |
+      cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1)
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "ssh",
+      "location": {
+          "path": "$TEST_IMG_FILE",
+          "server": {
+              "host": "127.0.0.1",
+              "port": "22"
+          },
+          "host-key-check": {
+              "mode": "hash",
+              "type": "sha1",
+              "hash": "wrong"
+          }
+      },
+      "size": 4194304
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "ssh",
+      "location": {
+          "path": "$TEST_IMG_FILE",
+          "server": {
+              "host": "127.0.0.1",
+              "port": "22"
+          },
+          "host-key-check": {
+              "mode": "hash",
+              "type": "sha1",
+              "hash": "$key"
+          }
+      },
+      "size": 4194304
+  }
+}
+{ "execute": "quit" }
+EOF
+
+_img_info | _filter_img_info
+
+echo
+echo "=== Invalid path and user ==="
+echo
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "ssh",
+      "location": {
+          "path": "/this/is/not/an/existing/path",
+          "server": {
+              "host": "127.0.0.1",
+              "port": "22"
+          }
+      },
+      "size": 4194304
+  }
+}
+{ "execute": "x-blockdev-create",
+  "arguments": {
+      "driver": "ssh",
+      "location": {
+          "path": "$TEST_IMG_FILE",
+          "user": "invalid user",
+          "server": {
+              "host": "127.0.0.1",
+              "port": "22"
+          }
+      },
+      "size": 4194304
+  }
+}
+{ "execute": "quit" }
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
new file mode 100644
index 0000000000..417deee970
--- /dev/null
+++ b/tests/qemu-iotests/207.out
@@ -0,0 +1,75 @@
+QA output created by 207
+
+=== Successful image creation (defaults) ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
+file format: IMGFMT
+virtual size: 4.0M (4194304 bytes)
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 4.0M (4194304 bytes)
+
+=== Test host-key-check options ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
+file format: IMGFMT
+virtual size: 8.0M (8388608 bytes)
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
+file format: IMGFMT
+virtual size: 4.0M (4194304 bytes)
+Testing:
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "remote host key does not match host_key_check 'wrong'"}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
+file format: IMGFMT
+virtual size: 8.0M (8388608 bytes)
+Testing:
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "remote host key does not match host_key_check 'wrong'"}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_DIR/t.IMGFMT"}}
+file format: IMGFMT
+virtual size: 4.0M (4194304 bytes)
+
+=== Invalid path and user ===
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "failed to open remote file '/this/is/not/an/existing/path': Failed opening remote file (libssh2 error code: -31)"}}
+{"error": {"class": "GenericError", "desc": "failed to authenticate using publickey authentication and the identities held by your ssh-agent"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 69b6504f67..c401791fcd 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -203,3 +203,4 @@
 204 rw auto quick
 205 rw auto quick
 206 rw auto
+207 rw auto
-- 
2.13.6
