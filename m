Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A52ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106B620820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOhgq8GP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106B620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9ds-0003uQ-TH
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91L-0001OW-RD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91K-0006gA-K7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:53:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91K-0006fu-Dj; Thu, 17 Oct 2019 12:53:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id o28so3163852wro.7;
 Thu, 17 Oct 2019 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uoKHrShfOPAUn47GW20hABBgh2KN1hcOeK5Wq7+CL6M=;
 b=gOhgq8GP5sYQEnSW9WK3rcpCFNDQEysr0bZf+j33qQ9INcqOoJ05Hbx3usMGHTxNY3
 5f5/j02S3fp1D9KysZTFY1/BQXxjEh8K3tKaOHptqa9v6LzPSxYICaYrRA0o1QVKz54A
 4WGdg2J8ctbGopmI3ApETFld5hSmZOrt9WUOmT2ms3rtKWRQF9I4ywSzucMyXN+Z/wwj
 iBzmLBPX88OHr1x2JBCJPMBcJzVMA9PdEWB1Qfj1cAmhbrJHGGaVo8VBS84zof3+Sl0s
 dskA98hxBTLMnHXAwZgWMBSnsu1MF37Q53DK+kjYdbJMqlr+epqdfFgJ8clYR/Qrbs9p
 fQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uoKHrShfOPAUn47GW20hABBgh2KN1hcOeK5Wq7+CL6M=;
 b=hqzLhs1BOKVEopNqz8U5xdV8E6f8TnevDNz0UaVIlhqeXgqenqhOybY2UDtvJi9bi1
 EfEXZqze9osQqQ2atp9Dh3goYt7fND8OvT9FHuzk+GDE7h4kZHIlH3j4K+PlO2prsSx8
 PgOUsMcicWgJbJuoEeKAAsk6rbQtVxVAItm4iXWLe9o9SVZdz+BESyAsjCFfLFBm3Cap
 k7bLyw+POMFXUF2Fv6zRarIyy/XdOH0iUUKHduhyB1kWc3Tv6npevF2l+UpSRbj5xg99
 4w9nIlqAzd0JdaNKuv4hqArNxYag5DMji08S7QabgNkT4s/CnnHN00HGQsaqti8cQlHk
 nP7A==
X-Gm-Message-State: APjAAAXRyYac0SlDk4WI5LLofZR1e7fN0zYwA3vriQRx9izK+f/490ru
 CugbtyogTYjuZqzZL0XrEl4uI7ajjI0=
X-Google-Smtp-Source: APXvYqwFMjkMxlqMJHq5vRSpIZ2CTxLrz/6a18DkzbUwXN7ZZEjDtoBlaGtf3DiFOYmq6yvkeGKjOg==
X-Received: by 2002:a5d:6246:: with SMTP id m6mr4084034wrv.262.1571331181223; 
 Thu, 17 Oct 2019 09:53:01 -0700 (PDT)
Received: from x1w.redhat.com (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id w22sm2557363wmc.16.2019.10.17.09.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:53:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/9] tests/acceptance: Test Sandalfoot initrd on the
 PReP/40p
Date: Thu, 17 Oct 2019 18:52:38 +0200
Message-Id: <20191017165239.30159-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017165239.30159-1-f4bug@amsat.org>
References: <20191017165239.30159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User case from:
https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html

Sandalfoot info:
http://www.juneau-lug.org/sandalfoot.php

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3:
- use avocado_qemu.wait_for_console_pattern (Cleber)
- use exec_command_and_wait_for_pattern
---
 tests/acceptance/ppc_prep_40p.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index 0ebedd16c8..d022fe5ab0 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -10,6 +10,7 @@ import logging
 
 from avocado import skipIf
 from avocado_qemu import Test
+from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
 
 
@@ -94,3 +95,32 @@ class IbmPrep40pMachine(Test):
 
         self.vm.launch()
         wait_for_console_pattern(self, 'NetBSD/prep BOOT, Revision 1.9')
+
+    def test_sandalfoot_busybox(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:40p
+        """
+        drive_url = ('http://www.juneau-lug.org/zImage.initrd.sandalfoot')
+        drive_hash = 'dacacfc4085ea51d34d99ef70e972b849e2c6949'
+        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', drive_path,
+                         '-boot', 'd')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Now booting the kernel')
+
+        msg = 'Please press Enter to activate this console.'
+        wait_for_console_pattern(self, msg)
+
+        version = 'BusyBox v0.60.0 (2001.08.19-09:26+0000) Built-in shell (ash)'
+        exec_command_and_wait_for_pattern(self, '', version)
+
+        uname = 'Linux ppc 2.4.18 #5 Wed May 21 23:50:43 AKDT 2003 ppc unknown'
+        exec_command_and_wait_for_pattern(self, 'uname -a', uname)
+
+        cpu = 'PReP IBM 6015/7020 (Sandalfoot/Sandalbow)'
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo', cpu)
-- 
2.21.0


