Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB2C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7132D20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8emhfso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7132D20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGj4-0007R2-JQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUd-0005tZ-6W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUb-0001D1-Td
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGUb-00017C-Li
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id 11so282009wmo.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/er0YYsHIwE0mZN9mnJ6X1m0HeTDXCeZYTdLs35Tmio=;
 b=z8emhfso8Got270aizEytcNYUCxFPHHSre6nGBDWQVuf1JopFRdnTOEYjkBk80UVEi
 p86OHjGiGfgiux1z5sti7OwuSiBW3svKHweTR6tqOTOUdVSTQtU6wDEroY/CJL9mvlyH
 WTp4+1IsCLGGD3s4ie4YKlH3GAIKwvnUMW1snNpYpvIxrDALlKqBftNvE6FT0xFmDn/a
 GMzGB/8sHAwGfO1oVsC+Qa+EDAwQWZO+ptM9ZtLwnbH6/zFe2E2Pc1cC2NWOsECP7Kkn
 pdkVJBymlrR8Q3DgVIPLSo7VNySm9twYqvaA2YDY4nSl1Eb0b1odtPFXupvyc7bHN1v8
 EffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/er0YYsHIwE0mZN9mnJ6X1m0HeTDXCeZYTdLs35Tmio=;
 b=fbRzt6FeJy5EnzIkIFQFsiB5ryV1IGqSiXiXeYAUO0My+UASZXCJeJg+hWQSOEi6IW
 KrmNkq0S+GRNICTZ0Q/Ah3iBuFCGAEazSDrqN/hwRrAn8oiVgjXk/WQLvW/mm6bVAWAd
 0cUQIKIs3pRYpovu2RLeMeBapMGdaxHGmiFnQmxKwToEOngq6QgJcHhz+CAif3rityNL
 TfAiT0Qs0gy9rGTqNIqeAaKz0hP79r4qufzv63XqxdHNYTrGe6Y5MBdbQtsTh0wsRIra
 ndzFC8lxb7xAbzlG/kxG1Okdar95Bwr6fjbxsxKpvTFddw3Wggz1ZZY8TMr5g6+F+nOn
 9kMQ==
X-Gm-Message-State: ANhLgQ1/PPE+FuGjaTiKFpINLOCU/6cPVlFA3g07Id9hc5D0sK5SAM+K
 uqfCKsrfWyb3v8Wwi6/fa9IUWw==
X-Google-Smtp-Source: ADFU+vtWNa6cXqeQ0LT3RkBKwVEknPNKH7B3euwtmGVwA0lU4+MkfgtUpbjYAp7brlCQMItg364gTA==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr236610wmj.156.1584467944667;
 Tue, 17 Mar 2020 10:59:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s131sm215016wmf.35.2020.03.17.10.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:58:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 244871FFB4;
 Tue, 17 Mar 2020 17:50:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 28/28] gdbstub: Fix single-step issue by confirming
 'vContSupported+' feature to gdb
Date: Tue, 17 Mar 2020 17:50:53 +0000
Message-Id: <20200317175053.5278-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Luc Michel <luc.michel@greensocs.com>,
 Changbin Du <changbin.du@gmail.com>
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
Message-Id: <20200316172155.971-29-alex.bennee@linaro.org>

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


