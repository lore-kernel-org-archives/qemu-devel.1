Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C4BC55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CF2218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KI9bNO9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CF2218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNsM-0004PB-6F
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPS-0001I8-JZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPM-0004S2-VX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id x7so1542639wrl.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HOwU98RZMWneK0M8Cb/j/xjexQnSYTI0gnEif5sp+1s=;
 b=KI9bNO9iJznDXg4qmY7+MWnCr2DAfNYKkL/mxINkT5fkGgHlj+zf2VB7gR8sMC3D+L
 lnAKDWYmwJpIWNLXYOHzJa5wrrfZPSDJL9Oyuud+ZYCNloaYGiPuPaFrjzE5OferVfS2
 pqrI+AnF7d6277QXupPzXGRZdX04NuiVka6pr8HuKZXMujvIJh7n7opHw2KTbRqUBjVO
 uYO085tXcuGtLNEhNnS9lLAFWdAD7psn+GhXFsfWXImyCckv4B5ed8w9hXUW0LKGKKNO
 eE5yQDTYT+Lkg9qjr7iyFiog9IpXf+Tqiq2bT+0hT5YKWYPbyCHo8GO6dwq6vbzUuz5i
 D2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HOwU98RZMWneK0M8Cb/j/xjexQnSYTI0gnEif5sp+1s=;
 b=GdDT9tQKy5n+Js9VbqRLJtx+Nu0CE2cHdyuskoTna61cRGRr7QcGJRzTWyTOvh5hmu
 ztiFw6Gjvgsma17LRxY+qaNp/7SlplPhGbjivUdDGAhTLoEbUqMtLN/wMPu3xAiyf+ca
 RMtHfhA+Ii2ESQRFZ/1IMyhtzfvBx7P3fOd6KnoW2g1gckWs2UPwO5MmRrPiIFYNCBIB
 9+nABesFUQZi8eFK9XbHiPypFJbr2s7Ge+TNgxyH7GRKPfM3ZAc3lAvTQBIFLdFJpQRa
 N44C+LiwjgZZovY91NEJcwjeepcosZjvwlu8ir1e4sKU4fH8UA66VBBjQOfYT5i70lGb
 cCpQ==
X-Gm-Message-State: AOAM533q9VA94M9J5jl4VZAzIulwJno9dFK1N6WUFne1+FOplRoiUWaU
 5AMFW+bv75Bdhok4k5o+AfzhKzFWThyifA==
X-Google-Smtp-Source: ABdhPJz2BDlNfD67PE1TDC8dTgSGJUTGUIp3M3DbYXrx5oBfBvjXuzSlTrSRga5DH+KylGGqOdHPAg==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr2537265wrs.342.1603799092913; 
 Tue, 27 Oct 2020 04:44:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/48] linux-user/elfload: Use Error for load_elf_interp
Date: Tue, 27 Oct 2020 11:43:59 +0000
Message-Id: <20201027114438.17662-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

This is slightly clearer than just using strerror, though
the different forms produced by error_setg_file_open and
error_setg_errno isn't entirely convenient.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201021173749.111103-10-richard.henderson@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 56fbda93d02..04c04bc2602 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2675,26 +2675,27 @@ static void load_elf_interp(const char *filename, struct image_info *info,
                             char bprm_buf[BPRM_BUF_SIZE])
 {
     int fd, retval;
+    Error *err = NULL;
 
     fd = open(path(filename), O_RDONLY);
     if (fd < 0) {
-        goto exit_perror;
+        error_setg_file_open(&err, errno, filename);
+        error_report_err(err);
+        exit(-1);
     }
 
     retval = read(fd, bprm_buf, BPRM_BUF_SIZE);
     if (retval < 0) {
-        goto exit_perror;
+        error_setg_errno(&err, errno, "Error reading file header");
+        error_reportf_err(err, "%s: ", filename);
+        exit(-1);
     }
+
     if (retval < BPRM_BUF_SIZE) {
         memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
     }
 
     load_elf_image(filename, fd, info, NULL, bprm_buf);
-    return;
-
- exit_perror:
-    fprintf(stderr, "%s: %s\n", filename, strerror(errno));
-    exit(-1);
 }
 
 static int symfind(const void *s0, const void *s1)
-- 
2.20.1


