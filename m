Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB015C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752A22145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLP6Nq5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752A22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIbj-0004mu-5a
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60105)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYk-0000IZ-AE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYi-0003Ls-GX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYi-0003Kl-8f
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id s15so17666721wmj.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8Qfy8a0GAVN3cZj53fYSGM9mBcfsB1yLOHRsBKNqTiU=;
 b=uLP6Nq5R+E+B5kGnDaycxGgK6koWwtR7zCMbDFrQp+hz/diqzJ3Vd3/3x6u5Npfs61
 y0eO2GwyMBvri266zyD6YavIVgzWasl6n+5ZenTjJvTExrMRgHeFN0LQo7Y+NyxornfB
 GfuSID8nymaniWexvBomqdLYbZ3AWUwutevRdgx0R6yMw9Z3i5xyQe9Qqyl98m1RPYfc
 v74uo0s4egHPiiW3Dk3thmoKiUWvHTSb6NF8ZSDiIyuRYnJwxpFzOVOt/JCFfMmNdp9g
 yt4iCjFl3vSAiV7r8TOIccxveiWfKruweGIUnrFbDAMnyafKR0tH/T3YimeAjD7MoH4e
 29BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=8Qfy8a0GAVN3cZj53fYSGM9mBcfsB1yLOHRsBKNqTiU=;
 b=d2qs/9oSU1S75MyqhZWFm8jP7VaF/dZ0lJ8i1o11e7EkJ6vatKPw1itPINSHK+zpgA
 5OatpDllWVBXr1SY0f7vw95RU3n2AvxVwpmZQaB9MkCOzxlaV9wIOVh7WFY73S8OssDy
 5zfXL63p4ohVl9PB+ZpMCTHGl4iCuBXouCfsXGadV1DAunXgJ+Qvz1+UQ50I0krrMzO5
 AKr4H9sVYCpX9d4N68CPmwIGa9Yi/LHDB7ZbsAl/3XhQKWsrh4mvRuUcSTFLFAIFVB44
 yH6FQdxutReVs9JmMRSJc3qDtZ8q4Qmnwk8FUokp7yyM7NX450TA5tT32e8VTI+QRSMp
 WVgg==
X-Gm-Message-State: APjAAAWidZl8sBLGhUecUYypGtx0RH06ddkn6mnY8VcI9yY1i01m+IVH
 pC3BTAoDoQr1GEjlAXKiE28p2zE/Geo=
X-Google-Smtp-Source: APXvYqz6oZIlQl9LCX+0+0LTUTSf5jMUydYg88xTmfhY/l2MmjknCsaWw03bdPVPD8yxCmwqNYhpug==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr17436015wmg.15.1563264694251; 
 Tue, 16 Jul 2019 01:11:34 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:12 +0200
Message-Id: <1563264677-39718-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 14/19] target/i386: sev: Do not unpin ram device
 memory region
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Brijesh Singh <brijesh.singh@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Williamson <alex.williamson@redhat.com>

The commit referenced below skipped pinning ram device memory when
ram blocks are added, we need to do the same when they're removed.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Fixes: cedc0ad539af ("target/i386: sev: Do not pin the ram device memory region")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <156320087103.2556.10983987500488190423.stgit@gimli.home>
Reviewed-by: Singh, Brijesh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6dbdc3c..5ba1384 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -161,6 +161,17 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size)
 {
     int r;
     struct kvm_enc_region range;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+
+    /*
+     * The RAM device presents a memory region that should be treated
+     * as IO region and should not have been pinned.
+     */
+    mr = memory_region_from_host(host, &offset);
+    if (mr && memory_region_is_ram_device(mr)) {
+        return;
+    }
 
     range.addr = (__u64)(unsigned long)host;
     range.size = size;
-- 
1.8.3.1



