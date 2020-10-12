Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92303C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1731B2074A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGK3euXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1731B2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwPB-00023a-79
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRwJT-0004s6-Sz
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRwJS-0000PD-Az
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602503301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=Nl2mYE5C9KesEpnCJiQEwmCtQkvzm/jntj+i9mgaEPE=;
 b=BGK3euXlufwWnyzd8lUTPq0NtHw+mJ0DIax/eARCIgLaoAwrd5unv/cmmlGLxMDcA3S/s9
 Uagd2L+14e2BQWjQzmn2bBsnOrO3chDh94dvFgRN882OaeVN/dkNgT3AYv12yfFmuawzAF
 x5+7mHkDTB2WKTsHoHflS26L574U+wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-iHAWrhpUPhmTd1BJbNyt6Q-1; Mon, 12 Oct 2020 07:48:19 -0400
X-MC-Unique: iHAWrhpUPhmTd1BJbNyt6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 080271019624
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 11:48:19 +0000 (UTC)
Received: from thuth.com (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19E5A5C22B;
 Mon, 12 Oct 2020 11:48:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/libqtest: Fix detection of architecture for
 binaries without path
Date: Mon, 12 Oct 2020 13:48:16 +0200
Message-Id: <20201012114816.43546-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqtest.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 58f58e1ece..7cbcc77fdd 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -830,9 +830,14 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
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


