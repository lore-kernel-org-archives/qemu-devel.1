Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C5BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD7323EB0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlCX8aGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD7323EB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvXU-0002QB-RO
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvWb-0001yJ-JF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:16:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvWZ-0000SS-Cm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593443806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tp8TkNwE4jlHF1IieJap3SKJN8FO0CS0VG/Xrud81cc=;
 b=BlCX8aGNN9Fbe/sN9FoDkGKIZzidIRWI6Zp2FAwdDL+6TlzjDTbSxLsH85IJTo9CZ4oSLV
 DrjAS3uHfffQONQGz2TsGGZB8Y4IMk3qz9PpydvFVGgc1YyEcoG29TooxRHKJXOSOz9ON/
 xJpqjdrk3UrVbOnN9SCX58TQWoyPxVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336--pt7TPiyNyODASwlZ0MQWQ-1; Mon, 29 Jun 2020 11:16:44 -0400
X-MC-Unique: -pt7TPiyNyODASwlZ0MQWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86FB9800D5C;
 Mon, 29 Jun 2020 15:16:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D32360BEC;
 Mon, 29 Jun 2020 15:16:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] coverity: provide Coverity-friendly MIN_CONST and MAX_CONST
Date: Mon, 29 Jun 2020 11:16:42 -0400
Message-Id: <20200629151642.11974-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity's parser chokes on __builtin_choose_expr inside a constant
expression.  Since it is used only to raise compilation errors for
non-constant arguments, we can just assume there are no such errors
in the Coverity runs, and define MIN_CONST and MAX_CONST to the
"classic" ternary-operator-based definitions of minimum and maximum.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/osdep.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0d26a1b9bd..4f4d4a3060 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -258,22 +258,29 @@ extern int daemon(int, int);
         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
         _a < _b ? _a : _b;                              \
     })
-#define MIN_CONST(a, b)                                         \
-    __builtin_choose_expr(                                      \
-        __builtin_constant_p(a) && __builtin_constant_p(b),     \
-        (a) < (b) ? (a) : (b),                                  \
-        ((void)0))
+
 #undef MAX
 #define MAX(a, b)                                       \
     ({                                                  \
         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
         _a > _b ? _a : _b;                              \
     })
+
+#ifdef __COVERITY__
+#define MIN_CONST(a, b) (a) < (b) ? (a) : (b)
+#define MAX_CONST(a, b) (a) > (b) ? (a) : (b)
+#else
+#define MIN_CONST(a, b)                                         \
+    __builtin_choose_expr(                                      \
+        __builtin_constant_p(a) && __builtin_constant_p(b),     \
+        (a) < (b) ? (a) : (b),                                  \
+        ((void)0))
 #define MAX_CONST(a, b)                                         \
     __builtin_choose_expr(                                      \
         __builtin_constant_p(a) && __builtin_constant_p(b),     \
         (a) > (b) ? (a) : (b),                                  \
         ((void)0))
+#endif
 
 /*
  * Minimum function that returns zero only if both values are zero.
-- 
2.26.2


