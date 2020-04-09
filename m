Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3F0C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CF8206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iONQkcJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CF8206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMcZr-0006Q9-0r
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 15:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jMcZ8-0005pb-Hd
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jMcZ7-0006cE-D1
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:10:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47406
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jMcZ7-0006bz-A8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586459417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E0exH5PxCQ1uU1tVH0yuzqFGbBKfr/Bn6feFKg50lkw=;
 b=iONQkcJcKRsW4Fiy0LmshfOm0kT/X4hm7SxawiPU0cDoGpBD/bWyxKnN6fSWsXEL4q7IFU
 h3gKUl2nlKF1Mh/EfVW/t7oJ4M51PGU1gMUWEJYZFLWw4lSPxw9C3mxMPtmWsE8zMbkSJC
 XMLn2ilmCiz3Pd3OgGnI4Igfv3/e3qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-xReme0GNNDOBX7mlG3BXvQ-1; Thu, 09 Apr 2020 15:10:11 -0400
X-MC-Unique: xReme0GNNDOBX7mlG3BXvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F1D6107ACCA;
 Thu,  9 Apr 2020 19:10:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04F1E60BFB;
 Thu,  9 Apr 2020 19:10:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for 5.0] qemu-iotests: allow qcow2 external discarded clusters
 to contain stale data
Date: Thu,  9 Apr 2020 15:10:06 -0400
Message-Id: <20200409191006.24429-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test 244 checks the expected behavior of qcow2 external data files
with respect to zero and discarded clusters.  Filesystems however
are free to ignore discard requests, and this seems to be the
case for overlayfs.  Relax the tests to skip checks on the
external data file for discarded areas, which implies not using
qemu-img compare in the data_file_raw=3Don case.

This fixes docker tests on RHEL8.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/244     | 10 ++++++++--
 tests/qemu-iotests/244.out |  9 ++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index 2ec1815e6f..efe3c0428b 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -143,7 +143,6 @@ $QEMU_IO -c 'read -P 0 0 1M' \
 echo
 $QEMU_IO -c 'read -P 0 0 1M' \
          -c 'read -P 0x11 1M 1M' \
-         -c 'read -P 0 2M 2M' \
          -c 'read -P 0x11 4M 1M' \
          -c 'read -P 0 5M 1M' \
          -f raw "$TEST_IMG.data" |
@@ -180,8 +179,15 @@ $QEMU_IO -c 'read -P 0 0 1M' \
          -f $IMGFMT "$TEST_IMG" |
          _filter_qemu_io
=20
+# Discarded clusters are only marked as such in the qcow2 metadata, but
+# they can contain stale data in the external data file.  Instead, zero
+# clusters must be zeroed in the external data file too.
 echo
-$QEMU_IMG compare "$TEST_IMG" "$TEST_IMG.data"
+$QEMU_IO -c 'read -P 0 0 1M' \
+         -c 'read -P 0x11 1M 1M' \
+         -c 'read -P 0 3M 3M' \
+         -f raw "$TEST_IMG".data |
+         _filter_qemu_io
=20
 echo -n "qcow2 file size after I/O: "
 du -b $TEST_IMG | cut -f1
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index e6f4dc7993..4afa32026d 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -74,8 +74,6 @@ read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 2097152/2097152 bytes at offset 2097152
-2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1048576/1048576 bytes at offset 4194304
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1048576/1048576 bytes at offset 5242880
@@ -108,7 +106,12 @@ read 1048576/1048576 bytes at offset 1048576
 read 4194304/4194304 bytes at offset 2097152
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
-Images are identical.
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 3145728/3145728 bytes at offset 3145728
+3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2 file size after I/O: 327680
=20
 =3D=3D=3D bdrv_co_block_status test for file and offset=3D0 =3D=3D=3D
--=20
2.18.2


