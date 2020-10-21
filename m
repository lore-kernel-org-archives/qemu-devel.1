Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA2C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6CA223BF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GN9uua4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6CA223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVINE-0003nB-FW
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVI48-0006pe-NP
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVI3z-0006Vt-AF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603301894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCTQX4mLqj2f5H121RmQ/r4zkcw4nXTmcR2H90CkbeE=;
 b=GN9uua4Vph1kvPHjpSKdzX7lJciqNh+5ngYDK/oanthrpo1hZr3u8mkVLlzgt79N2WU+wy
 B1dygeiJ88nSUNUt2FMPyxdpi9lgcqyzRJ2G2RBqoWxjwEqnLh6sd2JXYI6NTRgNv0O1HG
 /65xatdwri3/5WC+STLWrFnMMKMsH74=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-UZHwNRgqNgqRGk4exizU8A-1; Wed, 21 Oct 2020 13:38:11 -0400
X-MC-Unique: UZHwNRgqNgqRGk4exizU8A-1
Received: by mail-wr1-f72.google.com with SMTP id x16so2989789wrg.7
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wCTQX4mLqj2f5H121RmQ/r4zkcw4nXTmcR2H90CkbeE=;
 b=WU68ZXThmT49aLtPE7KTvZ0FsA9kVsFnCt72uK0NRGQE5Xqg1mFA3sh025vTmJrIAc
 VKdQwVCc/XKcmfhD1yXhCQB+8RrjqkB2agpiq9vcWTVxQzDv0BTYc2DP9yklKE4oCeAG
 BNW1eTF0ypI+LajnDfAvlY/X6IgRD0RyM8FMu9uyxK8mHFWX3fXhiYwSA6S6E/KxRiX5
 09mU+WdrbgzqKyuWhuFLdGQsenc+0vWGIh0MhnqJfRpbpTQ3RwrrXjF6l6Gr/FGn40Yg
 VDs5LJIIXm7S4FJ4d+ugz3tKLTGpQs6UkGp6WzeUB2mDJn7dYa1mjMWPIRhtCQpPgpxD
 sduQ==
X-Gm-Message-State: AOAM533EOrFTwK1lB4zv4sA4K/LA7ymHbjEbUq0A5XmAIihSaMlgVsxm
 I8YPktx/f6eXaax2OXvyrzLEKUj/IEaxvm8Qlr/yNt1iix3dJ/GVDc6hMF+HByZF86ByE/NqnPr
 AIZVUU6bThNG/wTw=
X-Received: by 2002:adf:bbc6:: with SMTP id z6mr6011345wrg.298.1603301890709; 
 Wed, 21 Oct 2020 10:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+gInbogEgvA5LYqMVO8Vqg0xBxVjoml4Dg59/ixdlEM5N1rJJS542EuRfO8pbKPGigDLclQ==
X-Received: by 2002:adf:bbc6:: with SMTP id z6mr6011330wrg.298.1603301890496; 
 Wed, 21 Oct 2020 10:38:10 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x81sm4606765wmb.11.2020.10.21.10.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:38:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 1/2] util/oslib-win32: Use _aligned_malloc for
 qemu_try_memalign
Date: Wed, 21 Oct 2020 19:38:02 +0200
Message-Id: <20201021173803.2619054-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173803.2619054-1-philmd@redhat.com>
References: <20201021173803.2619054-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We do not need or want to be allocating page sized quanta.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Message-Id: <20201018164836.1149452-1-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/oslib-win32.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index e99debfb8dd..29dd05d59d7 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -39,6 +39,7 @@
 #include "trace.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
+#include <malloc.h>
 
 /* this must come after including "trace.h" */
 #include <shlobj.h>
@@ -56,10 +57,8 @@ void *qemu_try_memalign(size_t alignment, size_t size)
 {
     void *ptr;
 
-    if (!size) {
-        abort();
-    }
-    ptr = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
+    g_assert(size != 0);
+    ptr = _aligned_malloc(alignment, size);
     trace_qemu_memalign(alignment, size, ptr);
     return ptr;
 }
@@ -93,9 +92,7 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
 void qemu_vfree(void *ptr)
 {
     trace_qemu_vfree(ptr);
-    if (ptr) {
-        VirtualFree(ptr, 0, MEM_RELEASE);
-    }
+    _aligned_free(ptr);
 }
 
 void qemu_anon_ram_free(void *ptr, size_t size)
-- 
2.26.2


