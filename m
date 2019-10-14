Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6744DC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A2D2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KptkjTR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A2D2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyRx-00020Y-0j
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy28-0006ZW-Mo
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy26-00055p-ND
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy26-00054S-Gt
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id y135so14227029wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P3Npp9kH1WEA99RC652KClnJyNjkx/khNWALo0be13M=;
 b=KptkjTR4iho6sjULn/JZnjxZXcKwj6eDc9kROudfYuqhS96mo39RmT9VWreX20ymBD
 shMtkC8HQ4MrAcrn+CubmT2aYnjkknv7PdWNsgne95NpR3rkRztygnBKRgz2n73BcEZT
 J79Za0ytM23d8sefg7erpOsNpUuHNUCdSUnbXW8h+Ak4Fk6ujAjrE2+4LQQ+qYAWV5x5
 DWS85o3lNHDCMzhadotqaJVRat4ti/0ft0Yz205vLIAmZVVWc9YGY8/blQh1ZgG/ybNe
 K/6I1e/MyPS8BLgxKhu2aZ2XCM6IURn1xXnY2pausRtLZISTE4o+T0AHWe77uMJtCBgF
 YlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P3Npp9kH1WEA99RC652KClnJyNjkx/khNWALo0be13M=;
 b=OTNngGbqBB/kASGPd8Ww1rlbdG7j630c3KrllOqydndJLsrJ/5cgRb18q/2a6/Cbbl
 K4TqTEr3I2KEh8zUFFgtB8P3NC5gb1IJtZMOs1T+hjZ9XYhdXZuaboALEhCjt6FFit5S
 ehLB4UGI1A7M/zwUA9HfEVqbIDcf9TKKMITycg2TQ0KO/FcoTnm2dfr1BGkMhkQ2FRvG
 C1YLu0hJJlRnLXPAF4IJnwPVyEbiDNHBowifesD2Ej1I/bxmjQ5WMHd3cww25llq60fR
 UW9lVj+aOzhtLKvbHY5KL9dQ/s00NuZ8NiBPXqT8mLAtCA1zKu1tWhluzZ373R56Pfy4
 DN2Q==
X-Gm-Message-State: APjAAAXR3467aV/u2rAdPtXp+bYlXXHOpEKm6GYLy0tHt84BEr7RLDjf
 LhUavk27IDTqse4u0+cGR3sfnQ==
X-Google-Smtp-Source: APXvYqwa6lV25ptagITy/JdAXkHXN00IKoPnMJxNReOybCN/kaV1b29NLfr6qJTZ9NKD2j6a5PRqOg==
X-Received: by 2002:a05:600c:20c4:: with SMTP id
 y4mr13169870wmm.87.1571050617284; 
 Mon, 14 Oct 2019 03:56:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 26sm13814874wmf.20.2019.10.14.03.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 684391FF9D;
 Mon, 14 Oct 2019 11:49:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 18/55] translate-all: notify plugin code of tb_flush
Date: Mon, 14 Oct 2019 11:49:11 +0100
Message-Id: <20191014104948.4291-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Plugins might allocate per-TB data that then they get passed each
time a TB is executed (via the *userdata pointer).

Notify plugin code every time a code cache flush occurs, so
that plugins can then reclaim the memory of the per-TB data.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 0a08fcda3e..6d1b0ecd69 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1231,6 +1231,8 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
+    bool did_flush = false;
+
     mmap_lock();
     /* If it is already been done on request of another CPU,
      * just retry.
@@ -1238,6 +1240,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     if (tb_ctx.tb_flush_count != tb_flush_count.host_int) {
         goto done;
     }
+    did_flush = true;
 
     if (DEBUG_TB_FLUSH_GATE) {
         size_t nb_tbs = tcg_nb_tbs();
@@ -1262,6 +1265,9 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 
 done:
     mmap_unlock();
+    if (did_flush) {
+        qemu_plugin_flush_cb();
+    }
 }
 
 void tb_flush(CPUState *cpu)
-- 
2.20.1


