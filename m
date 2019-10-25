Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF37CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E052070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIUz2cS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E052070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO28m-0005wM-DU
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO1zO-0004MJ-Jv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO1zN-0000jx-EF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO1zN-0000jS-7Z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id r141so2508990wme.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KB8ofR14/xZTM9k3bx3U5ZJX+jKnpJiT6PCRpzG6xLw=;
 b=CIUz2cS1ANaB9ZwE245dfwZ3zXA/n0Tb3MGySDL0LnAMfqj4ruxkw/WcKHtZ1uWnoc
 DmazanhK0PH9LChJuzvmwOHYTky1fOcLKzLCEcTzBe0N4Vj60DCHujq424u/Pxjqo62J
 ZhpXgg2q1mxfVRwgZi8Z1xgHJ5pTeEiU5bjqzgLflzeLtZrLHubXxRXaiDGouynDac65
 IbRDLO1fsMeaFzqC4BePEIBQHvkUJRUXSeS1AJOzAdLqNyvx4za/LmvcEq5pgDdtuQT2
 XCUZc1A7mzW0VEV+LzuC3RTUsTBcC8JBcHt3MIGUj27HmkrWFjMZoMXrRuQpJSJY+Qrl
 dRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KB8ofR14/xZTM9k3bx3U5ZJX+jKnpJiT6PCRpzG6xLw=;
 b=DSpp7sEoIKM9IskIG3iAEc0A6woDgXsHbtHOFuViELaCJ3pt/Z4fgVXlmvE/6PQnGF
 T3+jC+2glITpTeiWcNKV6KnXXVoQbZ4t+1knL6P7FNPAwEGZQrpActkUvYQ9ZH9xq1Jz
 cxKAlr1PcIPiTteTj+UcfioIXU58z+BQ8HfIFvPKx63Y3lZV08N0/3qH2I1b7+GU6+dq
 0ybOksdZ+LmNdhEsM2YftjwY9LFF5ll6mLs/Z7O1yNPl7vs+UIkgs17bETBfEc92nQF3
 skyK4zxvA0JKEEBFK4wnNY0X+CK9Ak3EbgpPgLqE4p0O3RexJkGAa+LhxymqDFEOpgoo
 9iSg==
X-Gm-Message-State: APjAAAUrmf64GyK/46YvdHr/7cXcBW9Rvf5M+K+TUM3PQCy03fsuZskN
 KGQhEV+qdDMPMV21hw+UteHxljiI9pU=
X-Google-Smtp-Source: APXvYqziEs7toGt52CuBlShAVI7bqohX6uIIKeDqxnWz8VYeU8+VCIABAWJbLL9/APIKqQ8T9gx+IQ==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr4053219wmj.91.1572019134947; 
 Fri, 25 Oct 2019 08:58:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 65sm4218887wrs.9.2019.10.25.08.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 08:58:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] tcg/i386/tcg-target.opc.h: Add copyright/license
Date: Fri, 25 Oct 2019 16:58:46 +0100
Message-Id: <20191025155848.17362-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025155848.17362-1-peter.maydell@linaro.org>
References: <20191025155848.17362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the copyright/license boilerplate for tcg/i386/tcg-target.opc.h.
This file has had only one commit, 770c2fc7bb70804a, by
a Linaro engineer.
The license is MIT, since that's what the rest of tcg/i386/ is.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/i386/tcg-target.opc.h | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
index e5fa88ba258..1312941800e 100644
--- a/tcg/i386/tcg-target.opc.h
+++ b/tcg/i386/tcg-target.opc.h
@@ -1,6 +1,28 @@
-/* Target-specific opcodes for host vector expansion.  These will be
-   emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
-   consider these to be UNSPEC with names.  */
+/*
+ * Copyright (c) 2019 Linaro
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ *
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
 
 DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
 DEF(x86_vpblendvb_vec, 1, 3, 0, IMPLVEC)
-- 
2.20.1


