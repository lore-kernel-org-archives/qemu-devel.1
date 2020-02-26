Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35391C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD2024672
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnNzvZdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD2024672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j73mi-0006BT-7B
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 16:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1j73m6-0005jn-13
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1j73m4-0001XY-4K
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:59:21 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1j73m2-0001VZ-C2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:59:19 -0500
Received: by mail-lj1-x244.google.com with SMTP id q8so729755ljb.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 12:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kevMSHiSenRMqIB/C6GZxpuQiSm20S/SQifzqRVGMiI=;
 b=bnNzvZdE3JC+bIHmgJxWTgAho53G9ykds2DugGEPMLrqR9r8OpmiHew6wf4Crfw12t
 McJXtK2dMGQAKVijmy6coTDAyd++d9OY9kC+mCYbqaF/pvZ5ALu6zmpb9A2GAuqWSe6u
 XPIAwFW9mPnU06vEhR1F37i1OYnrZFHdkytYwnqWXiHMn5ociKn/tNOWptlW5C3F1VPz
 TtghOC1RFPeWfR9i8SCvGSXjZ+gdsffreHSt/1nLGU3vo6M7ZRkFkBDOYkT3ILJED1sO
 LkfIMnJULjUCX7HkY/NUqhMlEd6xkDb9KtTDqxj547ElgA2/OrqcFNkBCNp1QSaHv2f/
 b6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kevMSHiSenRMqIB/C6GZxpuQiSm20S/SQifzqRVGMiI=;
 b=t+H0qsPaNodPVt8b3FJt5M+boQBczs3vS7snTUUiK2mWGHpu2gBjE4LblxZf7adMY2
 xdifLJjVqd2TD30fB17WfaiU80WqxvNv5H7OubloDxzXIC3kL2DIAUrubAgBDFpM70MV
 FAFf3bSgkIM6S47PbvDcULgPAVR26LdN/zPIf/ultUB7eeeeMljX8V53VFEvdk6Mlixh
 89dLPZV+DGMLQuyKSWYct8hyZQpIyfQE1O34LT7H+BKgKFMRyO9Qa8kl9I6gOIlp5yrn
 vwpo9WY+cW2bfMuscTjFV8/v+V5qa4+q7jNzE0CaxtErxZdMPvOS3VZ9oKGUx6UJOfkL
 rEdA==
X-Gm-Message-State: ANhLgQ3tU5BvulTyoo0vs1Ok+sffPRrzvVUwbsIKBjIxyWnGBiUXrhzf
 09TyurymlwO6CKTcX/naAM7jEiUf
X-Google-Smtp-Source: ADFU+vuDq/D7Q7mh13xR/vC7N4iM8rt2chiY/GsXNvBEf/j727s4O2exwmWMxM1oaESaYndmqk7xOQ==
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr529615ljh.136.1582750754852;
 Wed, 26 Feb 2020 12:59:14 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id v15sm1534437lfg.51.2020.02.26.12.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 12:59:13 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/xtensa: fix pasto in pfwait.r opcode name
Date: Wed, 26 Feb 2020 12:59:02 -0800
Message-Id: <20200226205902.32439-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Core xtensa opcode table has pfwait.o instead of pfwait.r. Fix that.

Fixes: c884400f2988 ("target/xtensa: implement block prefetch option opcodes")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 26dceddd2f22..665879793153 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -3742,7 +3742,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "pfwait.a",
         .translate = translate_nop,
     }, {
-        .name = "pfwait.o",
+        .name = "pfwait.r",
         .translate = translate_nop,
     }, {
         .name = "pitlb",
-- 
2.20.1


