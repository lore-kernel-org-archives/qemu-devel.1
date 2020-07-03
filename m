Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F22C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A6720737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkZQs4i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A6720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNGo-00026R-Us
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN78-00040i-QX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN77-0006lx-18
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id q5so32990804wru.6
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gk9DfX8/J7tsyEjRqdyCEtDuVKOgNFwSPI5bE1k8yEs=;
 b=FkZQs4i0PHggkH+l63CrOMoMBhq9V5ogNKc4p3ieY+RNtdv4WEm/yrsWep4uhDWDzm
 /3D6yka2A25eN0Pn4xCB2TtSO+IbsGjbiKJBXsBw02ft/ztfvb8rN7r6P/1ESRGmczW7
 iJquQ3dISjPJwwfjHwhGLBBG9GrP3M7BIGoXquH3p7s6og2ZwmN9MymKuJPQSu3OAVHU
 mUME1CWcFoNXkZkdonaAbBbWj0qTtFpwrKEPF9wPw+N7rPgmETQs/IpZnBPO+xJyIGYP
 6YgJAAI8gmj69MYl+A8ND/jtSnW58U8ixXdJ3fh83gzkfl9CcpFNMKk8fk1vSenC6K1N
 hG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gk9DfX8/J7tsyEjRqdyCEtDuVKOgNFwSPI5bE1k8yEs=;
 b=asmkPBIdrO4JfIvhs5hx7EHmRvQP9u6pdc1owrMrpnp/gb8RKWRz+5MNVySTyXEm6r
 ojUkjqAEwYY7Fx+oNo70Gi4tnmQt6QiptZ7agu4ttIQACxG+TjHKMkZu8eX78ZyP+LUT
 06GRnNfiXcU8ovRUIOHVB1SJixfIa1bRkRNd+7/Mc4u+5Y5n5sUuFaw/VIwmFi7BSQpS
 C5CQKcMqB8da2hMKq3QWb63joptVOUu1M5QNRWpVl/36oelSK9r8U2wSS0NxRL8qXEoP
 ddhM+/QoOHUiclt8HdbJIcw5JLDQ/z34M419Ddsd+tYvVuxF3z56pcGoMAcipNdCG23b
 W4YA==
X-Gm-Message-State: AOAM531pn2PnXuYTUbEBul/xSncktQTvGiaa/OtXIb7KqAgYytiJzPTC
 WVz6WD4qsmGdBeKn8WnNMcYD8qwxRNqapw==
X-Google-Smtp-Source: ABdhPJyh0dEc+Eeo/RagW5rmlqA1a9tbCn2u3bTGfgPAV4XnR61zmqHnKRCPjz0XxmyazviqlzF4Ag==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr7538607wrm.113.1593788187319; 
 Fri, 03 Jul 2020 07:56:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14078347wme.31.2020.07.03.07.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 07:56:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 9/9] util/drm: make portable by avoiding struct dirent
 d_type
Date: Fri,  3 Jul 2020 15:56:14 +0100
Message-Id: <20200703145614.16684-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703145614.16684-1-peter.maydell@linaro.org>
References: <20200703145614.16684-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Given this isn't perforance critical at all lets avoid the non-portable
d_type and use fstat instead to check whenever the file is a chardev.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reported-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200701180302.14821-1-kraxel@redhat.com
[PMM: fixed comment style; tweaked subject line]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/drm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/util/drm.c b/util/drm.c
index a23ff245382..dae8ffebc81 100644
--- a/util/drm.c
+++ b/util/drm.c
@@ -24,7 +24,8 @@ int qemu_drm_rendernode_open(const char *rendernode)
 {
     DIR *dir;
     struct dirent *e;
-    int r, fd;
+    struct stat st;
+    int r, fd, ret;
     char *p;
 
     if (rendernode) {
@@ -38,10 +39,6 @@ int qemu_drm_rendernode_open(const char *rendernode)
 
     fd = -1;
     while ((e = readdir(dir))) {
-        if (e->d_type != DT_CHR) {
-            continue;
-        }
-
         if (strncmp(e->d_name, "renderD", 7)) {
             continue;
         }
@@ -53,6 +50,18 @@ int qemu_drm_rendernode_open(const char *rendernode)
             g_free(p);
             continue;
         }
+
+        /*
+         * prefer fstat() over checking e->d_type == DT_CHR for
+         * portability reasons
+         */
+        ret = fstat(r, &st);
+        if (ret < 0 || (st.st_mode & S_IFMT) != S_IFCHR) {
+            close(r);
+            g_free(p);
+            continue;
+        }
+
         fd = r;
         g_free(p);
         break;
-- 
2.20.1


