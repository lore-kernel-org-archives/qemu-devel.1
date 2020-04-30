Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF86C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE9E2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LS0rnv1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE9E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUESp-0008LC-4S
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERC-0006Da-B4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERA-00039d-EW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUER9-00037z-0E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id u127so3322756wmg.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Xn/wGLfgFLD46kRhQwU2daT/QhgqlaCuFRqlRFnVf8=;
 b=LS0rnv1DgH7lE1OGbrZUs96l+sCf7xlVLImpMB/kz2EnK2fCT2PVPOacXb83K4H1T8
 rf82v3q3qhlK/62AzsrC0XeoOCFOjsGkSCVQffMCcKLxGZn1bGHbmRWZbxgNXJA11Ft4
 utsewYb2qTlrIszCKO7vL/9oNgnJCmmg7d3SBA2sfrCpvx8sqJmgGX7x0QGIs83N2n8S
 Db6AfKCUKFX4c3PxgX3MuYbQxkkaEYgHyg/gnI/WHZ5iJwV+DkBWgcNy/XpvLvl1Ifvb
 S35OXXp/+2LI9Q2vCjRZMdzpvFTsvwz6iNH6QEL10DzD4BGBR/WtvKDv6VQbdQ/GNXY/
 EbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Xn/wGLfgFLD46kRhQwU2daT/QhgqlaCuFRqlRFnVf8=;
 b=TfuComi+WaTv2TvKJQuTPe/FYII4hvtD+iDqT69B1cxfNSMqFtVJO4v1LNkIkZY2Lo
 4aD2WkS14BzYFDbQv4F6+XlsiJ8X8WL0V8M0bA9aubD8Br91LX4ZO2tDngW5SI6JmMBN
 lOza/meu6xmXQnqQcsJusQhBzMSLbAwS7TgWQaxDWLeTAfc6OI2DjYOkp4Bd6H76IvM7
 0ichJ1wxfNGORCDnG8rl3YibJUnoliN898GPlyId8ijVJdVv0U3r+wOxcQPkMGRGWFmT
 5IZ+zwep7EAv5C7qfEpQSMQcvEgu1ppusNESpnoCgApmergv3aoPNpwnsnkQ7oi0nQhk
 aqmg==
X-Gm-Message-State: AGi0Pua8hhWfOzbEa31QqO6NrDYa1Rn0PJ9Qj2G1EUDcvJehh8biSMbG
 4ELO/0KQtkPAIFOvNaLBN8lSBs7mr7Q=
X-Google-Smtp-Source: APiQypIeaIKCLDyUj2UNYVeBD+r/ShR6t0OSXxYoX/nUy5Cng29Wfw4zTAzsatshFWTN9mcuTZFTMQ==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr39304wmk.120.1588273289489;
 Thu, 30 Apr 2020 12:01:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h16sm1004908wrw.36.2020.04.30.12.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 12:01:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E041A1FF8F;
 Thu, 30 Apr 2020 20:01:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/9] tests/tcg: better trap gdb failures
Date: Thu, 30 Apr 2020 20:01:16 +0100
Message-Id: <20200430190122.4592-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430190122.4592-1-alex.bennee@linaro.org>
References: <20200430190122.4592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32a
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

It seems older and non-multiarach aware GDBs might not fail gracefully
when faced with something they don't know. For example when faced with
a target XML for s390x the Ubuntu 18.04 gdb will generate an internal
fault and prompt for a core dump.

Work around this by invoking GDB in a more batch orientated way and
then trying to filter out between test failures and gdb failures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py               | 19 ++++++++++++++++++-
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py |  1 -
 tests/tcg/aarch64/gdbstub/test-sve.py       |  1 -
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 8c49ee2f22..2bbb8fbaa3 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -50,8 +50,25 @@ if __name__ == '__main__':
     inferior = subprocess.Popen(shlex.split(cmd))
 
     # Now launch gdb with our test and collect the result
-    gdb_cmd = "%s %s -ex 'target remote localhost:1234' -x %s" % (args.gdb, args.binary, args.test)
+    gdb_cmd = "%s %s" % (args.gdb, args.binary)
+    # run quietly and ignore .gdbinit
+    gdb_cmd += " -q -n -batch"
+    # disable prompts in case of crash
+    gdb_cmd += " -ex 'set confirm off'"
+    # connect to remote
+    gdb_cmd += " -ex 'target remote localhost:1234'"
+    # finally the test script itself
+    gdb_cmd += " -x %s" % (args.test)
+
+    print("GDB CMD: %s" % (gdb_cmd))
 
     result = subprocess.call(gdb_cmd, shell=True);
 
+    # A negative result is the result of an internal gdb failure like
+    # a crash. We force a return of 0 so we don't fail the test on
+    # account of broken external tools.
+    if result < 0:
+        print("GDB crashed? SKIPPING")
+        exit(0)
+
     exit(result)
diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
index 984fbeb277..387b2fc20a 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -70,7 +70,6 @@ except (gdb.error, AttributeError):
 try:
     # These are not very useful in scripts
     gdb.execute("set pagination off")
-    gdb.execute("set confirm off")
 
     # Run the actual tests
     run_test()
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index dbe7f2aa93..5995689625 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -71,7 +71,6 @@ except (gdb.error, AttributeError):
 try:
     # These are not very useful in scripts
     gdb.execute("set pagination off")
-    gdb.execute("set confirm off")
 
     # Run the actual tests
     run_test()
-- 
2.20.1


