Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C24CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970912184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2bSKq5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970912184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzhn-0005ky-9o
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzef-0002Qv-Rc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005LS-Aa
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzee-0005I6-0V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id v9so8062254wrq.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VVvH7cAnAB8K2nnuUridcFUTxcRBjM1kLOxGGOEimW8=;
 b=J2bSKq5hhCy8tsE1l/M/4RAGDc4CuTkZaccL/noXmv7vBq8j1AvmxEy7eitVMcPvI6
 rBBKG+dEyeq9aVQejkZlzd0eLitU/n4tm38xl68XFqgcsvkaOHw/fzkiy40Vvh0gsmRi
 7tMiypeyDs9DQk/Q/MPeKof0x6OC+G2H4XHb2tBPNHXK89SfAWaL1WXwZdVKTolK9Say
 Sqcb+UUUd1C0kOshtDLnomiSGW/FIQWEP61msMDufgsmW57THkjkMtc+rzUdnJnk1OFq
 nCkNs284tI5awmAZLsjuxpILzb56cJyxRrKdtXkvy0vLLvnTPHWOsFL5FegTeJNO147G
 O6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VVvH7cAnAB8K2nnuUridcFUTxcRBjM1kLOxGGOEimW8=;
 b=F6HhuU7/WZgctqT3vxeXQqWEFf/J4jplogDkop6TVHBX4/kbJURm60IgzEZMjCCi8u
 5vzpfCuOz2JdLOFI9rFPleEDlRQyLUHvh7NgL/Wq7KaTE4FtzSMWw75D4X5k2fgowowe
 sHa6xoBxF/JmuLCtRBqgz666v4VW1SYXStcwy+KoJZL0BbsccTJSNr+e+R9x8new/5od
 DdAfpajGu3ylmB9XmTMkJSLwBf6IULv7iEfah6IxFKCWedpShya+Kyzl0mxqnRGt5zDq
 eruDFFks845NtuAQfIGrzGBaaaFetgqGYhrB7bS1Irp5W2gWRD6I1xNUBK0Ug5QsNpLw
 ZMkw==
X-Gm-Message-State: APjAAAVBl2+VqSkF3zWYXq/ov/nixDedqSiAnXxcrvuq8jXdtXdfWyqn
 d5K8/fiMuIfOVxY9tDEKkUlgFA==
X-Google-Smtp-Source: APXvYqxHDbWDrkskzXYREhqyltYBIa+G6QoCaQJtFLL2NBV2fKxHXN770MC5+zQdVumdNQ6ARtFuVg==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr4701657wrr.108.1571771832659; 
 Tue, 22 Oct 2019 12:17:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g11sm18634767wmh.45.2019.10.22.12.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D48F41FF96;
 Tue, 22 Oct 2019 20:17:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 07/19] cirrus.yml: reduce scope of MacOS build
Date: Tue, 22 Oct 2019 20:16:52 +0100
Message-Id: <20191022191704.6134-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, Ed Maste <emaste@freebsd.org>,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, Li-Wen Hsu <lwhsu@freebsd.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MacOS build can time out on Cirrus running to almost an hour.
Reduce the scope to the historical MacOS architectures much the same
way we do on Travis.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .cirrus.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 8326a3a4b16..4b042c0e12c 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -1,5 +1,6 @@
 env:
   CIRRUS_CLONE_DEPTH: 1
+  MACOS_ARCHES: i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu
 
 freebsd_12_task:
   freebsd_instance:
@@ -22,6 +23,6 @@ macos_task:
   install_script:
     - brew install pkg-config python gnu-sed glib pixman make sdl2
   script:
-    - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
+    - ./configure --python=/usr/local/bin/python3 --target-list=${MACOS_ARCHES} || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check -j$(sysctl -n hw.ncpu)
-- 
2.20.1


