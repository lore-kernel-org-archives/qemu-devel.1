Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C111BC4727E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDD320760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJo0/0Oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDD320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhdI-0004vl-78
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQT-0003Q4-Sn
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQS-0001Xr-4X
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id m6so12258630wrn.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NS6L75PHdbF1zs4u9dBK9m9xVUve0wzYaHJyBJ9jZSk=;
 b=RJo0/0Oid3bifvTEA8xmSe6UNU9M0jpA438xvMX1Q9D5xzAQkcJjFXTFu8R3NqmMqr
 5tDVtRkOmmlJBO+wQ/G8nHYcd/ZFXtnhbN3PduUUCKwi5NXBeoN0YgWF7Cr77QauFDjH
 6K0T7I3ZUtzAEkPhTAUdr6dLvqA+PWabaizfLnZ56KbvgamiHp86bAbcml5j2AfS6BpI
 /7TM+AV99aHjR+9D+qlmigAgWgKg4Xf5mWbYKgm97tZrWnJP9fexuJ0cKRzewB8sx7WR
 SKyxpQZHDuzl5kc3vFu0ynlSp0L1GJ0YlqwV0429NQOcQ+W05rCUYCFJS6vEFASluGJG
 HKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NS6L75PHdbF1zs4u9dBK9m9xVUve0wzYaHJyBJ9jZSk=;
 b=TNLh+rV23Ji3+8HP2xRtTpOt5fIRcMupGoaLsPfxAfiSU92PZtS9V0TfN25tGebIJH
 FmB37RIsitT1dukzdM3PuvvnvHaMvfu+EUT6cdAbu7BQbbGhPyVMT+9uhN+ZaCyJOILB
 O+Q/BreGW9uKurDQWpsufXjGxQMfrZU6WRbnSfEwxjfFV4yB/ksZQRZApYDzjJ4dQxLE
 e9ZkR1FlHWIWxUZfc0XQse5/eZW7ynODX88I4cQ+rfEy7QsRULTQz18niVydgwrgaXYn
 J5UK0KEdwTYbqMTKnwW2w37iopn9eZPhBSJB+eTLAzmYDbcYXP0QP+RIMNlL68Rh8O2J
 9tJg==
X-Gm-Message-State: AOAM533D1iG1CDvXtvNggpVbYkmeEgPm/uu3EOclxqGEi6B8m1zUh3FL
 dQ1PfZEaeYZfSaH7ELZjmoZYzUgTUB4=
X-Google-Smtp-Source: ABdhPJz+NGF42xhZ/yLzjIpq2ZIEaf19/zJDXEsv7o9NDV665hJx1cFmkykMaDGS6RBZspXd2HcOxw==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr3243417wrm.355.1601969418495; 
 Tue, 06 Oct 2020 00:30:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/37] replay: create temporary snapshot at debugger connection
Date: Tue,  6 Oct 2020 09:29:46 +0200
Message-Id: <20201006072947.487729-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

When record/replay does not uses overlays for storing the snapshots,
user is not capable of issuing reverse debugging commands.
This patch adds creation of the VM snapshot on the temporary
overlay image, when the debugger connects to QEMU.
Therefore the execution can be rewind to the moment
of the debugger connection while debugging the virtual machine.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

--

v6:
 - dropped unused error processing (suggested by Philippe Mathieu-Daudé)
Message-Id: <160174524096.12451.11651270339216758643.stgit@pasha-ThinkPad-X280>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 gdbstub.c                 |  1 +
 include/sysemu/replay.h   |  2 ++
 replay/replay-debugging.c | 14 ++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index ac92273018..f19f98ab1a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3321,6 +3321,7 @@ static void gdb_chr_event(void *opaque, QEMUChrEvent event)
         s->g_cpu = s->c_cpu;
 
         vm_stop(RUN_STATE_PAUSED);
+        replay_gdb_attached();
         gdb_has_xml = false;
         break;
     default:
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 172b20c60c..56c0c17c30 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -94,6 +94,8 @@ bool replay_reverse_continue(void);
 bool replay_running_debug(void);
 /* Called in reverse debugging mode to collect breakpoint information */
 void replay_breakpoint(void);
+/* Called when gdb is attached to gdbstub */
+void replay_gdb_attached(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 30ca38e5dd..ee9e86daa9 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -318,3 +318,17 @@ void replay_breakpoint(void)
     assert(replay_mode == REPLAY_MODE_PLAY);
     replay_last_breakpoint = replay_get_current_icount();
 }
+
+void replay_gdb_attached(void)
+{
+    /*
+     * Create VM snapshot on temporary overlay to allow reverse
+     * debugging even if snapshots were not enabled.
+     */
+    if (replay_mode == REPLAY_MODE_PLAY
+        && !replay_snapshot) {
+        if (save_snapshot("start_debugging", NULL) != 0) {
+            /* Can't create the snapshot. Continue conventional debugging. */
+        }
+    }
+}
-- 
2.26.2



