Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE6DC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49762082A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltAd+58Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49762082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzjSF-0004BJ-Fm
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 11:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzjPy-0002Ut-3H
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzjPw-0002Wn-Pk
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:17:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:35964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzjPw-0002Rn-Iq
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:17:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id w2so1349214pfi.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FYIOkeCFDs+BgfZApqGQTYKi9ofiCzdQQpabShx+clA=;
 b=ltAd+58YwCh5eaUQEsu2K4Js+5xQgGw9JIVMFYOr/3Jb49QKktf0Wb/JhDgils9xXZ
 iY51U5XNUY5VZMVWwBxeRzVALpmDZsvajMSGsVbP/0WGChTxiL8a4BOkln1bv0v4ioi1
 +basAvd3MtrGMdhCKpaWh3UUafeJFcI4Jod6L7/qK+Zqx6/uZ+GSRWIOmUwUl5GdcIUX
 bvdmXYn0G/9VhlFaCTRDeK8JQoGxjuOjQMYA0MytTRqmO/nMEc4A2OFzbPUgu+6oBArE
 7YIOK0FaiczpHILdMOnWdqJdPqVATWtd2rBglf8Oca8JIbaTFkHX7q/KOnC0Ujhklagz
 /fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FYIOkeCFDs+BgfZApqGQTYKi9ofiCzdQQpabShx+clA=;
 b=V55bCHpQnZmj0vpjDXNJas0eOsDTqPJKukXk5Adi18ZVWea4fdv78XQ1ifWczWR3vv
 +5zybmPxmPa+VlJIeB6rq2Yq3s0NJg2SsCi8m4GQ34IryNSBL05kMsndDg2CS55jnMgB
 Y+oEJiowrfj5uMBoaUGjMfjhOalEoY2PAIcK8VwIGajTxv+Zd1AFr4zbY7Q5ZEKxQup8
 yGw1FMdoqoWmfWhxZ67rQreB/BokQ6SetWO9+W4u7hr9DeToJDyuVyp/x48IwkkwtwfA
 rg7VmRPqL/5G9JKgjNPqd4GLrIEqD06jsLhE8Djw8srIonAk0Ywg/xp1HBOcqErIuCmU
 r49g==
X-Gm-Message-State: APjAAAXwA48XM8V0soxj+oPUkNaT6laXLQ3oGOknbYYd/pEaQjyvYYdb
 EvkUgvjzANyIqBDCvDLXtLMrE+livQc=
X-Google-Smtp-Source: APXvYqyNjvVuL2i/xaKNgryLYL4/IXw3l4OsJidKNWPYCtzKcrXzmR63YJs2+tMgAj/zBJ+6pdr5XQ==
X-Received: by 2002:a65:458d:: with SMTP id o13mr20056311pgq.34.1566227868801; 
 Mon, 19 Aug 2019 08:17:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r27sm21020406pgn.25.2019.08.19.08.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 08:17:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 08:17:43 -0700
Message-Id: <20190819151743.17267-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819151743.17267-1-richard.henderson@linaro.org>
References: <20190819151743.17267-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PULL 3/3] target/riscv: Remove redundant declaration
 pragmas
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are now generated by decodetree itself.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8d6ab73258..adeddb85f6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -708,26 +708,9 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rvd.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
-/*
- * Auto-generated decoder.
- * Note that the 16-bit decoder reuses some of the trans_* functions
- * initially declared by the 32-bit decoder, which results in duplicate
- * declaration warnings.  Suppress them.
- */
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
-# pragma GCC diagnostic push
-# pragma GCC diagnostic ignored "-Wredundant-decls"
-# ifdef __clang__
-#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
-# endif
-#endif
-
+/* Include the auto-generated decoder for 16 bit insn */
 #include "decode_insn16.inc.c"
 
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
-# pragma GCC diagnostic pop
-#endif
-
 static void decode_opc(DisasContext *ctx)
 {
     /* check for compressed insn */
-- 
2.17.1


