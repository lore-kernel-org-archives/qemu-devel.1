Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FDCC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A0620659
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjUUBiyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A0620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oYE-0005TM-RJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oSX-0004f0-St
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oSW-0007kw-JL
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33724
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oSW-0007kc-GA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582215232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uo7IzQcHLLPvInEIDQM2gitcHRMOb4KBi9jO0ZWKgM=;
 b=SjUUBiyS9GZUeL5R/pqPtU6gVJT8OSUAExMNvcedUrwkJhjM86Ic8p9Bmu77LQ3uoEn/kg
 wygWKEzhmjeXiJ6Pt+NyaXIMBpOZiEuZBqJp69vM0tUlbpWeSLqIB9e3WNTEIIrndWbUhf
 Upxs2QLamKorelJqv7+5WMQQFn/jyrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-mT73dgz0PO-s3A6N2w84DA-1; Thu, 20 Feb 2020 11:13:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EBA61005512;
 Thu, 20 Feb 2020 16:13:48 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18CCC5C1B0;
 Thu, 20 Feb 2020 16:13:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/18] iotests: Test snapshot -l field separation
Date: Thu, 20 Feb 2020 17:07:10 +0100
Message-Id: <20200220160710.533297-19-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mT73dgz0PO-s3A6N2w84DA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test that all fields in "qemu-img snapshot -l"s output are
separated by spaces.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200117105859.241818-3-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[mreitz: Renamed test from 284 to 286]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/286     | 76 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/286.out |  8 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 85 insertions(+)
 create mode 100755 tests/qemu-iotests/286
 create mode 100644 tests/qemu-iotests/286.out

diff --git a/tests/qemu-iotests/286 b/tests/qemu-iotests/286
new file mode 100755
index 0000000000..f14445ba4a
--- /dev/null
+++ b/tests/qemu-iotests/286
@@ -0,0 +1,76 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img snapshot -l
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
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto file
+# Internal snapshots are (currently) impossible with refcount_bits=3D1,
+# and generally impossible with external data files
+_unsupported_imgopts 'refcount_bits=3D1[^0-9]' data_file
+
+_make_test_img 64M
+
+# Should be so long as to take up the whole field width
+sn_name=3Dabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
+
+# More memory will give us a larger VM state, i.e. one above 1 MB.
+# This way, we get a number with a decimal point.
+qemu_comm_method=3Dmonitor _launch_qemu -m 512 "$TEST_IMG"
+
+_send_qemu_cmd $QEMU_HANDLE "savevm $sn_name" '(qemu)'
+_send_qemu_cmd $QEMU_HANDLE 'quit' '(qemu)'
+wait=3Dyes _cleanup_qemu
+
+# Check that all fields are separated by spaces.
+# We first collapse all space sequences into one space each;
+# then we turn every space-separated field into a '.';
+# and finally, we name the '.'s so the output is not just a confusing
+# sequence of dots.
+
+echo 'Output structure:'
+$QEMU_IMG snapshot -l "$TEST_IMG" | tail -n 1 | tr -s ' ' \
+    | sed -e 's/\S\+/./g' \
+    | sed -e 's/\./(snapshot ID)/' \
+          -e 's/\./(snapshot name)/' \
+          -e 's/\./(VM state size value)/' \
+          -e 's/\./(VM state size unit)/' \
+          -e 's/\./(snapshot date)/' \
+          -e 's/\./(snapshot time)/' \
+          -e 's/\./(VM clock)/'
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/286.out b/tests/qemu-iotests/286.out
new file mode 100644
index 0000000000..39ff07e12c
--- /dev/null
+++ b/tests/qemu-iotests/286.out
@@ -0,0 +1,8 @@
+QA output created by 286
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
+(qemu) quit
+Output structure:
+(snapshot ID) (snapshot name) (VM state size value) (VM state size unit) (=
snapshot date) (snapshot time) (VM clock)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b17711d17d..0317667695 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -292,3 +292,4 @@
 281 rw quick
 283 auto quick
 284 rw
+286 rw quick
--=20
2.24.1


