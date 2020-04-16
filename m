Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57436C352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2493F206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaJ8YPM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2493F206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5tj-0000UD-4X
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jP5rX-0005oU-20
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jP5rV-00049Q-AX
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:51:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jP5rT-00048O-Pu
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587048686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnjtElUniCSRnUXKRVHpqrvTsLwfWRH/d76JxEHIAAQ=;
 b=GaJ8YPM59dcL1zSdkBgZ1to813bke5lSGJBdwvig+jIf7xMg/bwRusFLu331qgNomNpf6a
 zXyY/N1cfm2knP9ntmQmL/gUAo7cFQX8/xPLjmjAjXlXTb0eqXJUhmpobr0K4DBD5Wjl4N
 1UbHPcjn8ztjwhPv20OQP3tEoJotvoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-StmlYZjlMUCkAOtkdHarmg-1; Thu, 16 Apr 2020 10:51:21 -0400
X-MC-Unique: StmlYZjlMUCkAOtkdHarmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 356E18017F6;
 Thu, 16 Apr 2020 14:51:20 +0000 (UTC)
Received: from blue.redhat.com (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A46791001DD8;
 Thu, 16 Apr 2020 14:51:19 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] iotests: Add test 291 to for qemu-img convert --bitmaps
Date: Thu, 16 Apr 2020 09:51:15 -0500
Message-Id: <20200416145115.699033-4-eblake@redhat.com>
In-Reply-To: <20200416145115.699033-1-eblake@redhat.com>
References: <20200416145115.699033-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: nsoffer@redhat.com, Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new test covering the feature added in the previous patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/291     | 143 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/291.out |  56 +++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 200 insertions(+)
 create mode 100755 tests/qemu-iotests/291
 create mode 100644 tests/qemu-iotests/291.out

diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
new file mode 100755
index 000000000000..dfdcc8e352c8
--- /dev/null
+++ b/tests/qemu-iotests/291
@@ -0,0 +1,143 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img convert --bitmaps
+#
+# Copyright (C) 2018-2020 Red Hat, Inc.
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
+seq=3D"$(basename $0)"
+echo "QA output created by $seq"
+
+status=3D1 # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    nbd_server_stop
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.nbd
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+_require_command QEMU_NBD
+
+do_run_qemu()
+{
+    echo Testing: "$@"
+    $QEMU -nographic -qmp stdio -serial none "$@"
+    echo
+}
+
+run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qmp \
+                          | _filter_qemu | _filter_imgfmt \
+                          | _filter_actual_image_size | _filter_qemu_io
+}
+
+# Create initial image and populate two bitmaps: one active, one inactive
+_make_test_img 10M
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add",
+  "arguments": {
+    "driver": "$IMGFMT",
+    "node-name": "n",
+    "file": {
+      "driver": "file",
+      "filename": "$TEST_IMG"
+    }
+  }
+}
+{ "execute": "human-monitor-command",
+    "arguments": {
+        "command-line": 'qemu-io n "write 0 1M"'
+    }
+}
+{ "execute": "block-dirty-bitmap-add",
+  "arguments": {
+    "node": "n",
+    "name": "b1",
+    "persistent": true,
+    "granularity": 65536
+  }
+}
+{ "execute": "human-monitor-command",
+    "arguments": {
+        "command-line": 'qemu-io n "write 1M 1M"'
+    }
+}
+{ "execute": "transaction",
+  "arguments": {
+    "actions": [
+      { "type": "block-dirty-bitmap-disable",
+        "data": {
+          "node": "n",
+          "name": "b1"
+        } },
+      { "type": "block-dirty-bitmap-add",
+        "data": {
+          "node": "n",
+          "name": "b2",
+          "persistent": true
+       } }
+    ]
+  }
+}
+{ "execute": "human-monitor-command",
+    "arguments": {
+        "command-line": 'qemu-io n "write 2M 1M"'
+    }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+echo "=3D=3D=3D Bitmap preservation not possible to non-qcow2 =3D=3D=3D"
+echo
+
+mv "$TEST_IMG" "$TEST_IMG.orig"
+$QEMU_IMG convert --bitmaps -O raw "$TEST_IMG.orig" "$TEST_IMG"
+
+echo
+echo "=3D=3D=3D convert with bitmap preservation =3D=3D=3D"
+echo
+
+$QEMU_IMG convert --bitmaps -O qcow2 "$TEST_IMG.orig" "$TEST_IMG"
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+
+echo
+echo "=3D=3D=3D check bitmap contents =3D=3D=3D"
+echo
+
+IMG=3D"driver=3Dnbd,server.type=3Dunix,server.path=3D$nbd_unix_socket"
+nbd_server_start_unix_socket -r -f qcow2 -B b1 "$TEST_IMG"
+$QEMU_IMG map --output=3Djson --image-opts \
+    "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b1" | _filter_qemu_img_map
+nbd_server_start_unix_socket -r -f qcow2 -B b2 "$TEST_IMG"
+$QEMU_IMG map --output=3Djson --image-opts \
+    "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
new file mode 100644
index 000000000000..3e826f93ca82
--- /dev/null
+++ b/tests/qemu-iotests/291.out
@@ -0,0 +1,56 @@
+QA output created by 291
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485760
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"return": ""}
+{"return": {}}
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"return": ""}
+{"return": {}}
+wrote 1048576/1048576 bytes at offset 2097152
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"return": ""}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+
+=3D=3D=3D Bitmap preservation not possible to non-qcow2 =3D=3D=3D
+
+qemu-img: Format driver 'raw' does not support bitmaps
+
+=3D=3D=3D convert with bitmap preservation =3D=3D=3D
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 10 MiB (10485760 bytes)
+disk size: 3.39 MiB
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    bitmaps:
+        [0]:
+            flags:
+                [0]: auto
+            name: b2
+            granularity: 65536
+        [1]:
+            flags:
+            name: b1
+            granularity: 65536
+    refcount bits: 16
+    corrupt: false
+
+=3D=3D=3D check bitmap contents =3D=3D=3D
+
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": true,=
 "offset": OFFSET},
+{ "start": 1048576, "length": 1048576, "depth": 0, "zero": false, "data": =
false},
+{ "start": 2097152, "length": 8388608, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true,=
 "offset": OFFSET},
+{ "start": 2097152, "length": 1048576, "depth": 0, "zero": false, "data": =
false},
+{ "start": 3145728, "length": 7340032, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET}]
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 435dccd5af90..8e9b9513a091 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -297,3 +297,4 @@
 288 quick
 289 rw quick
 290 rw auto quick
+291 rw quick
--=20
2.26.0


