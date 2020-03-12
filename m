Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02000C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF21220663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J06cYGm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF21220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOuh-0004um-TZ
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jCOrJ-0007Ig-Qb
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jCOrE-0006X7-Vp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:44035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jCOrE-0006Wb-QC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:30:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id d9so2723175plo.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8MBax5bvqnGFn59+X+0C/P+ZVgi3X2sGtV0kV14mTCU=;
 b=J06cYGm3233jvXeQUOsSAkPSWCP9g6/W9r8rJPtGKgW8HSC0UJJ69/ezmPCpWb1mCW
 lj6cJgOU+ZTpt0xylcPUQw7BtvuOgRuGCNCrUvmYpU/1LkLPsQ4PplbfYwhs2npYtVpB
 tfU1poP61yi6Ik7alJQmCgH6ImjUBaHzkaekDUQHYovNScNs4lm9PK5gGF5rlB5AWG+e
 lvD/yJyz4YW5Xc+K9874vRsg2Vl61yrF4CjLegqNDZHreY60OkEGXsCEQ7RIqtQb/2vS
 STNGO7oMCHyrQ4/8sApQ5Lqyi7+eRw1sIxb+u9x7LykLWXRDUOJlxNthXf+B5IY2liNv
 JYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8MBax5bvqnGFn59+X+0C/P+ZVgi3X2sGtV0kV14mTCU=;
 b=dakFVDTHvFmEbIIzgeudmtch17GclsmJ1MHloah6+pxd2V8l62bvWt3DAmUKDwcC8L
 GcX0jNBV6+PHAZaJYjZHYDEqOw+5i3JstPfq2iKwc+hdV7GasmxWO2KUtvkEGZhH4Mn9
 ItU8jWHeNC7fZQGvTX2chGhK5PuqLtGPpzwzVKTnp3+3OuMe9dWqpe7+RaY+4x4/NUgE
 Uj10Jgux/5R8Lv7rZzMwsvOLotTCOksRb3ieFeVAY73YHBuPRfZQrXCvmzzyBswqqKde
 Dece0sZYV4YDihlAfapnCRQGU+RMRZXYxLN8BqLsWLGnFUBe3yIIQ+1nQ+Q9To7FSSTP
 Qcig==
X-Gm-Message-State: ANhLgQ0tWD13r50yC/FY8QENDDpUFfwUQ/LIWC9rvJL252uxLv5J/FC0
 EWUGO59nKjO0Gdz8NF+ZX4LHKhZC1H0=
X-Google-Smtp-Source: ADFU+vu2iqanlfiAPx1vh89F01EoaI3xidL4bcWHHnAGk/uQfPJdXpBueHeY6RcabMll8QPhrVKt1w==
X-Received: by 2002:a17:902:9b8a:: with SMTP id
 y10mr7923687plp.114.1584023443479; 
 Thu, 12 Mar 2020 07:30:43 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:845e:b9f6:81a6:8f5e])
 by smtp.gmail.com with ESMTPSA id 63sm14832651pfx.132.2020.03.12.07.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 07:30:42 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/10] tests/vm: allow wait_ssh() to specify command
Date: Thu, 12 Mar 2020 10:27:24 -0400
Message-Id: <20200312142728.12285-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312142728.12285-1-robert.foley@linaro.org>
References: <20200312142728.12285-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows for waiting for completion of arbitrary commands.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3562a33ffa..305b839000 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -394,24 +394,24 @@ class BaseVM(object):
     def print_step(self, text):
         sys.stderr.write("### %s ...\n" % text)
 
-    def wait_ssh(self, wait_root=False, seconds=300):
+    def wait_ssh(self, wait_root=False, seconds=300, cmd="exit 0"):
         # Allow more time for VM to boot under TCG.
         if not kvm_available(self.arch):
             seconds *= self.tcg_ssh_timeout_multiplier
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
-        guest_up = False
+        cmd_success = False
         while datetime.datetime.now() < endtime:
-            if wait_root and self.ssh_root("exit 0") == 0:
-                guest_up = True
+            if wait_root and self.ssh_root(cmd) == 0:
+                cmd_success = True
                 break
-            elif self.ssh("exit 0") == 0:
-                guest_up = True
+            elif self.ssh(cmd) == 0:
+                cmd_success = True
                 break
             seconds = (endtime - datetime.datetime.now()).total_seconds()
             logging.debug("%ds before timeout", seconds)
             time.sleep(1)
-        if not guest_up:
+        if not cmd_success:
             raise Exception("Timeout while waiting for guest ssh")
 
     def shutdown(self):
-- 
2.17.1


