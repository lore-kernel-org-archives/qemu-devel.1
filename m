Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766B9C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457022072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pi4a91E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457022072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSJw-0006s0-EV
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1izSIx-000583-33
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1izSIw-00064U-42
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:50 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:38104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1izSIv-00063a-TP
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:50 -0500
Received: by mail-pg1-x531.google.com with SMTP id a33so1595165pgm.5
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OV9/GYr8QMb2MpdxO4ew9/UTUBDETqsBEY+AcIapd70=;
 b=pi4a91E7mprUaGo5YBnkhpkYXUAhZvdH3YKAiTCImDjqq3mtCeUpKe7m4I1xGIsMXh
 SNxNSAZJOLG9qN0Re5bLVG3Q5qCNZrYgCZAFibzmp3AZFXeuPtk77HaR9Wtu9xCETwaB
 EnGtCowSl1jfBGXY5LMi/F8zehzNGYyeNIBkhsgNK2jDQqPUFezDnDHZaU0CiLkcxqTY
 ZhcaW3lH1Rf8nsorw6x+ZFklSVptgIIvs6Qcy5Mk5AnZh0f0pwJ7b5cj4OG3POZKtY4j
 CScZPYq0HhF4SDpw/a1QSDSBHBCsSIl798sChPOS5AmIaxO+Y/M0cKc6WApsBqV3xuD9
 ug2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OV9/GYr8QMb2MpdxO4ew9/UTUBDETqsBEY+AcIapd70=;
 b=og32aSRD74okhiLhRJeHC4v0QzRPxWjDTDpj1Hiupw8TzIlVVIfnr4idGvQve5E2dd
 3vXpi8l7wFwLoZ/uDj4/1gLUAE/nADcDqoForcMgLqZ9gyikaMXSo+fVxriLfYLGWBTQ
 DvPD78ml7kEQkAWVo+Uey/vPj7g8B3jYWOnE4lfhJJ7IIk9mDi6sARWz1jGcB+RMENzb
 NE3vj5zwTt72tIfUsycfxLPSt5GY8jwUybKbilTj+lcAlACaaTOHXUiYqCHbz3Y7dTp6
 c9GnIjvsAxDT7/4LjSmeTL1H/xHacnerffE/NwG1fLAmtgyUvq4BnERrmUh/lXymiSd5
 i5PA==
X-Gm-Message-State: APjAAAUk70xTzy99UMxxiEq58SZjLjCY4SNX+xkjt5tySy5Y5UDLz9MH
 7Iky7mrLT290fbIM+lvqJZX1vszVHLg=
X-Google-Smtp-Source: APXvYqxJF4Hs/ejNWnPdUBSIZb8wSiee7uMKnwsBNgKOpnzMH1NzSsuOc8puh3j8L+ILUIxiMQwQVg==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr38435217pff.240.1580938428236; 
 Wed, 05 Feb 2020 13:33:48 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p4sm724576pgh.14.2020.02.05.13.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:33:47 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 02/14] tests/vm: Debug mode shows ssh output.
Date: Wed,  5 Feb 2020 16:29:08 -0500
Message-Id: <20200205212920.467-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205212920.467-1-robert.foley@linaro.org>
References: <20200205212920.467-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add changes to tests/vm/basevm.py so that during debug mode we show ssh output.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index ed5dd4f3d0..991115e44b 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -122,11 +122,16 @@ class BaseVM(object):
         return fname
 
     def _ssh_do(self, user, cmd, check):
-        ssh_cmd = ["ssh", "-q", "-t",
+        ssh_cmd = ["ssh",
+                   "-t",
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
+        # If not in debug mode, set ssh to quiet mode to
+        # avoid printing the results of commands.
+        if not self.debug:
+            ssh_cmd.append("-q")
         for var in self.envvars:
             ssh_cmd += ['-o', "SendEnv=%s" % var ]
         assert not isinstance(cmd, str)
-- 
2.17.1


