Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFC0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAA520B80
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XR8HRwDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAA520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJGZ-0004Zm-MM
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmJFu-0003xu-Ey
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:48:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmJFs-00079q-Dq
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:48:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id q11so10174463wrp.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KoCaGxW6EMM71vBXs/YRZpSQP62pAwedz2Y/ryLytRg=;
 b=XR8HRwDiPggE3WegMCn8oVqx8I0AheMMfDzHFhc5DPFELYB3fYRoIj8fYn3x2NrQ1N
 iQ5AdQE7hqq+dz8mgDC8kFIlEfLNNovqY/nIMVxVQoGcslTv/j1GAAB7d/F4zSshThDl
 K5Byo02/kO1jy4u8AYLPSLxD2bG9pu3Hgv2cX0puIYS/u8Ce7CC5yBAs2whEWWqiJ463
 eohg/6Oqhp6c+y5C/WtosYT9wgQacFJToe68astp3rMD67DzO3zgG8q1RWG7VItkg/Hs
 FuB7UOUrnF4/mOT1PqLbJXWWlao4X1aFn2i0y2TyMsJdaOYbmhrGuil1mm7MwVgxrQEf
 dBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KoCaGxW6EMM71vBXs/YRZpSQP62pAwedz2Y/ryLytRg=;
 b=cMoLfR5x3TYJgtV2PI5Qx6ilQVthEWcLnZKQzwxkIQERHQgjCE5D+RKzqsY8p6ewLG
 wGYBBK/rv1JWhtIeWJBklHTOsgn2Uy7dJJQGfmBbti8rq7Y0617hdn+YYAv88QSJLlDi
 1TZ2DSTwnipkTNGwi0YPnPeWEEPnVTzKLcyZec4T8ExiCe1dmacLjajOoADEcgBJkWy8
 qp87LLMhY3u96jk6YqXw0N5M8y20spe6Pq/Gg0WgYYh9mD9Bz1a5OnVVxOiwnpDVHpmY
 ByavCWcN94ImYVQHJ/EJFa/qLWIQQtp4u5/IR03FgLhFO8AszogNx4UDgkzY4d2v0Wos
 eIlA==
X-Gm-Message-State: AOAM533W1VUisLw0wZ3B5PzuYD4zQiinSth6a51TpUWcwEfy5lHVUZHY
 5pvh0Szb5XWbCjjJ/N7E2tsE0Pf4EW01cw==
X-Google-Smtp-Source: ABdhPJz+5wi/T0tL3ZI4SeGooGnkpNyHqxh41T/Ys3uFC61tGhvF0MBm/+hfIkSg76SGBz8s9hkuNQ==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr3198649wru.310.1592581714416; 
 Fri, 19 Jun 2020 08:48:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm7152008wmi.13.2020.06.19.08.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 08:48:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Deprecate TileGX port
Date: Fri, 19 Jun 2020 16:48:31 +0100
Message-Id: <20200619154831.26319-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Chen Gang <chengang@emindsoft.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecate our TileGX target support:
 * we have no active maintainer for it
 * it has had essentially no contributions (other than tree-wide cleanups
   and similar) since it was first added
 * the Linux kernel dropped support in 2018, as has glibc

Note the deprecation in the manual, but don't try to print a warning
when QEMU runs -- printing unsuppressable messages is more obtrusive
for linux-user mode than it would be for system-emulation mode, and
it doesn't seem worth trying to invent a new suppressible-error
system for linux-user just for this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We discussed dropping this target last year:
 https://patchew.org/QEMU/20191012071210.13632-1-philmd@redhat.com/
and before that in 2018, when Chen told us he didn't have time
to work on tilegx any more:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03955.html
Given that tilegx is no longer in upstream Linux I think it makes sense
to finally deprecate-and-drop our linux-user support for it.

 docs/system/deprecated.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 3a255591c34..e9097e089bb 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -387,6 +387,17 @@ The above, converted to the current supported format::
 
   json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
 
+linux-user mode CPUs
+--------------------
+
+``tilegx`` CPUs (since 5.1.0)
+'''''''''''''''''''''''''''''
+
+The ``tilegx`` guest CPU support (which was only implemented in
+linux-user mode) is deprecated and will be removed in a future version
+of QEMU. Support for this CPU was removed from the upstream Linux
+kernel in 2018, and has also been dropped from glibc.
+
 Related binaries
 ----------------
 
-- 
2.20.1


