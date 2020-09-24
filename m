Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E33C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F0B206FB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="u1AZlqL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F0B206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNGd-0001gE-Bg
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLNG1-0001G7-Gy
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:09:41 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLNFz-00040m-Q3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:09:41 -0400
Received: by mail-pj1-x1043.google.com with SMTP id b17so1283191pji.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=B0uxJ07z57G4A0Wf5srUqB/iSb9zi30R6BwAFVRDubA=;
 b=u1AZlqL9y3F1STfTso9hW+jUBO4on5Hme5DxSsnEcbUq3iwTTLyyec3idaIsmoMn+R
 i7meU7tYNOMc2UvRDWI/cB1DLnq3iyDwUqQo8s/20BY9LIHaBozDYnKMMrO5sAKPG6Ps
 TnE49B01ZvKNzj7oRrbr8WKYNEnhsKOlttoAIKu4xyw0A6QAxGdXBxvjd2u4YFuAt8/G
 FMZSwpIWO3CtoKM+0/PkOxK1dOU1+QtvSzMyg+WSFnTVdVdtzzW2QxCShPR00k6amFqv
 Q4J2fTLYj6IKtSaRJYDPXZQjG3SmlxN8DrvdmPz8fU/2pNCZjIfrfYn6I02wQQwIARNQ
 V8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=B0uxJ07z57G4A0Wf5srUqB/iSb9zi30R6BwAFVRDubA=;
 b=G1xi/+4Wv0LO/YuHlLO7zd+LPd/q3QdMyb+3s1Y2bVLA0Y4THJarogAbz35tBa8q+T
 vbIUYhOXMuvqMKVjLxv1a3Coj0tIDUvdGTz4dxAcFwUtxaRFIf7pq+IdPC8rrwqrFXwF
 s1IzZSX8GslU/FCVpf70HwUovOKiZpUjbwO4vgLwaDQ+VRMVxzif0Bp3VzzUh/NmSNhF
 /yyidU7nAomAFNDf5wagPypx31XBAWqWITzDOZQejMGpZQzbQjRC+wIYy1uhlZoOE1uE
 o+Jy/5nVP2gzlNc0j3NKoBMZHxSpP4H0iV2L2SEAHdz4EPuUSHi+a16s85RsSVtJ1OTM
 l4lg==
X-Gm-Message-State: AOAM531TUjkuwAoJ036itjDvlQrb9IAQ9uRk6GghZloPfde4mJ8Ym7Mt
 UkZhvc8NnW6t/MQi/o/BJfSm8FPOlSEHi1G1
X-Google-Smtp-Source: ABdhPJxFqV0rz2NmUzHX65J+eOn0nPOoMqJJFIv2hnz2p95kYfh9wfSxqUmtZR0O7TUYWuC3rOIVcQ==
X-Received: by 2002:a17:90b:f14:: with SMTP id
 br20mr3024135pjb.24.1600938576929; 
 Thu, 24 Sep 2020 02:09:36 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.162])
 by smtp.googlemail.com with ESMTPSA id
 y197sm2127478pfc.220.2020.09.24.02.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:09:35 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] Add a comment in bios-tables-test.c to clarify the reason
 behind approach
Date: Thu, 24 Sep 2020 14:39:25 +0530
Message-Id: <20200924090925.18915-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A comment is added in bios-tables-test.c that explains the reasoning
behind the process of updating the ACPI table blobs when new tests are added
or old tests are modified or code is committed that affect tests. The
explanation would help future contributors follow the correct process when
making code changes that affect ACPI tables.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Changelog:
v2: cosmetic - commit log reworded.
v3: review feedback incorporared and actual comment in the code reworded.
v4: more updates as per Igor's suggestion. Dropped some comment lines. added
    ack'd by line.

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index b514b70b62..34e2e1c55b 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -11,7 +11,7 @@
  */
 
 /*
- * How to add or update the tests:
+ * How to add or update the tests or commit changes that affect ACPI tables:
  * Contributor:
  * 1. add empty files for new tables, if any, under tests/data/acpi
  * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
@@ -38,6 +38,11 @@
  *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
  * 6. Now commit any changes to the expected binary, include diff from step 4
  *    in commit log.
+ *    Expected binary updates needs to be a separate patch from the code that
+ *    introduces changes to ACPI tables. It lets maintainer to drop
+ *    and regenerate binary updates in case of merge conflicts. Further, a code
+ *    change is easily reviewable but a binary blob is not (without doing a
+ *    diassemly).
  * 7. Before sending patches to the list (Contributor)
  *    or before doing a pull request (Maintainer), make sure
  *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure
-- 
2.17.1


