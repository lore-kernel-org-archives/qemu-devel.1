Received: from eggs.gnu.org ([2001:4830:134:3::10]:35064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxAj-0002r6-O6
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxAh-0002ke-Ul
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:05 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 14 Jul 2017 12:45:21 +0300
Message-Id: <20170714094521.4909-8-el13635@mail.ntua.gr>
In-Reply-To: <20170714094521.4909-1-el13635@mail.ntua.gr>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 7/7] block: add throttle block filter driver
 interface tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 tests/qemu-iotests/184     | 237 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/184.out | 319 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 557 insertions(+)
 create mode 100755 tests/qemu-iotests/184
 create mode 100644 tests/qemu-iotests/184.out

diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
new file mode 100755
index 0000000000..05f724a274
--- /dev/null
+++ b/tests/qemu-iotests/184
@@ -0,0 +1,237 @@
+#!/bin/bash
+#
+# Test I/O throttle block filter driver interface
+#
+# Copyright (C) 2017 Manos Pitsidianakis
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
+owner=Manos Pitsidianakis
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt raw qcow2
+_supported_proto file
+_supported_os Linux
+
+function do_run_qemu()
+{
+    echo Testing: "$@" | _filter_imgfmt
+    $QEMU -nographic -qmp-pretty stdio -serial none "$@"
+    echo
+}
+
+function run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp\
+                          | _filter_qemu_io | _filter_generated_node_ids
+}
+
+_make_test_img 64M
+test_throttle=$($QEMU_IMG --help|grep throttle)
+[ "$test_throttle" = "" ] && _supported_fmt throttle
+
+echo
+echo "== checking interface =="
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add",
+  "arguments": {
+    "driver": "$IMGFMT",
+    "node-name": "disk0",
+    "file": {
+      "driver": "file",
+      "filename": "$TEST_IMG"
+    }
+  }
+}
+{ "execute": "object-add",
+  "arguments": {
+    "qom-type": "throttling-group",
+    "id": "group0",
+    "props": {
+      "limits" : {
+        "iops-total": 1000
+      }
+    }
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+    "driver": "throttle",
+    "node-name": "throttle0",
+    "throttling-group": "group0",
+    "file": "disk0"
+  }
+}
+{ "execute": "query-named-block-nodes" }
+{ "execute": "query-block" }
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== create anonymous group =="
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add",
+  "arguments": {
+    "driver": "$IMGFMT",
+    "node-name": "disk0",
+    "file": {
+      "driver": "file",
+      "filename": "$TEST_IMG"
+    }
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+    "driver": "throttle",
+    "node-name": "throttle-anonymous",
+    "limits" : {
+      "iops-total" : 1000
+    },
+    "file": "disk0"
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== property changes in ThrottleGroup =="
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "object-add",
+  "arguments": {
+    "qom-type": "throttling-group",
+    "id": "group0",
+    "props" : {
+      "limits": {
+          "iops-total": 1000
+      }
+    }
+  }
+}
+{ "execute" : "qom-get",
+  "arguments" : {
+    "path" : "group0",
+    "property" : "limits"
+  }
+}
+{ "execute" : "qom-set",
+    "arguments" : {
+        "path" : "group0",
+        "property" : "limits",
+        "value" : {
+            "iops-total" : 0
+        }
+    }
+}
+{ "execute" : "qom-get",
+  "arguments" : {
+    "path" : "group0",
+    "property" : "limits"
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+    "driver": "$IMGFMT",
+    "node-name": "disk0",
+    "file": {
+      "driver": "file",
+      "filename": "$TEST_IMG"
+    }
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+    "driver": "throttle",
+    "node-name": "throttle0",
+    "throttling-group": "group0",
+    "limits" : {
+      "iops-total" : 128,
+      "iops-total-max" : 256,
+      "iops-total-max-length" : 60
+    },
+    "file": "disk0"
+  }
+}
+{ "execute" : "qom-get",
+  "arguments" : {
+    "path" : "group0",
+    "property" : "limits"
+  }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== object creation/set errors  =="
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "object-add",
+  "arguments": {
+    "qom-type": "throttling-group",
+    "id": "group0",
+    "props" : {
+      "limits": {
+          "iops-total": 1000
+      }
+    }
+  }
+}
+{ "execute" : "qom-set",
+  "arguments" : {
+    "path" : "group0",
+    "property" : "x-iops-total",
+    "value" : 0
+  }
+}
+{ "execute" : "qom-set",
+    "arguments" : {
+        "path" : "group0",
+        "property" : "limits",
+        "value" : {
+            "iops-total" : 10,
+            "iops-read" : 10
+        }
+    }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
new file mode 100644
index 0000000000..35d2683860
--- /dev/null
+++ b/tests/qemu-iotests/184.out
@@ -0,0 +1,319 @@
+QA output created by 184
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+
+== checking interface ==
+Testing:
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "json:{\"throttling-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"raw\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.raw\"}}}",
+                "format": "throttle",
+                "actual-size": 0
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "throttle0",
+            "backing_file_depth": 0,
+            "drv": "throttle",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "json:{\"throttling-group\": \"group0\", \"driver\": \"throttle\", \"file\": {\"driver\": \"raw\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.raw\"}}}",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.raw",
+                "format": "raw",
+                "actual-size": 0,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "disk0",
+            "backing_file_depth": 0,
+            "drv": "raw",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.raw",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.raw",
+                "format": "file",
+                "actual-size": 0,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
+            "drv": "file",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.raw",
+            "encryption_key_missing": false
+        }
+    ]
+}
+{
+    "return": [
+    ]
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+
+== create anonymous group ==
+Testing:
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+
+== property changes in ThrottleGroup ==
+Testing:
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+        "bps-read-max-length": 1,
+        "iops-read-max-length": 1,
+        "bps-read-max": 0,
+        "bps-total": 0,
+        "iops-total-max-length": 1,
+        "iops-total": 1000,
+        "iops-write-max": 0,
+        "bps-write": 0,
+        "bps-total-max": 0,
+        "bps-write-max": 0,
+        "iops-size": 0,
+        "iops-read": 0,
+        "iops-write-max-length": 1,
+        "iops-write": 0,
+        "bps-total-max-length": 1,
+        "iops-read-max": 0,
+        "bps-read": 0,
+        "bps-write-max-length": 1,
+        "iops-total-max": 0
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+        "bps-read-max-length": 1,
+        "iops-read-max-length": 1,
+        "bps-read-max": 0,
+        "bps-total": 0,
+        "iops-total-max-length": 1,
+        "iops-total": 0,
+        "iops-write-max": 0,
+        "bps-write": 0,
+        "bps-total-max": 0,
+        "bps-write-max": 0,
+        "iops-size": 0,
+        "iops-read": 0,
+        "iops-write-max-length": 1,
+        "iops-write": 0,
+        "bps-total-max-length": 1,
+        "iops-read-max": 0,
+        "bps-read": 0,
+        "bps-write-max-length": 1,
+        "iops-total-max": 0
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+        "bps-read-max-length": 1,
+        "iops-read-max-length": 1,
+        "bps-read-max": 0,
+        "bps-total": 0,
+        "iops-total-max-length": 60,
+        "iops-total": 128,
+        "iops-write-max": 0,
+        "bps-write": 0,
+        "bps-total-max": 0,
+        "bps-write-max": 0,
+        "iops-size": 0,
+        "iops-read": 0,
+        "iops-write-max-length": 1,
+        "iops-write": 0,
+        "bps-total-max-length": 1,
+        "iops-read-max": 0,
+        "bps-read": 0,
+        "bps-write-max-length": 1,
+        "iops-total-max": 256
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+
+== object creation/set errors  ==
+Testing:
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "error": {
+        "class": "GenericError",
+        "desc": "Property cannot be set after initialization"
+    }
+}
+{
+    "error": {
+        "class": "GenericError",
+        "desc": "bps/iops/max total values and read/write values cannot be used at the same time"
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 2aba585287..88f32aeddf 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -180,6 +180,7 @@
 181 rw auto migration
 182 rw auto quick
 183 rw auto migration
+184 rw auto quick
 185 rw auto
 188 rw auto quick
 189 rw auto quick
-- 
2.11.0
