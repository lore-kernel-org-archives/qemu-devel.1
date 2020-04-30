Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC803C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF5D20873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cy6JHVlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF5D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBop-0003hC-Jq
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBdX-0000Y9-8r
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jUBaF-0003MX-Ef
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:02:07 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a]:34303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jUBaE-0003HS-WA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:58:43 -0400
Received: by mail-qt1-x82a.google.com with SMTP id b1so5420468qtt.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aF24IKnVFhq1UB6gmNrnCUeMXZezC3NkQoX6jpUZt8c=;
 b=cy6JHVlpNUxfV38LmzXrlZLRwgiMfwqKMzLXkOM80giZPGva/sjsp7XttnRlBN02I5
 ml3IlaUEwaaJJmeDCg+kPXE1uehAbXZ71YgAXDiPYs3bFtQLs26PHCVFRdPTqKrc4wMb
 eyaAmT1H64ZJbKVoXTe3NcOjER7uxy7s82L6OC8HiXxtWniZtk+IkEU1emfia48ytlbM
 IZrXrxrqcxSeBn978UVeQSDzCHBW+KcC9NJr4BsCTpwJq/VC3gmorfbLVYHHLcC/Xwvy
 cTErmVnS4DRizUZuKfyfQTEISU2kNQ7BvRw1Elk1uq7ZUMLEWoLLthhxaUeCKN4xmlMS
 pyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aF24IKnVFhq1UB6gmNrnCUeMXZezC3NkQoX6jpUZt8c=;
 b=io64806EKT/AaCrW7uq/VQBAo63VOk62RdbEzuZ5drplVgwyCMfA6HhGUKE2Kum+6o
 ntEc3g9x+zTe3AqxWp8w3Jn/oiIB6k5HHVNBE2JI0Eg4fyo3m1kP5X9wcWK+2/XJkQZr
 194G11XntryLJmISWG8qCnfy+hR+dqRZHhe+FBMhDL0s0eA91XEw4pTqMkzxzrxGyB0C
 QgHX8ERtKQxSqNQ1XXjntrHPNXIGL5vQJEs0bcdf42wqJ/MpRqVdxTrFwjXRDH/RuQVZ
 3AmWBSG5TJm2g8jT+yUZUfQV9HVPi1jCliR5ZzErl6GZEO810ntN0QtkV0Va5+iG92AX
 47dw==
X-Gm-Message-State: AGi0PuZ2yLN5gzVDcYm4iYXv98UMNUSfc/BVN2RTH9g7h4QSVQtulE8P
 n36s3URbwpPa/42lk/7VbB4SB/SGDWVOZw==
X-Google-Smtp-Source: APiQypLDIgBAsh6qAW4H+Ry/jg/6OKc9HeIAwK008JYk0QbltXw27ekaV+e6mTip+PjWKuHJZZm60Q==
X-Received: by 2002:ac8:5653:: with SMTP id 19mr4289832qtt.252.1588262321752; 
 Thu, 30 Apr 2020 08:58:41 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:7489:3328:3806:7c3])
 by smtp.gmail.com with ESMTPSA id v16sm305254qkf.80.2020.04.30.08.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 08:58:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/9] tests/vm: allow wait_ssh() to specify command
Date: Thu, 30 Apr 2020 11:57:14 -0400
Message-Id: <20200430155718.212-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430155718.212-1-robert.foley@linaro.org>
References: <20200430155718.212-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x82a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::82a
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
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 7b86ccd018..9f06f84974 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -410,24 +410,24 @@ class BaseVM(object):
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


