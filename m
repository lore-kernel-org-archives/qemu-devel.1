Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFAAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5683B206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6GS+k4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5683B206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxB8-0000n0-DQ
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwxn-0005uG-Tx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwxl-00082h-BW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwxl-0007mA-4c
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQsIYSN0FPKdQpNSgHHqpBfRxC/QVujmoVGtLO9/WDA=;
 b=V6GS+k4FqdyoEUgU9Fi8d36SXEqMr4vUNdWQezm+cMffbI208pblvrA1cGR4scZfvoe9dX
 GfgxGaLOwj9pvPlBU0s8XyBoLzEeSzTqxtKEhiDVlUCN7FYu1MiC0TviSGBS4i/tZPRRIp
 bPp/23RJGLM31eY7x6ZU1qq8GZc3Pmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-vnMUKedDNIK1eKnel5cARQ-1; Thu, 19 Dec 2019 09:39:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D550518A8C81;
 Thu, 19 Dec 2019 14:39:26 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE87960BEC;
 Thu, 19 Dec 2019 14:39:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 18/18] iotests/281: Add test for FUSE exports
Date: Thu, 19 Dec 2019 15:38:18 +0100
Message-Id: <20191219143818.1646168-19-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vnMUKedDNIK1eKnel5cARQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have good coverage of the normal I/O paths now, but what remains is a
test that tests some more special cases: Exporting an image on itself
(thus turning a formatted image into a raw one), some error cases, and
non-writable and non-growable exports.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/281     | 328 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/281.out |  92 +++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 421 insertions(+)
 create mode 100755 tests/qemu-iotests/281
 create mode 100644 tests/qemu-iotests/281.out

diff --git a/tests/qemu-iotests/281 b/tests/qemu-iotests/281
new file mode 100755
index 0000000000..071420697c
--- /dev/null
+++ b/tests/qemu-iotests/281
@@ -0,0 +1,328 @@
+#!/usr/bin/env bash
+#
+# Test FUSE exports (in ways that are not captured by the generic
+# tests)
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
+    rmdir "$EXT_MP" 2>/dev/null
+    rm -f "$EXT_MP"
+    rm -f "$COPIED_IMG"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+# Generic format, but needs a plain filename
+_supported_fmt generic
+if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
+    _unsupported_fmt $IMGFMT
+fi
+
+_supported_proto file # We create the FUSE export manually
+_supported_os Linux # We need /dev/urandom
+
+# $1: Options (beyond the node-name)
+# $2: Expected return value (defaults to 'return')
+# $3: Node to export (defaults to 'node-format')
+fuse_export_add()
+{
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{'execute': 'fuse-export-add',
+          'arguments': {
+              'node-name': '${3:-node-format}',
+              $1
+          } }" \
+        "${2:-return}" \
+        | _filter_imgfmt
+}
+
+# $1: Mountpoint
+# $2: Expected return value (defaults to 'return')
+fuse_export_remove()
+{
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{'execute': 'fuse-export-remove',
+          'arguments': {
+              'mountpoint': '$1'
+          } }" \
+        "${2:-return}"
+}
+
+# Return the length of the protocol file
+# $1: Protocol node export mount point
+# $2: Original file (to compare)
+get_proto_len()
+{
+    len1=3D$(stat -c '%s' "$1")
+    len2=3D$(stat -c '%s' "$2")
+
+    if [ "$len1" !=3D "$len2" ]; then
+        echo 'ERROR: Length of export and original differ:' >&2
+        echo "$len1 !=3D $len2" >&2
+    else
+        echo '(OK: Lengths of export and original are the same)' >&2
+    fi
+
+    echo "$len1"
+}
+
+COPIED_IMG=3D"$TEST_IMG.copy"
+EXT_MP=3D"$TEST_IMG.fuse"
+
+echo '=3D=3D=3D Set up =3D=3D=3D'
+
+# Create image with random data
+_make_test_img 64M
+$QEMU_IO -c 'write -s /dev/urandom 0 64M' "$TEST_IMG" | _filter_qemu_io
+
+_launch_qemu
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'qmp_capabilities'}" \
+    'return'
+
+# Separate blockdev-add calls for format and protocol so we can remove
+# the format layer later on
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-add',
+      'arguments': {
+          'driver': 'file',
+          'node-name': 'node-protocol',
+          'filename': '$TEST_IMG'
+      } }" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-add',
+      'arguments': {
+          'driver': '$IMGFMT',
+          'node-name': 'node-format',
+          'file': 'node-protocol'
+      } }" \
+    'return'
+
+echo
+echo '=3D=3D=3D Mountpoint not present =3D=3D=3D'
+
+rmdir "$EXT_MP" 2>/dev/null
+rm -f "$EXT_MP"
+output=3D$(fuse_export_add "'mountpoint': '$EXT_MP'" error)
+
+if echo "$output" | grep -q 'CommandNotFound'; then
+    _notrun 'No FUSE support'
+fi
+
+echo "$output"
+
+echo
+echo '=3D=3D=3D Mountpoint is a directory =3D=3D=3D'
+
+mkdir "$EXT_MP"
+fuse_export_add "'mountpoint': '$EXT_MP'" error
+rmdir "$EXT_MP"
+
+echo
+echo '=3D=3D=3D Mountpoint is a regular file =3D=3D=3D'
+
+touch "$EXT_MP"
+fuse_export_add "'mountpoint': '$EXT_MP'"
+
+# Check that the export presents the same data as the original image
+$QEMU_IMG compare -f raw -F $IMGFMT -U "$EXT_MP" "$TEST_IMG"
+
+echo
+echo '=3D=3D=3D Mount over existing file =3D=3D=3D'
+
+# This is the coolest feature of FUSE exports: You can transparently
+# make images in any format appear as raw images
+fuse_export_add "'mountpoint': '$TEST_IMG'"
+
+# Accesses both exports at the same time, so we get a concurrency test
+$QEMU_IMG compare -f raw -F raw -U "$EXT_MP" "$TEST_IMG"
+
+# Just to be sure, we later want to compare the data offline.  Also,
+# this allows us to see that cp works without complaining.
+# (This is not a given, because cp will expect a short read at EOF.
+# Internally, qemu does not allow short reads, so we have to check
+# whether the FUSE export driver lets them work.)
+cp "$TEST_IMG" "$COPIED_IMG"
+
+# $TEST_IMG will be in mode 0400 because it is read-only; we are going
+# to write to the copy, so make it writable
+chmod 0600 "$COPIED_IMG"
+
+echo
+echo '=3D=3D=3D Double export =3D=3D=3D'
+
+# We have already seen that exporting a node twice works fine, but you
+# cannot export anything twice on the same mount point.  One reason is
+# that the MP acts as the unique identifier for the export.  The other
+# is that qemu has to stat the given mount point, and this would have
+# to be answered by the same qemu instance if it already has an export
+# there.  However, it cannot answer the stat because it is itself
+# caught up in that same stat.
+fuse_export_add "'mountpoint': '$EXT_MP'" error
+
+echo
+echo '=3D=3D=3D Remove export =3D=3D=3D'
+
+# Double-check that $EXT_MP appears as a non-empty file (the raw image)
+$QEMU_IMG info -f raw "$EXT_MP" | grep 'virtual size'
+
+fuse_export_remove "$EXT_MP"
+
+# See that the file appears empty again
+$QEMU_IMG info -f raw "$EXT_MP" | grep 'virtual size'
+
+echo
+echo '=3D=3D=3D Writable export =3D=3D=3D'
+
+fuse_export_add "'mountpoint': '$EXT_MP', 'writable': true"
+
+# Check that writing to the read-only export fails
+$QEMU_IO -f raw -c 'write -P 42 1M 64k' "$TEST_IMG" | _filter_qemu_io
+
+# But here it should work
+$QEMU_IO -f raw -c 'write -P 42 1M 64k' "$EXT_MP" | _filter_qemu_io
+
+# (Adjust the copy, too)
+$QEMU_IO -f raw -c 'write -P 42 1M 64k' "$COPIED_IMG" | _filter_qemu_io
+
+echo
+echo '=3D=3D=3D Resizing exports =3D=3D=3D'
+
+# Here, we need to export the protocol node -- the format layer may
+# not be growable in principle.
+
+# Remove all exports and the format node first so permissions will not
+# get in the way
+fuse_export_remove "$EXT_MP"
+fuse_export_remove "$TEST_IMG"
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'blockdev-del',
+      'arguments': {
+          'node-name': 'node-format'
+      } }" \
+    'return'
+
+# Now export the protocol node
+fuse_export_add \
+    "'mountpoint': '$EXT_MP', 'writable': true" \
+    'return' \
+    'node-protocol'
+
+echo
+echo '--- Try growing non-growable export ---'
+
+# Get the current size so we can write beyond the EOF
+orig_len=3D$(get_proto_len "$EXT_MP" "$TEST_IMG")
+orig_disk_usage=3D$(stat -c '%b' "$TEST_IMG")
+
+# Should fail (exports are non-growable by default)
+# (Note that qemu-io can never write beyond the EOF, so we have to use
+# dd here)
+dd if=3D/dev/zero of=3D"$EXT_MP" bs=3D1 count=3D64k seek=3D$orig_len 2>&1 =
\
+    | _filter_testdir | _filter_imgfmt
+
+echo
+echo '--- Resize export ---'
+
+# But we can truncate it explicitly; even with fallocate
+fallocate -o "$orig_len" -l 64k "$EXT_MP"
+
+new_len=3D$(get_proto_len "$EXT_MP" "$TEST_IMG")
+if [ "$new_len" !=3D "$((orig_len + 65536))" ]; then
+    echo 'ERROR: Unexpected post-truncate image size:'
+    echo "$new_len !=3D $((orig_len + 65536))"
+else
+    echo 'OK: Post-truncate image size is as expected'
+fi
+
+new_disk_usage=3D$(stat -c '%b' "$TEST_IMG")
+if [ "$new_disk_usage" -gt "$orig_disk_usage" ]; then
+    echo 'OK: Disk usage grew with fallocate'
+else
+    echo 'ERROR: Disk usage did not grow despite fallocate:'
+    echo "$orig_disk_usage =3D> $new_disk_usage"
+fi
+
+echo
+echo '--- Try growing growable export ---'
+
+# Now export as growable
+fuse_export_remove "$EXT_MP"
+fuse_export_add \
+    "'mountpoint': '$EXT_MP', 'writable': true, 'growable': true" \
+    'return' \
+    'node-protocol'
+
+# Now we should be able to write beyond the EOF
+dd if=3D/dev/zero of=3D"$EXT_MP" bs=3D1 count=3D64k seek=3D$new_len 2>&1 \
+    | _filter_testdir | _filter_imgfmt
+
+new_len=3D$(get_proto_len "$EXT_MP" "$TEST_IMG")
+if [ "$new_len" !=3D "$((orig_len + 131072))" ]; then
+    echo 'ERROR: Unexpected post-grow image size:'
+    echo "$new_len !=3D $((orig_len + 131072))"
+else
+    echo 'OK: Post-grow image size is as expected'
+fi
+
+echo
+echo '--- Shrink export ---'
+
+# Now go back to the original size
+truncate -s "$orig_len" "$EXT_MP"
+
+new_len=3D$(get_proto_len "$EXT_MP" "$TEST_IMG")
+if [ "$new_len" !=3D "$orig_len" ]; then
+    echo 'ERROR: Unexpected post-truncate image size:'
+    echo "$new_len !=3D $orig_len"
+else
+    echo 'OK: Post-truncate image size is as expected'
+fi
+
+echo
+echo '=3D=3D=3D Tear down =3D=3D=3D'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{'execute': 'quit'}" \
+    'return'
+
+wait=3Dyes _cleanup_qemu
+
+echo
+echo '=3D=3D=3D Compare copy with original =3D=3D=3D'
+
+$QEMU_IMG compare -f raw -F $IMGFMT "$COPIED_IMG" "$TEST_IMG"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/281.out b/tests/qemu-iotests/281.out
new file mode 100644
index 0000000000..ba41e14b2a
--- /dev/null
+++ b/tests/qemu-iotests/281.out
@@ -0,0 +1,92 @@
+QA output created by 281
+=3D=3D=3D Set up =3D=3D=3D
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+wrote 67108864/67108864 bytes at offset 0
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{'execute': 'qmp_capabilities'}
+{"return": {}}
+{'execute': 'blockdev-add', 'arguments': { 'driver': 'file', 'node-name': =
'node-protocol', 'filename': 'TEST_DIR/t.IMGFMT' } }
+{"return": {}}
+{'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name'=
: 'node-format', 'file': 'node-protocol' } }
+{"return": {}}
+
+=3D=3D=3D Mountpoint not present =3D=3D=3D
+{'execute': 'fuse-export-add', 'arguments': { 'node-name': 'node-format', =
'mountpoint': 'TEST_DIR/t.IMGFMT.fuse' } }
+{"error": {"class": "GenericError", "desc": "Failed to stat 'TEST_DIR/t.IM=
GFMT.fuse': No such file or directory"}}
+
+=3D=3D=3D Mountpoint is a directory =3D=3D=3D
+{'execute': 'fuse-export-add', 'arguments': { 'node-name': 'node-format', =
'mountpoint': 'TEST_DIR/t.IMGFMT.fuse' } }
+{"error": {"class": "GenericError", "desc": "'TEST_DIR/t.IMGFMT.fuse' is n=
ot a regular file"}}
+
+=3D=3D=3D Mountpoint is a regular file =3D=3D=3D
+{'execute': 'fuse-export-add', 'arguments': { 'node-name': 'node-format', =
'mountpoint': 'TEST_DIR/t.IMGFMT.fuse' } }
+{"return": {}}
+Images are identical.
+
+=3D=3D=3D Mount over existing file =3D=3D=3D
+{'execute': 'fuse-export-add', 'arguments': { 'node-name': 'node-format', =
'mountpoint': 'TEST_DIR/t.IMGFMT' } }
+{"return": {}}
+Images are identical.
+
+=3D=3D=3D Double export =3D=3D=3D
+{'execute': 'fuse-export-add', 'arguments': { 'node-name': 'node-format', =
'mountpoint': 'TEST_DIR/t.IMGFMT.fuse' } }
+{"error": {"class": "GenericError", "desc": "There already is a FUSE expor=
t on 'TEST_DIR/t.IMGFMT.fuse'"}}
+
+=3D=3D=3D Remove export =3D=3D=3D
+virtual size: 64 MiB (67108864 bytes)
+{'execute': 'fuse-export-remove', 'arguments': { 'mountpoint': 'TEST_DIR/t=
.IMGFMT.fuse' } }
+{"return": {}}
+virtual size: 0 B (0 bytes)
+
+=3D=3D=3D Writable export =3D=3D=3D
+{'execute': 'fuse-export-add', 'arguments': { 'node-name': 'node-format', =
'mountpoint': 'TEST_DIR/t.IMGFMT.fuse', 'writable': true } }
+{"return": {}}
+write failed: Permission denied
+wrote 65536/65536 bytes at offset 1048576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 1048576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D=3D Resizing exports =3D=3D=3D
+{'execute': 'fuse-export-remove', 'arguments': { 'mountpoint': 'TEST_DIR/t=
.IMGFMT.fuse' } }
+{"return": {}}
+{'execute': 'fuse-export-remove', 'arguments': { 'mountpoint': 'TEST_DIR/t=
.IMGFMT' } }
+{"return": {}}
+{'execute': 'blockdev-del', 'arguments': { 'node-name': 'node-format' } }
+{"return": {}}
+{'execute': 'fuse-export-add', 'arguments': { 'node-name': 'node-protocol'=
, 'mountpoint': 'TEST_DIR/t.IMGFMT.fuse', 'writable': true } }
+{"return": {}}
+
+--- Try growing non-growable export ---
+(OK: Lengths of export and original are the same)
+dd: error writing 'TEST_DIR/t.IMGFMT.fuse': Input/output error
+1+0 records in
+0+0 records out
+
+--- Resize export ---
+(OK: Lengths of export and original are the same)
+OK: Post-truncate image size is as expected
+OK: Disk usage grew with fallocate
+
+--- Try growing growable export ---
+{'execute': 'fuse-export-remove', 'arguments': { 'mountpoint': 'TEST_DIR/t=
.IMGFMT.fuse' } }
+{"return": {}}
+{'execute': 'fuse-export-add', 'arguments': { 'node-name': 'node-protocol'=
, 'mountpoint': 'TEST_DIR/t.IMGFMT.fuse', 'writable': true, 'growable': tru=
e } }
+{"return": {}}
+65536+0 records in
+65536+0 records out
+(OK: Lengths of export and original are the same)
+OK: Post-grow image size is as expected
+
+--- Shrink export ---
+(OK: Lengths of export and original are the same)
+OK: Post-truncate image size is as expected
+
+=3D=3D=3D Tear down =3D=3D=3D
+{'execute': 'quit'}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=3D=3D=3D Compare copy with original =3D=3D=3D
+Images are identical.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index eb57ddc72c..6fce3f1cfd 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -287,3 +287,4 @@
 273 backing quick
 277 rw quick
 279 rw backing quick
+281 rw
--=20
2.23.0


