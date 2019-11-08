Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6DCC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4908F214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeYTzusu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4908F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT03k-0008Ko-GD
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 03:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iT01a-0005oE-SJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iT01Z-0007dH-0c
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:53:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32505
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iT01Y-0007ct-Sr
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573203224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTHmPZ0tmXQAFQRegihNXrukHcIoHkQbxivSZDEwY/g=;
 b=KeYTzusuB2hVthJTz3QAoZtWcSt1vXqy0giNcjG2aYGmxxWvbEZlKnDX/PhhKnqa0ZdCPx
 jj60gsU8DpvsivmPFkotr1oWm+9eJRrDgXxXoBucSlQLsC8e3yd1+xRE3YqQWj5oOSeKRc
 WgQiT/AKsquYHRce6OMi+J/l7oLzrRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-EP0RvKKIPqObzGP4mW0jZQ-1; Fri, 08 Nov 2019 03:53:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 119C2107ACC5;
 Fri,  8 Nov 2019 08:53:40 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-227.ams2.redhat.com
 [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4C9F600C9;
 Fri,  8 Nov 2019 08:53:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests: Test multiple blockdev-snapshot calls
Date: Fri,  8 Nov 2019 09:53:12 +0100
Message-Id: <20191108085312.27049-3-kwolf@redhat.com>
In-Reply-To: <20191108085312.27049-1-kwolf@redhat.com>
References: <20191108085312.27049-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: EP0RvKKIPqObzGP4mW0jZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test that doing a second blockdev-snapshot doesn't make the first
overlay's backing file go away.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/273     |  76 +++++++++
 tests/qemu-iotests/273.out | 337 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 414 insertions(+)
 create mode 100755 tests/qemu-iotests/273
 create mode 100644 tests/qemu-iotests/273.out

diff --git a/tests/qemu-iotests/273 b/tests/qemu-iotests/273
new file mode 100755
index 0000000000..60076de7ce
--- /dev/null
+++ b/tests/qemu-iotests/273
@@ -0,0 +1,76 @@
+#!/usr/bin/env bash
+#
+# Test large write to a qcow2 image
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+seq=3D$(basename "$0")
+echo "QA output created by $seq"
+
+status=3D1=09# failure is the default!
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
+# This is a qcow2 regression test
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+do_run_qemu()
+{
+    echo Testing: "$@"
+    $QEMU -nographic -qmp-pretty stdio -nodefaults "$@"
+    echo
+}
+
+run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp |
+        _filter_generated_node_ids | _filter_imgfmt | _filter_actual_image=
_size
+}
+
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
+TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.mid"
+
+run_qemu \
+    -blockdev file,node-name=3Dbase,filename=3D"$TEST_IMG.base" \
+     -blockdev file,node-name=3Dmidf,filename=3D"$TEST_IMG.mid" \
+     -blockdev '{"driver":"qcow2","node-name":"mid","file":"midf","backing=
":null}' \
+     -blockdev file,node-name=3Dtopf,filename=3D"$TEST_IMG" \
+     -blockdev '{"driver":"qcow2","file":"topf","node-name":"top","backing=
":null}' \
+<<EOF
+{"execute":"qmp_capabilities"}
+{"execute":"blockdev-snapshot","arguments":{"node":"base","overlay":"mid"}=
}
+{"execute":"blockdev-snapshot","arguments":{"node":"mid","overlay":"top"}}
+{"execute":"query-named-block-nodes"}
+{"execute":"x-debug-query-block-graph"}
+{"execute":"quit"}
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/273.out b/tests/qemu-iotests/273.out
new file mode 100644
index 0000000000..c410fee5c4
--- /dev/null
+++ b/tests/qemu-iotests/273.out
@@ -0,0 +1,337 @@
+QA output created by 273
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid
+Testing: -blockdev file,node-name=3Dbase,filename=3DTEST_DIR/t.IMGFMT.base=
 -blockdev file,node-name=3Dmidf,filename=3DTEST_DIR/t.IMGFMT.mid -blockdev=
 {"driver":"IMGFMT","node-name":"mid","file":"midf","backing":null} -blockd=
ev file,node-name=3Dtopf,filename=3DTEST_DIR/t.IMGFMT -blockdev {"driver":"=
IMGFMT","file":"topf","node-name":"top","backing":null}
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
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "backing-image": {
+                    "backing-image": {
+                        "virtual-size": 197120,
+                        "filename": "TEST_DIR/t.IMGFMT.base",
+                        "format": "file",
+                        "actual-size": SIZE,
+                        "dirty-flag": false
+                    },
+                    "backing-filename-format": "file",
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.IMGFMT.mid",
+                    "cluster-size": 65536,
+                    "format": "IMGFMT",
+                    "actual-size": SIZE,
+                    "format-specific": {
+                        "type": "IMGFMT",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                    "backing-filename": "TEST_DIR/t.IMGFMT.base",
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "IMGFMT",
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.IMGFMT",
+                "cluster-size": 65536,
+                "format": "IMGFMT",
+                "actual-size": SIZE,
+                "format-specific": {
+                    "type": "IMGFMT",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.mid",
+                "backing-filename": "TEST_DIR/t.IMGFMT.mid",
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "top",
+            "backing_file_depth": 2,
+            "drv": "IMGFMT",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.IMGFMT.mid",
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.IMGFMT",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.IMGFMT",
+                "format": "file",
+                "actual-size": SIZE,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "topf",
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
+            "file": "TEST_DIR/t.IMGFMT",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "backing-image": {
+                    "virtual-size": 197120,
+                    "filename": "TEST_DIR/t.IMGFMT.base",
+                    "format": "file",
+                    "actual-size": SIZE,
+                    "dirty-flag": false
+                },
+                "backing-filename-format": "file",
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.IMGFMT.mid",
+                "cluster-size": 65536,
+                "format": "IMGFMT",
+                "actual-size": SIZE,
+                "format-specific": {
+                    "type": "IMGFMT",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": true,
+            "node-name": "mid",
+            "backing_file_depth": 1,
+            "drv": "IMGFMT",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.IMGFMT.mid",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.IMGFMT.mid",
+                "format": "file",
+                "actual-size": SIZE,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "midf",
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
+            "file": "TEST_DIR/t.IMGFMT.mid",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.IMGFMT.base",
+                "format": "file",
+                "actual-size": SIZE,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": true,
+            "node-name": "base",
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
+            "file": "TEST_DIR/t.IMGFMT.base",
+            "encryption_key_missing": false
+        }
+    ]
+}
+{
+    "return": {
+        "edges": [
+            {
+                "name": "file",
+                "parent": 5,
+                "shared-perm": [
+                    "graph-mod",
+                    "write-unchanged",
+                    "consistent-read"
+                ],
+                "perm": [
+                    "resize",
+                    "write",
+                    "consistent-read"
+                ],
+                "child": 4
+            },
+            {
+                "name": "backing",
+                "parent": 5,
+                "shared-perm": [
+                    "graph-mod",
+                    "resize",
+                    "write-unchanged",
+                    "write",
+                    "consistent-read"
+                ],
+                "perm": [
+                ],
+                "child": 3
+            },
+            {
+                "name": "file",
+                "parent": 3,
+                "shared-perm": [
+                    "graph-mod",
+                    "write-unchanged",
+                    "consistent-read"
+                ],
+                "perm": [
+                    "consistent-read"
+                ],
+                "child": 2
+            },
+            {
+                "name": "backing",
+                "parent": 3,
+                "shared-perm": [
+                    "graph-mod",
+                    "resize",
+                    "write-unchanged",
+                    "write",
+                    "consistent-read"
+                ],
+                "perm": [
+                ],
+                "child": 1
+            }
+        ],
+        "nodes": [
+            {
+                "name": "top",
+                "type": "block-driver",
+                "id": 5
+            },
+            {
+                "name": "topf",
+                "type": "block-driver",
+                "id": 4
+            },
+            {
+                "name": "mid",
+                "type": "block-driver",
+                "id": 3
+            },
+            {
+                "name": "midf",
+                "type": "block-driver",
+                "id": 2
+            },
+            {
+                "name": "base",
+                "type": "block-driver",
+                "id": 1
+            }
+        ]
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
+        "guest": false,
+        "reason": "host-qmp-quit"
+    }
+}
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index af322af756..5aabdfefde 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -282,3 +282,4 @@
 267 rw auto quick snapshot
 268 rw auto quick
 270 rw backing quick
+273 backing quick
--=20
2.20.1


