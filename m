Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894CDC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54533206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4Odnk50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54533206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0PP6-0003lu-IS
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0POQ-0003Gd-QR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:11:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0POO-0006yC-LH
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595941899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gVQ8qgCj17cx9v5D9tR3+t6OmTfBo0qCDtQrd09v7eI=;
 b=Y4Odnk50clu14O3uCNLDaKXObupn3n6YLiw/93Nj9y9a1zCCbfl2muZzk6BtfHqtsDFiYF
 IugSd59//W1ApVLHADtZPm9rb3KtGcIRYdCha4Y+EB31SBE4cff0t3hahjYd2gENK9jlbK
 dqL369XVL/Ygd8L0xEhKMYwaSvLZUjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-Cvb8Zaw-PtGvt2jiiCHHrg-1; Tue, 28 Jul 2020 09:11:37 -0400
X-MC-Unique: Cvb8Zaw-PtGvt2jiiCHHrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DBCD80183C;
 Tue, 28 Jul 2020 13:11:36 +0000 (UTC)
Received: from localhost (ovpn-112-145.ams2.redhat.com [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF0E46FEC6;
 Tue, 28 Jul 2020 13:11:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2] iotests/197: Fix for non-qcow2 formats
Date: Tue, 28 Jul 2020 15:11:34 +0200
Message-Id: <20200728131134.902519-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:02:02
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While 197 is very much a qcow2 test, and it looks like the partial
cluster case at the end (introduced in b0ddcbbb36a66a6) is specifically
a qcow2 case, the whole test scripts actually marks itself to work with
generic formats (and generic protocols, even).

Said partial cluster case happened to work with non-qcow2 formats as
well (mostly by accident), but 1855536256 broke that, because it sets
the compat option, which does not work for non-qcow2 formats.

So go the whole way and force IMGFMT=qcow2 and IMGPROTO=file, as done in
other places in this test.

Fixes: 1855536256eb0a5708b04b85f744de69559ea323
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
v2:
- Add --no-opts to the _make_test_img line so this passes for formats
  that have some default non-empty $IMGOPTS (like vmdk)
---
 tests/qemu-iotests/197     | 8 +++++---
 tests/qemu-iotests/197.out | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 121959a09c..a161c89816 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -114,9 +114,11 @@ echo
 
 # Force compat=1.1, because writing zeroes on a v2 image without a
 # backing file would just result in an unallocated cluster
-_make_test_img -o compat=1.1 1024
-$QEMU_IO -f $IMGFMT -C -c 'read 0 1024' "$TEST_IMG" | _filter_qemu_io
-$QEMU_IO -f $IMGFMT -c map "$TEST_IMG"
+# (Also, note that this is really a pure qcow2 test.)
+IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
+    _make_test_img --no-opts -o compat=1.1 1024
+$QEMU_IO -f qcow2 -C -c 'read 0 1024' "$TEST_WRAP" | _filter_qemu_io
+$QEMU_IO -f qcow2 -c map "$TEST_WRAP"
 _check_test_img
 
 # success, all done
diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
index 7ca46be6e4..ad414c3b0e 100644
--- a/tests/qemu-iotests/197.out
+++ b/tests/qemu-iotests/197.out
@@ -26,7 +26,7 @@ Images are identical.
 
 === Partial final cluster ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024
+Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=1024
 read 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
-- 
2.26.2


