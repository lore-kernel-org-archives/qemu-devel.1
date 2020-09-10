Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194DAC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F58207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXrXmuTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F58207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMRa-00060m-Kd
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMQ4-0004Fj-Sl
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMQ2-0006Bq-Uk
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id z1so6670153wrt.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NerGAGER8t51tNNFzaXyr6ZuNtUYYRuPZHB2QB32qyI=;
 b=IXrXmuTvhPl0Rph80bXrcmCIanq6XLMnGnp36EV9dwAg+b76TS3WeO7TZPGBje7xIc
 pQUhxzq8kskRWeXqxy1bsKrpfmjhR0oim20ReEZD1dI+E+7ON2TL7Fuy0VwksIxSdjh0
 mUVLKvyBydU5R4fFGG8aGUWJ1sAnpweWZqTUwVtsL2nPbrEP70VKtd4J1bHq7CyLNmQV
 XLWpUle8SYeSh5DfJotYtSH56lsUiqbRCNMGH3HdMd1CIgbdEgNk197I+Bi8X6u8XZus
 HeqtNI6QrNM71nSboriGN7QEjSfm3b2INRFTW7LB7mUxEdxu61vl5JYkgmaTxMUjE5cG
 /H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NerGAGER8t51tNNFzaXyr6ZuNtUYYRuPZHB2QB32qyI=;
 b=RLAVACKkQNPeInl2PaIj6CLalxldi3P0Y1IyufAuYfegmS/aRpxjfwRHzoiXJQmI8d
 7dsHPjQQUZoD7yAmBPm032E8MMRVCSvOBpW320F1pfWbIFejED/LqOp5lbJ180fSA16Q
 UovAnekhh6te9R/44EzAWXNxpfaHl38gia2HCSJpBC0RgAKEgYwz535Bw5ILC+eEqa2w
 8Go2uu05BG+Y2lVYIxmV7RSMhC3A6DiuZ22lmPa32ULwWMxd/fuUQLxsv7z+zqODtQnr
 SxvZvBLpukXN8aP+PCC2edAhsW3U83Qw1U8hq0CK03cpbiG9aUJgyU+sgFJR3OlkvHFi
 Qp4g==
X-Gm-Message-State: AOAM532GTnnHsTuWhLAfO00YH4Amm3zK9s9OftgrAzPeQ3j32PsaedSb
 melLUuRFcvGPSN7An9p8o0l6Yg==
X-Google-Smtp-Source: ABdhPJyw55Xtw89+zMvKz9/cuwS417DaQO/UCm5pNC7Q4xHfufsw0ypY1sA/1GElEWOcE/3jhyJPQQ==
X-Received: by 2002:adf:9027:: with SMTP id h36mr8825477wrh.259.1599743717426; 
 Thu, 10 Sep 2020 06:15:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z14sm8674078wrh.14.2020.09.10.06.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:15:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E47C51FF92;
 Thu, 10 Sep 2020 14:15:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/10] configure: don't enable ppc64abi32-linux-user by default
Date: Thu, 10 Sep 2020 14:15:00 +0100
Message-Id: <20200910131504.11341-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910131504.11341-1-alex.bennee@linaro.org>
References: <20200910131504.11341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The user can still enable this explicitly but they will get a warning
at the end of configure for their troubles. This also drops any builds
of ppc64abi32 from our CI tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200909112742.25730-7-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 4231d56bcc0..2b5492a0d63 100755
--- a/configure
+++ b/configure
@@ -542,6 +542,8 @@ gettext=""
 bogus_os="no"
 malloc_trim=""
 
+deprecated_features=""
+
 # parse CC options first
 for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
@@ -1720,26 +1722,25 @@ if [ "$bsd_user" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
 fi
 
-if test -z "$target_list_exclude"; then
-    for config in $mak_wilds; do
-        default_target_list="${default_target_list} $(basename "$config" .mak)"
-    done
-else
-    exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
-    for config in $mak_wilds; do
-        target="$(basename "$config" .mak)"
-        exclude="no"
-        for excl in $exclude_list; do
-            if test "$excl" = "$target"; then
-                exclude="yes"
-                break;
-            fi
-        done
-        if test "$exclude" = "no"; then
-            default_target_list="${default_target_list} $target"
+if test -z "$target_list_exclude" -a -z "$target_list"; then
+    # if the user doesn't specify anything lets skip deprecating stuff
+    target_list_exclude=ppc64abi32-linux-user
+fi
+
+exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
+for config in $mak_wilds; do
+    target="$(basename "$config" .mak)"
+    exclude="no"
+    for excl in $exclude_list; do
+        if test "$excl" = "$target"; then
+            exclude="yes"
+            break;
         fi
     done
-fi
+    if test "$exclude" = "no"; then
+        default_target_list="${default_target_list} $target"
+    fi
+done
 
 # Enumerate public trace backends for --help output
 trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' "$source_path"/scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
@@ -7557,7 +7558,7 @@ TARGET_SYSTBL=""
 case "$target_name" in
   i386)
     mttcg="yes"
-	gdb_xml_files="i386-32bit.xml"
+    gdb_xml_files="i386-32bit.xml"
     TARGET_SYSTBL_ABI=i386
     TARGET_SYSTBL=syscall_32.tbl
   ;;
@@ -7667,6 +7668,7 @@ case "$target_name" in
     TARGET_SYSTBL_ABI=common,nospu,32
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
+    deprecated_features="ppc64abi32 ${deprecated_features}"
   ;;
   riscv32)
     TARGET_BASE_ARCH=riscv
@@ -8011,6 +8013,12 @@ fi
 touch ninjatool.stamp
 fi
 
+if test -n "${deprecated_features}"; then
+    echo "Warning, deprecated features enabled."
+    echo "Please see docs/system/deprecated.rst"
+    echo "  features: ${deprecated_features}"
+fi
+
 # Save the configure command line for later reuse.
 cat <<EOD >config.status
 #!/bin/sh
-- 
2.20.1


