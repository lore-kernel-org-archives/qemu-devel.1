Received: from eggs.gnu.org ([2001:4830:134:3::10]:47314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUw-0003k0-PU
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUr-00067t-Un
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Sep 2017 14:28:07 +0200
Message-Id: <20170925122808.14561-5-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-1-kwolf@redhat.com>
References: <20170925122808.14561-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] qemu-iotests: Test commit block job where
 top has two parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/191     | 152 +++++++++
 tests/qemu-iotests/191.out | 827 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 980 insertions(+)
 create mode 100755 tests/qemu-iotests/191
 create mode 100644 tests/qemu-iotests/191.out

diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
new file mode 100755
index 0000000000..a4e0d691fa
--- /dev/null
+++ b/tests/qemu-iotests/191
@@ -0,0 +1,152 @@
+#!/bin/bash
+#
+# Test commit block job where top has two parents
+#
+# Copyright (C) 2017 Red Hat, Inc.
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
+status=1 # failure is the default!
+
+MIG_SOCKET="${TEST_DIR}/migrate"
+
+_cleanup()
+{
+    rm -f "${TEST_IMG}.mid"
+    rm -f "${TEST_IMG}.ovl2"
+    rm -f "${TEST_IMG}.ovl3"
+    _cleanup_test_img
+    _cleanup_qemu
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+size=64M
+
+echo
+echo === Preparing and starting VM ===
+echo
+
+TEST_IMG="${TEST_IMG}.base" _make_test_img $size
+TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
+_make_test_img -b "${TEST_IMG}.mid"
+TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
+
+$QEMU_IO -c 'write -P 0x55 1M 64k' "${TEST_IMG}.mid" | _filter_qemu_io
+
+qemu_comm_method="qmp"
+qmp_pretty="y"
+
+_launch_qemu \
+    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.base,node-name=base" \
+    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.mid,node-name=mid,backing=base" \
+    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG},node-name=top,backing=mid" \
+    -blockdev "driver=${IMGFMT},file.driver=file,file.filename=${TEST_IMG}.ovl2,node-name=top2,backing=mid"
+h=$QEMU_HANDLE
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" '^}'
+
+echo
+echo === Perform commit job ===
+echo
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'block-commit',
+       'arguments': { 'job-id': 'commit0',
+                      'device': 'top',
+                      'base':'$TEST_IMG.base',
+                      'top': '$TEST_IMG.mid' } }" \
+    "BLOCK_JOB_COMPLETED"
+_send_qemu_cmd $h "" "^}"
+
+echo
+echo === Check that both top and top2 point to base now ===
+echo
+
+_send_qemu_cmd $h "{ 'execute': 'query-named-block-nodes' }" "^}" |
+    _filter_generated_node_ids
+
+_send_qemu_cmd $h "{ 'execute': 'quit' }" "^}"
+wait=1 _cleanup_qemu
+
+_img_info
+TEST_IMG="$TEST_IMG.ovl2" _img_info
+
+
+echo
+echo === Preparing and starting VM with -drive ===
+echo
+
+TEST_IMG="${TEST_IMG}.base" _make_test_img $size
+TEST_IMG="${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
+_make_test_img -b "${TEST_IMG}.mid"
+TEST_IMG="${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
+TEST_IMG="${TEST_IMG}.ovl3" _make_test_img -b "${TEST_IMG}.ovl2"
+
+$QEMU_IO -c 'write -P 0x55 1M 64k' "${TEST_IMG}.mid" | _filter_qemu_io
+
+qemu_comm_method="qmp"
+qmp_pretty="y"
+
+_launch_qemu \
+    -drive "driver=${IMGFMT},file=${TEST_IMG},node-name=top,backing.node-name=mid" \
+    -drive "driver=${IMGFMT},file=${TEST_IMG}.ovl3,node-name=top2,backing.backing=mid"
+h=$QEMU_HANDLE
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" '^}'
+
+echo
+echo === Perform commit job ===
+echo
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'block-commit',
+       'arguments': { 'job-id': 'commit0',
+                      'device': 'top',
+                      'base':'$TEST_IMG.base',
+                      'top': '$TEST_IMG.mid' } }" \
+    "BLOCK_JOB_COMPLETED"
+_send_qemu_cmd $h "" "^}"
+
+echo
+echo === Check that both top and top2 point to base now ===
+echo
+
+_send_qemu_cmd $h "{ 'execute': 'query-named-block-nodes' }" "^}" |
+    _filter_generated_node_ids
+
+_send_qemu_cmd $h "{ 'execute': 'quit' }" "^}"
+wait=1 _cleanup_qemu
+
+_img_info
+TEST_IMG="$TEST_IMG.ovl2" _img_info
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
new file mode 100644
index 0000000000..7bfcd2d5d8
--- /dev/null
+++ b/tests/qemu-iotests/191.out
@@ -0,0 +1,827 @@
+QA output created by 191
+
+=== Preparing and starting VM ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+wrote 65536/65536 bytes at offset 1048576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{
+    "return": {
+    }
+}
+
+=== Perform commit job ===
+
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "BLOCK_JOB_COMPLETED",
+    "data": {
+        "device": "commit0",
+        "len": 67108864,
+        "offset": 67108864,
+        "speed": 0,
+        "type": "commit"
+    }
+}
+
+=== Check that both top and top2 point to base now ===
+
+{
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "backing-image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2.base",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": 397312,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "qcow2",
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "full-backing-filename": "TEST_DIR/t.qcow2.base",
+                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "top2",
+            "backing_file_depth": 1,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.qcow2.base",
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2.ovl2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "format": "file",
+                "actual-size": 200704,
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
+            "file": "TEST_DIR/t.qcow2.ovl2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "backing-image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2.base",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": 397312,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "qcow2",
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "full-backing-filename": "TEST_DIR/t.qcow2.base",
+                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "top",
+            "backing_file_depth": 1,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.qcow2.base",
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2",
+                "format": "file",
+                "actual-size": 200704,
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
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "backing-image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2.base",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": 397312,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "qcow2",
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2.mid",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 397312,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "full-backing-filename": "TEST_DIR/t.qcow2.base",
+                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "mid",
+            "backing_file_depth": 1,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.qcow2.base",
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2.mid",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 393216,
+                "filename": "TEST_DIR/t.qcow2.mid",
+                "format": "file",
+                "actual-size": 397312,
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
+            "file": "TEST_DIR/t.qcow2.mid",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2.base",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 397312,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "base",
+            "backing_file_depth": 0,
+            "drv": "qcow2",
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
+            "file": "TEST_DIR/t.qcow2.base",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 393216,
+                "filename": "TEST_DIR/t.qcow2.base",
+                "format": "file",
+                "actual-size": 397312,
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
+            "file": "TEST_DIR/t.qcow2.base",
+            "encryption_key_missing": false
+        }
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
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+image: TEST_DIR/t.IMGFMT.ovl2
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+
+=== Preparing and starting VM with -drive ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.mid
+Formatting 'TEST_DIR/t.IMGFMT.ovl3', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.ovl2
+wrote 65536/65536 bytes at offset 1048576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{
+    "return": {
+    }
+}
+
+=== Perform commit job ===
+
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "BLOCK_JOB_COMPLETED",
+    "data": {
+        "device": "commit0",
+        "len": 67108864,
+        "offset": 67108864,
+        "speed": 0,
+        "type": "commit"
+    }
+}
+
+=== Check that both top and top2 point to base now ===
+
+{
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "backing-image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2.base",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": 397312,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "qcow2",
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "full-backing-filename": "TEST_DIR/t.qcow2.base",
+                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": true,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 1,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.qcow2.base",
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2.ovl2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2.ovl2",
+                "format": "file",
+                "actual-size": 200704,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": true,
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
+            "file": "TEST_DIR/t.qcow2.ovl2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "backing-image": {
+                    "backing-image": {
+                        "virtual-size": 67108864,
+                        "filename": "TEST_DIR/t.qcow2.base",
+                        "cluster-size": 65536,
+                        "format": "qcow2",
+                        "actual-size": 397312,
+                        "format-specific": {
+                            "type": "qcow2",
+                            "data": {
+                                "compat": "1.1",
+                                "lazy-refcounts": false,
+                                "refcount-bits": 16,
+                                "corrupt": false
+                            }
+                        },
+                        "dirty-flag": false
+                    },
+                    "backing-filename-format": "qcow2",
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2.ovl2",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": 200704,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "full-backing-filename": "TEST_DIR/t.qcow2.base",
+                    "backing-filename": "TEST_DIR/t.qcow2.base",
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "qcow2",
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2.ovl3",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "full-backing-filename": "TEST_DIR/t.qcow2.ovl2",
+                "backing-filename": "TEST_DIR/t.qcow2.ovl2",
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "top2",
+            "backing_file_depth": 2,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.qcow2.ovl2",
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2.ovl3",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2.ovl3",
+                "format": "file",
+                "actual-size": 200704,
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
+            "file": "TEST_DIR/t.qcow2.ovl3",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2.base",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 397312,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": true,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
+            "drv": "qcow2",
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
+            "file": "TEST_DIR/t.qcow2.base",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 393216,
+                "filename": "TEST_DIR/t.qcow2.base",
+                "format": "file",
+                "actual-size": 397312,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": true,
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
+            "file": "TEST_DIR/t.qcow2.base",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "backing-image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2.base",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": 397312,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "qcow2",
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "full-backing-filename": "TEST_DIR/t.qcow2.base",
+                "backing-filename": "TEST_DIR/t.qcow2.base",
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "top",
+            "backing_file_depth": 1,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.qcow2.base",
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2",
+                "format": "file",
+                "actual-size": 200704,
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
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        }
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
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+image: TEST_DIR/t.IMGFMT.ovl2
+file format: IMGFMT
+virtual size: 64M (67108864 bytes)
+cluster_size: 65536
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 108339cd03..63d4ee052c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -187,6 +187,7 @@
 188 rw auto quick
 189 rw auto
 190 rw auto quick
+191 rw auto
 192 rw auto quick
 194 rw auto migration quick
 195 rw auto quick
-- 
2.13.5
