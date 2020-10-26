Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D489C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3599223AC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj0yF21U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3599223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzSW-0007Wt-P7
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOp-0002QL-Qo
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOl-0006aN-DS
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=+LT4RxKVcAVhYRwncs0L+BQ1wRj6aHo9PM7a1P0TdeU=;
 b=Cj0yF21UHXYtFH8YURMQELE7Oc/ni9R7LZHzsgAG/T68tzTtNw1xOMHCYVc7QoSt2jTHJy
 YU6ijikwSMdnzZW0dUZASSau+5Xau9R1wvoBeYvb385SVDPsRMkHoH2Ibf1VlAMY0JQaqN
 Kw45SOHjPCCOTLVR2YnZeaL7QSBSK/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-IPZHlRcPPEa5doNrH5yJmw-1; Mon, 26 Oct 2020 06:06:40 -0400
X-MC-Unique: IPZHlRcPPEa5doNrH5yJmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBE295A09A;
 Mon, 26 Oct 2020 10:06:38 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE0A38B843;
 Mon, 26 Oct 2020 10:06:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/31] tests/qtest/libqtest: Fix detection of architecture for
 binaries without path
Date: Mon, 26 Oct 2020 11:06:03 +0100
Message-Id: <20201026100632.212530-3-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qtests can be run directly by specifying the QEMU binary with the
QTEST_QEMU_BINARY environment variable, for example:

 $ QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/qtest/test-hmp

However, if you specify a binary without a path, for example with
QTEST_QEMU_BINARY=qemu-system-x86_64 if the QEMU binary is in your
$PATH, then the test currently simply crashes.

Let's try a little bit smarter here by looking for the final '-'
instead of the slash.

Message-Id: <20201012114816.43546-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqtest.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 08929f5ff6..b9ff29055b 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -870,9 +870,14 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
 const char *qtest_get_arch(void)
 {
     const char *qemu = qtest_qemu_binary();
-    const char *end = strrchr(qemu, '/');
+    const char *end = strrchr(qemu, '-');
 
-    return end + strlen("/qemu-system-");
+    if (!end) {
+        fprintf(stderr, "Can't determine architecture from binary name.\n");
+        abort();
+    }
+
+    return end + 1;
 }
 
 bool qtest_get_irq(QTestState *s, int num)
-- 
2.18.2


