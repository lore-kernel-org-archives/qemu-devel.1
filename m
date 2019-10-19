Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179BECA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1D1222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrljT+rL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1D1222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqWM-00010p-Qz
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNy-0001K7-UU
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNw-00076v-Go
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:18 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:47029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNv-000737-2r
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id o18so9162045wrv.13
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TPCN4WzRP9NgdoqPPa5MaOK6LcXOEN/F7yGRSMuex64=;
 b=QrljT+rLXqxtXjjqr2jqgDhboow+xDi+HX7BCD8jip2wcgB1HpVYEYRrj1NN7SInyx
 VQQLrLL9aWp7uy7UG8uw7G2+9t3rOlmGKZRjy867iOs/cJ86vZCL233ia6vJr7htu+CW
 FAdHm6DbbVIbFpHeTHTqlqWzUdUAy+AznNw8lHTLyE6nbY7aHJmgnukLAIq71vvQWrqF
 Y9B/hNdyz/GwKEgn2ZQhj+c49mn9WPSBdSZgnjdPUqVLlP8dkeA+M88BIVtKyHzdcr4t
 2cq18x3A15KHwMF2G5jNqJYnA6rPD2MGPhB43kyhDT/XHXeTQkyeTJRFZ1jztMas/H8Z
 1Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TPCN4WzRP9NgdoqPPa5MaOK6LcXOEN/F7yGRSMuex64=;
 b=oTfroLrLFYwMI1AsoQezCpq38Yf7qL11lbxttt+ceJmoNYlei1agMawDZ0WxX+ssQA
 Ci7nGG1Z39R7vWCNjBr3IvLQFmr4Jt4Ysold3cwJjs6/P2y5xkO1L9Rslinf/8Nt9eoY
 /k7GbtAJLqSPb7e/09mmaz8VkPEyIADQ+WGoiejeU31TW9QpfPzdw0+85xpL6Uv1Muig
 31qxk0YfsDFswj3PYiOicMy1viLYjp7DiTMUj+LS1WhB6QP/nIZV2RPX7aInasj4magu
 5jQWr6n+zFLZPIk+7PELNHiQjkbBOnEExCAQlByMi/3G1e/GgBMLzjeG6Gc0UXfbsWWI
 RXRw==
X-Gm-Message-State: APjAAAU6l5mUHRnUrJmS51e5uiBfhnKceweNSYD8YDVlwZbc20UZzgmK
 vuo11YOrlEikCfmDMvz9AtB9O9Lo
X-Google-Smtp-Source: APXvYqxxb0nvh13WvknQ0RolSLJqlKenf7402wPCALlNQBs7hbYNSDlKGbF5r8FEgRs59n5CkWik/A==
X-Received: by 2002:a5d:67c5:: with SMTP id n5mr12723221wrw.72.1571497872234; 
 Sat, 19 Oct 2019 08:11:12 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t13sm10753964wra.70.2019.10.19.08.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:11:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/11] tests/ssh_linux_malta: Remove duplicated test
Date: Sat, 19 Oct 2019 17:10:55 +0200
Message-Id: <20191019151058.31733-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019151058.31733-1-f4bug@amsat.org>
References: <20191019151058.31733-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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


