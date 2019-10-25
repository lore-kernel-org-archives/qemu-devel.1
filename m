Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C7CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A757221872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="myGQuG/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A757221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO23S-0007fN-HG
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO1zM-0004Hf-74
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO1zL-0000jJ-5Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO1zK-0000j7-Vu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:58:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id w18so2943749wrt.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bVLJ7+GME2py4X5FmfdSBsVUYfInyOChkRTg8XJtJUM=;
 b=myGQuG/U0FzSiWVydhByhWndEPY7c65H2dvCKSl6albvpQqzKk2uJ6wQo1CXFVu8vN
 euxdUwckRyLzbrNgaZ2eqSSL+OueNnAJpyrhzza8fG5b/sAKTB/qheGkB2TO8inhuppH
 Nyu2FLFfbXz6sUnvskfuLM4vqxEH6s30c0nxZZtQAuQC8vfq+p6HytEt8PUqVUYx7rJ7
 rt9uHxhSDEEWbGSYjkP3mPH4AQ6Srl9NdtKWuBrSeHc0TcNUKgzIPwFGxx1JLChTHvMO
 RBxbU8K0lHwvu9O0V1c+yKsLZlevXHODi+vsORGqR3a49kRtpWjkSUipYurMWFbjeuVJ
 kg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bVLJ7+GME2py4X5FmfdSBsVUYfInyOChkRTg8XJtJUM=;
 b=jwMivss6XsgTD2CZWNqAzhKZzuooisEav3F81iwVigs32lTwXmdDR14x+lAqfa96fv
 dtf2lX2XByAMTRaCcHckmS7QNOUjiCO6TUKrf9qfZC/oh9fEbTPHz4l3WRgcpf3+G64P
 qJzWSiiKSk1oRRjXppZ0bZ3Eojoko6JejK/ozwNxWntIPw6gZhFSI7Er40qsf6uu3qPq
 YOzOWrh1gQ24S0kk24PnVvt+tBsu27HoImWygvB3ZGLHOHRwVAfB0cRcwzSZse8MrZYI
 lv5FL2NIaGm8qlrb/b+II8tS+3Ok6WqAakIh3l+mk4Y99mUoYPTfn9dJlErsimyxre2w
 dbHQ==
X-Gm-Message-State: APjAAAWpuhR4LMte4b412siiKSv/E5IQxYpRmQK1Ojy1mDIsG5BoGiRC
 ZiKtR/mwOeBkU4F8NVTCvk1sS49D+dQ=
X-Google-Smtp-Source: APXvYqwAMVD8dmGLc9CcqLRzhNfkEw3GPKKxmcFoYARz6f9MiAjWIiB8xqH7554eVO9pCv5HBq9mNQ==
X-Received: by 2002:adf:f746:: with SMTP id z6mr3581648wrp.238.1572019133365; 
 Fri, 25 Oct 2019 08:58:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 65sm4218887wrs.9.2019.10.25.08.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 08:58:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] tcg/aarch64/tcg-target.opc.h: Add copyright/license
Date: Fri, 25 Oct 2019 16:58:45 +0100
Message-Id: <20191025155848.17362-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025155848.17362-1-peter.maydell@linaro.org>
References: <20191025155848.17362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Add the copyright/license boilerplate for target/aarch64/tcg-target.opc.h.
This file has only had two commits: 14e4c1e2355473ccb29
and 79525dfd08262d8, both by Linaro engineers.
The license is GPL-2-or-later, since that's what the
rest of tcg/aarch64 uses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/aarch64/tcg-target.opc.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target.opc.h
index 59e1d3f7f7d..26bfd9c4609 100644
--- a/tcg/aarch64/tcg-target.opc.h
+++ b/tcg/aarch64/tcg-target.opc.h
@@ -1,5 +1,14 @@
-/* Target-specific opcodes for host vector expansion.  These will be
-   emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
-   consider these to be UNSPEC with names.  */
+/*
+ * Copyright (c) 2019 Linaro
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.
+ *
+ * See the COPYING file in the top-level directory for details.
+ *
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
 
 DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
-- 
2.20.1


