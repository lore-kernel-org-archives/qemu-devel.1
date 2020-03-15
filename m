Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653ECC2BB1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3216C205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNBSb2Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3216C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTNW-0002kW-85
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJi-00087t-MH
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJg-0003LS-SV
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJf-0003Ie-5K
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id w16so1441484wrv.13
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cElIp5LI4R05nZljrre+VQi0ay9bW2zvw5msneFgmQA=;
 b=XNBSb2Kb73VEMVZ6qaPqa9Sn9X6D3SxSKgChkwjkTSbB8Io0cvPZuKc2ubgMb+aDTj
 8AVQTSwp6noKKQGI4EU9DerQB8i+0daxub2k5t213KCjlbjkjXl/74iR/80OMPJxN50z
 LULBL/mEd9KZ+FxAynxa7YwDPIyxQt3ewoQt8Ngc8QPHeFY5rsCAa4qiZ1RlvjDqIoKW
 5qEL+MhSwdzrBupU7lSDLAT54ZtCPn74tp4oSRPGlrRoOd1eK5UmX5qFJb6Kx4tdBdDp
 AGjPQ8cVRc3w11tFxYVmTmHqcw9PLv3CrcOeAq/S0byg7snW5DSSuJrN65VfIUydKoSI
 qJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cElIp5LI4R05nZljrre+VQi0ay9bW2zvw5msneFgmQA=;
 b=KVhSfeNOYzkr3fx50mdmQxw0WLi0iKzC7M4jatLFo/Y66JF7l29fywmUXogRvTYUSy
 smee6uRsgrkZvFB7pIVPsje8l+/QZIxBDCmM9j4uvjgdDY14sLC1JnAXjVZZcG0qEPqF
 84CpDsGzfDntnyXN//YELzy4lqEckIMl6+x7zFA7u+8QNN0ErC50/7khn8UxQFlM+cJO
 7YwLHTceGxmHiKDsEC341F93vpNUlGtR14U0RyMjOUjdG5LK8EBAInYbc9QqB+GMHqO4
 oEF0USibyYBxaEmX0bGFfsiuEhSNlzIfd0fjf1XLcvNBj+w6J17gYhrQm/6t6uBFZeIM
 jXzA==
X-Gm-Message-State: ANhLgQ3Vc2oEmfRP7MAv2HFoF0cjfhlh3GmdavUxmdej3cHycNudWC+g
 mtKza3PXJQvah6np5Qc1d+2jEWFj
X-Google-Smtp-Source: ADFU+vuzN8pLtnk3BwoIDzcTB2FHl3odKFGS17WNoYIgzSX523P9fEecsHKdeFKa6YYqWDvvV34zpw==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr28266681wrr.281.1584278908870; 
 Sun, 15 Mar 2020 06:28:28 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/13] target/rx: Use prt_ldmi for XCHG_mr disassembly
Date: Sun, 15 Mar 2020 14:28:05 +0100
Message-Id: <20200315132810.7022-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315132810.7022-1-f4bug@amsat.org>
References: <20200315132810.7022-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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


