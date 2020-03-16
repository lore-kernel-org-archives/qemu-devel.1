Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A5BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872FA20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZ3O3rJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872FA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtuW-0005YU-Mm
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRj-0001Io-AO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRf-00024w-4p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRe-0001uD-Q7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:30 -0400
Received: by mail-wm1-x343.google.com with SMTP id r7so13797952wmg.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7aNXZAoL0fEr8CHp9NIvYI/wCGleSQwEmfp3SuRJ1II=;
 b=GZ3O3rJrzhGNg0CM8AEaKyrEvYVxBCL51fXVE/7hRqQr1tt/5Ncc6kWQAFdf+m8Glw
 tQYL6Kf42n+Za4+rA7MrmCCWJMYriBqjUX58jEr1jL/ZVnTvONbtZpqJWtCvm+eb7H86
 7f1FJxZhmaVNqES1vYNeuAgKhQYZF68R5Lfz6VHlc9zGY/74c/ZqFD/bfs+cWtJgZGA1
 YixPbCgtH/iY6scDl3mmK9qOUBKzQdil9xGrHtOISIWRdlXzsFgryw1ZDRgh06Vg3Oo0
 BxAytqJ3hN6tX8z20HhII2qudjjpkRYSThlWqB2eLVMMUOuH08Vas1H2NuzAFDx3H/AD
 Wv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7aNXZAoL0fEr8CHp9NIvYI/wCGleSQwEmfp3SuRJ1II=;
 b=RJlM6zjBiPDUEg7yXpVf26GNQxBd55ZmfFxDRx34vei7ckTmWH9MK7KQolwQr62L+u
 hefGi+kS/OI0pSCVOPtfdEg2uhqAQAdcAwUSl/uQ75hoWNRJ+gZrSO0pjj285+4xwORO
 AOVtduLhJehRnxeHPmXbSDAO9ZaCbl8vt1O78Unqzl9f6v3Jqc5ld/roUxJwnzpFH01G
 iangcy0E0ATezzdCTYvCDpDOH0WYwoxAnPiCY+DR+5/W0bqRI3UOF7h3Vw16jbVC5n2x
 CiTM6qCnzyhGXtt0XiwKYfO55UC1EuE9d7m2Xm9q4ViGAYro0O+PtcHInzm9bBcYMoVj
 mDEg==
X-Gm-Message-State: ANhLgQ2eeSW1e3kRjM9UVvCId+7KDsq6DxTqqohXp3ktBCXPbk91RXx1
 /omkoMMyNguvsTGermHcZVoHNA==
X-Google-Smtp-Source: ADFU+vsdrorSCRHex1nb95ebvHsRyd/B8fRk97wi5pQPeCfiK2sgXn0zQeixDGN9JIeVdgNC9ekPEg==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr194207wmc.32.1584379348650;
 Mon, 16 Mar 2020 10:22:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s22sm414601wmc.16.2020.03.16.10.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EC0801FFB5;
 Mon, 16 Mar 2020 17:21:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 28/28] gdbstub: Fix single-step issue by confirming
 'vContSupported+' feature to gdb
Date: Mon, 16 Mar 2020 17:21:55 +0000
Message-Id: <20200316172155.971-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>, Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Changbin Du <changbin.du@gmail.com>

Recently when debugging an arm32 system on qemu, I found sometimes the
single-step command (stepi) is not working. This can be reproduced by
below steps:
 1) start qemu-system-arm -s -S .. and wait for gdb connection.
 2) start gdb and connect to qemu. In my case, gdb gets a wrong value
    (0x60) for PC, which is an another bug.
 3) After connected, type 'stepi' and expect it will stop at next ins.

But, it has never stopped. This because:
 1) We doesn't report ‘vContSupported’ feature to gdb explicitly and gdb
    think we do not support it. In this case, gdb use a software breakpoint
    to emulate single-step.
 2) Since gdb gets a wrong initial value of PC, then gdb inserts a
    breakpoint to wrong place (PC+4).

Not only for the arm target, Philippe has also encountered this on MIPS.
Probably gdb has different assumption for different architectures.

Since we do support ‘vContSupported’ query command, so let's tell gdb that
we support it.

Before this change, gdb send below 'Z0' packet to implement single-step:
gdb_handle_packet: Z0,4,4

After this change, gdb send "vCont;s.." which is expected:
gdb_handle_packet: vCont?
put_packet: vCont;c;C;s;S
gdb_handle_packet: vCont;s:p1.1;c:p1.-1

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200221002559.6768-1-changbin.du@gmail.com>
[AJB: fix for static gdbstub]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index 9ae148cd1ff..013fb1ac0f1 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2130,7 +2130,7 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
         gdbserver_state.multiprocess = true;
     }
 
-    g_string_append(gdbserver_state.str_buf, ";multiprocess+");
+    g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
     put_strbuf();
 }
 
-- 
2.20.1


