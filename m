Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C803C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD8120738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhu1xL46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD8120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFO2-0003X9-Kc
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCj-0003tK-R2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCi-0003ml-HG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:33 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCi-0003ge-9m
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id h6so6221560wrs.6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1enKsIBdEviq5nykP6LOEgZbSgk5slEBebWoM6e6JJM=;
 b=Lhu1xL46r5+epPlep0AEbOEjzP7r8OMGtrUbgA9duExYp/Nuc2R/sctwDj64FckOet
 620FH2+fM1t/E6ctFqDaoZvhpQJ/r8+dWK8wbSv9q4fHNe1mnMsXZ4EeA9t+1b4yt+wb
 vwe2RqYpEmUJDOJp42eZ/8dK8I+vQaExsBPV7UMo+cSfTCIYtGpelxg43xNBaE2Mjs0A
 LHZn7YNpztvSIpx/B/KaWHKHq6Sb8KyPQyfMxRh27jZhFnmyNlsGLw7JEGUQ2LNuy+kR
 GTkceBV6C6ePaIJ45qOCF0wCwfjn8E72ntCruerJu9YcDduVexi2z8SOZz9V3cBVNSvo
 4ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1enKsIBdEviq5nykP6LOEgZbSgk5slEBebWoM6e6JJM=;
 b=XDe59++A6XIc181msWtarFyHbwC+C3OZGYvYZKpO4EVqwHiRVSUej7jFuOqgzde6Yt
 m6CKmCT5K5SBGCs5fgWbL/4DOegnBE5lt7R4PCNrkDeInf/oHX119SvP5sXdeF09LhOO
 oYkN4ihu3j3Jz+tuwc6+UXSflFSwoxXWh0u9R3jPibJuSJB61Jcilyy7feMboxwxBMFV
 CHjfZutaMr5Y2p7J6fbcfH4jh3aJNqRUfytTw1XHm2lDsnZojZ/rEISsx3aHNl1Wm+iV
 6AUkhoJW3N60CdgpC9zj5pyXW31eq0+uc2Sfi3SIEwisio39F7g2uGmDoMSDrNjPL6qn
 O0mw==
X-Gm-Message-State: ANhLgQ1eHNu1Q73vq5eEItKr8YLGhaWasz2L8WCIqf/7ogwoOJYcFAY6
 STPKtMh1KNi5X6tISYRdaKAoeQ73
X-Google-Smtp-Source: ADFU+vsyRGk9qajRzf6pq2wSfRqEfyobWWnTR7qX3jFAWhj3NmvWeiG7IQGVJ+vgnAjzzTwFjeJXEg==
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr6618622wrq.333.1584462990895; 
 Tue, 17 Mar 2020 09:36:30 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b202sm4618697wmd.15.2020.03.17.09.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 09:36:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/13] target/rx: Use prt_ldmi for XCHG_mr disassembly
Date: Tue, 17 Mar 2020 17:36:12 +0100
Message-Id: <20200317163616.30027-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317163616.30027-1-f4bug@amsat.org>
References: <20200317163616.30027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Note that the ld == 3 case handled by prt_ldmi is decoded as
XCHG_rr and cannot appear here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190531134315.4109-21-richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/disas.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 0c4115669d..a0c444020c 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -366,13 +366,7 @@ static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
 /* xchg dsp[rs].<mi>,rd */
 static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
 {
-    static const char msize[][4] = {
-        "b", "w", "l", "ub", "uw",
-    };
-    char dsp[8];
-
-    rx_index_addr(ctx, dsp, a->ld, a->mi);
-    prt("xchg\t%s[r%d].%s, r%d", dsp, a->rs, msize[a->mi], a->rd);
+    prt_ldmi(ctx, "xchg", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
 
-- 
2.21.1


