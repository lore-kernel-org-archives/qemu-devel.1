Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6CDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3663925599
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbZGYXSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3663925599
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpweY-0005du-Hc
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpwdi-0004lg-G0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:28:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpwdg-0005Cq-De
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593448091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yWJbwWNhf3dmWGkZrzakTcTSU0KHFsyqtUkotr0cKFU=;
 b=IbZGYXSSx8u8vjO0lEFOypjbHKezlezU9X5Z0x4An0n5qJC3FpybFY57xdz6baqJZedpr5
 gaDbKnR8wztFW8fsa/DtaX0J2sXOB8L5ebmDEIVYz4I5Gpak6jclNVNSU4Y2Nd9YiQQe0Y
 Ng9fCb5SU0Mhr0rE+KHV86YHY0xE2c8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-GobT2k5TP9K5Tz-_99_jXA-1; Mon, 29 Jun 2020 12:28:07 -0400
X-MC-Unique: GobT2k5TP9K5Tz-_99_jXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55B61100CCC0;
 Mon, 29 Jun 2020 16:28:06 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0622D7166E;
 Mon, 29 Jun 2020 16:28:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] coverity: provide Coverity-friendly MIN_CONST and MAX_CONST
Date: Mon, 29 Jun 2020 11:28:04 -0500
Message-Id: <20200629162804.1096180-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity has problems seeing through __builtin_choose_expr, which
result in it abandoning analysis of later functions that utilize a
definition that used MIN_CONST or MAX_CONST, such as in qemu-file.c:

 50    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);

CID 1429992 (#1 of 1): Unrecoverable parse warning (PARSE_ERROR)1.
expr_not_constant: expression must have a constant value

As has been done in the past (see 07d66672), it's okay to dumb things
down when compiling for static analyzers.  (Of course, now the
syntax-checker has a false positive on our reference to
__COVERITY__...)

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: CID 1429992, CID 1429995, CID 1429997, CID 1429999
Signed-off-by: Eric Blake <eblake@redhat.com>
---

Improvements over Paolo's v1:
- proper use of ()
- add comment explaining the COVERITY section
- add indentation for easier read of #if/#else flow

 include/qemu/osdep.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0d26a1b9bd07..0fc206ae6154 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -250,7 +250,8 @@ extern int daemon(int, int);
  * Note that neither form is usable as an #if condition; if you truly
  * need to write conditional code that depends on a minimum or maximum
  * determined by the pre-processor instead of the compiler, you'll
- * have to open-code it.
+ * have to open-code it.  Sadly, Coverity is severely confused by the
+ * constant variants, so we have to dumb things down there.
  */
 #undef MIN
 #define MIN(a, b)                                       \
@@ -258,22 +259,28 @@ extern int daemon(int, int);
         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
         _a < _b ? _a : _b;                              \
     })
-#define MIN_CONST(a, b)                                         \
-    __builtin_choose_expr(                                      \
-        __builtin_constant_p(a) && __builtin_constant_p(b),     \
-        (a) < (b) ? (a) : (b),                                  \
-        ((void)0))
 #undef MAX
 #define MAX(a, b)                                       \
     ({                                                  \
         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
         _a > _b ? _a : _b;                              \
     })
-#define MAX_CONST(a, b)                                         \
+
+#ifdef __COVERITY__
+# define MIN_CONST(a, b) ((a) < (b) ? (a) : (b))
+# define MAX_CONST(a, b) ((a) > (b) ? (a) : (b))
+#else
+# define MIN_CONST(a, b)                                        \
+    __builtin_choose_expr(                                      \
+        __builtin_constant_p(a) && __builtin_constant_p(b),     \
+        (a) < (b) ? (a) : (b),                                  \
+        ((void)0))
+# define MAX_CONST(a, b)                                        \
     __builtin_choose_expr(                                      \
         __builtin_constant_p(a) && __builtin_constant_p(b),     \
         (a) > (b) ? (a) : (b),                                  \
         ((void)0))
+#endif

 /*
  * Minimum function that returns zero only if both values are zero.
-- 
2.27.0


