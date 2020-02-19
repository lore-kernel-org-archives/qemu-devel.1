Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DC5C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0C02464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSZ1+EZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0C02464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SlP-0002bK-EL
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SO9-0002kh-7L
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SO8-0007yi-8Y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:53 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:36643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SO8-0007y5-2W
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:52 -0500
Received: by mail-pl1-x636.google.com with SMTP id a6so290648plm.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AK6voT7klf41ScUCFY9SIwj/Ejz8/BionSSI8Z7kz7w=;
 b=WSZ1+EZ6MPm26Ma07Mp/WtlRLng2BoKnjv+/9/CU8ZcDnyugbylW08wRLLv3i50JmG
 pt6TivRN+1KAgyXAPKi65lbhx1xQVCtnpqGAF2YTl/D97/mM02TOIBk+ppI9BAjSAsB1
 NzA8vO6IijahNWuDJ3svPFjI0HxKN4CH5ijRjcSHyjVk6Fmt03RKXH1fwLjXAq+Y+mBy
 cftEI7O32BZZkAjKi1TzwzUcujJIO40HSyOJGWsT5ww/yHYYmgkyQprNq8FNE4yzo0Bf
 wqakNJkfyBdz66DKKBLHPa/139Jn2sFop2FyeNoK6ccClWRRCOrPYeEtD5bOWeHaTwL0
 COHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AK6voT7klf41ScUCFY9SIwj/Ejz8/BionSSI8Z7kz7w=;
 b=l6q1ftwRa8HDqigCfGhMPJI9xWe7uUIVBKEF3AxhCvgRXhgi+DtF0tqpVU10o76YK0
 PKkJypPjnO3xGt8+ux0htUNdVvPDUqkdMpm2djUY/nuLnUMUZDNrjvi4YQ09uLhGYAzd
 7qA+nAlw8yGCM/+Dkop0nOYrYXk+EMPjS28HLiqqvEaUH0ka1b3PZGYf4w/UmxVdRLJg
 0xFYlRuwC1dDn8Qw95J0GdymCii0cRaco2lixS6MCVoRGkf8AucimzR/IpHQdl3I0GzL
 IyBX0qGqmR5LJsVy7mhry8aNdAh6Prx8vvP3FrE1cUIO+GD1IoDzztKWF+3WjCprdjEE
 vcGg==
X-Gm-Message-State: APjAAAXPkK6UX/i4+FVLR/zO6ycrw0/+PZXidraosHKmn/Oop6gvlAFR
 E2g2UKBsOl3eLMmJ4xmmShZETXz3XvU=
X-Google-Smtp-Source: APXvYqxZ/XT1iY7SidHMP1LZ0t93S0p60BqvBf/cn9IER2LvDlIVVcp5Gt7Amd4Z2yafvMBTfHIviA==
X-Received: by 2002:a17:90a:7345:: with SMTP id
 j5mr9337899pjs.69.1582130390725; 
 Wed, 19 Feb 2020 08:39:50 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:39:50 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/14] tests/vm: increased max timeout for vm boot.
Date: Wed, 19 Feb 2020 11:35:26 -0500
Message-Id: <20200219163537.22098-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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

Add change to increase timeout waiting for VM to boot.
Needed for some emulation cases where it can take longer
than 5 minutes to boot.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c99725b8c0..5ca445e29a 100644
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
2.17.1


