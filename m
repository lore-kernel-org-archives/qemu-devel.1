Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1E4C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66EF20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixreZ99d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66EF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04q9-0000hb-TX
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hz-0000gX-V2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hy-00038D-UN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:15 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hx-00034p-M9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:14 -0500
Received: by mail-wr1-x444.google.com with SMTP id u6so2986488wrt.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0hFySE3Hou0OiDajW5Nmty9K6sqgPFavnoNsO7kOd/I=;
 b=ixreZ99dT+kEqJOnn5h1eaqhMY8BTEnxGKm2bQVWXuKsdd4m0gHuYXXvAuzZvZQ7l2
 f+4i3Avln7bIJgytvpdQ94DB1C4I0JGqaGnSVbn6+OxyF2YVo2I2B3rZpzhGcbhGAr1P
 UHZo6covAfApu00DzEPXDuxJZFkapxvTEHOMVjm8i/YJ1dz04uOQ8B52M98rMUo9F0pr
 2pR8HAoraOcJOQAR6zzb5EwuJ54FJTHVMX1pCchdfBny1Uf+m8wdaakec0lHJHFqE4tn
 Plnju3e63ASqc1jAEM3rvotjx4jNrbkqHOqRpDamXfucf/lWNb1oiYSER/A4fZPmgzpq
 K6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0hFySE3Hou0OiDajW5Nmty9K6sqgPFavnoNsO7kOd/I=;
 b=AkAUZHbfEWRSGMKh64h31qCbz4MQx90IsoIXFXIGCMVAfuo0EO3JBTDEGKQzNGVs5D
 uyqzogmmlFbrRn0LPNHbx2QwUXOulweqFZSAuX4AXlu70ZaHY+1pAczyH80NEEy++udp
 /FXo7SiJtcbSBmMk5lsojiwVzQrdUgeChMgk522UmSjbWjROO14OPOFp142yzE0NRriz
 RmHCStTb2gOTgls5ZUIXFlvzYuMuKiD/obcpjurFJRM+PkTeYjJbflKxQ3xxpzf7Vee0
 gVBh1o0Y6vfV9xG4vRDhZdeW11zwiZG6G5EdUr+LxaIOTjvxQi7TkJuh3uAzeUHPGE9J
 Rw+g==
X-Gm-Message-State: APjAAAVnJe+E1LK6d4nS7CG4HAr1Fy5ubNbLhYkVUFEEmiZurFcPFT+u
 tZVKP7zKbP/2Z8pRcGkDToifuWmWUMQ=
X-Google-Smtp-Source: APXvYqwnAuZuJHoXZxkE6/+WvUTglA+v+JvNbOIw7I1VcFPg1vcNOMFAjIfUagKkFyP2qJi/xixFQw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr5034702wrp.1.1581086052353;
 Fri, 07 Feb 2020 06:34:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/48] target/arm: Update ctr_el0_access for EL2
Date: Fri,  7 Feb 2020 14:33:20 +0000
Message-Id: <20200207143343.30322-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Update to include checks against HCR_EL2.TID2.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-25-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e41bece6b58..72b336e3b5d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5264,11 +5264,27 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
 static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
-    /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
-     * but the AArch32 CTR has its own reginfo struct)
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TID2) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TID2) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
 
     if (arm_current_el(env) < 2 && arm_hcr_el2_eff(env) & HCR_TID2) {
-- 
2.20.1


