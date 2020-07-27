Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B63C433F7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302C32083B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exHximD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302C32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04JM-0007Nd-F1
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k04Gr-0003Bd-OH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:38:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k04Go-0001yR-MZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9eCuHo27xQCJSX8p6MpgkUs3+FTCb3BEl2LXTc7dKc=;
 b=exHximD9SM9TrHC8rO8e7Cljzk6e/Xaui42x79UOrAeynfNtUyF0XY4//wX1eZiUZ6Nim7
 /HDXznji0JE9bS3b8dcETQvJET9ktlrT7A4v1dmxASovOh7ZibIPA5KTq+yGFFinR4BhjX
 pXPVHCU8YnBlpZ33aowWI9bD29OdSIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-JLNIBcLONhuD6bF6gK7EAQ-1; Mon, 27 Jul 2020 10:38:21 -0400
X-MC-Unique: JLNIBcLONhuD6bF6gK7EAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB1EB1005510;
 Mon, 27 Jul 2020 14:38:20 +0000 (UTC)
Received: from localhost (ovpn-113-45.ams2.redhat.com [10.36.113.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EF966FEC6;
 Mon, 27 Jul 2020 14:38:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/3] iotests/197: Fix for compat=0.10
Date: Mon, 27 Jul 2020 16:38:12 +0200
Message-Id: <20200727143812.1101547-4-mreitz@redhat.com>
In-Reply-To: <20200727143812.1101547-1-mreitz@redhat.com>
References: <20200727143812.1101547-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

Writing zeroes to a qcow2 v2 images without a backing file results in an
unallocated cluster as of 61b3043965.  197 has a test for COR-ing a
cluster on an image without a backing file, which means that the data
will be zero, so now on a v2 image that cluster will just stay
unallocated, and so the test fails.  Just force compat=1.1 for that
particular case to enforce the cluster to get allocated.

Fixes: 61b3043965fe3552ee2684a97e7cc809ca7a71b3
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200727135237.1096841-1-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/197 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 95f05b0e34..121959a09c 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -112,7 +112,9 @@ echo
 echo '=== Partial final cluster ==='
 echo
 
-_make_test_img 1024
+# Force compat=1.1, because writing zeroes on a v2 image without a
+# backing file would just result in an unallocated cluster
+_make_test_img -o compat=1.1 1024
 $QEMU_IO -f $IMGFMT -C -c 'read 0 1024' "$TEST_IMG" | _filter_qemu_io
 $QEMU_IO -f $IMGFMT -c map "$TEST_IMG"
 _check_test_img
-- 
2.26.2


