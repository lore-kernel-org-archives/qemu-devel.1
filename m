Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7613C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EDA2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9vig0vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EDA2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2PGb-0002Xf-NN
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1p-0008Ba-Vg
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1n-00079N-U2
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:08:04 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2P1n-00078s-OK
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:08:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id w26so12838537pfq.12
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 17:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/XFbLeboaSoNQ/ccFxUcDwe/zAUd/IKOGwT/LITW6bI=;
 b=h9vig0vbvh29Xz8hO6gKVTJBDADbGW53iQOLRHkc0l9TvHqjXwgnXZPWF9zB91avov
 7TcFNr4ligGApRZ5O5o/XaiPWdBGacnMR9IqiwIAvnH7J3J0HWkNiKHqoWidHBL6+ydi
 BdR0to3hCHCSv1V114WA7vT2RFMlU20GJbNgq4x1bH3iQ8Ksj7mbW3IoE8P4Tbl87W90
 0x5DzOrRltfhjqFsAxN8XsSSF3rQu5pF5+n2TbH9XT7MxQW/2JNP1vM3qbX8RLdWRVaI
 p3GTmaHN2r5j0Zsv9JGygm2sb3lEj9a4unPdsWwo1i5AOXdJq/x9PVSk+gFQS2GQlqWj
 cq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/XFbLeboaSoNQ/ccFxUcDwe/zAUd/IKOGwT/LITW6bI=;
 b=MtKGf4zzP5eI4fjbKCGkPzDwLsWaLwR+m/Ez82hirSAg2BUodzAx9WkhopUkpiAEeo
 DoGgsVMfPLjB2Ae5yLSqcnRCAIBNsIhNBxMCdytqPqsyOGg7t5XcewdAMQ/YZjyNRCMy
 ZbYI38pb2AscpoI4P8IglCi+ENGKRGz7ajUJQFQRZ8ub177ULa8jDzhrgIe6OmWB0Uoa
 DeRCyJcQRGUG9nbBTjqk2CQgFLEkpjgO7qr9Lf1eoLbYm3w4LM40y7HZ6x6J0IBLWtKV
 qMIPURQXI9rbE86B+ypF8QZxf2LJgjBBwr5jbNBu1r9jDKmHkG+bqWEKDyeNEDug2nxH
 +t6g==
X-Gm-Message-State: APjAAAVmRxRf1KUMCIN0sMFXR7SZCDugpstucGkeidABJ3BpVl3Ku6Y9
 MXcTMbIjFzsVT74Y2luWTgtNKRC7IjU=
X-Google-Smtp-Source: APXvYqyy62DkV+kWeRrzj6IQs1d/T5EU8xQR0WvhBaTuKzwGXSSYxeyvIAzVc4d7w8f4UCtjBy8TeQ==
X-Received: by 2002:aa7:8488:: with SMTP id u8mr23494563pfn.229.1566864482486; 
 Mon, 26 Aug 2019 17:08:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e189sm11691067pgc.15.2019.08.26.17.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 17:08:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 17:07:45 -0700
Message-Id: <20190827000745.19645-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827000745.19645-1-richard.henderson@linaro.org>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 13/13] target/openrisc: Update cpu "any" to v1.3
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
Cc: shorne@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the two updates from v3.1 are implemented,
update the "any" cpu to enable it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index f96a69e278..506aec6bfb 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -129,7 +129,7 @@ static void openrisc_any_initfn(Object *obj)
 
     cpu->env.vr = 0x13000040;   /* Obsolete VER + UVRP for new SPRs */
     cpu->env.vr2 = 0;           /* No version specific id */
-    cpu->env.avr = 0x01010000;  /* Architecture v1.1 */
+    cpu->env.avr = 0x01030000;  /* Architecture v1.3 */
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP | UPR_PMP;
     cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_OF32S |
-- 
2.17.1


