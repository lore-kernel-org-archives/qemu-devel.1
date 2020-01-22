Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D82C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8CB21569
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP27wj2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8CB21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuJHx-0007kk-Vu
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 11:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8j-0007xW-5W
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8h-0000nw-Np
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:46:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26219
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iuJ8h-0000nl-KL
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579711559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yHKlma0RqRqXD07hhoBdeZ3PKajDpMe6PRs4+4K6aU=;
 b=cP27wj2Yy1TOcomGSFscG9XkPU6EEdqQhIaaGzdSnU6Bc+eiJD7JscsncNpd4qqOXsc0Kv
 2GqG9Zcx3gD14NB6Cf1x3RC5dNdGcPSh1psCeNZu5PwQtjvUGKuxtcIawymoQc+BVjSayF
 6gr+I9+CBq4KFFeuijCfp+jHpfgSilk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-RTxKzuZ0PDqKIa8kcv3jjA-1; Wed, 22 Jan 2020 11:45:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D86FD61268;
 Wed, 22 Jan 2020 16:45:50 +0000 (UTC)
Received: from localhost (unknown [10.36.118.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 480AC811FF;
 Wed, 22 Jan 2020 16:45:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/5] iotests: Add test for image creation fallback
Date: Wed, 22 Jan 2020 17:45:32 +0100
Message-Id: <20200122164532.178040-6-mreitz@redhat.com>
In-Reply-To: <20200122164532.178040-1-mreitz@redhat.com>
References: <20200122164532.178040-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: RTxKzuZ0PDqKIa8kcv3jjA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/259     | 61 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/259.out | 14 +++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

diff --git a/tests/qemu-iotests/259 b/tests/qemu-iotests/259
new file mode 100755
index 0000000000..22b4c10241
--- /dev/null
+++ b/tests/qemu-iotests/259
@@ -0,0 +1,61 @@
+#!/usr/bin/env bash
+#
+# Test generic image creation fallback (by using NBD)
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
+_supported_fmt raw
+_supported_proto nbd
+_supported_os Linux
+
+
+_make_test_img 64M
+
+echo
+echo '--- Testing creation ---'
+
+$QEMU_IMG create -f qcow2 "$TEST_IMG" 64M | _filter_img_create
+$QEMU_IMG info "$TEST_IMG" | _filter_img_info
+
+echo
+echo '--- Testing creation for which the node would need to grow ---'
+
+$QEMU_IMG create -f qcow2 -o preallocation=3Dmetadata "$TEST_IMG" 64M 2>&1=
 \
+    | _filter_img_create
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/259.out b/tests/qemu-iotests/259.out
new file mode 100644
index 0000000000..ffed19c2a0
--- /dev/null
+++ b/tests/qemu-iotests/259.out
@@ -0,0 +1,14 @@
+QA output created by 259
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+
+--- Testing creation ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3Dqcow2 size=3D67108864
+image: TEST_DIR/t.IMGFMT
+file format: qcow2
+virtual size: 64 MiB (67108864 bytes)
+disk size: unavailable
+
+--- Testing creation for which the node would need to grow ---
+qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Image format driver d=
oes not support resize
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3Dqcow2 size=3D67108864 preallocation=
=3Dmetadata
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1904223020..ec47c2216a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -273,6 +273,7 @@
 256 rw auto quick
 257 rw
 258 rw quick
+259 rw auto quick
 260 rw quick
 261 rw
 262 rw quick migration
--=20
2.24.1


