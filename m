Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D38ACA9EAD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B17222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1UEZTt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B17222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqSr-0006M1-2K
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNr-0001ED-B8
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNq-00070h-5G
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNp-0006zt-Vj
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id p7so8961300wmp.4
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sj0gWaKf7F1u1yqYOnBP1Je+BdxFG+7SDe9DUcADRaE=;
 b=o1UEZTt9pwUVMa0JKGkLmRO8Jjq65ZDS+0OopMSn6vIuop70hSNaArxRWxJ0G3Ax9M
 2UyY7WQ3d1HMpioNigvIdcrahuIsE5G26jy9zi7RM7pBkR1HvS7id2C/PHaPowxe5UTj
 oYNLK2dAAcn0pi6nNXMZ/+u8sQACFTVp6y9YF7kjCAUvXfd0GWKyKY9vNCsotkguksoh
 yfx8GADdB6Xs89bCmNXunCJezQIejAlejrZtEfpOq3EiOcNrG8JdgD21tSKGKrkicCDW
 QOVsevpX2hKtiUnNXHU9NgXrCZMiHnvGBBA/prrOBRSCGahT+PMTOQMLS40RAEyR4K8T
 lIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sj0gWaKf7F1u1yqYOnBP1Je+BdxFG+7SDe9DUcADRaE=;
 b=CHoYq+kXuMOG5dvVOc2YHS8S7DUTXdo77um2U/6EAw3Xgx8w4e8rBMWsrBT7Qimdar
 3Ox0Z2/SR9YQ7tN2C8+RWsuyQpLqIDJc2kaQLl/ymoTToU1Walq0fbMk9u+tM8i47CKH
 oxqabcT8p0T67+2ehuFLty8JzWloGpEVGuWVHZtQZz3Wt64VPAy0Hl3IiRTRfcHp17Uy
 +TyL0wzev/nnVvFxstcaR7Ug9dEF3h515ehSdKUlsl8ZbCI2JXel89xAT/W8EuRfYL3z
 o4XfBIq8F1dIA9Y34u5qsNw6DcjpHnn219swGhdBHR9u2CHkNhCTVAMf0SSGRbiRKGLT
 qpcA==
X-Gm-Message-State: APjAAAUWtfb1ekVhqD18l8Q+50rmnFv7lg4Z944RQXewzqyZW9il+q+F
 vtcADAu1gJhaowOWXNG6lEcQ4S9+
X-Google-Smtp-Source: APXvYqz07/5/z/AHZnieoApPT5Ag4jWdxp8fxrYz2XbO/i3kYpe4kaLS3nQKp1iC8yxopm28JW1SOw==
X-Received: by 2002:a05:600c:490:: with SMTP id
 d16mr11996280wme.131.1571497868718; 
 Sat, 19 Oct 2019 08:11:08 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t13sm10753964wra.70.2019.10.19.08.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:11:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/11] tests/boot_linux_console: Use Avocado
 archive::gzip_uncompress()
Date: Sat, 19 Oct 2019 17:10:52 +0200
Message-Id: <20191019151058.31733-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019151058.31733-1-f4bug@amsat.org>
References: <20191019151058.31733-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

Avocado 67.0 [*] introduced the avocado.utils.archive module which
provides handling of gzip files. Use the gzip_uncompress() method.

[*] https://avocado-framework.readthedocs.io/en/67.0/api/utils/avocado.utils.html#avocado.utils.archive.gzip_uncompress

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: New patch replacing the gunzip() refactor
---
 tests/acceptance/boot_linux_console.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 4b419b0559..67d7e96d98 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -145,10 +145,7 @@ class BootLinuxConsole(Test):
         initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
         initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
         initrd_path = self.workdir + "rootfs.cpio"
-
-        with gzip.open(initrd_path_gz, 'rb') as f_in:
-            with open(initrd_path, 'wb') as f_out:
-                shutil.copyfileobj(f_in, f_out)
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
 
         self.vm.set_machine('malta')
         self.vm.set_console()
-- 
2.21.0


