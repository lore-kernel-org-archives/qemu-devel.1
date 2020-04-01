Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E44C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 21:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482E12054F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 21:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZ4/Bcqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E12054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJlEj-00088s-Fx
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 17:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJlDO-0007D3-KU
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 17:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJlDN-0003mH-3F
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 17:48:02 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJlDM-0003bA-PJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 17:48:01 -0400
Received: by mail-pg1-x544.google.com with SMTP id o26so774114pgc.12
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xrDuAKgwVA8BL+xlHUkPyAY7LleeHRNeQBc0rfMPChQ=;
 b=eZ4/Bcqxc7kW4ZcbfK82qMKbRDPSfOrmCVJxIc/hzCJMApNt3+KiKKGS58eSPvbSkB
 DRViGYIEaONvkJkH80ajw3StNXYkjgXx+Y/mr6pdsz7djCVJ2Y4k2DWH8Sk1QYrtFUoE
 ELP3uG8zktdHVxizDeaOvtnlwhyzw5ivb8uTfynVidUUwu8Z3AcXYYvggH39FGQ2MQp+
 m6e+BGok+7aoWzKB/TDW9U26slz/CzxLiKrcZ+bvUsrFek7sD3UyP0OVjjvLEkT/l1x+
 zXtOeFI+41M/hzMd6P+gTq23qNtisFKRkhg/4kmXjdQ25gkY8lb2V/lB3ZZXsbVYtVzX
 IGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xrDuAKgwVA8BL+xlHUkPyAY7LleeHRNeQBc0rfMPChQ=;
 b=Fzwj3Qw0sVJekOxxf/KWERgKTURFVGnVs6AckbyizGKV/WJDGfL5vSZQF84AwxLD6F
 FOR5pnERyuWMeFnhkd07SSIv2H0+91dAZ0CYB9d2iELZR1hnqPE+9AboKSE4b76qWY/f
 MM1xWPC4LAOUP8yhVVIt09NgyePlMtuUOyA75M1NKLOwZT+OD4l03zXU4XrxneLeu7fe
 DcbxMVvFhZ740gP+ymz6Ndv58YUtKqmjnuFSi9e5dhRvempR53+E/PjTFc+2SAlm3P9x
 5b786XWMZlaHjeKqnzh9pCCQ9kz2I4U9BdpbqLsVm/A365WroS+wuwnzYt17lcdxcihi
 rDmw==
X-Gm-Message-State: AGi0PuZaWo0rpC/mFoCV3bnPM4++X2/QjH0TvqXKibJeeqhaP6eJ9xF5
 vvugsHYyS4vwkjwKHaTN0Yk3N2EF9ig=
X-Google-Smtp-Source: APiQypLjqORY7gZhWe9d+eLdcE4KseF/azRffQCxl7m+H5DtOapPzIuKCtGV37tn/tRBCDVBxFoqVg==
X-Received: by 2002:a63:8b4b:: with SMTP id j72mr217516pge.261.1585777677965; 
 Wed, 01 Apr 2020 14:47:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b189sm2268133pfa.209.2020.04.01.14.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 14:47:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] configure: Add -Werror to PIE probe
Date: Wed,  1 Apr 2020 14:47:56 -0700
Message-Id: <20200401214756.6559-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without -Werror, the probe may succeed, but then compilation fails
later when -Werror is added for other reasons.  Shows up on windows,
where the compiler complains about -fPIC.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 22870f3867..233c671aaa 100755
--- a/configure
+++ b/configure
@@ -2119,7 +2119,7 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
 fi
 
 if test "$static" = "yes"; then
-  if test "$pie" != "no" && compile_prog "-fPIE -DPIE" "-static-pie"; then
+  if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     QEMU_LDFLAGS="-static-pie $QEMU_LDFLAGS"
     pie="yes"
@@ -2132,7 +2132,7 @@ if test "$static" = "yes"; then
 elif test "$pie" = "no"; then
   QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
   QEMU_LDFLAGS="$LDFLAGS_NOPIE $QEMU_LDFLAGS"
-elif compile_prog "-fPIE -DPIE" "-pie"; then
+elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
   QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
   QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
   pie="yes"
-- 
2.20.1


