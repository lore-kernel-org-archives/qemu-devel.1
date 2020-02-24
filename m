Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0A6C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F3520838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+x4Gau+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F3520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HMO-0001be-WF
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6HLV-0000uJ-Mr
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6HLT-0003FX-Oe
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:16:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57681
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6HLT-0003E8-D7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582564598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TyMCqejM+7TBzqzeLoooX5dQqYB4s2A/WwyaKEswkHk=;
 b=B+x4Gau+9AjON/UjUtg2gcK89vYQb5y/f2Izk3eOfQ0y6IeNy19I46oUn13KMlvz3rZxEv
 XQXQfFuFhchHEBoHtgvXzF0deSEenfU0ZeniXI/FvmKu7Zc7EmOwXb6NPhjqXGOR8o5YYa
 En9w+UKB1vH4z/0fYDVUXcJYWwjhTYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-zTwPwY0dMZKx2SlZTY7a0Q-1; Mon, 24 Feb 2020 12:16:34 -0500
X-MC-Unique: zTwPwY0dMZKx2SlZTY7a0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8701D13E4;
 Mon, 24 Feb 2020 17:16:33 +0000 (UTC)
Received: from localhost (unknown [10.36.118.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B4085D9CD;
 Mon, 24 Feb 2020 17:16:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests: Fix cleanup path in some tests
Date: Mon, 24 Feb 2020 18:16:31 +0100
Message-Id: <20200224171631.384314-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some iotests leave behind some external data file when run for qcow2
with -o data_file.  Fix that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/085 | 1 +
 tests/qemu-iotests/087 | 6 ++++++
 tests/qemu-iotests/279 | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 46981dbb64..dd3c993a2d 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -39,6 +39,7 @@ SNAPSHOTS=3D10
 _cleanup()
 {
     _cleanup_qemu
+    _cleanup_test_img
     for i in $(seq 1 ${SNAPSHOTS})
     do
         _rm_test_img "${TEST_DIR}/${i}-${snapshot_virt0}"
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index d6c8613419..bdfdad3454 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -26,6 +26,12 @@ echo "QA output created by $seq"
=20
 status=3D1=09# failure is the default!
=20
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
index 30d29b1cb2..75a4747e6b 100755
--- a/tests/qemu-iotests/279
+++ b/tests/qemu-iotests/279
@@ -26,7 +26,7 @@ status=3D1=09# failure is the default!
 _cleanup()
 {
     _cleanup_test_img
-    rm -f "$TEST_IMG.mid"
+    _rm_test_img "$TEST_IMG.mid"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
--=20
2.24.1


