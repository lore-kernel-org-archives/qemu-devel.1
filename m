Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7FFC433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4F9206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8VCeyDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4F9206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Pzf-0001mg-Je
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0PyT-0008JK-G6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:48:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0PyR-0003ts-Ux
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595944135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlMrdIXLzJJirKfVg8qQNIPA0qZScZa3KKwIAXzhr38=;
 b=e8VCeyDRKvBPctafUpDTOCL3LnIrpHRDueQx9cfemLPoTj+sdnei5shhMkZ+rJl6m7FoBx
 cK2j92zpSH7/7hrwffoZ1Vju6eQMK/ttrKrfvabqZGavH0hwPCs1npI226gqks+E3tAwT2
 1J3Zin96MnSrdJfAI2L+Ggv9vMCJ/aQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-YHMlM3P8NyKh_jw8RZc57w-1; Tue, 28 Jul 2020 09:48:51 -0400
X-MC-Unique: YHMlM3P8NyKh_jw8RZc57w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCD3F801A03;
 Tue, 28 Jul 2020 13:48:48 +0000 (UTC)
Received: from localhost (ovpn-112-145.ams2.redhat.com [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71A9519C4F;
 Tue, 28 Jul 2020 13:48:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/3] iotests/197: Fix for non-qcow2 formats
Date: Tue, 28 Jul 2020 15:48:40 +0200
Message-Id: <20200728134840.1557546-4-mreitz@redhat.com>
In-Reply-To: <20200728134840.1557546-1-mreitz@redhat.com>
References: <20200728134840.1557546-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
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
       ("iotests/197: Fix for compat=0.10")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200728131134.902519-1-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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


