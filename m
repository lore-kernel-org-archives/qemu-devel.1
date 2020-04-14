Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D969C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A84206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/dySJqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A84206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOS4a-000340-CD
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORyh-0003xD-5O
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORyf-0001hV-RL
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORyf-0001gg-H3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id d77so14538532wmd.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NPiyUCAjRop3t1WgPzKfTIoYlwAGqnRWW17Y8kgOmss=;
 b=v/dySJqPPNf/T7mPWN0oYESPDypKjKp5xHxSiMfxPfnUaVxMuqEsH5gzYWcLoLrxYq
 a3CVyLt9+uKeI1c7khVD0y/QJW+6KUYUQXLxl1ElA4SZ+8slq/cgJ9bSwsiQmDHNfNa4
 oc6V9EB3gALg5DM9nzmcuTg0ZRToKyXhlAzJGqzz8byKWyMHGd7AebTuVNj0PHTdUnPU
 gvyFKDd/pnkoIty0RhzU7/cq6JgRpNqRwTIoZuucI996R9lzfY++cnYi+r7x7Ui1319t
 kZ0q9uphLiPTEIp/S9VuWNnorDCbZcV2Z2ibe9rAaV1bXnIfTF0kvj01hVjoa118ChyX
 7gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NPiyUCAjRop3t1WgPzKfTIoYlwAGqnRWW17Y8kgOmss=;
 b=O2sy9qvLwf1kzD8ry4R4UoOQmUwpgzQw8nc+Vg5AG0e35RRGLMOmbyXU81O5dpA2R/
 ogbgzI8wFpxg3PR8sirJA0WFyfS9WmYLlZjBLbt9nzK+/W4FmGjO7wupNyQmwMCXrJGp
 qz4lPt3SrJRx2bMAim6omdg2RZto6YDuRVmKBS04xx3N3fU3nC5gB7kBLtLVX1vaM+Qn
 mz7c4rd0JzfC8RtJPGZT0ctXkprSHRJH0wSj3PtCIcybA04DbKtxGAeZNtROwpGf5ERz
 qLmrsPiaRzkWhTGNE0HTbpVIDXAVn0KKYeFU3W8lfO+YlI6mAbUjRcxZo7kE5cErevo1
 6CQg==
X-Gm-Message-State: AGi0PuZqmN/LlIBNaG5tf6+EikWD+nx3W1rhckI6/2X4kauSHRkgFFcn
 e6iqPULgBeZPlZm47pMq0vKwEQ==
X-Google-Smtp-Source: APiQypJ8f3dtPM71hhtp8NrfIcNzbDDOJ6uPfpVUYGE98V/HxVImHARvdMCL5K1XWG/zS9h0DefQFg==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr1677166wme.56.1586895372176; 
 Tue, 14 Apr 2020 13:16:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y9sm19434556wmm.26.2020.04.14.13.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:16:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31E541FF9E;
 Tue, 14 Apr 2020 21:06:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 16/17] tests/tcg: drop inferior.was_attached() test
Date: Tue, 14 Apr 2020 21:06:30 +0100
Message-Id: <20200414200631.12799-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test seems flaky and reports attachment even when we failed to
negotiate the architecture. However the fetching of the guest
architecture will fail tripping up the gdb AttributeError which will
trigger our early no error status exit from the test

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py | 3 ---
 tests/tcg/aarch64/gdbstub/test-sve.py       | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
index 984fbeb277e..5824abe09ac 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -58,9 +58,6 @@ def run_test():
 #
 try:
     inferior = gdb.selected_inferior()
-    if inferior.was_attached == False:
-        print("SKIPPING (failed to attach)", file=sys.stderr)
-        exit(0)
     arch = inferior.architecture()
     report(arch.name() == "aarch64", "connected to aarch64")
 except (gdb.error, AttributeError):
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index dbe7f2aa932..90201d80094 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -59,9 +59,6 @@ def run_test():
 #
 try:
     inferior = gdb.selected_inferior()
-    if inferior.was_attached == False:
-        print("SKIPPING (failed to attach)", file=sys.stderr)
-        exit(0)
     arch = inferior.architecture()
     report(arch.name() == "aarch64", "connected to aarch64")
 except (gdb.error, AttributeError):
-- 
2.20.1


