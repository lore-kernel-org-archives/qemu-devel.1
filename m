Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A08C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A6F2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ct1FZzov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A6F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k30NL-0003KO-NB
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k30Ji-00070j-T9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:01:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28653
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k30JY-0005SD-Qj
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596560483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TI0IEB99UqKTBYdPDe/N1xM4vdQ7QBL+iNqeyknjFuY=;
 b=Ct1FZzovWmW+5aHPiEALGk6z9KWKiRh1pTeLBgHzDoL4OF0UvocY/EKyw/7fL04mj/FDrA
 Xg+5sv9dh68AzJyLmhDaMcNZOTb2gxtMf4EUz7MmYRPSVSwIZH4ZqU8bXL9Dc6I42jFCNW
 wOmhk/QLNHzCNLRAnONCQKsruizPpm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-dRDdEXtjPsORUdurId5y5w-1; Tue, 04 Aug 2020 13:01:19 -0400
X-MC-Unique: dRDdEXtjPsORUdurId5y5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 162F9E919;
 Tue,  4 Aug 2020 17:01:18 +0000 (UTC)
Received: from thuth.com (ovpn-112-162.ams2.redhat.com [10.36.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40DFD10013D7;
 Tue,  4 Aug 2020 17:01:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 02/11] target/riscv/vector_helper: Fix build on 32-bit big
 endian targets
Date: Tue,  4 Aug 2020 19:00:46 +0200
Message-Id: <20200804170055.2851-3-thuth@redhat.com>
In-Reply-To: <20200804170055.2851-1-thuth@redhat.com>
References: <20200804170055.2851-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code currently fails to compile on 32-bit big endian targets:

 target/riscv/vector_helper.c: In function 'vext_clear':
 target/riscv/vector_helper.c:154:16: error: cast to pointer from integer
 of different size [-Werror=int-to-pointer-cast]
         memset((void *)((uintptr_t)tail & ~(7ULL)), 0, part1);
                ^
 target/riscv/vector_helper.c:155:16: error: cast to pointer from integer
 of different size [-Werror=int-to-pointer-cast]
         memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 0, part2);
                ^
 cc1: all warnings being treated as errors

We should not use "long long" (i.e. 64-bit) values here to avoid the
problem. Switch to our QEMU_ALIGN_PTR_DOWN/UP macros instead.

Fixes: 751538d5da ("add vector stride load and store instructions")
Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/riscv/vector_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 39f44d1029..793af99067 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -151,8 +151,8 @@ static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
     if (cnt % 8) {
         part1 = 8 - (cnt % 8);
         part2 = tot - cnt - part1;
-        memset((void *)((uintptr_t)tail & ~(7ULL)), 0, part1);
-        memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 0, part2);
+        memset(QEMU_ALIGN_PTR_DOWN(tail, 8), 0, part1);
+        memset(QEMU_ALIGN_PTR_UP(tail, 8), 0, part2);
     } else {
         memset(tail, 0, part2);
     }
-- 
2.18.1


