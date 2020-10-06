Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A62CC47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5F12078E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vG67bz7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5F12078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhb4-0001Bf-NA
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQK-00030G-5f
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:50457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQI-0001TB-Ew
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id 13so1845667wmf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cpyQLJv0wdPNrXTFIzMBIsZDapctBMjUV4cbdzJBuo8=;
 b=vG67bz7ebTOVQJz9RT/YmTd7evzbpRD3qQJl3fsAohvrZX4eQpbbGBPe6VgEEx7ONv
 W1zMLyRAPjQhLgKmnyKFOflPD9PzgL6lPhrNyG3p+j6x/6xjvftVJjePBksiMbJwTaXI
 YStHhPZ+y88HcpkFvrDpFHDaavpMvNFBSK5jroDTS+qy1PvpHTsAEucpYGGd0ncqbG49
 vm6qnQZn1Wf9KFIm1RsyiM6t8VhfNmDAUFW9BYqCrPLl4qMckK/S4rJGhVbunf6rnMZL
 Y15qmfA+I44kmbyqZ5C0MEB+9eNg1yHNCSPIRaeLTI4izu887mEy/nebHAALTfi+qYKZ
 b+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cpyQLJv0wdPNrXTFIzMBIsZDapctBMjUV4cbdzJBuo8=;
 b=DS9dbGN6RMR4ViM9EBOnCNFHIebtBTFQz/AM84/gtsWYlf3R8ST4cvp/Hh0CWRDOBK
 owvbupzZ8T/2zdCYfDd1VlDxdtKZ9K3hucRPOr0ok4wIgz2Z8vFEczxVBheGS1X79ZJC
 qra33kzmkjYa2LZM6UcTVZnLZ7IEIWW9rwy/iR3s5QTsBUGdoaqyMxVXqJbB1ZYgj0LN
 F9M4szsTJcJt7sngemmCf9g2Z9DJWUBP0ReJ6OFT3mSoC42lJf1b+08EmtL44citbABD
 26Q8QJx6ki8TylZtPYTcwWlvt0UIgbdAjJDpuT6s/jhiQcX/NwMpjXdyVkPyObi3tjNv
 cyHg==
X-Gm-Message-State: AOAM5339mqe3LT65qfN7p085wVx2AVref/m3C/tBwylmexjViFDCYCsC
 fT0Qz4StUK1FE7+92pdxFcOkLfg0Yfo=
X-Google-Smtp-Source: ABdhPJyleGGaJRe8grVKKfHjm09vYC/FDyF56I2nW7N/1xd7te3g9UIR8VIm9pWMuVo1okKF7ggRMQ==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr3219414wmh.158.1601969408843; 
 Tue, 06 Oct 2020 00:30:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/37] replay: provide an accessor for rr filename
Date: Tue,  6 Oct 2020 09:29:35 +0200
Message-Id: <20201006072947.487729-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds an accessor function for the name of the record/replay
log file. Adding an accessor instead of making variable global,
prevents accidental modification of this variable by other modules.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <160174517710.12451.17645787545733927488.stgit@pasha-ThinkPad-X280>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/replay.h | 2 ++
 replay/replay.c         | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index a140d69a73..7d963139e5 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -72,6 +72,8 @@ void replay_start(void);
 void replay_finish(void);
 /*! Adds replay blocker with the specified error description */
 void replay_add_blocker(Error *reason);
+/* Returns name of the replay log file */
+const char *replay_get_filename(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay.c b/replay/replay.c
index 4c1457b07e..797b6a5b15 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -399,3 +399,8 @@ void replay_add_blocker(Error *reason)
 {
     replay_blockers = g_slist_prepend(replay_blockers, reason);
 }
+
+const char *replay_get_filename(void)
+{
+    return replay_filename;
+}
-- 
2.26.2



