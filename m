Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2CFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B180206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arwY1f4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B180206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEgq-0004W0-8u
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbK-0003mi-9F
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbJ-0004LZ-EK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id g10so8878318wmh.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4Pg7eHIFFR7duliWOM5u/d7WwTMjFuTuB8JB6dQTfeM=;
 b=arwY1f4IdKCebi4O8DulvVwQoPU+85sydRs+WtUzKPXUmJdKR6qytEDW4xA1wZ7yDG
 iMFL+JzL/VkFF0Skb2VTp6ER8SqKbY4MNnCBx9pdVZ2ekPVHA/JecHFarr4v6QULKkdK
 wbG3nbCpNV8lG6dBmhOmISctpVTkY+GJOsKML59oswJ+we5rXzscKoYnjM99sl+30fQ2
 SfaSsSZhJujHUNMhyAUptx3uM4psikFfygQh2FrZmO3c4cfQ4x+4sVifT9X7aMF2tPbR
 n8QkFvRF/eY2HwNE1CmSPnrqrCpQVH42a1WWEZMsRDNfSKHmVQBdt1AqK4Ec7XGqwX9O
 dsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Pg7eHIFFR7duliWOM5u/d7WwTMjFuTuB8JB6dQTfeM=;
 b=ATa04XMInZjsTgdMRTZFexAYuXSpOcwm9799PIRLbioAFsi1gB+ZOAhk9JTqGWb4DO
 lS0tHeTjffE8sNN9Wa/WSInwpQgUCX9OG1hJdpw4UJI/pBPQ6eEmA2KrEwjFj/bVBRfv
 60mrs/F7kC1evgwrnKHGJ4DbQ+p00Q/isV/TdKk4lq7S+tv7MvKmG2n4yiCPblHXVsy8
 6cJGGuxSC/BH7lD3m5E/ZL0/951SaAgDUKPZ/vAfxIs8EHGxOuPbwD5wBahF+K43Q/+u
 OoqtT49VW4NQF5zqHRf3a2zDe2wR32kcFr+g29WU/dPhUs8UQ+RRLY8K1Pkwd+QxiIs0
 0PRQ==
X-Gm-Message-State: AOAM531MzRwETcJYGr24qjgblsw/LnnL2kYDC34XJX8Qrzz4Ibe9NFwu
 rqq3kboqKUf/AQP14JAg3VzPeCAZHFo=
X-Google-Smtp-Source: ABdhPJzgB1DJhxgqwNgE1u07FZt03sMy8irByl1H4uz59gPeRx+0EdaTGR7ijsK3h4pYOVKUGIXLwg==
X-Received: by 2002:a1c:7dd5:: with SMTP id y204mr3152341wmc.182.1591372184050; 
 Fri, 05 Jun 2020 08:49:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm12300394wrn.64.2020.06.05.08.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F5191FF92;
 Fri,  5 Jun 2020 16:49:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 06/14] .shippable: temporaily disable some cross builds
Date: Fri,  5 Jun 2020 16:49:21 +0100
Message-Id: <20200605154929.26910-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These currently fail due to Debian bug #960271 as the
linux-libc-library has a user-space build breaking symbol in it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index 2cce7b56890..10cf219bff4 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -5,8 +5,8 @@ env:
   global:
     - LC_ALL=C
   matrix:
-    - IMAGE=debian-amd64
-      TARGET_LIST=x86_64-softmmu,x86_64-linux-user
+    # - IMAGE=debian-amd64
+    #   TARGET_LIST=x86_64-softmmu,x86_64-linux-user
     - IMAGE=debian-win32-cross
       TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
     - IMAGE=debian-win64-cross
@@ -19,10 +19,10 @@ env:
       TARGET_LIST=aarch64-softmmu,aarch64-linux-user
     - IMAGE=debian-s390x-cross
       TARGET_LIST=s390x-softmmu,s390x-linux-user
-    - IMAGE=debian-mips-cross
-      TARGET_LIST=mips-softmmu,mipsel-linux-user
-    - IMAGE=debian-mips64el-cross
-      TARGET_LIST=mips64el-softmmu,mips64el-linux-user
+    # - IMAGE=debian-mips-cross
+    #   TARGET_LIST=mips-softmmu,mipsel-linux-user
+    # - IMAGE=debian-mips64el-cross
+    #   TARGET_LIST=mips64el-softmmu,mips64el-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
-- 
2.20.1


