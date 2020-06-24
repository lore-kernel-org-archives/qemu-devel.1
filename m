Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A186C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5058F2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8Hmfn43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5058F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo38v-0002sS-Fz
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zo-0001Dd-K1
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zm-0001Kf-J6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/f+g1sL79bkK2ZcWOndgrRFIJ4GVzXBxsrToUJIrww=;
 b=g8Hmfn43bLAarDbAHKT+kk48fj7Up9VeL8rrcnCRWNdFfjH9xPvTqli+hamdknmJKVcuw3
 76VuqvFkNdCTY029Jy6kaqZ4ocquz8x8oU9UgjOGk1N2/1Ny4DxLT78u9W4m5+MGWUMGF8
 dHh4qk7OXb9Y1IA7/+j3qxMwrwe+UtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-xbfjNjHyNnm3LLxNatbclw-1; Wed, 24 Jun 2020 06:51:07 -0400
X-MC-Unique: xbfjNjHyNnm3LLxNatbclw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A789A18A8222;
 Wed, 24 Jun 2020 10:51:06 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A4CD5D9C5;
 Wed, 24 Jun 2020 10:51:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/31] softfloat: fix floatx80 remainder pseudo-denormal check
 for zero
Date: Wed, 24 Jun 2020 06:50:33 -0400
Message-Id: <20200624105048.375353-16-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The floatx80 remainder implementation ignores the high bit of the
significand when checking whether an operand (numerator) with zero
exponent is zero.  This means it mishandles a pseudo-denormal
representation of 0x1p-16382L by treating it as zero.  Fix this by
checking the whole significand instead.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <alpine.DEB.2.21.2006081655180.23637@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b7dcf4d6c3..f164b5c0ad 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5741,7 +5741,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         normalizeFloatx80Subnormal( bSig, &bExp, &bSig );
     }
     if ( aExp == 0 ) {
-        if ( (uint64_t) ( aSig0<<1 ) == 0 ) return a;
+        if ( aSig0 == 0 ) return a;
         normalizeFloatx80Subnormal( aSig0, &aExp, &aSig0 );
     }
     bSig |= UINT64_C(0x8000000000000000);
-- 
2.26.2



