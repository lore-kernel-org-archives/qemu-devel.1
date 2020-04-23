Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C18C55193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AE520857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRPoJNbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AE520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfJr-0003Y5-UF
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIg-00013y-MI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIf-0005Ve-Rr
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:33411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIf-0005Uh-Az
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id v8so7927696wma.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Xn/wGLfgFLD46kRhQwU2daT/QhgqlaCuFRqlRFnVf8=;
 b=DRPoJNbCfoD7YP8g55X7LdkmXphvibqng/WH+lcvTZr++fsfa7LlEL87NiZHdtHceP
 P16Op08PVs+04nxv069zTiCW/i6g92cjHmPryOVuhZVaymEhzKS/slqeZuNfSBtNT5Mt
 Nb8F9+lLHLdE0TvVKBzcklCs3cFgFvWQ3vgUGRVFT4emayoEYSrd/zlJvoG4PlXjhnen
 D6SRCldiWgcCaXEKAf6Js1jwY/HTIZ99zuOWTTTRslL/VHVUnFmEITjKiL2j8UqrJX/U
 gDUUYlpqEk0dTPv/J91iK695XdFkYNH7APz/d2yh2RHH7a6pStfzZWZoXD6s0jCty9Pq
 F9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Xn/wGLfgFLD46kRhQwU2daT/QhgqlaCuFRqlRFnVf8=;
 b=F3KjE2rrGLI3UCew3XlLb9viGnv0IUWAuG7+P6htVKuDR0SUGATdHHgOSEeEdvY0No
 N4M4A++cE5VlSGorBQpcG6MEI1dKPvQbUKLPr9ubyKOrm6+3wb1tm2HPDVtgq8Matyis
 6S20QCl8KiyjurDof63/3Bm2xkBJnlpVV2RvRm3Uz4VqMj3OJdSFNYWToyq1CCs1krut
 uCIeEQuEMLOBRnAdQ3wXqoWBQyT0YLSnRr/yjze4qXjNw0EjOgxWjW5cV2dw4juk3dDl
 khTmzEc+qBYUeIElQECAq98aE43zORKZlGyiijqHK8/PFzyb8f750KWG/a1TcbA+74RB
 Qnog==
X-Gm-Message-State: AGi0PuYicFLjZjAGRRA9QQ2QmutLnYhbcNoHCo481Ndw8h7ZH7KYPOD7
 Qj14KEz6MFIrThToFUvHmmLxzA==
X-Google-Smtp-Source: APiQypLTfhET4THTUfXTrQhY9awvWcuDGyj6UjnRXZXRA1vR9OKC5Iv4eGwPQwAWdHvCwq4seh9Pmw==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr5348534wmg.110.1587661567859; 
 Thu, 23 Apr 2020 10:06:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 17sm4396657wmo.2.2020.04.23.10.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:06:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E34F61FF93;
 Thu, 23 Apr 2020 18:05:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 07/14] tests/tcg: better trap gdb failures
Date: Thu, 23 Apr 2020 18:05:50 +0100
Message-Id: <20200423170557.31106-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::333
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


