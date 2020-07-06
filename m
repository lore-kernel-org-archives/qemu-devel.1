Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCCDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999E5206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkLoWLLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999E5206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUFF-00008H-R3
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC5-0003FA-Hf
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35880
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC3-00034b-LZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7Vqy0cUQDaGat8HGCJqia6EBQonR/DoDUwTP+bhjxY=;
 b=CkLoWLLudHmVNFQjucI6Xp1qBQcE6cnZiMHkrMVLcvhP5j3DaunXJdRgtOd9DxZ3H7DOyW
 KYPYI9f6NyiNs5JBpZPqz+IrrtxNsWNxSVWOHbjEXgzwomwNeoFFHr1XoLTEpEurpPC07K
 +F3E9atakRiKJPohE0eiePP6iopxtic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-CMyXuF1PO7KopQsrA5jfhA-1; Mon, 06 Jul 2020 12:42:08 -0400
X-MC-Unique: CMyXuF1PO7KopQsrA5jfhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A11EC1A0;
 Mon,  6 Jul 2020 16:42:07 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B20121002380;
 Mon,  6 Jul 2020 16:42:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/53] target/i386: set SSE FTZ in correct floating-point state
Date: Mon,  6 Jul 2020 12:41:10 -0400
Message-Id: <20200706164155.24696-9-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
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
Cc: Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The code to set floating-point state when MXCSR changes calls
set_flush_to_zero on &env->fp_status, so affecting the x87
floating-point state rather than the SSE state.  Fix to call it for
&env->sse_status instead.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2006252357170.3832@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 71cec3962f..ec5b9db8b9 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -2972,7 +2972,7 @@ void update_mxcsr_status(CPUX86State *env)
     set_flush_inputs_to_zero((mxcsr & SSE_DAZ) ? 1 : 0, &env->sse_status);
 
     /* set flush to zero */
-    set_flush_to_zero((mxcsr & SSE_FZ) ? 1 : 0, &env->fp_status);
+    set_flush_to_zero((mxcsr & SSE_FZ) ? 1 : 0, &env->sse_status);
 }
 
 void helper_ldmxcsr(CPUX86State *env, uint32_t val)
-- 
2.26.2



