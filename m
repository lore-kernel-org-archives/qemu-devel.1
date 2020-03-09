Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E74C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD5C208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X66+vyV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD5C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKlA-0003bV-Ek
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKa4-0002ON-0q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKa2-0001Zq-Ss
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKa2-0001ZO-Me
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id p9so3995wmc.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hy1+wvhnmgnT9CuRfCiRbzAqA7FrWPViwFJZB+FlhcY=;
 b=X66+vyV5Dr+7CKUEqZ7h2mIqDYdP/0hAgIQbere4X4Z3q/4eFrGbRa/OMbc8Ga1XR0
 DlCl5F76NL6RTLN811AZT7ZHkE6lhr7nc5LLCCLMLQyIbS+hsS9bJbSDvrH8Es8qV44R
 6f/Ft0dsmGyh9M8OpdXqJ85F4JDhIqLpETjgtfbOt58aal4OZw6QgpP3EZT5PSilXPRr
 24qE4esjw6kVp4O88d2P416tCZO3JgYNi+g2CA7OaXkADfnpcIJyjdqBMBKIVB264SOm
 vE3iJRlCxcJ+mtuA4U0nqG47EWl4uXrupy15+2Ub6K6LMm+caqCp4fLJi+QJFwA64h6M
 1O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hy1+wvhnmgnT9CuRfCiRbzAqA7FrWPViwFJZB+FlhcY=;
 b=Fbu9gbXDAAy72Y7wgTaqW6jrhJt6tFoyldcS/ZnlJ4qHMhKK3vX84Cg9Xn42phEf5p
 cOJ+N9G/lU45iemB4PwfpwQL0GD/mVQMlRZyYTp9+wII2ANiz9KxQLWmxBeZVcc63lXX
 0Pribax2M51SBQlLT0cD3tksXb28IjXR2O8sZl8sadAn19pq1MWC/x9rh655YeeWq6/y
 wskG2HayvFi87wexZbjIfT1UJmpiKSdJUgVW1OByjFBFkqUcig++54OIIBhJVobnYA+0
 Ok7tbEsJ6JEqYyGKAWELyHQ77y+n/iZz4UkLE4KNU2Q4jLi7+65BTTwa7csS5GmHjQ3U
 y77w==
X-Gm-Message-State: ANhLgQ3rTHL5CxJlE3PvvKUxk8hYxn+rGLxWtPBn/B6Go1AGaUpjbJXq
 YpHcInQlh7LSVcVElgp3RnXXJvdj8h7c0Q==
X-Google-Smtp-Source: ADFU+vvN3WG78SjdwJGMDhrCXSsJkSHg10neJgChQtlI1fezEWAhrDMxyvNB2oiJYgG4VbiBpDtSIg==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr20502805wma.5.1583768670356; 
 Mon, 09 Mar 2020 08:44:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/18] Remove Texinfo related files from .gitignore and
 git.orderfile
Date: Mon,  9 Mar 2020 15:44:03 +0000
Message-Id: <20200309154405.13548-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't use Texinfo any more; we can remove the references to the
.texi source files and the generated output files from our
.gitignore and git.orderfile.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitignore            | 15 ---------------
 scripts/git.orderfile |  1 -
 2 files changed, 16 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0c5af83aa74..920d523f40d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -45,20 +45,15 @@
 /qapi/qapi-visit-*.[ch]
 !/qapi/qapi-visit-core.c
 /qapi/qapi-visit.[ch]
-/qapi/qapi-doc.texi
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
 /qemu-version.h
 /qemu-version.h.tmp
 /module_block.h
@@ -82,7 +77,6 @@
 *.ky
 *.log
 *.pdf
-*.pod
 *.cps
 *.fns
 *.kys
@@ -124,15 +118,6 @@
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
index 7cf22e0bf54..f69dff07dbc 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -11,7 +11,6 @@
 
 # Documentation
 docs/*
-*.texi
 
 # build system
 configure
-- 
2.20.1


