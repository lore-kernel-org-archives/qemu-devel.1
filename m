Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293E2C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9ADF2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baR0dMUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9ADF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXnQ-0005l6-1g
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjl-0006gu-Qs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjk-00010O-Nl
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjk-0000zQ-Gz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:44 -0500
Received: by mail-wr1-x441.google.com with SMTP id y11so16896159wrt.6
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BuZq74AcExvB1BROkfUDXADMHwgIVYZ/lX0BGlkiD+o=;
 b=baR0dMUizp4X28H/M+VTiYNXwornIUQNw5yH4LMT5YtcsOib8onqhOUFaT++MfIezX
 OEjz/Nbz29i5CO7sp0q0Lmj2L7IxOqgGSz3NNlDhKYiTAULRLbvD9J9/76Z6WSuJXVXW
 q43DLTYRUNEbQgv5gP/ze+tkyzixekG5mrQp0PitfkpWeGv8WfpehQWrEe2nBf3xblmb
 Q89yiDXVMq3/VugTMhLNh88jC3PVzfn9om1CT4Lhnx4CpymsNtrulL4vOAtzUNyzeKnf
 wjj0vomOGp9KGJsMXrb+I6en6FJ4t3WiGV2XCgnOfcfhX/I1L+tqts5B+kwsFj6Khl2a
 JCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BuZq74AcExvB1BROkfUDXADMHwgIVYZ/lX0BGlkiD+o=;
 b=qDDYN+AUeOJSwrT0Hb39g3RHdlcfh/PeH9POXuCmjc7FadRlFyWPlwzebsOtPRqjYz
 lSMdQ1PhYyUsZKlK6vAf296udx4+wLxGNIetaTK3LRanNUpxPRi0Gnp96K2MGFSpWZX2
 lp/6TiAIVQov1u2JXGaDlMi5jEZ6wNLWj+SJaIOKXhIG+x+5RVvJluGPRjtiJxDdQAgq
 HCYKcH/UwNPXUaReGRoV+QEAkJdrLjuqOTjqR4Vrri6rY65lKYSQMUib9KBRKvOrLBu1
 xuDN7jLHB/cYMd8W4qZyJkaFXiFkmiXpWzOKTPgZB6G42Pdps8MBKwcOZ3KelGqYj2po
 BSpg==
X-Gm-Message-State: APjAAAUVkdoe/6cClMaTmPfOriOFaPFVUh+p/HXOA3B0PDnXN5JIGbXY
 tt/bRTp/d3zMi/tj6rRjf79G/g==
X-Google-Smtp-Source: APXvYqxyFRWDbtf7V7TXGYbxIhHOircUOcWdqnejsPB504YiBmESFJY9LFH23P+KyaSIdI6hM+cDwQ==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr13758710wro.209.1580720983620; 
 Mon, 03 Feb 2020 01:09:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm1995378wmh.26.2020.02.03.01.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:39 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F0C531FF96;
 Mon,  3 Feb 2020 09:09:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/17] .travis.yml: Drop superfluous use of
 --python=python3 parameter
Date: Mon,  3 Feb 2020 09:09:22 +0000
Message-Id: <20200203090932.19147-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

As we require Python3 since commit ddf9069963, we don't need to
explicit it with the --python=/usr/bin/python3 configure option.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200125184217.30034-1-f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index e75c979b6c5..75269678476 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -270,7 +270,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
+        - CONFIG="--target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
         - TEST_CMD="make check-acceptance"
       after_script:
         - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-- 
2.20.1


