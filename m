Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A7AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D090620702
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/5waZSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D090620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUQE-0000w4-3v
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCM-0003en-BS
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCF-000372-AJ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBB65MnNg9u2PaUFPswO5ijYUE99YGGjTJSGMEtR2ZQ=;
 b=X/5waZSsERd9s6mbdb9ywiQluBOi7XbWm0cUyBwEzDIxGi1z0fjJrtQcRCvgT/5O83AAiq
 PblADjOlWmo2yevhesDT+2G0zmGKEYKb/jPVB++IKTCXWgqHdzTf80fqa4BJgBbvrMShL+
 wssWWcUe7CSqLW52Rtx0F5sZDzDHC5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-7WR0Q20VMzOXILzI3k7m1A-1; Mon, 06 Jul 2020 12:42:10 -0400
X-MC-Unique: 7WR0Q20VMzOXILzI3k7m1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42813107ACF2;
 Mon,  6 Jul 2020 16:42:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E00D5B3A7E;
 Mon,  6 Jul 2020 16:42:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/53] coverity: provide Coverity-friendly MIN_CONST and
 MAX_CONST
Date: Mon,  6 Jul 2020 12:41:13 -0400
Message-Id: <20200706164155.24696-12-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
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

From: Eric Blake <eblake@redhat.com>

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
Message-Id: <20200629162804.1096180-1-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/osdep.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0d26a1b9bd..0fc206ae61 100644
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
2.26.2



