Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9501CC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0E420756
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW/9j/Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0E420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUNd-0006i2-G8
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUJG-0001Ko-CD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUJC-0001NW-Gt
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfjF74tp47ZpXNlY7HopEab86NvPE+ocIBvLVgpRnhI=;
 b=BW/9j/TipnE/MXfws6Ycl0OOU7879pdUBQOwsmXiCdyxIXVNzw8GyC+qrfV2K5aE14UZi9
 2a+dqhej/dhjRldqEA3o2umwjE6P3Ema4czGN/76C5IwIsYNfGRLVIVZvmVTUpgjWAJ66s
 KXSPdXWs1QeYzXjry9NpNb22LphBGpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-0lnEgvJxM0iLSC4E1QB2lA-1; Tue, 27 Oct 2020 15:06:59 -0400
X-MC-Unique: 0lnEgvJxM0iLSC4E1QB2lA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C46426124F;
 Tue, 27 Oct 2020 19:06:58 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BFEC60C07;
 Tue, 27 Oct 2020 19:06:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 10/20] iotests/046: Avoid renaming images
Date: Tue, 27 Oct 2020 20:05:50 +0100
Message-Id: <20201027190600.192171-11-mreitz@redhat.com>
In-Reply-To: <20201027190600.192171-1-mreitz@redhat.com>
References: <20201027190600.192171-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This generally does not work on non-file protocols.  It is better to
create the image with the final name from the start, and most tests do
this already.  Let 046 follow suit.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/046     | 5 +++--
 tests/qemu-iotests/046.out | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 88b3363c19..40a9f30087 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -47,6 +47,8 @@ size=128M
 echo
 echo "== creating backing file for COW tests =="
 
+TEST_IMG_SAVE=$TEST_IMG
+TEST_IMG="$TEST_IMG.base"
 _make_test_img $size
 
 backing_io()
@@ -67,8 +69,7 @@ backing_io()
 
 backing_io 0 32 write | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
 
-mv "$TEST_IMG" "$TEST_IMG.base"
-
+TEST_IMG=$TEST_IMG_SAVE
 _make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G
 
 echo
diff --git a/tests/qemu-iotests/046.out b/tests/qemu-iotests/046.out
index b022bcddd5..66ad987ab3 100644
--- a/tests/qemu-iotests/046.out
+++ b/tests/qemu-iotests/046.out
@@ -1,7 +1,7 @@
 QA output created by 046
 
 == creating backing file for COW tests ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 65536
-- 
2.26.2


