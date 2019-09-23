Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F7C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8CE20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQZ9bhlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8CE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXQ6-00027r-6e
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJb-0005Y1-2S
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJY-00082F-3a
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:18 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJX-00081W-Qm
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:15 -0400
Received: by mail-pl1-x644.google.com with SMTP id s17so5724938plp.6
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QCKS3yxfLQ4jE5yT+JsFmTOrmseheZBe+jPLNTKKzwI=;
 b=tQZ9bhlZ78sLR0JmELQxY75Ky/qNTx8OOgpz52R5Uw8qOCjxeKwQWqX2aKHXYGKMsd
 2oWixByLYfif6P7v505svSGt1w2akl0C+1u8K/iWFQ9yN9Odb2MsI8ZIEfgd1LUwV18b
 hKwGPwukX+/AZtWCThzPvy8RNy19/h9KStpRoTFqJa/EYsdvfa0II9TFjeqDRirgBmrD
 ALuRtmrMV6/sdCIbZKK2vjIebEUpJeDE7StIABJjmyN7aWjhhV9AV9oN3t5AHY73Muaf
 iTBjiNPh6FFxmbSiRVTk7LHo3dvztMOdKPW4AjWI5/l8lBP/RGVI8TBeK2wh7S3lZY7P
 QHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QCKS3yxfLQ4jE5yT+JsFmTOrmseheZBe+jPLNTKKzwI=;
 b=tRkSY02VQCJlLIaNOxDfwIAf7B8+I2IlDdHyGN/n3dyDghZtAaV2QfU7aNMEkcRadQ
 afPUHlFMRdmKIBPaHeoHblqrN9x/UZTpCkIwe9Eip+64DntIDD+0gYSTGb2IQsUJamb+
 zwuJwUroUFRWm2vuTizRq6glplb1iU7QUzT81piZXS1U48HOTzMCcJfq2N1si42ctzwS
 Gz80RdZEB98gHtoTB7iccOOdXBarR+hfRIyHHxzhlc8qgwuF0HVVACfXpclYHvMtZ57r
 qFM74Rd2oNq7VWjyPBFbGoC8HLbQ9L+SUQj6AsEWAXo40AhqIpFyA/4tovhBhIv7TmRU
 gu/w==
X-Gm-Message-State: APjAAAXzM0FuwK+EbrSs34ctXi+eAX5Bhta9P/Gb+waZLhu5oTsKZ9LS
 aR/3Ue2c5+uSWaOx6CQPA5AYfNaTzro=
X-Google-Smtp-Source: APXvYqwFZaw2LXpvZuS8D76JQ543UEyNG5l3d2ap3N4S/lcMv/GvAO44UKu1ATvRm2oyYE490l/Hfw==
X-Received: by 2002:a17:902:fe12:: with SMTP id
 g18mr2107665plj.97.1569279614328; 
 Mon, 23 Sep 2019 16:00:14 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/16] cputlb: Use optimize_away in load/store_helpers
Date: Mon, 23 Sep 2019 15:59:52 -0700
Message-Id: <20190923230004.9231-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Increase the current runtime assert to a compile-time assert.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2222b87764..e529af6d09 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1396,7 +1396,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         res = ldq_le_p(haddr);
         break;
     default:
-        g_assert_not_reached();
+        optimize_away();
     }
 
     return res;
@@ -1680,8 +1680,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         stq_le_p(haddr, val);
         break;
     default:
-        g_assert_not_reached();
-        break;
+        optimize_away();
     }
 }
 
-- 
2.17.1


