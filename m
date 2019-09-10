Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12696C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E6420872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6xy5QM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E6420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cU1-0007zL-Uc
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0f-0004jm-EX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0a-0004qO-6g
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:25 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7c0a-0004pf-09
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id d17so5727771wrq.13
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=05dnYVGGKVj+CF91WFubqktnlFwPYrggGM7CJVpX+/U=;
 b=p6xy5QM4x5udtOW8e/xx8zUTW6rOCAUz24/Ge+d8E9dfs2Viva8brC34jwNU2qMSsW
 m1cH2nmypxnOQFfA2sGSmVwcajkHGcWxk5ZpRHaWLxRZwjmy9XVL4OWpK0TqlHWUw09c
 Xu1Hi8WY6/6csnB/tFruKds0P5cR/+0e++V/GyK4k3A9XmDGTwyOiNDxEeMmrX/ZmssQ
 bTfb3JwWkmstJw8fa6zyjMKUDtH+WhtxUhOSWwCXwJfNcpvU6kvYee3u7+tgyLC56QkV
 bc8Adc5sYLFNlFWIsLGvq/PjSSwRqKTEb5NjbYluzSAWM48wdM3cGKd6vNgS3G+gMBPY
 ovXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=05dnYVGGKVj+CF91WFubqktnlFwPYrggGM7CJVpX+/U=;
 b=fiVDq/5mtxUXQzk0nXGzNadBaH1BdX1YB27fHYJZKoyF52Wm38j37VzOFh0NWkeVf/
 +aManzB/8jEts5jPEJmydTtqZei52QiEG01uWigr/wQqoJUQkIlHsqva/zyAXkEl2rDl
 5l3MtvpuodE9ZdFV+P/5h5AOv3Yknhq2lmUaSPPMIhGK0s6oj+0+g3wAjRzv5kO1f+9P
 Erd0syUTynX+czToitYvqxHwV71Zy7xMqETZbmLTG/2s7fWijz15uyDCgfOdZeFgmwFt
 ILCxZnq2Fhlh6O/OvBTdVGfGk8x+VjQQZT0GCt5ntTa3/CfJOsHzG1usFjyfGoCcqtUH
 aYwA==
X-Gm-Message-State: APjAAAVjH60+MQmwjfxKWEo0P1hZz4z2f+EMACrIsLCovn63Fw02RrZC
 eUAJokLcFWILkSknwsrTQFJNSA==
X-Google-Smtp-Source: APXvYqzxNmSliI7Y2nnRtAK9Psfd/356qsvu43FHrOhvumlwRmnfvYdaj/bGFTFkw7CgB2BKUlrDmQ==
X-Received: by 2002:adf:e485:: with SMTP id i5mr24054802wrm.175.1568106018948; 
 Tue, 10 Sep 2019 02:00:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm30318640wra.70.2019.09.10.02.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:00:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 28DEC1FF90;
 Tue, 10 Sep 2019 09:43:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:32 +0100
Message-Id: <20190910084349.28817-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 28/45] tests/docker: avoid $SHELL invoke bash
 directly
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On some images SHELL is pointing at a limited /bin/sh which doesn't
understand noprofile/norc. Given the run script is running bash just
invoke it directly.

This fixes:

  $ make docker-test-build@IMAGE DEBUG=1
  [...]
  + echo '  ./test-build'
  ./test-build
  + echo '* Hit Ctrl-D to continue, or type '\''exit 1'\'' to abort'
  * Hit Ctrl-D to continue, or type 'exit 1' to abort
  + echo
  + /bin/sh --noprofile --norc
  /bin/sh: 0: Illegal option --

Fixes: 2b0c4fa13f3
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/run b/tests/docker/run
index 1014871fec0..8edc7026ee3 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -62,7 +62,7 @@ echo "* Prepared to run command:"
 echo "  $CMD"
 echo "* Hit Ctrl-D to continue, or type 'exit 1' to abort"
 echo
-$SHELL --noprofile --norc
+env bash --noprofile --norc
 
 if "$CMD"; then
     exit 0
@@ -72,7 +72,7 @@ elif test -n "$DEBUG"; then
     echo "* Hit Ctrl-D to exit"
     echo
     # Force error after shell exits
-    $SHELL --noprofile --norc && exit 1
+    env bash --noprofile --norc && exit 1
 else
     exit 1
 fi
-- 
2.20.1


