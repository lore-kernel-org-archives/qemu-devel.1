Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDA1206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGlsxl5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDA1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTZY-0000Op-O8
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8x-0007xb-7M
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8t-00012O-Mp
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDBHQtVitR2UF3gM0easaFDJXNK3KOw8227wlXl8uXk=;
 b=gGlsxl5U1NMMBvZiOpZ8qAhGx19aSQWwmAYZNwsVxHJmb+SsUkCCS/kaiUtOONKl/dY0SI
 OnqrfUJr35WT53kDbgJtutb2oOklBcageSX8U9VDPFxa/qK7Rhgxv6PA79p9yaVlaaF6Zt
 wa2y/G5BsN+ObJTUxUG3i+dQajGquuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-Chn9K9sdN4Cp-6v131tnIw-1; Thu, 11 Jun 2020 15:45:36 -0400
X-MC-Unique: Chn9K9sdN4Cp-6v131tnIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CB078064DD;
 Thu, 11 Jun 2020 19:45:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2053997B12;
 Thu, 11 Jun 2020 19:45:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 055/115] target/i386: fix fscale handling of rounding precision
Date: Thu, 11 Jun 2020 15:43:49 -0400
Message-Id: <20200611194449.31468-56-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The fscale implementation uses floatx80_scalbn for the final scaling
operation.  floatx80_scalbn ends up rounding the result using the
dynamic rounding precision configured for the FPU.  But only a limited
set of x87 floating-point instructions are supposed to respect the
dynamic rounding precision, and fscale is not in that set.  Fix the
implementation to save and restore the rounding precision around the
call to floatx80_scalbn.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005070045430.18350@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c          |  3 +++
 tests/tcg/i386/test-i386-fscale.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 72d1e77eb0..4d14c1ca24 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1001,7 +1001,10 @@ void helper_fscale(CPUX86State *env)
         }
     } else {
         int n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
+        signed char save = env->fp_status.floatx80_rounding_precision;
+        env->fp_status.floatx80_rounding_precision = 80;
         ST0 = floatx80_scalbn(ST0, n, &env->fp_status);
+        env->fp_status.floatx80_rounding_precision = save;
     }
 }
 
diff --git a/tests/tcg/i386/test-i386-fscale.c b/tests/tcg/i386/test-i386-fscale.c
index b953e7c563..d23b3cfeec 100644
--- a/tests/tcg/i386/test-i386-fscale.c
+++ b/tests/tcg/i386/test-i386-fscale.c
@@ -8,6 +8,8 @@ union u {
     long double ld;
 };
 
+volatile long double ld_third = 1.0L / 3.0L;
+volatile long double ld_four_thirds = 4.0L / 3.0L;
 volatile union u ld_invalid_1 = { .s = { 1, 1234 } };
 volatile union u ld_invalid_2 = { .s = { 0, 1234 } };
 volatile union u ld_invalid_3 = { .s = { 0, 0x7fff } };
@@ -91,5 +93,16 @@ int main(void)
         printf("FAIL: fscale finite down inf\n");
         ret = 1;
     }
+    /* Set round-to-nearest with single-precision rounding.  */
+    cw = cw & ~0xf00;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (ld_third), "u" (2.0L));
+    cw = cw | 0x300;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    if (ld_res != ld_four_thirds) {
+        printf("FAIL: fscale single-precision\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.26.2



