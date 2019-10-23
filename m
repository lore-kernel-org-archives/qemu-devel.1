Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D5BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D097C21872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHgiuslL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D097C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIO0-0004FZ-Pv
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8u-000898-1U
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-0001F0-8x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:43 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-000148-0t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: by mail-qt1-x844.google.com with SMTP id w14so32711138qto.9
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EExBny+oAa/2RvpDTj0xViQxKJSM6o83jutlTagIpwU=;
 b=BHgiuslLxkJnigYSTvXdCp93fuQwDMVJ7gYL9ag7+xEwTumXP37XSSYwnGjBFlatKB
 at+nvPaGK6BBWW50B/yicOwTFh6ZCIHwJzCDhbFjGMI6U8DX2ZRiS/h/AiZ39Mrj7oPq
 rPfHVnBiFF9R2M4p46YflPHFUlrE7LncC8MEh6evKEAJh6MNwby61IFzaIF7Ys51Xns5
 VtGHmRU5em1h6YINFvzoWWHPqWanK43+p1cibz0M0/sbN2meUWUMEzslx4RsQWbX4Dqd
 v5ycHBiJ7VE6aN8Zf1o9it3QwYsk1c3k24obdHUWupmlvov/9ux1gjO5+QtwF3ksf8wK
 /4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EExBny+oAa/2RvpDTj0xViQxKJSM6o83jutlTagIpwU=;
 b=bROpsUkW/yBsdP1NKFbBNi6yU1DeZhYvxWJ++1eF2hjfjmWhWSYX4XcPtogItQN8/L
 0gHsuFL4F6QM94YCWUejXS+gUU+xApf98Gu+SffFbQd18zwlW9ccZ9nh1YZr1Spu78rJ
 QCfUUHvVGApo8wQA/boycpt1wHRi92Fynx+dMJQEOY0vcy6ni3x+Lu8phFC7N/7hYtLA
 +j3IYyfTRPFlGni8nxdRaL8hLBfQXKMeTv/6Rld/kMVh76lm9JzKB36lhxPqDWmikSrE
 MDYT+sHky+XVOKBu0q0ZyWJhl/+dEiE2HDmB3nhrmGYE82547wjuGtvTXvE61JoaA3d1
 0pbQ==
X-Gm-Message-State: APjAAAUVGdsRA7ZrFLPkUNLSrUeEF/q+vJ/vf6WWGb4nCd9dmCp9oC1Z
 APXhURzQEAhf6/eDYzVRI+w7XPk9E/g=
X-Google-Smtp-Source: APXvYqysAqnIEIVoLcGcmM9AA6zb40vpUTcNOAaxXWd3N9zEQETvfzVtMfnR3XLKMZy8Qk/Wjr/jzw==
X-Received: by 2002:ad4:504c:: with SMTP id m12mr7250814qvq.52.1571842873178; 
 Wed, 23 Oct 2019 08:01:13 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 08/24] target/arm: Split out rebuild_hflags_aprofile
Date: Wed, 23 Oct 2019 11:00:41 -0400
Message-Id: <20191023150057.25731-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a function to compute the values of the TBFLAG_ANY bits
that will be cached, and are used by A-profile.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1cd54cc93..ddd21edfcf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11106,18 +11106,28 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_aprofile(CPUARMState *env)
+{
+    int flags = 0;
+
+    flags = FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL,
+                       arm_debug_target_el(env));
+    return flags;
+}
+
 static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
-    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+    uint32_t flags = rebuild_hflags_aprofile(env);
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
+    uint32_t flags = rebuild_hflags_aprofile(env);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
     ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-    uint32_t flags = 0;
     uint64_t sctlr;
     int tbii, tbid;
 
@@ -11262,12 +11272,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
-    if (!arm_feature(env, ARM_FEATURE_M)) {
-        int target_el = arm_debug_target_el(env);
-
-        flags = FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL, target_el);
-    }
-
     *pflags = flags;
     *cs_base = 0;
 }
-- 
2.17.1


