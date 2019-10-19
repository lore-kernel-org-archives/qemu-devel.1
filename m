Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602B0CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E1A20854
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X78yY+/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E1A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqrr-0005XD-TZ
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqki-0005Bd-Pn
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkh-0002sz-BD
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkh-0002sY-5d
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id 5so9006499wmg.0
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sj0gWaKf7F1u1yqYOnBP1Je+BdxFG+7SDe9DUcADRaE=;
 b=X78yY+/FiWu/vOU/BzjaO1Lj3RdJ6U4spA9vfenAsWU+tEHPNheaHkma1GV9ZUftw5
 DKuy8vaqNGR7TMTc5MwYjiHN07QJHF/TM4QrYKB1JBHZPhQEYEAlETU3fQv62ajMOs4f
 zP3U1Pq8N8/Vevx8PmyCllsle2Ij3OPHJONTgoF6yi0gnq3kbWrDQRg5CLYFzTScsh09
 EbYzpOwrSINsXEunu+wGx1I0bQLXivOR/51AWqdjttC3DmSiV3k9ZBW5wUSCdgfFoKun
 v/b/b16r87NUmsdqnaLM7EX/ypsG2AN1YcXHZhnS8ICV8SudvHYWNuCSid29hj7SiWRV
 nsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sj0gWaKf7F1u1yqYOnBP1Je+BdxFG+7SDe9DUcADRaE=;
 b=l+fOrMiiRQP6UuB2KVykhdYcdSmBbtV/kTlYWRcGBXHhu4ElcGN2eDtYeSVan6G/1K
 f0oI9RuSOsgiLbObKWBzGOMjZ8+GAaPTBk6swywRLP2/AGsCykM2Y2of5BY3VCeKOYxX
 OB99D68jsewv8zSQTBJvRfprMoyYajCP4iMs5Y2QaZ6ztDEipnWVd7Ob1zDjxtEpmQN3
 kRWA9pmnWdmYSqrAaybXH0iK/e4DbGDiXsHmnSnlsKy9IzR80Y6ZjiaoxWqr5kw89QX8
 YKMK9EcKBI3rJSt74oSk1Ye9Ue2MZEovO3q1H35RCfjjGeTNnON6iBoYiCRJsKgrKAlT
 TuiA==
X-Gm-Message-State: APjAAAWeYKPD/lWUwpHuGsumFEUMcC4BhDx3MyetN75wCtPSnoP/ppPy
 nx/xuhIrknu13+x+dtL/nnirr2o8
X-Google-Smtp-Source: APXvYqylPMfVMJ+dH0bEqzzD4kSX+qnclFbot7J8nW0lPj4HKPmFofkyBC3JHgnV17tPzoCDTh+TuA==
X-Received: by 2002:a7b:cf0e:: with SMTP id l14mr12368753wmg.46.1571499286024; 
 Sat, 19 Oct 2019 08:34:46 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j19sm15245605wre.0.2019.10.19.08.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:34:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/11] tests/boot_linux_console: Use Avocado
 archive::gzip_uncompress()
Date: Sat, 19 Oct 2019 17:34:31 +0200
Message-Id: <20191019153437.9820-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019153437.9820-1-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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


