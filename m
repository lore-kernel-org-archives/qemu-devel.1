Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE04FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE2422BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EvYj0WuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE2422BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DtS-0002t4-L8
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dov-00014N-3N
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dot-0004xo-8m
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id p20so9317706wrf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gvLkpu8rW3JTmQqRZmEUsHrF4uVAVJ/B/J8K9PNu4Yo=;
 b=EvYj0WuQVSdDqdNVEJYS0z2xnxcGJH/pb1Y/SQpRjoeToQZCIR5XXJg2vUb0NF+AAz
 tVoGy6XtUc3Wh5/FN8VG643CarFvBy1HozVR7uORvc5ucIoKlmk1f3fbp6LDI6nLhOHn
 aTo9nK/GvgMcGxwG3Htx5pSM+knTOdakKO2JF5Krm/J6jpZKHrIC/kIOoQnu5O1/X5C9
 V/PSwMyEwMmayJVVBkYHEebG4jNKLcN9/iMpLIOmPytSxTQqtTJHzt9PftGhXX33FJBZ
 6E8LAIDtl0vK2KaYEpalo7TvleT8GtWHY5gG5m3UGLJ1Q6gLNGihZk9vC3QRyWJhCgnV
 ZAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gvLkpu8rW3JTmQqRZmEUsHrF4uVAVJ/B/J8K9PNu4Yo=;
 b=AKBDcNfNcGC/jMaIKMrbEx/xMKV6VUjrw+XoYGJ2iOiIzKyyw06+RErbbG5E+BzYKx
 hi6EKs/T9Dz/isCiV2OKcjlb+UOvcd/475fiYWzlRAuBmzdL9bRt14qsikYltc/NPHRw
 ngfHwwpMmirIWnR9+T8kmLHUXTO6P7c8euL6KISfBwBJyHA5g70DPL2iBRsMivIhTsFi
 EYOUJFNhoKlupexlsRBcv0OGWPDCqNAA7lW4QrnD6zKuHLvHEAcFF3v9nbQlM7DYgNYz
 34n5mrY2Lt/NMSmg8l3ypYlaigJaHVtJIcRzGNy99RxFFiAIWDv4R5AbNn9aUN/nwjN9
 6Tww==
X-Gm-Message-State: AOAM531eHm82NrU4vrHc+00ea+DBqFox+Svf+qndcjS9Sv8pN/XA8Pif
 SxmF+2sk8a6La9Wj7d86f/hXi/qJjFtNdQ==
X-Google-Smtp-Source: ABdhPJyZ2/eECkxs7L25sLHdkqePdo7ZNQshU9FfExJwLZ9IwB46Civ0T5HYc/YZ8CmEZbPHTVoatA==
X-Received: by 2002:adf:f207:: with SMTP id p7mr28159033wro.292.1597089053348; 
 Mon, 10 Aug 2020 12:50:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 18/20] Remove Texinfo related files from .gitignore and
 git.orderfile
Date: Mon, 10 Aug 2020 20:50:17 +0100
Message-Id: <20200810195019.25427-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't use Texinfo any more; we can remove the references to the
.texi source files and the generated output files from our
.gitignore and git.orderfile.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitignore            | 15 ---------------
 scripts/git.orderfile |  1 -
 2 files changed, 16 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2992d15931a..6a3e335f6a7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -45,20 +45,15 @@
 /qapi/qapi-visit-*.[ch]
 !/qapi/qapi-visit-core.c
 **/qapi/qapi-visit.[ch]
-**/qapi/qapi-doc.texi
 /qemu-edid
 /qemu-img
 /qemu-nbd
 /qemu-options.def
-/qemu-options.texi
-/qemu-img-cmds.texi
 /qemu-img-cmds.h
 /qemu-io
 /qemu-ga
 /qemu-bridge-helper
 /qemu-keymap
-/qemu-monitor.texi
-/qemu-monitor-info.texi
 /qemu-storage-daemon
 /qemu-version.h
 /qemu-version.h.tmp
@@ -83,7 +78,6 @@
 *.ky
 *.log
 *.pdf
-*.pod
 *.cps
 *.fns
 *.kys
@@ -126,15 +120,6 @@
 /pc-bios/s390-ccw/s390-ccw.elf
 /pc-bios/s390-ccw/s390-ccw.img
 /docs/built
-/docs/interop/qemu-ga-qapi.texi
-/docs/interop/qemu-ga-ref.html
-/docs/interop/qemu-ga-ref.info*
-/docs/interop/qemu-ga-ref.txt
-/docs/interop/qemu-qmp-qapi.texi
-/docs/interop/qemu-qmp-ref.html
-/docs/interop/qemu-qmp-ref.info*
-/docs/interop/qemu-qmp-ref.txt
-/docs/version.texi
 /contrib/vhost-user-gpu/50-qemu-gpu.json
 *.tps
 .stgit-*
diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 73fd818d7f3..de276d6c8de 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -12,7 +12,6 @@
 # Documentation
 docs/*
 *.rst
-*.texi
 
 # build system
 configure
-- 
2.20.1


