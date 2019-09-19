Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86D5C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE4A21A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaG9Db08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE4A21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0Wy-0002mV-DA
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB07O-0000JK-OV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzwj-0004Lz-6F
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzwi-0004LT-Ve
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id y135so7642637wmc.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CCrWZlrAxxrJZBUu+oP477w2n13YI50PJV59anpksr4=;
 b=BaG9Db08x1Qa/PxygQOVTvtkIyBibdb4t7y+ICQkop/gZxUNWgXowJ6BPvEHIql7qW
 ybvH4Rh1sqDpEKWa2kl7qS1RyldNiI3d+yro9farCA2x/qGJEJ33BV/F7OqFa1ja8xFh
 BMKvMP7wKV0YVtTp7Tu0bwudYc2f1GoAG1M2bV0pJHYS3ZtPqNQTneLao72V2z4KyrVC
 VlKtmjtcxvIuFCdKw2MFLc6we8tnCuYEO9Iu2bJT0NtAEIqlbtifq0plMYB7VfroSTg7
 +eKmHjDO7CnVtHp2SXAecjXr1Wk+ieJ1Rn5HPfreacQ34Xne/8XzAX8l57H8pRuDI6y0
 s7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CCrWZlrAxxrJZBUu+oP477w2n13YI50PJV59anpksr4=;
 b=eanuwZwasSziQvXQEJttpeIaUIytuc6Z6daGNr+MxvryOpxBNgc1Qz4hroGwZ8KhL5
 LoTuwXEmbw2tn2x+uPc3eEOFQ1wl5NTI6pkn8I/pe0ExCPGEqFF5RIubZqLNbBy5xFCd
 dGswOmjrq9KK88tACXji4Owdc9DbfmslFfLsrBavHlVj9yCqReRrAes3CoKCJJA527Q2
 NhNs1z5V2kL0cF1RDVJulf6eLAJSXoIUMy9zy93Nb3tTFcjPdH3n7yNRJU1vhNVaSrIH
 +gdIDzWDdFsg6BsVS3Jd15+OH2IDmk2upZe+w13j4B4hlSzIGadvJAP+A3b+1RTHtYRd
 +Tpw==
X-Gm-Message-State: APjAAAW2wTKJNL984nsg2/o7+30Z8+UQGFbPR2dfSzEUUH+wyu3uCUVw
 TALXolxnHbFEjGGE3ZUXSSifTA==
X-Google-Smtp-Source: APXvYqymbbxErAqOoXBy13R/t8n0/Fc5S4uFkTbAh1XJ9EV/qAO3aSrRpJ1rny0SrvL9xKIvfXYCCg==
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr3874144wmf.46.1568913019810;
 Thu, 19 Sep 2019 10:10:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm19762180wrf.73.2019.09.19.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:10:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 090F31FF91;
 Thu, 19 Sep 2019 18:10:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/16] tests/docker: reduce scary warnings from failed
 inspect
Date: Thu, 19 Sep 2019 18:10:03 +0100
Message-Id: <20190919171015.12681-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a race here in the clean-up code so lets just accept that
sometimes the active task we just looked up might have finished before
we got to inspect it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 29613afd489..4dca6006d2f 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -235,20 +235,24 @@ class Docker(object):
         if not only_active:
             cmd.append("-a")
         for i in self._output(cmd).split():
-            resp = self._output(["inspect", i])
-            labels = json.loads(resp)[0]["Config"]["Labels"]
-            active = json.loads(resp)[0]["State"]["Running"]
-            if not labels:
-                continue
-            instance_uuid = labels.get("com.qemu.instance.uuid", None)
-            if not instance_uuid:
-                continue
-            if only_known and instance_uuid not in self._instances:
-                continue
-            print("Terminating", i)
-            if active:
-                self._do(["kill", i])
-            self._do(["rm", i])
+            try:
+                resp = self._output(["inspect", i])
+                labels = json.loads(resp)[0]["Config"]["Labels"]
+                active = json.loads(resp)[0]["State"]["Running"]
+                if not labels:
+                    continue
+                instance_uuid = labels.get("com.qemu.instance.uuid", None)
+                if not instance_uuid:
+                    continue
+                if only_known and instance_uuid not in self._instances:
+                    continue
+                print("Terminating", i)
+                if active:
+                    self._do(["kill", i])
+                    self._do(["rm", i])
+            except subprocess.CalledProcessError:
+                # i likely finished running before we got here
+                pass
 
     def clean(self):
         self._do_kill_instances(False, False)
-- 
2.20.1


