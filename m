Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D57FCA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FC420854
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDUCYG0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FC420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqrz-0005hj-Tp
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkl-0005FO-Po
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkk-0002vE-UZ
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:51 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkk-0002ue-PC
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id t16so4098249wrr.1
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TPCN4WzRP9NgdoqPPa5MaOK6LcXOEN/F7yGRSMuex64=;
 b=iDUCYG0HBFIrl9z6+Tn9dOLjMVypliSGEhIg6ZV1UedvGmX0MTw3fcw3z3Uy+3kkuW
 C0DsH9lQ26d+snHCskPFPRdvGYdtRLfBf7/+iEJdSKNitG9SEAsEmvaYHqnZFBECdYLz
 ZCCgQrsjoGm4qwjO+g5lOeFK3eMW/FbXPOJxr2QjIkAp5+5Hg9sThb/dXoJMXRc32gSS
 Muw5OztJiQUV+i0xwUMtBA7/vEU3KSmH4oK/RSXtRC2pgBQWsM+6o/efwMbbhq0Dia9d
 hZ+l8maVuck9/NEKtSg2MOj2kfBlGVbpQh3cYMj+jGMpB1P2F5bjnDgDxFU/B6+x9IVo
 43kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TPCN4WzRP9NgdoqPPa5MaOK6LcXOEN/F7yGRSMuex64=;
 b=ByukUcQWypHXI/s8GeAkF41HzqMdOssG8xZaMkhQXMtZokP6i9PEZ78lHIDeYpA6HY
 1Bb66U6ucj6L+4l2K9haZV3fxvlWTIO9BVEI5n7uCoGMy6w3RR3/BDfCfFZ2ZoEUBv4t
 Y7BBhHE2UEZ+gPxbbxtXddqF31m1ocYSFC4LeYBqMjv0nsPIlgxcuMmJYgERiMJqR32s
 vPjsczkayqdv7bcLcoiuFXqWUe1t+wLFVa7rkMAjq0UwEpHvkf8SehCu+gyIpkXp5e1c
 i3dsT6rxX3PkTbKkcwlMLJhraT0Cvt1hYx3WTdS6h7u3ptiBmzvaxz14v0R64rMr4cOM
 zJ5g==
X-Gm-Message-State: APjAAAWDR2YcaUv51Oh+sOVOxPExYttHDuvyTUJS2KCZQ8QYNY16hc3c
 PtBhGuBLx7eLs1Fj14x3SAvDbZ9R
X-Google-Smtp-Source: APXvYqzzvGYGHVrIJKUk6NIx1g8IHytGpnlmQPJtH2f8s9YCTiG07fRcMkTniPIcpOHtngdXjvifWQ==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr11078654wrv.281.1571499289652; 
 Sat, 19 Oct 2019 08:34:49 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j19sm15245605wre.0.2019.10.19.08.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:34:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/11] tests/ssh_linux_malta: Remove duplicated test
Date: Sat, 19 Oct 2019 17:34:34 +0200
Message-Id: <20191019153437.9820-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019153437.9820-1-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove duplicated test (probably copy/paste error in
commit 9090d3332cdcc).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/linux_ssh_mips_malta.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index 27907e8fbd..5523ae2144 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -140,9 +140,6 @@ class LinuxSSH(Test):
         self.ssh_command_output_contains(
             'cat /proc/interrupts',
             'eth0')
-        self.ssh_command_output_contains(
-            'cat /proc/interrupts',
-            'eth0')
         self.ssh_command_output_contains(
             'cat /proc/devices',
             'input')
-- 
2.21.0


