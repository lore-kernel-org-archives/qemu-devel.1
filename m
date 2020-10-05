Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE6FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7132C2064C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z86um8JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7132C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPM9j-00008A-Fk
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmv-0008Dr-1l
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:39621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLms-0007Kl-Ke
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:04 -0400
Received: by mail-wm1-x336.google.com with SMTP id t17so7812945wmi.4
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pzlB8cgub50emfNDfPBPB6dE8W+ByvrdAxbOhcWQOPc=;
 b=Z86um8JQLUsN6b21MEE5fIsTg/prJUrGm9Bkhl6Y5C/vG5u4ClJVkva806dopclMfb
 BMB9oATltWK30QlrKsp+E3kE+bbx7oDc5wNkoNA9WD0MhPm31XqAuFhCIgH8XBlyKoKI
 wO5r3qTjosVdEDAauHbsrcXH/MSC43EjuxfJL0hBvYQ5dRU0Lquazll17H7I4I2/IqgV
 W0f+IF7kGhusBK2msxz9KNG7N2AfLwglJuyYhy2gxz6vYNDdMZJsrR/B0lMHXx4uDaFx
 0x25XkwY11DLRnW9SOvq4ZKTs3czeZHo9RBG9Aj9h8fYHQW/RpTKG3e+DGq9FTZVxa8A
 KeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pzlB8cgub50emfNDfPBPB6dE8W+ByvrdAxbOhcWQOPc=;
 b=dKgBoP5fG0DB7c+jMEgNxhW4VT0aq01JA7Nht3t+9j7CyBWg2d6Ax+4BH9MwS/Fb8z
 ENCkxKUsAkJH5G1bmAEXWoF+AYO+bVVHPv7jRkltWwFhr6i0ku2hLMAmlKTQq4dPU92l
 SuHEOjtI/Bnz2rNj0KTD7p1X6Cd3Mr8+B57jAaz2hPMKh1FbmQNyMkmtOezcRmrUulHY
 b/WtWXQA5pysAoopD34OzW3XLznWSLv36Go1GCXwUZe0E6Iddaj31zVxEbb3imB2g6Lf
 PbXHe3dWyVEEu052TPN8nHAdh7/5BHadPPGUjQM7sdJTFDfMec1Ub0lKNUq41lqU31Wi
 +14Q==
X-Gm-Message-State: AOAM530+Il655hQnMO0MlzpO+4L2LzXEnTlbwgfNo9tSAkCs2Fs6qDC1
 gElueSQeQ0dBXGdCSjrDnGloMJgIseM=
X-Google-Smtp-Source: ABdhPJyCluN6dyXp4/YaBqQ72u+TDAGsOJQeVYHxAPhJVNkkcutRXTUXFUJGEm5ulGVs2AfPLu2x+A==
X-Received: by 2002:a1c:df08:: with SMTP id w8mr15722491wmg.93.1601886241017; 
 Mon, 05 Oct 2020 01:24:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:24:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/19] target-i386: seperate MCIP & MCE_MASK error reason
Date: Mon,  5 Oct 2020 10:23:45 +0200
Message-Id: <20201005082349.354095-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhenwei pi <pizhenwei@bytedance.com>

Previously we would only get a simple string "Triple fault" in qemu
log. Add detailed message for the two reasons to describe why qemu
has to reset the guest.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20200930100440.1060708-2-pizhenwei@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 70be53e2c3..17e1684ff9 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -857,6 +857,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *cenv = &cpu->env;
     uint64_t *banks = cenv->mce_banks + 4 * params->bank;
+    g_autofree char *msg = NULL;
+    bool need_reset = false;
 
     cpu_synchronize_state(cs);
 
@@ -894,16 +896,25 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
             return;
         }
 
-        if ((cenv->mcg_status & MCG_STATUS_MCIP) ||
-            !(cenv->cr[4] & CR4_MCE_MASK)) {
-            monitor_printf(params->mon,
-                           "CPU %d: Previous MCE still in progress, raising"
-                           " triple fault\n",
-                           cs->cpu_index);
-            qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
+        if (cenv->mcg_status & MCG_STATUS_MCIP) {
+            need_reset = true;
+            msg = g_strdup_printf("CPU %d: Previous MCE still in progress, "
+                                  "raising triple fault", cs->cpu_index);
+        }
+
+        if (!(cenv->cr[4] & CR4_MCE_MASK)) {
+            need_reset = true;
+            msg = g_strdup_printf("CPU %d: MCE capability is not enabled, "
+                                  "raising triple fault", cs->cpu_index);
+        }
+
+        if (need_reset) {
+            monitor_printf(params->mon, "%s", msg);
+            qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
         }
+
         if (banks[1] & MCI_STATUS_VAL) {
             params->status |= MCI_STATUS_OVER;
         }
-- 
2.26.2



