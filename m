Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FB72072D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTQsFK8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FB72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QtE-0002Ie-FV
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqo-0006zq-R1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqn-0000Rp-Da
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:02 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:39771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqn-0000Q6-6r
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id y17so1599309wrn.6
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1qnpQiuLu8k4ZAfo7VfU1hbr6iwSq3LWEeDvjeoy05s=;
 b=WTQsFK8ZOUYiEx2SWDgvMUQif2MGXcPuGbUv2uehID1FM78IXF4OSq7y5hCfllxJzZ
 I7v20CB48BnOK4BYY2jmGmr0NWJ2pEoBbRat5zoVONGRYxhK4Pdv09kQGdxCeuhoSVXC
 OTnBEvlEmNUo9BPM4IyYrSkxxd8fO57PNkvZCHIAyD1Z1iPUf02FaSK1GF3HBCqxIGsK
 e3CwngXPS5WeY3SU4r3FhOKUOpXctMhj4p1lGCQLbdP19B1rkQ9Rp9FxMT2k25N5b6v7
 1hfimFpj+yeKNW/LxlxpvB2hD6ElDtJ51s5xS7KIMS6fRABHwsDncEWHQ/6UOmynoIKl
 SY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1qnpQiuLu8k4ZAfo7VfU1hbr6iwSq3LWEeDvjeoy05s=;
 b=GXtdjEbWKOuW1/P9wEtMyu5+PDNIBy9istpR1txLJsFezaHlJriXk5oPS6ica4e77j
 zhIyriJz5ZdJ3yAe0eoaxvg8l3oafyunJXyBUu7Muqg0Qr7u3iVUHgXIAULXauwTvBUt
 8X2BCIXeKVQHC+uJlbnWrFFS0Pues08IFzwYFCM6CBZhKPuH+DjaVKbq6T5AaEvPnfo6
 9ru/RCDYjGPo2KKJ1iOlkri6mg/2zd/aplmf0xSIjk80Z0kUWe61cKkaEo49vfUPzmNM
 kGWopNcEwRZWBPlJRRyG/iFY+guMfYEFeIr9rBkcIlFzjk1FhxCgIz1f28ivhToICk5f
 NkVA==
X-Gm-Message-State: ANhLgQ1zL3CMu1wsq7MHA27X+rwsvoDqnDzFrPQuOBsFXnYPBSgpldqQ
 kuRR3d2r7l5Bu2OeWLrv+Kv/gQ==
X-Google-Smtp-Source: ADFU+vtRqoI9CmQWzOmJnJuxN3qiLDvVMIERZK/KdBupT5fJAUONUKWpAbCnnxI70ocSjnGgwWTM+Q==
X-Received: by 2002:adf:ed42:: with SMTP id u2mr3398768wro.345.1583316120186; 
 Wed, 04 Mar 2020 02:02:00 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o3sm4055067wme.36.2020.03.04.02.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:01:55 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C3141FF90;
 Wed,  4 Mar 2020 10:01:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/9] tests/vm: increased max timeout for vm boot.
Date: Wed,  4 Mar 2020 10:01:48 +0000
Message-Id: <20200304100154.14822-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304100154.14822-1-alex.bennee@linaro.org>
References: <20200304100154.14822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Fam Zheng <fam@euphon.net>, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Add change to increase timeout waiting for VM to boot.
Needed for some emulation cases where it can take longer
than 5 minutes to boot.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200219163537.22098-4-robert.foley@linaro.org>
Message-Id: <20200303150622.20133-4-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c99725b8c0d..5ca445e29af 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -57,6 +57,10 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
+    # Scale up some timeouts under TCG.
+    # 4 is arbitrary, but greater than 2,
+    # since we found we need to wait more than twice as long.
+    tcg_ssh_timeout_multiplier = 4
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -309,6 +313,9 @@ class BaseVM(object):
         sys.stderr.write("### %s ...\n" % text)
 
     def wait_ssh(self, seconds=300):
+        # Allow more time for VM to boot under TCG.
+        if not kvm_available(self.arch):
+            seconds *= self.tcg_ssh_timeout_multiplier
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
-- 
2.20.1


