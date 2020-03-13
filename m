Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93FFC4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB5E20409
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uO9R+YS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB5E20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCo41-0003VY-Ky
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 13:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCo3I-0002vj-Lp
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCo3H-0006w3-41
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:24:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCo3G-0006un-Tm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:24:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id s14so13122519wrt.8
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dLesLAm1eL1nhyeIN3Gcr4+dzCmfTRF/hQyK2zuFN6I=;
 b=uO9R+YS1tvNkPtMZ5eja5hMz4byHLg9cl1gHFw586JplciQNkgPiFaUgrs6T+AnmHH
 BTTSab+oD4p1sWCUdheFte8keNeRRJtHtE+S1SwvFJKTLyc8ranTaXqMBvAfi1WeS1Z4
 mvLqDSXRzRu2sT59Rwoasgz5bSV6JDlUpr+EKR8j3BnBgvh9HJhJV5wBIWVE10vZ6ckT
 Um2C7aXww7zE75EyrO7v0ilMSUVae4mVRSroHkgjgvZ12RVSP0AvNdMUJ3DZrwyf7x5D
 1cS+0eOoNv704MJOplUAJZsWRwd5/QCDmKwFBLl9KY4ikaseL1DVDGf21eO7hGt6sLb9
 X7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dLesLAm1eL1nhyeIN3Gcr4+dzCmfTRF/hQyK2zuFN6I=;
 b=inrGa5A80JJIu9w/J0Oce2LIEY5Dg20hgNPe/j+tKB3ULdstZoVIBWZ1mY0OSVcpZk
 5L3eW7Dhc3ScjQ3MLfGX+l742J890Em9R5iZSGR4LXIY/bGvuyM6OXj3dx+4tGjB69no
 Gg40WsL0z1NIdQ64dQsxgM95sqDuedUOiriqOxjvMO7td20oaZ1ABSSsC+zjZKwY/1JL
 AEhh19UmAy2MOBTGcmN2wOyj9dbWODS5dAVjocgJoCzWYxaRorIpP6qn8l2ZC5HqiK1U
 BFUYvjrtdwvFNA+/+2PDhr4/nSXzpjuxBto/Goq4JYrCS8nEnVOmrSnX42fLxd6Z9+cL
 oFNg==
X-Gm-Message-State: ANhLgQ254FzyH+H9eyDWddH6G+Diw4O7qfP8tOas9WDJXMGbXS0lltdI
 AyyWTSTTTL8O0BCTsZR5mTIaqSQeXR5lAA==
X-Google-Smtp-Source: ADFU+vs6v8j5fvuUACzrCUL0+ilZx9PlAGpx2Nq/hnK51KZXJ4ynMf9DqjBowGh5ZyCU8UWt3sdu+w==
X-Received: by 2002:adf:fc82:: with SMTP id g2mr19668554wrr.117.1584120289349; 
 Fri, 13 Mar 2020 10:24:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w204sm8002547wma.1.2020.03.13.10.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 10:24:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] softmmu/vl.c: Handle '-cpu help' and '-device help' before
 'no default machine'
Date: Fri, 13 Mar 2020 17:24:47 +0000
Message-Id: <20200313172447.15471-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently if you try to ask for the list of CPUs for a target
architecture which does not specify a default machine type
you just get an error:

  $ qemu-system-arm -cpu help
  qemu-system-arm: No machine specified, and there is no default
  Use -machine help to list supported machines

Since the list of CPUs doesn't depend on the machine, this is
unnecessarily unhelpful. "-device help" has a similar problem.

Move the checks for "did the user ask for -cpu help or -device help"
up so they precede the select_machine() call which checks that the
user specified a valid machine type.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This has been on-and-off irritating me for years, and it's
embarrassing how simple the fix turns out to be...
---
 softmmu/vl.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index ff2685dff84..6a285925b37 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3789,6 +3789,22 @@ void qemu_init(int argc, char **argv, char **envp)
      */
     loc_set_none();
 
+    /*
+     * Check for -cpu help and -device help before we call select_machine(),
+     * which will return an error if the architecture has no default machine
+     * type and the user did not specify one, so that the user doesn't need
+     * to say '-cpu help -machine something'.
+     */
+    if (cpu_option && is_help_option(cpu_option)) {
+        list_cpus(cpu_option);
+        exit(0);
+    }
+
+    if (qemu_opts_foreach(qemu_find_opts("device"),
+                          device_help_func, NULL, NULL)) {
+        exit(0);
+    }
+
     user_register_global_props();
 
     replay_configure(icount_opts);
@@ -3877,11 +3893,6 @@ void qemu_init(int argc, char **argv, char **envp)
         qemu_set_hw_version(machine_class->hw_version);
     }
 
-    if (cpu_option && is_help_option(cpu_option)) {
-        list_cpus(cpu_option);
-        exit(0);
-    }
-
     if (!trace_init_backends()) {
         exit(1);
     }
@@ -4112,11 +4123,6 @@ void qemu_init(int argc, char **argv, char **envp)
                       fsdev_init_func, NULL, &error_fatal);
 #endif
 
-    if (qemu_opts_foreach(qemu_find_opts("device"),
-                          device_help_func, NULL, NULL)) {
-        exit(0);
-    }
-
     /*
      * Note: we need to create block backends before
      * machine_set_property(), so machine properties can refer to
-- 
2.20.1


