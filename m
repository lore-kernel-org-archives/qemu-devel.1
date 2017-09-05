Received: from eggs.gnu.org ([2001:4830:134:3::10]:42999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpFap-0008GD-1g
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpFae-0002rU-Uz
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:16:47 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Sep 2017 17:16:14 +0200
Message-Id: <20170905151614.31303-4-cohuck@redhat.com>
In-Reply-To: <20170905151614.31303-1-cohuck@redhat.com>
References: <20170905151614.31303-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] iotests: use -ccw on s390x for 067
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
 tests/qemu-iotests/067                     |  11 +-
 tests/qemu-iotests/067.s390-ccw-virtio.out | 458 +++++++++++++++++++++++++++++
 2 files changed, 468 insertions(+), 1 deletion(-)
 create mode 100644 tests/qemu-iotests/067.s390-ccw-virtio.out

diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index 5d4ca4bc61..c5db04fb50 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -37,6 +37,15 @@ _supported_os Linux
 # Because anything other than 16 would change the output of query-block
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
 
+case "$QEMU_DEFAULT_MACHINE" in
+  s390-ccw-virtio)
+      hba=virtio-scsi-ccw
+      ;;
+  *)
+      hba=virtio-scsi-pci
+      ;;
+esac
+
 function do_run_qemu()
 {
     echo Testing: "$@"
@@ -141,7 +150,7 @@ echo
 echo === Empty drive with -device and device_del ===
 echo
 
-run_qemu -device virtio-scsi-pci -device scsi-cd,id=cd0 <<EOF
+run_qemu -device $hba -device scsi-cd,id=cd0 <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "query-block" }
 { "execute": "device_del", "arguments": { "id": "cd0" } }
diff --git a/tests/qemu-iotests/067.s390-ccw-virtio.out b/tests/qemu-iotests/067.s390-ccw-virtio.out
new file mode 100644
index 0000000000..55315c6efd
--- /dev/null
+++ b/tests/qemu-iotests/067.s390-ccw-virtio.out
@@ -0,0 +1,458 @@
+QA output created by 067
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+
+=== -drive/-device and device_del ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk -device virtio-blk,drive=disk,id=virtio0
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "io-status": "ok",
+            "device": "disk",
+            "locked": false,
+            "removable": false,
+            "inserted": {
+                "iops_rd": 0,
+                "detect_zeroes": "off",
+                "image": {
+                    "virtual-size": 134217728,
+                    "filename": "TEST_DIR/t.qcow2",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": SIZE,
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
+                "iops_wr": 0,
+                "ro": false,
+                "node-name": "NODE_NAME",
+                "backing_file_depth": 0,
+                "drv": "qcow2",
+                "iops": 0,
+                "bps_wr": 0,
+                "write_threshold": 0,
+                "encrypted": false,
+                "bps": 0,
+                "bps_rd": 0,
+                "cache": {
+                    "no-flush": false,
+                    "direct": false,
+                    "writeback": true
+                },
+                "file": "TEST_DIR/t.qcow2",
+                "encryption_key_missing": false
+            },
+            "qdev": "/machine/peripheral/virtio0/virtio-backend",
+            "type": "unknown"
+        }
+    ]
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
+    ]
+}
+{
+    "return": {
+    }
+}
+
+=== -drive/device_add and device_del ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,if=none,id=disk
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "disk",
+            "locked": false,
+            "removable": true,
+            "inserted": {
+                "iops_rd": 0,
+                "detect_zeroes": "off",
+                "image": {
+                    "virtual-size": 134217728,
+                    "filename": "TEST_DIR/t.qcow2",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": SIZE,
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
+                "iops_wr": 0,
+                "ro": false,
+                "node-name": "NODE_NAME",
+                "backing_file_depth": 0,
+                "drv": "qcow2",
+                "iops": 0,
+                "bps_wr": 0,
+                "write_threshold": 0,
+                "encrypted": false,
+                "bps": 0,
+                "bps_rd": 0,
+                "cache": {
+                    "no-flush": false,
+                    "direct": false,
+                    "writeback": true
+                },
+                "file": "TEST_DIR/t.qcow2",
+                "encryption_key_missing": false
+            },
+            "type": "unknown"
+        }
+    ]
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
+    ]
+}
+{
+    "return": {
+    }
+}
+
+=== drive_add/device_add and device_del ===
+
+Testing:
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": "OK\r\n"
+}
+{
+    "return": [
+        {
+            "device": "disk",
+            "locked": false,
+            "removable": true,
+            "inserted": {
+                "iops_rd": 0,
+                "detect_zeroes": "off",
+                "image": {
+                    "virtual-size": 134217728,
+                    "filename": "TEST_DIR/t.qcow2",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": SIZE,
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
+                "iops_wr": 0,
+                "ro": false,
+                "node-name": "NODE_NAME",
+                "backing_file_depth": 0,
+                "drv": "qcow2",
+                "iops": 0,
+                "bps_wr": 0,
+                "write_threshold": 0,
+                "encrypted": false,
+                "bps": 0,
+                "bps_rd": 0,
+                "cache": {
+                    "no-flush": false,
+                    "direct": false,
+                    "writeback": true
+                },
+                "file": "TEST_DIR/t.qcow2",
+                "encryption_key_missing": false
+            },
+            "type": "unknown"
+        }
+    ]
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
+    ]
+}
+{
+    "return": {
+    }
+}
+
+=== blockdev_add/device_add and device_del ===
+
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
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 134217728,
+                "filename": "TEST_DIR/t.qcow2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": SIZE,
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
+            "node-name": "disk",
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
+                "actual-size": SIZE,
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
+                "virtual-size": 134217728,
+                "filename": "TEST_DIR/t.qcow2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": SIZE,
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
+            "node-name": "disk",
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
+                "actual-size": SIZE,
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
+
+=== Empty drive with -device and device_del ===
+
+Testing: -device virtio-scsi-ccw -device scsi-cd,id=cd0
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "",
+            "locked": false,
+            "removable": true,
+            "qdev": "cd0",
+            "tray_open": false,
+            "type": "unknown"
+        }
+    ]
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
+    ]
+}
+{
+    "return": {
+    }
+}
+*** done
-- 
2.13.5
