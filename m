Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A7C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA1E20772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/NS5gfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA1E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZzd-0005qX-Od
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyg-0004BW-RC
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyf-00029q-RG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJZyf-00029T-LW
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id d5so29822537wrn.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R7MN9eSx9agbWPqT5OjGjNM4Lpuf6u0q6HsuyaT0dMs=;
 b=G/NS5gfWIvoCMjoY/hf6IqM6cjUKWTvJWafLiokeUrWmsyOUqHWVix0rCBZvqnwHcr
 599UFL2w6uKsYK7GiuKBpkRDyTontw0CE6QTiJEm4ppRm96velXyZKeVq1cDeseFhscq
 XdeU14sYH8OY21JIrRI/JzJyuSsN0jvEgpjxk2PRFHcepz9QJx9eGpDMsqgqDwLE1fRl
 bc5KESuFNU+AWpsCeEsodlbZ+Ed3kqQmzSE2gNbYin/i8KRTXudMvzfn5UXj5BDCZMIC
 jOFVR5AN6EdmzKpv/LXRxQjZ1ndRSYrn4l0+LOb6sOq4PlSnYuQpOYxs4Lpy7Dl2RViO
 A3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R7MN9eSx9agbWPqT5OjGjNM4Lpuf6u0q6HsuyaT0dMs=;
 b=oJA56x5KQ7K5KItnxBVOxx1dtULLWD0+qPanHdppmQZ4SqbOxJs8TV0vLylX1L2w/c
 OMhgCCdObVswizL+wD4reLv6EMeInar/LzePYWMd/WZ2r/d+ILketG32CDaNmQoqGM6X
 2DwWXIjvNuY45htkpigZrzccECmMuSWndiTK7oip6oPvW/XSp3ncWlv0xsBqcFnwAo7K
 dRrBK8CEEKmFkzMOX1gR1UdeTonzeUtBnyrV0Em8nLQinfbZT2anjtCQUzOXYWFOFJb3
 HAvPWDXozACvSwF63QNw+IXJr+zLhOEAWdMR8rC1y89OayRxZGMpX+vg5U3ykg/gfFrE
 /RAQ==
X-Gm-Message-State: ANhLgQ34zpCnFVvqc93OFYmYoxpbgjyUPsK4vF0qBF9WXrIp9xhRWvDb
 spQbzhZr0XwiyYboaDnEaUqXiMZ3EFs=
X-Google-Smtp-Source: ADFU+vvOFY+aWMF2/XPNNr7wtarEqkwsP/9guZq60tSSqWCzbXk0agQ23jh0oIsphq6MF7kN9ioSmQ==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr27049589wrs.56.1585734484637; 
 Wed, 01 Apr 2020 02:48:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y80sm2006688wmc.45.2020.04.01.02.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 02:48:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 59C5F1FF8F;
 Wed,  1 Apr 2020 10:48:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 03/10] tests/tcg: remove extraneous pasting macros
Date: Wed,  1 Apr 2020 10:47:52 +0100
Message-Id: <20200401094759.5835-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401094759.5835-1-alex.bennee@linaro.org>
References: <20200401094759.5835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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


