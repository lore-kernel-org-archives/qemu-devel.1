Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE2FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A9D2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRU5agBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A9D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zVj-0004X7-AM
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zUl-0003FH-6w
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:08:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zUj-0005m3-I9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:08:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id p20so3037190wrf.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=e9h1dxfcHunD8hLi5hAFgkUxc0WZaXDSQ3fg/GVRuNw=;
 b=oRU5agBGMx3vpPU2okvvejkn6JQ1UfOyFHwt6y6S7xpybG4v8MMS8r16soCxGewGvJ
 AQHPCqgTLHkps+4bDj3oxLZvQFzVFKEUdX/GhAp89BmAnc/bkQ3wK7GOPlnQi0PGMqc3
 jk5YlZ+y04/aG+N1ZpKetBl0I+FkcQLAp6MnpPxcBLVHJ78fBuxn/eJSsg81m6V/uIhQ
 O9gbVFAcPSFU1p5mDz5/9DmLXYWjTlkM8bb338AudD+jFPPgaJI9lr1exWBFb/ay8PC9
 rwUzg8zWq800zinpag3juCjPQyMgYXPfVl2jnV8g1480r4cyrnIJCnaZzm0Reen8QKZI
 BpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e9h1dxfcHunD8hLi5hAFgkUxc0WZaXDSQ3fg/GVRuNw=;
 b=dRb6JNGJpq/xSa+Sqc0hkbPfZWF5iTHF14ghlIWBW5wP0aEv+8NfW5fQoFV6lx+2tz
 JGi1xRXhGIMbhJtrWZophRTpGx/ISKJy2Mw0OVuawzbrT9NiIp8iBznIwl1OKDZbbPMK
 Fh7zNaMfv3g2/L9Sq9VTNSDl2hkhMiIPT68XemPW/8FUWZKrn+UJBz0JKWJpiHEmC3UG
 WfZ8oOncUjUDtRmVBnlE7tndD4QjOX5FKxkHh0Rl8HpBjqif7HaqASuFbppy8KB2wrdf
 tu/QWQCJ1C+NSFqM+D9o+1yJOp7QMhjAepTdDXPbCzF/2qVA4ZKRx1no52n/yG+wvYb0
 he+Q==
X-Gm-Message-State: AOAM532sk4fWxMkoxr+e7cnRWU+DqwWl87YxU0Bv9aap7BCerFi8fV5H
 YgL4Yf4C040OWQ6rx/OncoPf79/A3AD0JQ==
X-Google-Smtp-Source: ABdhPJwmr7dQlZNHnks+5wV7SapB2KOb7dnH6kJofDfjbpze0vTqj0HL2/EKZet6MZ+B+/K99xOyDg==
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr21680545wrt.73.1596557330884; 
 Tue, 04 Aug 2020 09:08:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b186sm5625928wme.1.2020.08.04.09.08.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 09:08:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] docs/devel: Document decodetree no-overlap groups
Date: Tue,  4 Aug 2020 17:08:42 +0100
Message-Id: <20200804160843.30245-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200804160843.30245-1-peter.maydell@linaro.org>
References: <20200804160843.30245-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

When support for this feature went in, the update to the
documentation was forgotten.

Fixes: 067e8b0f45d6
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200803205708.315829-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/decodetree.rst | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
index ce7f52308ff..74f66bf46e2 100644
--- a/docs/devel/decodetree.rst
+++ b/docs/devel/decodetree.rst
@@ -173,18 +173,25 @@ Pattern Groups
 
 Syntax::
 
-  group    := '{' ( pat_def | group )+ '}'
+  group            := overlap_group | no_overlap_group
+  overlap_group    := '{' ( pat_def | group )+ '}'
+  no_overlap_group := '[' ( pat_def | group )+ ']'
 
-A *group* begins with a lone open-brace, with all subsequent lines
-indented two spaces, and ending with a lone close-brace.  Groups
-may be nested, increasing the required indentation of the lines
-within the nested group to two spaces per nesting level.
+A *group* begins with a lone open-brace or open-bracket, with all
+subsequent lines indented two spaces, and ending with a lone
+close-brace or close-bracket.  Groups may be nested, increasing the
+required indentation of the lines within the nested group to two
+spaces per nesting level.
 
-Unlike ungrouped patterns, grouped patterns are allowed to overlap.
-Conflicts are resolved by selecting the patterns in order.  If all
-of the fixedbits for a pattern match, its translate function will
-be called.  If the translate function returns false, then subsequent
-patterns within the group will be matched.
+Patterns within overlap groups are allowed to overlap.  Conflicts are
+resolved by selecting the patterns in order.  If all of the fixedbits
+for a pattern match, its translate function will be called.  If the
+translate function returns false, then subsequent patterns within the
+group will be matched.
+
+Patterns within no-overlap groups are not allowed to overlap, just
+the same as ungrouped patterns.  Thus no-overlap groups are intended
+to be nested inside overlap groups.
 
 The following example from PA-RISC shows specialization of the *or*
 instruction::
@@ -200,7 +207,7 @@ instruction::
 When the *cf* field is zero, the instruction has no side effects,
 and may be specialized.  When the *rt* field is zero, the output
 is discarded and so the instruction has no effect.  When the *rt2*
-field is zero, the operation is ``reg[rt] | 0`` and so encodes
+field is zero, the operation is ``reg[r1] | 0`` and so encodes
 the canonical register copy operation.
 
 The output from the generator might look like::
-- 
2.20.1


