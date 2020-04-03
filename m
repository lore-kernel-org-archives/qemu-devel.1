Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC13C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9931420719
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BONettR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9931420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRkv-00059l-G3
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjS-0003Ff-4H
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjP-00021q-Sj
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjP-000206-MR
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:55 -0400
Received: by mail-wm1-x341.google.com with SMTP id a81so8870936wmf.5
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R7MN9eSx9agbWPqT5OjGjNM4Lpuf6u0q6HsuyaT0dMs=;
 b=BONettR/CVYQoMOwUD4wfIm3Y7+Q0ldet1ttJYyBwey05p1vyzvBKbeOTVPmtK3/Sg
 T33I8vcG5F3OfsDlbKz++1IxtogEzpN7dypoREzNIuE3NIuYH0Bedg6/3y730smfb8Fu
 0vGAPnFNcuKoKuxlKZ0sX9xZMBzn+FHOHS/rEtaDrKKJwW81ju4JPNc1T7HkPtUGHBOj
 1mljXvF9Px61bQV1ylFzhqqw7aWLYCvsCXc+dZctNXj0A7CSBp0vBI0mz4eBaFXqgVMU
 32qaaXitVivYOKYde2CK2/Y9YM5+pMw49mKkBuR/6gySiXeID3L0Yx3JRDKbdWOd8u5L
 yfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R7MN9eSx9agbWPqT5OjGjNM4Lpuf6u0q6HsuyaT0dMs=;
 b=m5C9qU9I+mrvWJrxGeOEjLi+NR72xn9QzXJ/uEGBdD9fjm/K8iUDCbCZLKrZk1ZZC6
 8Cxmlbo+6oNua8Ym+0KG1rFxhHxmpl5FhHj0HwI3s0oI0U5S6SOrq8SeOt7GLkplc47X
 biWebLSM2YzfvhVBj9IYytXeM+2VB5cx+Pr3sSDZ6zXOc+BU/ESrlgl4MOCR4WgzBa3z
 2Dt/42SZY8+B8H+0e1HyF5fw1l/9k+HGJ0nvBHd0mmpmC3GqwpGyebsHtIrIhR9bxR5T
 BvcQfuKvzQAToKfWR6m0Ygn8+k3Mief5KpKd3RuoIzd7FHYsVPUOyaItXuktuJMawymr
 +snA==
X-Gm-Message-State: AGi0PubmTPKrAmC8dTu6pLNyGmAN2rrNdLStofzwX3Cg0t5cZbW/TeiU
 LYeCz1PvoJSyVb9Rmt6z8nzVAA==
X-Google-Smtp-Source: APiQypKiSj4LBhfTZybCiPsA/XuDVwyWvqnt3E9S7rFOECobzf/eMh8jgWS67YcgJRHLBsXL6ongVw==
X-Received: by 2002:a1c:1d02:: with SMTP id d2mr1706593wmd.78.1585941114631;
 Fri, 03 Apr 2020 12:11:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g194sm2615680wme.32.2020.04.03.12.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DAF421FF8F;
 Fri,  3 Apr 2020 20:11:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 03/12] tests/tcg: remove extraneous pasting macros
Date: Fri,  3 Apr 2020 20:11:41 +0100
Message-Id: <20200403191150.863-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are not using them and they just get in the way.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/x86_64/system/boot.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/tcg/x86_64/system/boot.S b/tests/tcg/x86_64/system/boot.S
index 205cfbd3982..73b19a2bda6 100644
--- a/tests/tcg/x86_64/system/boot.S
+++ b/tests/tcg/x86_64/system/boot.S
@@ -41,10 +41,7 @@
 #define XEN_ELFNOTE_PHYS32_ENTRY  18
 
 #define __ASM_FORM(x)	x
-#define __ASM_FORM_RAW(x)     x
-#define __ASM_FORM_COMMA(x) x,
-#define __ASM_SEL(a,b)           __ASM_FORM(b)
-#define __ASM_SEL_RAW(a,b)      __ASM_FORM_RAW(b)
+#define __ASM_SEL(a,b)  __ASM_FORM(b)
 #define _ASM_PTR	__ASM_SEL(.long, .quad)
 
 	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR 0x100000)
-- 
2.20.1


