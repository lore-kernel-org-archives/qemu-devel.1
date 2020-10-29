Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6F6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B92206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJjaNwdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B92206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY74D-0006kQ-N9
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 08:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kY72q-0006J9-Ri
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kY72p-0004OO-8k
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603974522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=UsIsY9bFqR9LQIaBu5c+5NbzHTcequ/Ko5EicdfTAZw=;
 b=VJjaNwdLGX//2JQD6fGuZfjvQWvuhw1vegpf4zWPx6bftgqiiccOZyIxnOlHhmETFziSHB
 CgfIXT4uc/Aocaym45ETp7Lhuue2OM68DFpD5hTDlfsFE9tijk3xOKDET0GZ6YjCjP5DFc
 Oh2EuKHm4Lwk2IEPujPTq/0CQ3Uf3+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-iq7vxyPMMBqOn0q-OtLlXQ-1; Thu, 29 Oct 2020 08:28:38 -0400
X-MC-Unique: iq7vxyPMMBqOn0q-OtLlXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 685E31899981;
 Thu, 29 Oct 2020 12:28:37 +0000 (UTC)
Received: from thuth.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26A93610AF;
 Thu, 29 Oct 2020 12:28:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Richard Henderson <rth@twiddle.net>,
	qemu-devel@nongnu.org
Subject: [PATCH] tcg/optimize: Add fallthrough annotations
Date: Thu, 29 Oct 2020 13:28:33 +0100
Message-Id: <20201029122833.195420-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to compile this file with -Werror=implicit-fallthrough,
we need to add some fallthrough annotations to the case statements
that might fall through. Unfortunately, the typical "/* fallthrough */"
comments do not work here as expected since some case labels are
wrapped in macros and the compiler fails to match the comments in
this case. But using __attribute__((fallthrough)) seems to work fine,
so let's use that instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tcg/optimize.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 220f4601d5..c2768c9770 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -26,6 +26,12 @@
 #include "qemu/osdep.h"
 #include "tcg/tcg-op.h"
 
+#if __has_attribute(fallthrough)
+# define fallthrough() __attribute__((fallthrough))
+#else
+# define fallthrough() do {} while (0)
+#endif
+
 #define CASE_OP_32_64(x)                        \
         glue(glue(case INDEX_op_, x), _i32):    \
         glue(glue(case INDEX_op_, x), _i64)
@@ -855,6 +861,7 @@ void tcg_optimize(TCGContext *s)
             if ((arg_info(op->args[1])->mask & 0x80) != 0) {
                 break;
             }
+            fallthrough();
         CASE_OP_32_64(ext8u):
             mask = 0xff;
             goto and_const;
@@ -862,6 +869,7 @@ void tcg_optimize(TCGContext *s)
             if ((arg_info(op->args[1])->mask & 0x8000) != 0) {
                 break;
             }
+            fallthrough();
         CASE_OP_32_64(ext16u):
             mask = 0xffff;
             goto and_const;
@@ -869,6 +877,7 @@ void tcg_optimize(TCGContext *s)
             if ((arg_info(op->args[1])->mask & 0x80000000) != 0) {
                 break;
             }
+            fallthrough();
         case INDEX_op_ext32u_i64:
             mask = 0xffffffffU;
             goto and_const;
@@ -886,6 +895,7 @@ void tcg_optimize(TCGContext *s)
             if ((arg_info(op->args[1])->mask & 0x80000000) != 0) {
                 break;
             }
+            fallthrough();
         case INDEX_op_extu_i32_i64:
             /* We do not compute affected as it is a size changing op.  */
             mask = (uint32_t)arg_info(op->args[1])->mask;
-- 
2.18.2


