Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE85CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE5D20867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6cnekdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE5D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtZC-0008Ge-TL
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMr-0007nX-F5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMq-00038K-DP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtMq-00037l-7U
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id l10so956455wrb.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s6dUXbiyhwUKB16Q3aSXxKi++FouEOb+/iuvzgagYLA=;
 b=F6cnekdTs4Di1+8Zm6PTW2chDDEAQsC+Z3rNSo85HXtP+zsQnOxamognLd4LnJZyMI
 TbZY9yJRCcUYbqgrycErNioTOjnukwYwWITWnnQwBV0LMNrfVCI+1U4lAKKsPWxVojCd
 bRAwTVb9Cb0cuPhOjQa8oGn7NMRJrzvFYOtbnqIhp6BnJPl2qZgS8Gs5QdS/22CHNr/q
 dVp08Oh6j40if8YrscbeeQ1mCI1euIRJYo6vQcNGOl2nU8uy1jUHPc+suozrMCNolDYj
 mfM5FpDVqQ7eJzDbqKPYmVv39xgsdUTwoOaQw+78j1d7NfmcROd/pZv//TrtK0EuBYsW
 qP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s6dUXbiyhwUKB16Q3aSXxKi++FouEOb+/iuvzgagYLA=;
 b=eGPf6ZQpfielN10Ub/INUPYrkusx0dbptkuFFl3QhHN+0vbI/r/UdyKA1h0ex7UIKE
 DzW1rDW/D2xnlXSMV3zdRNiiO8qf3++1Bf8q2sDpWnvQteZBRqMrmVS9gwMSI9cSIYHk
 sDIuUmisj6hWi4bPNsXrHz6+kh08e5A/RQ5T3MSTRr6yvjIjGdb02FUq0AoYTvf+FcTV
 EioqEmn4AbuyX5cFFmDJ3nWd25JStTUTSWRd+s6fTn7e7mQMKLZ/zepiy+vZv3l3l7/Z
 giTcFFpxJYilvSgNCJ7sWYHOtFxQTaV8LS+UPF9GXtDWM6sMgtk+Hvxu7L+9NYih9WDs
 o6HA==
X-Gm-Message-State: APjAAAV53CN8+/4n2RPjG2DUPb/yLYInTxXuJvmiwaDGXauiWlul9BHp
 KAvbvRIQz9W6uJFYRvwNtspkGYFaXxc=
X-Google-Smtp-Source: APXvYqxOU9yh+0X/TdkePEx//GvIwoZ8iQbsm7ITrY9mwl+ZxzdJ475qlfwexKI4k7GAc2TaSVR2vQ==
X-Received: by 2002:adf:f04e:: with SMTP id t14mr1368959wro.106.1571985995059; 
 Thu, 24 Oct 2019 23:46:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p17sm1824079wrn.4.2019.10.24.23.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 945611FFCB;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 52/73] configure: add --enable-plugins
Date: Fri, 25 Oct 2019 07:36:52 +0100
Message-Id: <20191025063713.23374-53-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds the basic boilerplate feature enable option for the build.
We shall expand it later.

[AJB: split from larger patch]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/configure b/configure
index d6fbcf45e4f..2995559ed21 100755
--- a/configure
+++ b/configure
@@ -498,6 +498,7 @@ libxml2=""
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
+plugins="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -1529,6 +1530,10 @@ for opt do
   ;;
   --disable-xkbcommon) xkbcommon=no
   ;;
+  --enable-plugins) plugins="yes"
+  ;;
+  --disable-plugins) plugins="no"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1710,6 +1715,8 @@ Advanced options (experts only):
   --enable-profiler        profiler support
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --enable-plugins
+                           enable plugins via shared library loading
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -6442,6 +6449,7 @@ echo "capstone          $capstone"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
+echo "plugin support    $plugins"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7272,6 +7280,11 @@ if test "$sheepdog" = "yes" ; then
   echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
 fi
 
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGIN=y" >> $config_host_mak
+    LIBS="-ldl $LIBS"
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-- 
2.20.1


