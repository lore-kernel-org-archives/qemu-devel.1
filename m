Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD6C20A8B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIrM4+uA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD6C20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2fov-00070V-Fk
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2foN-0006aU-Lg
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:07:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2foM-0000IA-8Z
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596481669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TI0IEB99UqKTBYdPDe/N1xM4vdQ7QBL+iNqeyknjFuY=;
 b=AIrM4+uAltKhhikySYGuQ1Rkfey8Ksr248a2ZhuKWT+XP9HL18rUV4afQ74hXiV6heg8xO
 pAnj25bVWDI4R4esTwwoDYLj1XVJfA/8BCV4/8NL3zepShnvemOsPqpKiZX+Z3KFIThJhl
 9yXjn7X9JniyfZqLvM6HzcrF7Wsz0FI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-aaQzhxtbOF-BBYgbrITNdg-1; Mon, 03 Aug 2020 15:06:41 -0400
X-MC-Unique: aaQzhxtbOF-BBYgbrITNdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8316057;
 Mon,  3 Aug 2020 19:06:40 +0000 (UTC)
Received: from thuth.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7863571767;
 Mon,  3 Aug 2020 19:06:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH] target/riscv/vector_helper: Fix build on 32-bit big endian
 targets
Date: Mon,  3 Aug 2020 21:06:36 +0200
Message-Id: <20200803190636.8439-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 13:51:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
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


