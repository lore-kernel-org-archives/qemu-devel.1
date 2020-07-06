Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEEFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B96206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rk3ykQQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B96206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUOX-0005qO-Kh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCM-0003fA-EW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41702
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCI-00037u-2z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mo/vHzn13bWMwYHSzkNfUXN+2hSv+iJGMj9zWWsqq4Q=;
 b=Rk3ykQQiCs7Nc0Viy9zfOCiBmR93W3VPEZMN0RC/UqYJfkiFIhkhOlxFV62ner+QFcSwi7
 3scTwht1a6fuxs8GvSSAJIZPpQYzB8KJ3ScbI7Wi0FZnbc6tQiP30T/XsoYYV5oX9EM2Dc
 pwuSFLJbc2zlCaFpeQk3NECouq2bF6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-MzlNeYKAPa-45Iso1TdWBw-1; Mon, 06 Jul 2020 12:42:23 -0400
X-MC-Unique: MzlNeYKAPa-45Iso1TdWBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D81E81937FDD;
 Mon,  6 Jul 2020 16:42:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75CDD5F7D8;
 Mon,  6 Jul 2020 16:42:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/53] target/i386: implement undocumented "smsw r32" behavior
Date: Mon,  6 Jul 2020 12:41:32 -0400
Message-Id: <20200706164155.24696-31-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In 32-bit mode, the higher 16 bits of the destination
register are undefined.  In practice CR0[31:0] is stored,
just like in 64-bit mode, so just remove the "if" that
currently differentiates the behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reported-by: Roman Bolshakov <r.bolshakov@yadro.com>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5ef72ff401..a1d31f09c1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7579,12 +7579,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         CASE_MODRM_OP(4): /* smsw */
             gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_CR0);
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, cr[0]));
-            if (CODE64(s)) {
-                mod = (modrm >> 6) & 3;
-                ot = (mod != 3 ? MO_16 : s->dflag);
-            } else {
-                ot = MO_16;
-            }
+            /*
+             * In 32-bit mode, the higher 16 bits of the destination
+             * register are undefined.  In practice CR0[31:0] is stored
+             * just like in 64-bit mode.
+             */
+            mod = (modrm >> 6) & 3;
+            ot = (mod != 3 ? MO_16 : s->dflag);
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 0xee: /* rdpkru */
-- 
2.26.2



