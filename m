Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA60C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C084204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmFE7c2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C084204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RFJ-0007MD-KU
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9W-0006D0-C5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49648
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9T-0006tb-TB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595948663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ah1BNHGRzQCMR0vyXLGcIrWGVHRIu4rYiTqWfrIuzH4=;
 b=KmFE7c2jWY4yYUg/4+PvxBcQ+HwmFgBVl5isJjtE0XidRQ758Z3HHBOY3ZmgKWey7qXIx7
 0J/dUhpOFg7WKY2Ziri83zGTPHgWh217AN35v96LO+LU1sHHGHlh3rnrhGM7vFoCxb7lFX
 rZaOGfveGK6Fu3j3vTfo2TPWvNHyMuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-7NmkATP3NsOxTOiwYVeDKA-1; Tue, 28 Jul 2020 11:04:17 -0400
X-MC-Unique: 7NmkATP3NsOxTOiwYVeDKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED01F10059BB;
 Tue, 28 Jul 2020 15:04:16 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02DD819C71;
 Tue, 28 Jul 2020 15:04:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] iotests: Test convert to qcow2 compressed to NBD
Date: Tue, 28 Jul 2020 10:04:03 -0500
Message-Id: <20200728150408.291299-6-eblake@redhat.com>
In-Reply-To: <20200728150408.291299-1-eblake@redhat.com>
References: <20200728150408.291299-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Nir Soffer <nirsof@gmail.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nir Soffer <nirsof@gmail.com>

Add test for "qemu-img convert -O qcow2 -c" to NBD target. The tests    
create a OVA file and write compressed qcow2 disk content directly into
the OVA file via qemu-nbd.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Message-Id: <20200727215846.395443-5-nsoffer@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/302     | 127 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/302.out |  31 +++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 159 insertions(+)
 create mode 100755 tests/qemu-iotests/302
 create mode 100644 tests/qemu-iotests/302.out

diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
new file mode 100755
index 000000000000..a8506bda1592
--- /dev/null
+++ b/tests/qemu-iotests/302
@@ -0,0 +1,127 @@
+#!/usr/bin/env python3
+#
+# Tests converting qcow2 compressed to NBD
+#
+# Copyright (c) 2020 Nir Soffer <nirsof@gmail.com>
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
+# owner=nirsof@gmail.com
+
+import io
+import tarfile
+
+import iotests
+
+from iotests import (
+    file_path,
+    qemu_img,
+    qemu_img_check,
+    qemu_img_create,
+    qemu_img_log,
+    qemu_img_measure,
+    qemu_io,
+    qemu_nbd_popen,
+)
+
+iotests.script_initialize(supported_fmts=["qcow2"])
+
+# Create source disk. Using qcow2 to enable strict comparing later, and
+# avoid issues with random filesystem on CI environment.
+src_disk = file_path("disk.qcow2")
+qemu_img_create("-f", iotests.imgfmt, src_disk, "1g")
+qemu_io("-f", iotests.imgfmt, "-c", "write 1m 64k", src_disk)
+
+# The use case is writing qcow2 image directly into an ova file, which
+# is a tar file with specific layout. This is tricky since we don't know the
+# size of the image before compressing, so we have to do:
+# 1. Add an ovf file.
+# 2. Find the offset of the next member data.
+# 3. Make room for image data, allocating for the worst case.
+# 4. Write compressed image data into the tar.
+# 5. Add a tar entry with the actual image size.
+# 6. Shrink the tar to the actual size, aligned to 512 bytes.
+
+tar_file = file_path("test.ova")
+
+with tarfile.open(tar_file, "w") as tar:
+
+    # 1. Add an ovf file.
+
+    ovf_data = b"<xml/>"
+    ovf = tarfile.TarInfo("vm.ovf")
+    ovf.size = len(ovf_data)
+    tar.addfile(ovf, io.BytesIO(ovf_data))
+
+    # 2. Find the offset of the next member data.
+
+    offset = tar.fileobj.tell() + 512
+
+    # 3. Make room for image data, allocating for the worst case.
+
+    measure = qemu_img_measure("-O", "qcow2", src_disk)
+    tar.fileobj.truncate(offset + measure["required"])
+
+    # 4. Write compressed image data into the tar.
+
+    nbd_sock = file_path("nbd-sock", base_dir=iotests.sock_dir)
+    nbd_uri = "nbd+unix:///exp?socket=" + nbd_sock
+
+    # Use raw format to allow creating qcow2 directly into tar file.
+    with qemu_nbd_popen(
+            "--socket", nbd_sock,
+            "--export-name", "exp",
+            "--format", "raw",
+            "--offset", str(offset),
+            tar_file):
+
+        iotests.log("=== Target image info ===")
+        qemu_img_log("info", nbd_uri)
+
+        qemu_img(
+            "convert",
+            "-f", iotests.imgfmt,
+            "-O", "qcow2",
+            "-c",
+            src_disk,
+            nbd_uri)
+
+        iotests.log("=== Converted image info ===")
+        qemu_img_log("info", nbd_uri)
+
+        iotests.log("=== Converted image check ===")
+        qemu_img_log("check", nbd_uri)
+
+        iotests.log("=== Comparing to source disk ===")
+        qemu_img_log("compare", src_disk, nbd_uri)
+
+        actual_size = qemu_img_check(nbd_uri)["image-end-offset"]
+
+    # 5. Add a tar entry with the actual image size.
+
+    disk = tarfile.TarInfo("disk")
+    disk.size = actual_size
+    tar.addfile(disk)
+
+    # 6. Shrink the tar to the actual size, aligned to 512 bytes.
+
+    tar_size = offset + (disk.size + 511) & ~511
+    tar.fileobj.seek(tar_size)
+    tar.fileobj.truncate(tar_size)
+
+with tarfile.open(tar_file) as tar:
+    members = [{"name": m.name, "size": m.size, "offset": m.offset_data}
+               for m in tar]
+    iotests.log("=== OVA file contents ===")
+    iotests.log(members)
diff --git a/tests/qemu-iotests/302.out b/tests/qemu-iotests/302.out
new file mode 100644
index 000000000000..e37d3a103082
--- /dev/null
+++ b/tests/qemu-iotests/302.out
@@ -0,0 +1,31 @@
+Start NBD server
+=== Target image info ===
+image: nbd+unix:///exp?socket=SOCK_DIR/PID-nbd-sock
+file format: raw
+virtual size: 448 KiB (458752 bytes)
+disk size: unavailable
+
+=== Converted image info ===
+image: nbd+unix:///exp?socket=SOCK_DIR/PID-nbd-sock
+file format: qcow2
+virtual size: 1 GiB (1073741824 bytes)
+disk size: unavailable
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    compression type: zlib
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+=== Converted image check ===
+No errors were found on the image.
+1/16384 = 0.01% allocated, 100.00% fragmented, 100.00% compressed clusters
+Image end offset: 393216
+
+=== Comparing to source disk ===
+Images are identical.
+
+Kill NBD server
+=== OVA file contents ===
+[{"name": "vm.ovf", "offset": 512, "size": 6}, {"name": "disk", "offset": 1536, "size": 393216}]
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1d0252e1f051..1e1cb27bc8e3 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -308,3 +308,4 @@
 297 meta
 299 auto quick
 301 backing quick
+302 quick
-- 
2.27.0


