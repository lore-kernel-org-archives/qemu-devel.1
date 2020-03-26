Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F71C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B283620663
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icKxNZgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B283620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbqC-0007g9-QK
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbck-00038S-JS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbci-0001zl-Co
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:18 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbci-0001yT-6j
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:16 -0400
Received: by mail-pf1-x444.google.com with SMTP id d25so3539381pfn.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XWCeE/5E1HZf0ja/1RRJESpNCJLpd5hNPRFBKO5ZIL8=;
 b=icKxNZgINscLHQzuXJde8x0qqoeXNgrjWKtOxFEHuJVwQZzSoa8bQCLD44dWlVwp+9
 BMfNG++TtWZ71up4vdx5vki2E1b08GzPXuPscp4JWsnA4bQQeZZYeT9ymHWWnfDHmqyW
 Pe8u5LgMyX/xLK4fbYM/+4Pt+BwY7A7glNoM6xzEa3/L8ou1HWORqMdV1ho3zkjmuAXr
 TayBcIb6G9kr/TFuiWU+MddOdi/9BLdy5TYLsQLRPcihZmyc7QKM2b136J/QLSIgEzOh
 XRdZP3f940aoT4Y2HwsPI+Uju0+0XJP5Q2HpQl/9renCWjG0v1KFTEjVspZYORJ7gvRg
 qdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XWCeE/5E1HZf0ja/1RRJESpNCJLpd5hNPRFBKO5ZIL8=;
 b=HpIcjYOFsAoX/VyamSK+ITQT6/4M03S/UHFpyMDWCO4vB7M0OA5/Yl312Wg53QsbKN
 /xzIfE/3qqXJggDH5rDE9pjyG0l0gtvlPwqN1IELzkCOUwOfJiNoWT3kqxtvVHS82oLG
 D5phb4cC+tt0StgzTMZ4PSRw+ON3omkcnV2n+UhbuyBsR8pauunRbNXr3sDb+PCBXJtp
 UyZLerqyWoVfQpXBIntNfaq/xdCnvnccCD/ilot5HOWSVe37SOSf1RAl0HCNVJ+4krQI
 mXPFFEJiixKUpe6jky5RbJ8g7pHkEUFRjvVbzAPAJMVmITivxmykiq2w41DmWzMyb8ni
 CMiQ==
X-Gm-Message-State: ANhLgQ0+WOd7g4+AgunnLFV/v1GdY6a4BfRjAwKh2uKHvv+2KuGdqD6J
 tpF3AvDya2esRdKge1TBXLAAV2OdKH8=
X-Google-Smtp-Source: ADFU+vs+7QumS3vKSXnZJs/GYFazcjo3QHpyyw+CYnc79vfVh/t9HAM3cvMO3+3kMIQP9pjf7TxrXw==
X-Received: by 2002:aa7:8108:: with SMTP id b8mr11659763pfi.212.1585264154959; 
 Thu, 26 Mar 2020 16:09:14 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/31] target/arm: Implement SVE2 bitwise shift and insert
Date: Thu, 26 Mar 2020 16:08:35 -0700
Message-Id: <20200326230838.31112-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  5 +++++
 target/arm/translate-sve.c | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 756f939df1..9bf66e8ad4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1261,3 +1261,8 @@ SSRA            01000101 .. 0 ..... 1110 00 ..... .....  @rd_rn_tszimm_shr
 USRA            01000101 .. 0 ..... 1110 01 ..... .....  @rd_rn_tszimm_shr
 SRSRA           01000101 .. 0 ..... 1110 10 ..... .....  @rd_rn_tszimm_shr
 URSRA           01000101 .. 0 ..... 1110 11 ..... .....  @rd_rn_tszimm_shr
+
+## SVE2 bitwise shift and insert
+
+SRI             01000101 .. 0 ..... 11110 0 ..... .....  @rd_rn_tszimm_shr
+SLI             01000101 .. 0 ..... 11110 1 ..... .....  @rd_rn_tszimm_shl
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 1d1f55dfdd..7556cecfb3 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6351,3 +6351,13 @@ static bool trans_URSRA(DisasContext *s, arg_rri_esz *a)
 {
     return do_sve2_fn2i(s, a, arm_gen_gvec_ursra);
 }
+
+static bool trans_SRI(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, arm_gen_gvec_sri);
+}
+
+static bool trans_SLI(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, arm_gen_gvec_sli);
+}
-- 
2.20.1


