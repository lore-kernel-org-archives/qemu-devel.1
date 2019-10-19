Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D9FCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CF32064A
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uznfB4XJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CF32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqSs-0006Oq-MD
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNv-0001Gl-6R
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNt-00073v-En
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNt-00071v-5R
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id o28so9193399wro.7
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8KsmRbilP8bTZKqxOfgUbDMH68hI/j6t6Vn/sO5YZF0=;
 b=uznfB4XJD+NpZQv6j7m3WRlhlt5eDIhOdZEzz/XoSJGxlz02S0S73ZMhnsL+wlfw5B
 A//UiretDOPWmb3xO8qPaw5VTj8GcPc1JLmCIvrdy9v+UFe4K7F+MF2WXQDxozhrLC0p
 twJ+IKNoWChywO20NKuHwna5m6gyeHdEt3hd6GITncsrWptrEJ11BZbwF/8obZ/a/qww
 O1upyNJkbugzmvDCcmWGHLOlLVg2ri5LSGU2gzub83Bl/DHazxhTlTsYM0n2ceEyMcFZ
 0iIRayUDRhCKO31/Omsadf8DfObXjE9mrb9lRgDS2UjcpagWsV98YDpkWYBFlTCOUF3w
 u1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8KsmRbilP8bTZKqxOfgUbDMH68hI/j6t6Vn/sO5YZF0=;
 b=c4fg28p/AkEGFD79pYlA8luI2Ydxu0y3kE8Ip8KsnsYETPI15PsbQuqxQxSGUwRqd+
 nW/jCLB2L7aAKW7K4JnUElZg25i19DdV2Us5+lHagjMJUkQmFZZ1PUQamCXazSU9gTBJ
 s+vzYcGkF6RsGN4Fx9L9j3fysrAVFhvxo2HPhboVu741Iyynx8WANYjs7o6g0cji382I
 mRKyQz6nhyF46lcR+QZiwujfVxKglZQwAUlsO8gci3zSz5JJMmet0NUP7lPgeH0vDuiy
 X5pTe1IgqoD1d28mMTHy1Qe+SNLNsE/6E7NFw83p3cAJMMZUOIrHV0yHrK42By/OiU4u
 ppgQ==
X-Gm-Message-State: APjAAAUpgUQYXo//VWuxsjmOqrhFD7/vO46FuNEumUXlDJe+d26CEdQE
 5l8lnsbzY/4yFcVn5Ae2Vcl7LZdj
X-Google-Smtp-Source: APXvYqxFGrYIYyRQ9f/yO2mcZclEnvfgW0FnUoitnvbzAXWcjYb9PKWwr4f66Cb5/olfbTTtptghBA==
X-Received: by 2002:adf:e80b:: with SMTP id o11mr12463828wrm.231.1571497870948; 
 Sat, 19 Oct 2019 08:11:10 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t13sm10753964wra.70.2019.10.19.08.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:11:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] tests/ssh_linux_malta: Run tests using a snapshot image
Date: Sat, 19 Oct 2019 17:10:54 +0200
Message-Id: <20191019151058.31733-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019151058.31733-1-f4bug@amsat.org>
References: <20191019151058.31733-1-f4bug@amsat.org>
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

If a test fails, it can corrupt the underlying QCow2 image,
making further tests failing.
Fix this by running each test with a snapshot.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/linux_ssh_mips_malta.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index ffbb06f846..27907e8fbd 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -90,7 +90,7 @@ class LinuxSSH(Test):
         self.vm.add_args('-no-reboot',
                          '-kernel', kernel_path,
                          '-append', kernel_command_line,
-                         '-hda', image_path,
+                         '-drive', 'file=%s,snapshot=on' % image_path,
                          '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
                          '-device', 'pcnet,netdev=vnet')
         self.vm.launch()
-- 
2.21.0


