Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C746DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9869E20867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dkaas+Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9869E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtVk-0007XF-6M
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE6-0003R1-SE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE5-0008TS-M1
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtE5-0008ST-Bm
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id q70so769195wme.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ejSGmzKi8yOJXrP8xmGu9NmM/5lE3B8zIrb30U/0RJ0=;
 b=Dkaas+RuFbYXkql0xawrGQmJ2idIvjDSXnSbERjVKJeq0aeh+XyAS2RQG3qv6/TLwu
 gCxcdpPMQ5Ii6t+sao3aSsbghL4q6df8V7xFmzIXKIv/BZ3cIFDpP9J1ZHosYCQFJJac
 qp3DpgDVXp0D/+GGLBukLGnRfOFZ2RRglnZBffIkFRaTZsUroLh/kD5SRc5t1iIAVeoK
 cWCWhrGRCCWnliT1U7+iMQL5Qjb+x45CPATEcqcolM0VOh9crJ8PsTet0W12dJvtzKpG
 6EXabIWFHiRsV6N+dKvAOe8E64xC+XfGwfwW+WcNSzbnm2u/zGPua+8VPIMREne/TfBo
 q6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ejSGmzKi8yOJXrP8xmGu9NmM/5lE3B8zIrb30U/0RJ0=;
 b=kyIuHh2f6X8wf7Q8FoBddPn2R+5vqevmMphIoVCb1p+kC973JU5FQJIsyvR6l5Yvaj
 Xvn/y+DFH/eqYih1urkMDdaqqo+9CP7BhXp6ph2hh0PhGu0zkjByrIVddyIDq2dDwYnl
 2nBbnSOcLwVF0WVbfVFD28j3OKxP3F/gyjl30Du38/KO/BX0vbJ1Nn3oHC9K0Hyqagf7
 DeKaFK+CMAo3a6I9bMTDLwmdJiAzHiKyMWpUa69ScLoMhgqUSEZF1sy+0TwnVrHkzNhg
 7fuqk3f8nLGne9Fz01eaW3U2YavRI8+pfnbn0xBCbh0jdX/aHQmJjtisuZTwVyNpZ0iL
 Qcyg==
X-Gm-Message-State: APjAAAVNCwaxKArh65LY5/uFYDVbxLcGbEBfAgwqyrX4jj27ZxjTdUaS
 7V+Ei1yoGksen0ETuB/DmZuYQQ==
X-Google-Smtp-Source: APXvYqxXpp7YLhQ0qp4POW0Rnv20kYC+XXyzHEm4/CxkQcfb+v5MQylBfEVa1O6G/pMHFlcO/FsJMg==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr1922093wma.111.1571985450983; 
 Thu, 24 Oct 2019 23:37:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l26sm455009wmg.3.2019.10.24.23.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 045201FFCF;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 56/73] plugin: add qemu_plugin_outs helper
Date: Fri, 25 Oct 2019 07:36:56 +0100
Message-Id: <20191025063713.23374-57-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having the plugins grab stdout and spew stuff there is a bit ugly and
certainly makes the tests look ugly. Provide a hook back into QEMU
which can be redirected as needed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>

diff --git a/include/qemu/log.h b/include/qemu/log.h
index b097a6cae11..a91105b2adc 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
 /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 #define CPU_LOG_TB_FPU     (1 << 17)
+#define CPU_LOG_PLUGIN     (1 << 18)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index ddf267fbfe0..a00a7deb461 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -384,4 +384,10 @@ int qemu_plugin_n_vcpus(void);
 /* returns -1 in user-mode */
 int qemu_plugin_n_max_vcpus(void);
 
+/**
+ * qemu_plugin_outs() - output string via QEMU's logging system
+ * @string: a string
+ */
+void qemu_plugin_outs(const char *string);
+
 #endif /* QEMU_PLUGIN_API_H */
diff --git a/plugins/api.c b/plugins/api.c
index 5adc4d25a1e..fa1d9f276d3 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -331,3 +331,11 @@ int qemu_plugin_n_max_vcpus(void)
     return get_ms()->smp.max_cpus;
 #endif
 }
+
+/*
+ * Plugin output
+ */
+void qemu_plugin_outs(const char *string)
+{
+    qemu_log_mask(CPU_LOG_PLUGIN, "%s", string);
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 267ec381b4a..4bdb381f48e 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -36,4 +36,5 @@
   qemu_plugin_vcpu_for_each;
   qemu_plugin_n_vcpus;
   qemu_plugin_n_max_vcpus;
+  qemu_plugin_outs;
 };
diff --git a/util/log.c b/util/log.c
index 1d1b33f7d9f..1ca13059eef 100644
--- a/util/log.c
+++ b/util/log.c
@@ -273,6 +273,9 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+#ifdef CONFIG_PLUGIN
+    { CPU_LOG_PLUGIN, "plugin", "output from TCG plugins\n"},
+#endif
     { 0, NULL, NULL },
 };
 
-- 
2.20.1


