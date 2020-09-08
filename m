Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC7C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7BF2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vzl5mXzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7BF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkAc-0008JY-Bx
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFk9z-0007SC-PK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:24:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFk9y-00073C-0X
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599596646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUI+h7h87pyB2AX9IsPLMO1tJI/gI6/lq/ODu6/RGEI=;
 b=Vzl5mXzdvwKW1L4CpPCfbhSbPIJwQPSwAes8BXGJ6qbKXZpOj/Z9un29FAce5BdWOzoFcJ
 Ay2dkEvrTJ8KwqRUSSFb1ND8gHzkgdUnL18GweNM3rfvgRHIfxW0V0uSabSF+ruaxgGf/Z
 ZP6QbP3FHGCFFMf+RKO4aBxcGiVN+/o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-t2ItnuxDP_axmtQRqxRihQ-1; Tue, 08 Sep 2020 16:24:02 -0400
X-MC-Unique: t2ItnuxDP_axmtQRqxRihQ-1
Received: by mail-wr1-f69.google.com with SMTP id w7so57214wrp.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oUI+h7h87pyB2AX9IsPLMO1tJI/gI6/lq/ODu6/RGEI=;
 b=QHffYqYNdlzEJ3Q+DQC3SGXPUwUTS2FOfII4/s26d5c1XuL031W3VRkZYf5v77mmpD
 30A4TLsjsAHul7xak9xciZoUxXkk4LgRuCDYwfW4bSvjb67de7/DqLjuZgWV1kvnqsKW
 4WAFpNiG5YrIY95G7AJx8DelHBzqp4kfGrFKbWXYSpmwgehHjFa/4rSnFspLNKTMIy3k
 R/fPM/q+yGC3w+jQJGbqmAZWB94naDIsAevtGYLSp9uDv4YdGAqTOxdFpQx6IvUsIxnq
 2W2Tm2Yfr+XvMrUKgEwL0eW5ME5sr/7DucJ4UQoclzPGuU0/ldQtpB5HWOilrK5eevvM
 EUpA==
X-Gm-Message-State: AOAM531ewZIXzZSPIcjmHbKblLIrXAH//EakJ8TE+KZsQhHfQCKf7tcQ
 M1W19OouStW93yzegag+342eZJ/z6tYrERkUmiJ0lFC0g3gHxvcXZoyEgtIGG8DRaGVLteZX/gm
 GLzPByep28OZ+owY=
X-Received: by 2002:adf:db48:: with SMTP id f8mr406475wrj.144.1599596641013;
 Tue, 08 Sep 2020 13:24:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQP1xRmtnSvz+AbkO+JSdK8tgFdjAd58JFFsu5n306uz6bzHS7GXUBC5WV2W6T2uJ9iO5oCw==
X-Received: by 2002:adf:db48:: with SMTP id f8mr406463wrj.144.1599596640814;
 Tue, 08 Sep 2020 13:24:00 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z19sm665529wmi.3.2020.09.08.13.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 13:24:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] tests: bump avocado version
Date: Tue,  8 Sep 2020 22:23:51 +0200
Message-Id: <20200908202352.298506-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908202352.298506-1-philmd@redhat.com>
References: <20200908202352.298506-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <willianr@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

Reverse debugging test uses gdb remote client of avocado framework.
This client was fixed since the currently used version 76.
Therefore this patch bumps the version to 81 and fixes command
line version compatibility issue.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Message-Id: <159903462803.28509.16851113546106095750.stgit@pasha-ThinkPad-X280>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/Makefile.include | 2 +-
 tests/requirements.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f93e6112202..2baebc179e7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -127,7 +127,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
             --filter-by-tags-include-empty --filter-by-tags-include-empty-key \
             $(AVOCADO_TAGS) \
-            $(if $(GITLAB_CI),,--failfast=on) tests/acceptance, \
+            $(if $(GITLAB_CI),,--failfast) tests/acceptance, \
             "AVOCADO", "tests/acceptance")
 
 # Consolidated targets
diff --git a/tests/requirements.txt b/tests/requirements.txt
index f9c84b4ba1a..036691c9221 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,5 +1,5 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework==76.0
+avocado-framework==81.0
 pycdlib==1.9.0
-- 
2.26.2


