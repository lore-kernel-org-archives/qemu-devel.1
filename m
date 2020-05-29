Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99924C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6203D208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8NarI4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6203D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelwu-0006k3-K0
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqh-0005uF-CL
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:27 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:44519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqg-0000rq-Cu
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id bh7so1696374plb.11
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I57f4z5ddl8Jgj2XC06LWOjtbgtg/rXwxyMqaFaoBAM=;
 b=d8NarI4a5bR1b0jOmT4mpBXTixvltA5AycOdlCe0wkJGSJ1L1nvwx8iYL8ts3Ii55B
 CMBxeMX6Y1TNUSsRk0O1niUCjEpwxqUFZY2/rswBF1I86yaHxnmr+b+z/VLEoN6YAp/q
 5hyS2uBQAYQqAmLNIndz12LbB5zGrCSNSI0ZoJ0MvzW+pff+vw+Ocq4DwGgSSdMSBUxS
 JngFdR1D1M+tUFzXRI9qNMFCUJyaY6CoTiFj1ctcxspc8NqHz44mnKQGjYbmVSqkSEKM
 Wrbeq3Hn0EZlQCQgGVbNqg1Wx/qI93IVEDjC/AQNnuRclXfbpAS7MCsE2MFsGn70Q2yd
 wu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I57f4z5ddl8Jgj2XC06LWOjtbgtg/rXwxyMqaFaoBAM=;
 b=hUJtKQCB5gIMU91VsaeWHT/KPKpRinT6I8YPZoo4YwHlVA2W6JM/J2XTEPuDs1E3UM
 NtQBWC5N0SYk+IsNVUEvDC7qo7B45Y0Lr4n1WhfTE/yXqUSHhq9P8qE61OVITHI2BQjs
 PN+j+JsNOFTbFaEllh0j3xJgrfmT+48lS+Id0+nndO4RiZCWukP9mnTrUxGcIv9/pAJy
 taZ9wKJH+KpV5dBpoet20d6m07ajDpZdhut19q5mLqYE2aK5HiMYqnMeAoaKr9dcS+pT
 p3bHjNuqQpGJYo/sIiw4KgjKwXsDt6XB7PwMBf6nb5pLyIEhfwqlvZI2MDhYbtdWSqA5
 I/6g==
X-Gm-Message-State: AOAM533AwTKL2Q6Ul/pFY531Z6enAY7ljTIc670n8XWzzprAh0HZDPkL
 RLCvXEZ8I/OnnvL9q2lQUYq7Gx3O+qbB/A==
X-Google-Smtp-Source: ABdhPJy3ztoWAT52XGQOtZx1307bL8ruciP2QMQhornJXdnywh/MD3i87K1GfphPB8MbVivqPVOc9Q==
X-Received: by 2002:a17:90a:a884:: with SMTP id
 h4mr11578316pjq.82.1590785004522; 
 Fri, 29 May 2020 13:43:24 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id t12sm282839pjf.3.2020.05.29.13.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 13:43:23 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 06/12] tests/vm: allow wait_ssh() to specify command
Date: Fri, 29 May 2020 16:34:52 -0400
Message-Id: <20200529203458.1038-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529203458.1038-1-robert.foley@linaro.org>
References: <20200529203458.1038-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows for waiting for completion of arbitrary commands.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 75a7ac2bd3..1aab9e3a24 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -411,24 +411,24 @@ class BaseVM(object):
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


