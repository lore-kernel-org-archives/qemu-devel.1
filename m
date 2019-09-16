Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E64C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A30D420665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duaHcljH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30D420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9scI-00078Y-7O
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCo-0006Jb-Fk
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCm-0007Q5-Df
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCm-0007Ph-17
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 7so80693wme.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mE/BuqEE8gv/JobfMAiia0z3Ltz3qiUZMeH9v73HiNI=;
 b=duaHcljHBMDeBPj8+dxOx69c5+tMT1BrLsxK18JJKUDoeLkIACjQzFnNM30SlCvHuQ
 BS/lex4pHFOJi+OPj8QHNxyni8UOCKMghX/hDSXog90hAylo7uzJW17OKpst5Bw7iDHS
 hZnBQVWbQSP7c+wNXKmdGNoySGRDH1sjiYfC49mmB5ZRVFRqFHGuCo2h/mXuTWIMYOYA
 WEzhHDqIGXYch1JN3MHMLWJ7UTWNNUS2n+dNiEPO7nBeHLD6Ye8JZbRIy0ylJigJHkS3
 UHPIPWzjDOgong05a60znkUlVCWKHNsVoEod5pUtqa9wrrlteZqJmlj/7vIAqpkhj8VQ
 0hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=mE/BuqEE8gv/JobfMAiia0z3Ltz3qiUZMeH9v73HiNI=;
 b=tObuyt3yjlrfOSm/a7BbckssOlzXkm3PyrP6uHdVyVNSVPT8SP8dhCAnVenqiS/Afv
 M6ZR4zs9iLNSD7v9beB4YLCNs/ZzD3D73FGLForhJoC6D+AwnuiqK+rJXQhjestvYMnU
 M/qFnbGN+JQw4tL2L7psE/6eIQ8Gtnfn144d9H+s6+OPVcDBnrQqLwF/kOCvXUSkjR5o
 /Nex/1xeDGWwI+7P9LaClGbvLaWtCC2FrgfUoPfTtQ+/Oq4FAKgkhlwvCnxarlCJWnsM
 JSttt7KGCQtcm2ZKm0SodkMxeu++NCnBohZwXN5ZzNEdd0WnVviprc5Ki0R8H4Jp8gBq
 G5dw==
X-Gm-Message-State: APjAAAX/BOv7Stm6xDtRVY6fslmUmsNyz/yrA06b3PlOTdg/MrTpqfFl
 jMSvDXQADVMZs91SzkEBTvQg7i8x
X-Google-Smtp-Source: APXvYqyZNgif8Elheu7kUKrwItLHC7HqeMIbhaqH2FZTgsimIA2VrI7LugzlDBgBdDnvBdA5Hca5Rw==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr37094wme.41.1568644934721;
 Mon, 16 Sep 2019 07:42:14 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:44 +0200
Message-Id: <1568644929-9124-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 04/29] exec.c: subpage->sub_section is already
 initialized to 0
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
Cc: Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

In subpage_init(), we will set subpage->sub_section to
PHYS_SECTION_UNASSIGNED by subpage_register. Since
PHYS_SECTION_UNASSIGNED is defined to be 0, and we allocate subpage with
g_malloc0, this means subpage->sub_section is already initialized to 0.

This patch removes the redundant setup for a new subpage and also fix
the code style.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190321082555.21118-5-richardw.yang@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/exec.c b/exec.c
index ff3cb3e..d9827ef 100644
--- a/exec.c
+++ b/exec.c
@@ -1491,8 +1491,8 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
 
 #if !defined(CONFIG_USER_ONLY)
 
-static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
-                             uint16_t section);
+static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
+                            uint16_t section);
 static subpage_t *subpage_init(FlatView *fv, hwaddr base);
 
 static void *(*phys_mem_alloc)(size_t size, uint64_t *align, bool shared) =
@@ -2913,8 +2913,8 @@ static const MemoryRegionOps subpage_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
-                             uint16_t section)
+static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
+                            uint16_t section)
 {
     int idx, eidx;
 
@@ -2937,6 +2937,7 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base)
 {
     subpage_t *mmio;
 
+    /* mmio->sub_section is set to PHYS_SECTION_UNASSIGNED with g_malloc0 */
     mmio = g_malloc0(sizeof(subpage_t) + TARGET_PAGE_SIZE * sizeof(uint16_t));
     mmio->fv = fv;
     mmio->base = base;
@@ -2947,7 +2948,6 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base)
     printf("%s: %p base " TARGET_FMT_plx " len %08x\n", __func__,
            mmio, base, TARGET_PAGE_SIZE);
 #endif
-    subpage_register(mmio, 0, TARGET_PAGE_SIZE-1, PHYS_SECTION_UNASSIGNED);
 
     return mmio;
 }
-- 
1.8.3.1



