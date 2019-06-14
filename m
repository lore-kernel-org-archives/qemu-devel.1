Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1FC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C372183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liNlhIYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C372183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpnG-0002gb-Hp
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkE-0000S1-Ug
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkD-0002we-EF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkD-0002vU-5a
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:05 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so3321244wrs.5
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bJlRK12NgWRhW3McWfNYPpf/1E3ddcXa2ZT9Jrrle8U=;
 b=liNlhIYrR8Z2D81wKr24l4CaxT63ZZlnWOLIYKEA1hOU1+VGh8aZeU6f7EXWrBFNft
 7vjeWU61sMupXH7ZrVWJ4hrgHbTYvynUf9+D15GulLp1eE1xu5vvsmfLVTVhakEt7AsQ
 xlRMjzIz15yKUp3wXeUnOvWVGZFiropttAWk8Qh7ud0xC3bWHgSTAN2K9P0gJ9G+5bFp
 HizKJLAr2DJhPu/G9cMoXOLUEKG9ftCssd6lnXVNwHTJ7rXBB586jixWQWeMt/DbjrLl
 EE9vFU7V4LGGWXiUqZcOxkmS3G4wtFMovfkFLwuqc41iKcsBLRnNZ35ls5Nbv9qIIWxS
 lSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bJlRK12NgWRhW3McWfNYPpf/1E3ddcXa2ZT9Jrrle8U=;
 b=EI6fWtJxNgJGtP9Ha+9XnM3IpYDAnZr3/pJY9CqJih0VoaAKAh+HXpaZt6wIGxp9P9
 CtYUGSdqL1VXau6aYWee0g2EsZY9Fp2MWQNiMDrdFD/6n6dnzTs9gPpAxn7NEdiwvXTq
 d6OrariCsllR5lvBJ95dXfDI+50K7VY8W7fjVVuRuvBMO/5oiqiGhQE8KTmkYRMSOb6L
 9wKbdHc3xjQc2BL2qQ6dmy5bgv9MLWWBP9UHTH5I7g7Db004AwRFrnd1J0IqKzzHk3cg
 gRaaP+G56Fkeod3ZbFXa9ADjRtRRlNUAkpWQaN7a8h696RcLPWTXvgaphf6D8dF3OEyt
 SyBw==
X-Gm-Message-State: APjAAAWEF6ZiBSPIVLXOl2Hseb9mK+z+wZ7MX+YLUlZArjbWtlo9IPa9
 ED8DgyMWznNFZLJLWscsKB0DXr5hgis=
X-Google-Smtp-Source: APXvYqw0OJnrgeBp6CxmVpNi+pYutlL6v8aJUUfQFIWNpItw/0kqj4OHO2LSNrdfWCdeGYvQIM0pcw==
X-Received: by 2002:adf:f186:: with SMTP id h6mr719115wro.274.1560532323665;
 Fri, 14 Jun 2019 10:12:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 18sm2315024wmg.43.2019.06.14.10.12.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:02 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AC1651FF90;
 Fri, 14 Jun 2019 18:12:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:13 +0100
Message-Id: <20190614171200.21078-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v3 03/50] cpu: introduce
 cpu_in_exclusive_work_context()
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus-common.c     |  2 ++
 include/qom/cpu.h | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/cpus-common.c b/cpus-common.c
index 3ca58c64e8..960058457a 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -335,7 +335,9 @@ void process_queued_cpu_work(CPUState *cpu)
              */
             qemu_mutex_unlock_iothread();
             start_exclusive();
+            cpu->in_exclusive_work_context = true;
             wi->func(cpu, wi->data);
+            cpu->in_exclusive_work_context = false;
             end_exclusive();
             qemu_mutex_lock_iothread();
         } else {
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5ee0046b62..08481ad304 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -373,6 +373,7 @@ struct CPUState {
     bool unplug;
     bool crash_occurred;
     bool exit_request;
+    bool in_exclusive_work_context;
     uint32_t cflags_next_tb;
     /* updates protected by BQL */
     uint32_t interrupt_request;
@@ -785,6 +786,18 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
  */
 void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
+/**
+ * cpu_in_exclusive_work_context()
+ * @cpu: The vCPU to check
+ *
+ * Returns true if @cpu is an exclusive work context, which has
+ * previously been queued via async_safe_run_on_cpu().
+ */
+static inline bool cpu_in_exclusive_work_context(const CPUState *cpu)
+{
+    return cpu->in_exclusive_work_context;
+}
+
 /**
  * qemu_get_cpu:
  * @index: The CPUState@cpu_index value of the CPU to obtain.
-- 
2.20.1


