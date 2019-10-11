Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A769AC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC29222C5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC29222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIx67-0004CT-Ff
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwqy-0002Y0-6c
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwqu-0006oU-C5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwqm-0006lr-MZ; Fri, 11 Oct 2019 11:29:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA4347E424;
 Fri, 11 Oct 2019 15:29:02 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDBB45C1B2;
 Fri, 11 Oct 2019 15:29:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 16/16] iotests: Test qcow2's snapshot table handling
Date: Fri, 11 Oct 2019 17:28:14 +0200
Message-Id: <20191011152814.14791-17-mreitz@redhat.com>
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
References: <20191011152814.14791-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 11 Oct 2019 15:29:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Add a test how our qcow2 driver handles extra data in snapshot table
entries, and how it repairs overly long snapshot tables.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/261     | 523 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/261.out | 346 ++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 870 insertions(+)
 create mode 100755 tests/qemu-iotests/261
 create mode 100644 tests/qemu-iotests/261.out

diff --git a/tests/qemu-iotests/261 b/tests/qemu-iotests/261
new file mode 100755
index 0000000000..fb96bcfbe2
--- /dev/null
+++ b/tests/qemu-iotests/261
@@ -0,0 +1,523 @@
+#!/usr/bin/env bash
+#
+# Test case for qcow2's handling of extra data in snapshot table entries
+# (and more generally, how certain cases of broken snapshot tables are
+# handled)
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
+# creator
+owner=3Dmreitz@redhat.com
+
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_IMG".v{2,3}.orig
+    rm -f "$TEST_DIR"/sn{0,1,2}{,-pre,-extra,-post}
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+# This tests qocw2-specific low-level functionality
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+# (1) We create a v2 image that supports nothing but refcount_bits=3D16
+# (2) We do some refcount management on our own which expects
+#     refcount_bits=3D16
+_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
+
+# Parameters:
+#   $1: image filename
+#   $2: snapshot table entry offset in the image
+snapshot_table_entry_size()
+{
+    id_len=3D$(peek_file_be "$1" $(($2 + 12)) 2)
+    name_len=3D$(peek_file_be "$1" $(($2 + 14)) 2)
+    extra_len=3D$(peek_file_be "$1" $(($2 + 36)) 4)
+
+    full_len=3D$((40 + extra_len + id_len + name_len))
+    echo $(((full_len + 7) / 8 * 8))
+}
+
+# Parameter:
+#   $1: image filename
+print_snapshot_table()
+{
+    nb_entries=3D$(peek_file_be "$1" 60 4)
+    offset=3D$(peek_file_be "$1" 64 8)
+
+    echo "Snapshots in $1:" | _filter_testdir | _filter_imgfmt
+
+    for ((i =3D 0; i < nb_entries; i++)); do
+        id_len=3D$(peek_file_be "$1" $((offset + 12)) 2)
+        name_len=3D$(peek_file_be "$1" $((offset + 14)) 2)
+        extra_len=3D$(peek_file_be "$1" $((offset + 36)) 4)
+
+        extra_ofs=3D$((offset + 40))
+        id_ofs=3D$((extra_ofs + extra_len))
+        name_ofs=3D$((id_ofs + id_len))
+
+        echo "  [$i]"
+        echo "    ID: $(peek_file_raw "$1" $id_ofs $id_len)"
+        echo "    Name: $(peek_file_raw "$1" $name_ofs $name_len)"
+        echo "    Extra data size: $extra_len"
+        if [ $extra_len -ge 8 ]; then
+            echo "    VM state size: $(peek_file_be "$1" $extra_ofs 8)"
+        fi
+        if [ $extra_len -ge 16 ]; then
+            echo "    Disk size: $(peek_file_be "$1" $((extra_ofs + 8)) =
8)"
+        fi
+        if [ $extra_len -gt 16 ]; then
+            echo '    Unknown extra data:' \
+                "$(peek_file_raw "$1" $((extra_ofs + 16)) $((extra_len -=
 16)) \
+                   | tr -d '\0')"
+        fi
+
+        offset=3D$((offset + $(snapshot_table_entry_size "$1" $offset)))
+    done
+}
+
+# Mark clusters as allocated; works only in refblock 0 (i.e. before
+# cluster #32768).
+# Parameters:
+#   $1: Start offset of what to allocate
+#   $2: End offset (exclusive)
+refblock0_allocate()
+{
+    reftable_ofs=3D$(peek_file_be "$TEST_IMG" 48 8)
+    refblock_ofs=3D$(peek_file_be "$TEST_IMG" $reftable_ofs 8)
+
+    cluster=3D$(($1 / 65536))
+    ecluster=3D$((($2 + 65535) / 65536))
+
+    while [ $cluster -lt $ecluster ]; do
+        if [ $cluster -ge 32768 ]; then
+            echo "*** Abort: Cluster $cluster exceeds refblock 0 ***"
+            exit 1
+        fi
+        poke_file "$TEST_IMG" $((refblock_ofs + cluster * 2)) '\x00\x01'
+        cluster=3D$((cluster + 1))
+    done
+}
+
+
+echo
+echo '=3D=3D=3D Create v2 template =3D=3D=3D'
+echo
+
+# Create v2 image with a snapshot table with three entries:
+# [0]: No extra data (valid with v2, not valid with v3)
+# [1]: Has extra data unknown to qemu
+# [2]: Has the 64-bit VM state size, but not the disk size (again,
+#      valid with v2, not valid with v3)
+
+TEST_IMG=3D"$TEST_IMG.v2.orig" IMGOPTS=3D'compat=3D0.10' _make_test_img =
64M
+$QEMU_IMG snapshot -c sn0 "$TEST_IMG.v2.orig"
+$QEMU_IMG snapshot -c sn1 "$TEST_IMG.v2.orig"
+$QEMU_IMG snapshot -c sn2 "$TEST_IMG.v2.orig"
+
+# Copy out all existing snapshot table entries
+sn_table_ofs=3D$(peek_file_be "$TEST_IMG.v2.orig" 64 8)
+
+# ofs: Snapshot table entry offset
+# eds: Extra data size
+# ids: Name + ID size
+# len: Total entry length
+sn0_ofs=3D$sn_table_ofs
+sn0_eds=3D$(peek_file_be "$TEST_IMG.v2.orig" $((sn0_ofs + 36)) 4)
+sn0_ids=3D$(($(peek_file_be "$TEST_IMG.v2.orig" $((sn0_ofs + 12)) 2) +
+           $(peek_file_be "$TEST_IMG.v2.orig" $((sn0_ofs + 14)) 2)))
+sn0_len=3D$(snapshot_table_entry_size "$TEST_IMG.v2.orig" $sn0_ofs)
+sn1_ofs=3D$((sn0_ofs + sn0_len))
+sn1_eds=3D$(peek_file_be "$TEST_IMG.v2.orig" $((sn1_ofs + 36)) 4)
+sn1_ids=3D$(($(peek_file_be "$TEST_IMG.v2.orig" $((sn1_ofs + 12)) 2) +
+           $(peek_file_be "$TEST_IMG.v2.orig" $((sn1_ofs + 14)) 2)))
+sn1_len=3D$(snapshot_table_entry_size "$TEST_IMG.v2.orig" $sn1_ofs)
+sn2_ofs=3D$((sn1_ofs + sn1_len))
+sn2_eds=3D$(peek_file_be "$TEST_IMG.v2.orig" $((sn2_ofs + 36)) 4)
+sn2_ids=3D$(($(peek_file_be "$TEST_IMG.v2.orig" $((sn2_ofs + 12)) 2) +
+           $(peek_file_be "$TEST_IMG.v2.orig" $((sn2_ofs + 14)) 2)))
+sn2_len=3D$(snapshot_table_entry_size "$TEST_IMG.v2.orig" $sn2_ofs)
+
+# Data before extra data
+dd if=3D"$TEST_IMG.v2.orig" of=3D"$TEST_DIR/sn0-pre" bs=3D1 skip=3D$sn0_=
ofs count=3D40 \
+    &> /dev/null
+dd if=3D"$TEST_IMG.v2.orig" of=3D"$TEST_DIR/sn1-pre" bs=3D1 skip=3D$sn1_=
ofs count=3D40 \
+    &> /dev/null
+dd if=3D"$TEST_IMG.v2.orig" of=3D"$TEST_DIR/sn2-pre" bs=3D1 skip=3D$sn2_=
ofs count=3D40 \
+    &> /dev/null
+
+# Extra data
+dd if=3D"$TEST_IMG.v2.orig" of=3D"$TEST_DIR/sn0-extra" bs=3D1 \
+    skip=3D$((sn0_ofs + 40)) count=3D$sn0_eds &> /dev/null
+dd if=3D"$TEST_IMG.v2.orig" of=3D"$TEST_DIR/sn1-extra" bs=3D1 \
+    skip=3D$((sn1_ofs + 40)) count=3D$sn1_eds &> /dev/null
+dd if=3D"$TEST_IMG.v2.orig" of=3D"$TEST_DIR/sn2-extra" bs=3D1 \
+    skip=3D$((sn2_ofs + 40)) count=3D$sn2_eds &> /dev/null
+
+# Data after extra data
+dd if=3D"$TEST_IMG.v2.orig" of=3D"$TEST_DIR/sn0-post" bs=3D1 \
+    skip=3D$((sn0_ofs + 40 + sn0_eds)) count=3D$sn0_ids \
+    &> /dev/null
+dd if=3D"$TEST_IMG.v2.orig" of=3D"$TEST_DIR/sn1-post" bs=3D1 \
+    skip=3D$((sn1_ofs + 40 + sn1_eds)) count=3D$sn1_ids \
+    &> /dev/null
+dd if=3D"$TEST_IMG.v2.orig" of=3D"$TEST_DIR/sn2-post" bs=3D1 \
+    skip=3D$((sn2_ofs + 40 + sn2_eds)) count=3D$sn2_ids \
+    &> /dev/null
+
+# Amend them, one by one
+# Set sn0's extra data size to 0
+poke_file "$TEST_DIR/sn0-pre" 36 '\x00\x00\x00\x00'
+truncate -s 0 "$TEST_DIR/sn0-extra"
+# Grow sn0-post to pad
+truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn0-pre") - 40)) \
+    "$TEST_DIR/sn0-post"
+
+# Set sn1's extra data size to 42
+poke_file "$TEST_DIR/sn1-pre" 36 '\x00\x00\x00\x2a'
+truncate -s 42 "$TEST_DIR/sn1-extra"
+poke_file "$TEST_DIR/sn1-extra" 16 'very important data'
+# Grow sn1-post to pad
+truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn1-pre") - 82)) \
+    "$TEST_DIR/sn1-post"
+
+# Set sn2's extra data size to 8
+poke_file "$TEST_DIR/sn2-pre" 36 '\x00\x00\x00\x08'
+truncate -s 8 "$TEST_DIR/sn2-extra"
+# Grow sn2-post to pad
+truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn2-pre") - 48)) \
+    "$TEST_DIR/sn2-post"
+
+# Construct snapshot table
+cat "$TEST_DIR"/sn0-{pre,extra,post} \
+    "$TEST_DIR"/sn1-{pre,extra,post} \
+    "$TEST_DIR"/sn2-{pre,extra,post} \
+    | dd of=3D"$TEST_IMG.v2.orig" bs=3D1 seek=3D$sn_table_ofs conv=3Dnot=
runc \
+          &> /dev/null
+
+# Done!
+TEST_IMG=3D"$TEST_IMG.v2.orig" _check_test_img
+print_snapshot_table "$TEST_IMG.v2.orig"
+
+echo
+echo '=3D=3D=3D Upgrade to v3 =3D=3D=3D'
+echo
+
+cp "$TEST_IMG.v2.orig" "$TEST_IMG.v3.orig"
+$QEMU_IMG amend -o compat=3D1.1 "$TEST_IMG.v3.orig"
+TEST_IMG=3D"$TEST_IMG.v3.orig" _check_test_img
+print_snapshot_table "$TEST_IMG.v3.orig"
+
+echo
+echo '=3D=3D=3D Repair botched v3 =3D=3D=3D'
+echo
+
+# Force the v2 file to be v3.  v3 requires each snapshot table entry
+# to have at least 16 bytes of extra data, so it will not comply to
+# the qcow2 v3 specification; but we can fix that.
+cp "$TEST_IMG.v2.orig" "$TEST_IMG"
+
+# Set version
+poke_file "$TEST_IMG" 4 '\x00\x00\x00\x03'
+# Increase header length (necessary for v3)
+poke_file "$TEST_IMG" 100 '\x00\x00\x00\x68'
+# Set refcount order (necessary for v3)
+poke_file "$TEST_IMG" 96 '\x00\x00\x00\x04'
+
+_check_test_img -r all
+print_snapshot_table "$TEST_IMG"
+
+
+# From now on, just test the qcow2 version we are supposed to test.
+# (v3 by default, v2 by choice through $IMGOPTS.)
+# That works because we always write all known extra data when
+# updating the snapshot table, independent of the version.
+
+if echo "$IMGOPTS" | grep -q 'compat=3D\(0\.10\|v2\)' 2> /dev/null; then
+    subver=3Dv2
+else
+    subver=3Dv3
+fi
+
+echo
+echo '=3D=3D=3D Add new snapshot =3D=3D=3D'
+echo
+
+cp "$TEST_IMG.$subver.orig" "$TEST_IMG"
+$QEMU_IMG snapshot -c sn3 "$TEST_IMG"
+_check_test_img
+print_snapshot_table "$TEST_IMG"
+
+echo
+echo '=3D=3D=3D Remove different snapshots =3D=3D=3D'
+
+for sn in sn0 sn1 sn2; do
+    echo
+    echo "--- $sn ---"
+
+    cp "$TEST_IMG.$subver.orig" "$TEST_IMG"
+    $QEMU_IMG snapshot -d $sn "$TEST_IMG"
+    _check_test_img
+    print_snapshot_table "$TEST_IMG"
+done
+
+echo
+echo '=3D=3D=3D Reject too much unknown extra data =3D=3D=3D'
+echo
+
+cp "$TEST_IMG.$subver.orig" "$TEST_IMG"
+$QEMU_IMG snapshot -c sn3 "$TEST_IMG"
+
+sn_table_ofs=3D$(peek_file_be "$TEST_IMG" 64 8)
+sn0_ofs=3D$sn_table_ofs
+sn1_ofs=3D$((sn0_ofs + $(snapshot_table_entry_size "$TEST_IMG" $sn0_ofs)=
))
+sn2_ofs=3D$((sn1_ofs + $(snapshot_table_entry_size "$TEST_IMG" $sn1_ofs)=
))
+sn3_ofs=3D$((sn2_ofs + $(snapshot_table_entry_size "$TEST_IMG" $sn2_ofs)=
))
+
+# 64 kB of extra data should be rejected
+# (Note that this also induces a refcount error, because it spills
+# over to the next cluster.  That's a good way to test that we can
+# handle simultaneous snapshot table and refcount errors.)
+poke_file "$TEST_IMG" $((sn3_ofs + 36)) '\x00\x01\x00\x00'
+
+# Print error
+_img_info
+echo
+_check_test_img
+echo
+
+# Should be repairable
+_check_test_img -r all
+
+echo
+echo '=3D=3D=3D Snapshot table too big =3D=3D=3D'
+echo
+
+sn_table_ofs=3D$(peek_file_be "$TEST_IMG.v3.orig" 64 8)
+
+# Fill a snapshot with 1 kB of extra data, a 65535-char ID, and a
+# 65535-char name, and repeat it as many times as necessary to fill
+# 64 MB (the maximum supported by qemu)
+
+touch "$TEST_DIR/sn0"
+
+# Full size (fixed + extra + ID + name + padding)
+sn_size=3D$((40 + 1024 + 65535 + 65535 + 2))
+
+# We only need the fixed part, though.
+truncate -s 40 "$TEST_DIR/sn0"
+
+# 65535-char ID string
+poke_file "$TEST_DIR/sn0" 12 '\xff\xff'
+# 65535-char name
+poke_file "$TEST_DIR/sn0" 14 '\xff\xff'
+# 1 kB of extra data
+poke_file "$TEST_DIR/sn0" 36 '\x00\x00\x04\x00'
+
+# Create test image
+_make_test_img 64M
+
+# Hook up snapshot table somewhere safe (at 1 MB)
+poke_file "$TEST_IMG" 64 '\x00\x00\x00\x00\x00\x10\x00\x00'
+
+offset=3D1048576
+size_written=3D0
+sn_count=3D0
+while [ $size_written -le $((64 * 1048576)) ]; do
+    dd if=3D"$TEST_DIR/sn0" of=3D"$TEST_IMG" bs=3D1 seek=3D$offset conv=3D=
notrunc \
+        &> /dev/null
+    offset=3D$((offset + sn_size))
+    size_written=3D$((size_written + sn_size))
+    sn_count=3D$((sn_count + 1))
+done
+truncate -s "$offset" "$TEST_IMG"
+
+# Give the last snapshot (the one to be removed) an L1 table so we can
+# see how that is handled when repairing the image
+# (Put it two clusters before 1 MB, and one L2 table one cluster
+# before 1 MB)
+poke_file "$TEST_IMG" $((offset - sn_size + 0)) \
+    '\x00\x00\x00\x00\x00\x0e\x00\x00'
+poke_file "$TEST_IMG" $((offset - sn_size + 8)) \
+    '\x00\x00\x00\x01'
+
+# Hook up the L2 table
+poke_file "$TEST_IMG" $((1048576 - 2 * 65536)) \
+    '\x80\x00\x00\x00\x00\x0f\x00\x00'
+
+# Make sure all of the clusters we just hooked up are allocated:
+# - The snapshot table
+# - The last snapshot's L1 and L2 table
+refblock0_allocate $((1048576 - 2 * 65536)) $offset
+
+poke_file "$TEST_IMG" 60 \
+    "$(printf '%08x' $sn_count | sed -e 's/\(..\)/\\x\1/g')"
+
+# Print error
+_img_info
+echo
+_check_test_img
+echo
+
+# Should be repairable
+_check_test_img -r all
+
+echo
+echo "$((sn_count - 1)) snapshots should remain:"
+echo "  qemu-img info reports $(_img_info | grep -c '^ \{34\}') snapshot=
s"
+echo "  Image header reports $(peek_file_be "$TEST_IMG" 60 4) snapshots"
+
+echo
+echo '=3D=3D=3D Snapshot table too big with one entry with too much extr=
a data =3D=3D=3D'
+echo
+
+# For this test, we reuse the image from the previous case, which has
+# a snapshot table that is right at the limit.
+# Our layout looks like this:
+# - (a number of snapshot table entries)
+# - One snapshot with $extra_data_size extra data
+# - One normal snapshot that breaks the 64 MB boundary
+# - One normal snapshot beyond the 64 MB boundary
+#
+# $extra_data_size is calculated so that simply by virtue of it
+# decreasing to 1 kB, the penultimate snapshot will fit into 64 MB
+# limit again.  The final snapshot will always be beyond the limit, so
+# that we can see that the repair algorithm does still determine the
+# limit to be somewhere, even when truncating one snapshot's extra
+# data.
+
+# The last case has removed the last snapshot, so calculate
+# $old_offset to get the current image's real length
+old_offset=3D$((offset - sn_size))
+
+# The layout from the previous test had one snapshot beyond the 64 MB
+# limit; we want the same (after the oversized extra data has been
+# truncated to 1 kB), so we drop the last three snapshots and
+# construct them from scratch.
+offset=3D$((offset - 3 * sn_size))
+sn_count=3D$((sn_count - 3))
+
+# Assuming we had already written one of the three snapshots
+# (necessary so we can calculate $extra_data_size next).
+size_written=3D$((size_written - 2 * sn_size))
+
+# Increase the extra data size so we go past the limit
+# (The -1024 comes from the 1 kB of extra data we already have)
+extra_data_size=3D$((64 * 1048576 + 8 - sn_size - (size_written - 1024))=
)
+
+poke_file "$TEST_IMG" $((offset + 36)) \
+    "$(printf '%08x' $extra_data_size | sed -e 's/\(..\)/\\x\1/g')"
+
+offset=3D$((offset + sn_size - 1024 + extra_data_size))
+size_written=3D$((size_written - 1024 + extra_data_size))
+sn_count=3D$((sn_count + 1))
+
+# Write the two normal snapshots
+for ((i =3D 0; i < 2; i++)); do
+    dd if=3D"$TEST_DIR/sn0" of=3D"$TEST_IMG" bs=3D1 seek=3D$offset conv=3D=
notrunc \
+        &> /dev/null
+    offset=3D$((offset + sn_size))
+    size_written=3D$((size_written + sn_size))
+    sn_count=3D$((sn_count + 1))
+
+    if [ $i =3D 0 ]; then
+        # Check that the penultimate snapshot is beyond the 64 MB limit
+        echo "Snapshot table size should equal $((64 * 1048576 + 8)):" \
+            $size_written
+        echo
+    fi
+done
+
+truncate -s $offset "$TEST_IMG"
+refblock0_allocate $old_offset $offset
+
+poke_file "$TEST_IMG" 60 \
+    "$(printf '%08x' $sn_count | sed -e 's/\(..\)/\\x\1/g')"
+
+# Print error
+_img_info
+echo
+_check_test_img
+echo
+
+# Just truncating the extra data should be sufficient to shorten the
+# snapshot table so only one snapshot exceeds the extra size
+_check_test_img -r all
+
+echo
+echo '=3D=3D=3D Too many snapshots =3D=3D=3D'
+echo
+
+# Create a v2 image, for speeds' sake: All-zero snapshot table entries
+# are only valid in v2.
+IMGOPTS=3D'compat=3D0.10' _make_test_img 64M
+
+# Hook up snapshot table somewhere safe (at 1 MB)
+poke_file "$TEST_IMG" 64 '\x00\x00\x00\x00\x00\x10\x00\x00'
+# "Create" more than 65536 snapshots (twice that many here)
+poke_file "$TEST_IMG" 60 '\x00\x02\x00\x00'
+
+# 40-byte all-zero snapshot table entries are valid snapshots, but
+# only in v2 (v3 needs 16 bytes of extra data, so we would have to
+# write 131072x '\x10').
+truncate -s $((1048576 + 40 * 131072)) "$TEST_IMG"
+
+# But let us give one of the snapshots to be removed an L1 table so
+# we can see how that is handled when repairing the image.
+# (Put it two clusters before 1 MB, and one L2 table one cluster
+# before 1 MB)
+poke_file "$TEST_IMG" $((1048576 + 40 * 65536 + 0)) \
+    '\x00\x00\x00\x00\x00\x0e\x00\x00'
+poke_file "$TEST_IMG" $((1048576 + 40 * 65536 + 8)) \
+    '\x00\x00\x00\x01'
+
+# Hook up the L2 table
+poke_file "$TEST_IMG" $((1048576 - 2 * 65536)) \
+    '\x80\x00\x00\x00\x00\x0f\x00\x00'
+
+# Make sure all of the clusters we just hooked up are allocated:
+# - The snapshot table
+# - The last snapshot's L1 and L2 table
+refblock0_allocate $((1048576 - 2 * 65536)) $((1048576 + 40 * 131072))
+
+# Print error
+_img_info
+echo
+_check_test_img
+echo
+
+# Should be repairable
+_check_test_img -r all
+
+echo
+echo '65536 snapshots should remain:'
+echo "  qemu-img info reports $(_img_info | grep -c '^ \{34\}') snapshot=
s"
+echo "  Image header reports $(peek_file_be "$TEST_IMG" 60 4) snapshots"
+
+# success, all done
+echo "*** done"
+status=3D0
diff --git a/tests/qemu-iotests/261.out b/tests/qemu-iotests/261.out
new file mode 100644
index 0000000000..2600354566
--- /dev/null
+++ b/tests/qemu-iotests/261.out
@@ -0,0 +1,346 @@
+QA output created by 261
+
+=3D=3D=3D Create v2 template =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT.v2.orig', fmt=3DIMGFMT size=3D67108864
+No errors were found on the image.
+Snapshots in TEST_DIR/t.IMGFMT.v2.orig:
+  [0]
+    ID: 1
+    Name: sn0
+    Extra data size: 0
+  [1]
+    ID: 2
+    Name: sn1
+    Extra data size: 42
+    VM state size: 0
+    Disk size: 67108864
+    Unknown extra data: very important data
+  [2]
+    ID: 3
+    Name: sn2
+    Extra data size: 8
+    VM state size: 0
+
+=3D=3D=3D Upgrade to v3 =3D=3D=3D
+
+No errors were found on the image.
+Snapshots in TEST_DIR/t.IMGFMT.v3.orig:
+  [0]
+    ID: 1
+    Name: sn0
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+  [1]
+    ID: 2
+    Name: sn1
+    Extra data size: 42
+    VM state size: 0
+    Disk size: 67108864
+    Unknown extra data: very important data
+  [2]
+    ID: 3
+    Name: sn2
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+
+=3D=3D=3D Repair botched v3 =3D=3D=3D
+
+Repairing snapshot table entry 0 is incomplete
+Repairing snapshot table entry 2 is incomplete
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    2 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+Snapshots in TEST_DIR/t.IMGFMT:
+  [0]
+    ID: 1
+    Name: sn0
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+  [1]
+    ID: 2
+    Name: sn1
+    Extra data size: 42
+    VM state size: 0
+    Disk size: 67108864
+    Unknown extra data: very important data
+  [2]
+    ID: 3
+    Name: sn2
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+
+=3D=3D=3D Add new snapshot =3D=3D=3D
+
+No errors were found on the image.
+Snapshots in TEST_DIR/t.IMGFMT:
+  [0]
+    ID: 1
+    Name: sn0
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+  [1]
+    ID: 2
+    Name: sn1
+    Extra data size: 42
+    VM state size: 0
+    Disk size: 67108864
+    Unknown extra data: very important data
+  [2]
+    ID: 3
+    Name: sn2
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+  [3]
+    ID: 4
+    Name: sn3
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+
+=3D=3D=3D Remove different snapshots =3D=3D=3D
+
+--- sn0 ---
+No errors were found on the image.
+Snapshots in TEST_DIR/t.IMGFMT:
+  [0]
+    ID: 2
+    Name: sn1
+    Extra data size: 42
+    VM state size: 0
+    Disk size: 67108864
+    Unknown extra data: very important data
+  [1]
+    ID: 3
+    Name: sn2
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+
+--- sn1 ---
+No errors were found on the image.
+Snapshots in TEST_DIR/t.IMGFMT:
+  [0]
+    ID: 1
+    Name: sn0
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+  [1]
+    ID: 3
+    Name: sn2
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+
+--- sn2 ---
+No errors were found on the image.
+Snapshots in TEST_DIR/t.IMGFMT:
+  [0]
+    ID: 1
+    Name: sn0
+    Extra data size: 16
+    VM state size: 0
+    Disk size: 67108864
+  [1]
+    ID: 2
+    Name: sn1
+    Extra data size: 42
+    VM state size: 0
+    Disk size: 67108864
+    Unknown extra data: very important data
+
+=3D=3D=3D Reject too much unknown extra data =3D=3D=3D
+
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Too much extra metadata in=
 snapshot table entry 3
+You can force-remove this extra metadata with qemu-img check -r all
+
+qemu-img: ERROR failed to read the snapshot table: Too much extra metada=
ta in snapshot table entry 3
+You can force-remove this extra metadata with qemu-img check -r all
+qemu-img: Check failed: File too large
+
+Discarding too much extra metadata in snapshot table entry 3 (65536 > 10=
24)
+ERROR cluster 10 refcount=3D0 reference=3D1
+Rebuilding refcount structure
+Repairing cluster 1 refcount=3D1 reference=3D0
+Repairing cluster 2 refcount=3D1 reference=3D0
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    2 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+
+=3D=3D=3D Snapshot table too big =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Snapshot table is too big
+You can force-remove all 1 overhanging snapshots with qemu-img check -r =
all
+
+qemu-img: ERROR failed to read the snapshot table: Snapshot table is too=
 big
+You can force-remove all 1 overhanging snapshots with qemu-img check -r =
all
+qemu-img: Check failed: File too large
+
+Discarding 1 overhanging snapshots (snapshot table is too big)
+Leaked cluster 14 refcount=3D1 reference=3D0
+Leaked cluster 15 refcount=3D1 reference=3D0
+Leaked cluster 1039 refcount=3D1 reference=3D0
+Leaked cluster 1040 refcount=3D1 reference=3D0
+Repairing cluster 14 refcount=3D1 reference=3D0
+Repairing cluster 15 refcount=3D1 reference=3D0
+Repairing cluster 1039 refcount=3D1 reference=3D0
+Repairing cluster 1040 refcount=3D1 reference=3D0
+The following inconsistencies were found and repaired:
+
+    4 leaked clusters
+    1 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+
+507 snapshots should remain:
+  qemu-img info reports 507 snapshots
+  Image header reports 507 snapshots
+
+=3D=3D=3D Snapshot table too big with one entry with too much extra data=
 =3D=3D=3D
+
+Snapshot table size should equal 67108872: 67108872
+
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Too much extra metadata in=
 snapshot table entry 505
+You can force-remove this extra metadata with qemu-img check -r all
+
+qemu-img: ERROR failed to read the snapshot table: Too much extra metada=
ta in snapshot table entry 505
+You can force-remove this extra metadata with qemu-img check -r all
+qemu-img: Check failed: File too large
+
+Discarding too much extra metadata in snapshot table entry 505 (116944 >=
 1024)
+Discarding 1 overhanging snapshots (snapshot table is too big)
+Leaked cluster 1041 refcount=3D1 reference=3D0
+Leaked cluster 1042 refcount=3D1 reference=3D0
+Repairing cluster 1041 refcount=3D1 reference=3D0
+Repairing cluster 1042 refcount=3D1 reference=3D0
+The following inconsistencies were found and repaired:
+
+    2 leaked clusters
+    2 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+
+=3D=3D=3D Too many snapshots =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Snapshot table too large
+
+qemu-img: ERROR snapshot table too large
+You can force-remove all 65536 overhanging snapshots with qemu-img check=
 -r all
+qemu-img: Check failed: File too large
+
+Discarding 65536 overhanging snapshots
+Leaked cluster 14 refcount=3D1 reference=3D0
+Leaked cluster 15 refcount=3D1 reference=3D0
+Leaked cluster 56 refcount=3D1 reference=3D0
+Leaked cluster 57 refcount=3D1 reference=3D0
+Leaked cluster 58 refcount=3D1 reference=3D0
+Leaked cluster 59 refcount=3D1 reference=3D0
+Leaked cluster 60 refcount=3D1 reference=3D0
+Leaked cluster 61 refcount=3D1 reference=3D0
+Leaked cluster 62 refcount=3D1 reference=3D0
+Leaked cluster 63 refcount=3D1 reference=3D0
+Leaked cluster 64 refcount=3D1 reference=3D0
+Leaked cluster 65 refcount=3D1 reference=3D0
+Leaked cluster 66 refcount=3D1 reference=3D0
+Leaked cluster 67 refcount=3D1 reference=3D0
+Leaked cluster 68 refcount=3D1 reference=3D0
+Leaked cluster 69 refcount=3D1 reference=3D0
+Leaked cluster 70 refcount=3D1 reference=3D0
+Leaked cluster 71 refcount=3D1 reference=3D0
+Leaked cluster 72 refcount=3D1 reference=3D0
+Leaked cluster 73 refcount=3D1 reference=3D0
+Leaked cluster 74 refcount=3D1 reference=3D0
+Leaked cluster 75 refcount=3D1 reference=3D0
+Leaked cluster 76 refcount=3D1 reference=3D0
+Leaked cluster 77 refcount=3D1 reference=3D0
+Leaked cluster 78 refcount=3D1 reference=3D0
+Leaked cluster 79 refcount=3D1 reference=3D0
+Leaked cluster 80 refcount=3D1 reference=3D0
+Leaked cluster 81 refcount=3D1 reference=3D0
+Leaked cluster 82 refcount=3D1 reference=3D0
+Leaked cluster 83 refcount=3D1 reference=3D0
+Leaked cluster 84 refcount=3D1 reference=3D0
+Leaked cluster 85 refcount=3D1 reference=3D0
+Leaked cluster 86 refcount=3D1 reference=3D0
+Leaked cluster 87 refcount=3D1 reference=3D0
+Leaked cluster 88 refcount=3D1 reference=3D0
+Leaked cluster 89 refcount=3D1 reference=3D0
+Leaked cluster 90 refcount=3D1 reference=3D0
+Leaked cluster 91 refcount=3D1 reference=3D0
+Leaked cluster 92 refcount=3D1 reference=3D0
+Leaked cluster 93 refcount=3D1 reference=3D0
+Leaked cluster 94 refcount=3D1 reference=3D0
+Leaked cluster 95 refcount=3D1 reference=3D0
+Repairing cluster 14 refcount=3D1 reference=3D0
+Repairing cluster 15 refcount=3D1 reference=3D0
+Repairing cluster 56 refcount=3D1 reference=3D0
+Repairing cluster 57 refcount=3D1 reference=3D0
+Repairing cluster 58 refcount=3D1 reference=3D0
+Repairing cluster 59 refcount=3D1 reference=3D0
+Repairing cluster 60 refcount=3D1 reference=3D0
+Repairing cluster 61 refcount=3D1 reference=3D0
+Repairing cluster 62 refcount=3D1 reference=3D0
+Repairing cluster 63 refcount=3D1 reference=3D0
+Repairing cluster 64 refcount=3D1 reference=3D0
+Repairing cluster 65 refcount=3D1 reference=3D0
+Repairing cluster 66 refcount=3D1 reference=3D0
+Repairing cluster 67 refcount=3D1 reference=3D0
+Repairing cluster 68 refcount=3D1 reference=3D0
+Repairing cluster 69 refcount=3D1 reference=3D0
+Repairing cluster 70 refcount=3D1 reference=3D0
+Repairing cluster 71 refcount=3D1 reference=3D0
+Repairing cluster 72 refcount=3D1 reference=3D0
+Repairing cluster 73 refcount=3D1 reference=3D0
+Repairing cluster 74 refcount=3D1 reference=3D0
+Repairing cluster 75 refcount=3D1 reference=3D0
+Repairing cluster 76 refcount=3D1 reference=3D0
+Repairing cluster 77 refcount=3D1 reference=3D0
+Repairing cluster 78 refcount=3D1 reference=3D0
+Repairing cluster 79 refcount=3D1 reference=3D0
+Repairing cluster 80 refcount=3D1 reference=3D0
+Repairing cluster 81 refcount=3D1 reference=3D0
+Repairing cluster 82 refcount=3D1 reference=3D0
+Repairing cluster 83 refcount=3D1 reference=3D0
+Repairing cluster 84 refcount=3D1 reference=3D0
+Repairing cluster 85 refcount=3D1 reference=3D0
+Repairing cluster 86 refcount=3D1 reference=3D0
+Repairing cluster 87 refcount=3D1 reference=3D0
+Repairing cluster 88 refcount=3D1 reference=3D0
+Repairing cluster 89 refcount=3D1 reference=3D0
+Repairing cluster 90 refcount=3D1 reference=3D0
+Repairing cluster 91 refcount=3D1 reference=3D0
+Repairing cluster 92 refcount=3D1 reference=3D0
+Repairing cluster 93 refcount=3D1 reference=3D0
+Repairing cluster 94 refcount=3D1 reference=3D0
+Repairing cluster 95 refcount=3D1 reference=3D0
+The following inconsistencies were found and repaired:
+
+    42 leaked clusters
+    65536 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+
+65536 snapshots should remain:
+  qemu-img info reports 65536 snapshots
+  Image header reports 65536 snapshots
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5805a79d9e..5191dfcdf2 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -273,6 +273,7 @@
 256 rw quick
 257 rw
 258 rw quick
+261 rw
 262 rw quick migration
 263 rw quick
 265 rw auto quick
--=20
2.21.0


