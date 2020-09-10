Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7467C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277C2206B8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itRG7zEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277C2206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK2N-0002i6-6H
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJy6-0002sv-7s; Thu, 10 Sep 2020 06:38:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJy4-0003m6-I4; Thu, 10 Sep 2020 06:38:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id l191so4023128pgd.5;
 Thu, 10 Sep 2020 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K7y5ZJD/cG5cMFm0+/8rHEDw15+8VS3xMSK8qF/3N8U=;
 b=itRG7zELBtlvSk4lp/xapCo3jDgHecD7aaSCd9aSJ7j3FwEXd3nyeU8ExemihDPg45
 6jiyrW6pIrM/m5Uic2MIWTCztzMThj1EexoRlZhhxf/H4vSXxCxwbHg3kZk4dGZrmBEH
 KrTp4YjsCHFjIAoGpwds1vd6bUh+hxyz9KyoYJ+7K12BtXDInIi9Ro/b0n+VrqaJgL1c
 LI1h2r6aS105aBoN9JZ9zdBHGHtqnb+48Ly/smx4vbWfb4OQGTwbho5NoYnEbLC3CI6I
 QzALFDpnLOkJRuqLXWLR7Ld4+yXi/HNQ5lIvw86FXrlze1hpwb/zQXLnPA2tx3H1goJ9
 sbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K7y5ZJD/cG5cMFm0+/8rHEDw15+8VS3xMSK8qF/3N8U=;
 b=fAorhVdyZtZhVzHD4OiXxa7xVyaH++PBGG9xwVo9ZI4k4XSoY8ZPYJPFp4lrv+gtaM
 YP7OfmHfQd78vi75U0Yqd3ZotgykkgANyEzOv7/s7PWD7xFRPQm3isa7fOdOnudxKYHL
 64qxvwq/nsDrodKRvmbpoiQFLLiEMbERkaL0p9J+a67UrAi6X+QEaHG7UWv35r/CcHNA
 D5CiaswfIWAK6Z/+JfGszytA9B2GtOAs6wLpMOK0AXSbyTlA1Iq6R/iRzQm+ZHYUa0nn
 vWJE9fYZAFZ2k57iOr4bDMMu5LyecF/4KRcEp9xZO0QS1wuy2f9QBTsTIhjwJqVQIFTd
 lqSw==
X-Gm-Message-State: AOAM533fqa8je74ynVeYw7/2LCu9/v9st9EU44fO3KMBD05oL/cqU4Sd
 3SZf2Ea+Ar7NL3G8KPk+cotgC23QlTcGVJ915BA=
X-Google-Smtp-Source: ABdhPJzHqItAQkAbMm7aRHILlHp2LtTk4hmK7Oj+3JOZoJgKZ4ZYXFs7WqiZ0Xa4Ou04aoUXCEkh+Q==
X-Received: by 2002:a62:52c8:0:b029:13e:d13d:a07c with SMTP id
 g191-20020a6252c80000b029013ed13da07cmr4926373pfb.19.1599734294019; 
 Thu, 10 Sep 2020 03:38:14 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id 99sm1781191pjo.40.2020.09.10.03.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:38:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 24/25] rcu: fixes test-logging.c by call drain_call_rcu
 before rmdir_full
Date: Thu, 10 Sep 2020 18:37:24 +0800
Message-Id: <20200910103725.1439-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103725.1439-1-luoyonggang@gmail.com>
References: <20200910103725.1439-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

drain_call_rcu is necessary on win32, because under win32, if you
don't close the file before remove it, the remove would be fail.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-logging.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index 783fe09a27..8b1522cfed 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -210,6 +210,8 @@ int main(int argc, char **argv)
                          tmp_path, test_logfile_lock);
 
     rc = g_test_run();
+    qemu_log_close();
+    drain_call_rcu();
 
     rmdir_full(tmp_path);
     return rc;
-- 
2.28.0.windows.1


