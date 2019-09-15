Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF840C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84082067D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQw9XrSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84082067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9bz7-0005qU-C1
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bw4-0003L9-Ly
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bw3-0000oL-Gc
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bw0-0000lF-Fr; Sun, 15 Sep 2019 17:19:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id i16so1975218wmd.3;
 Sun, 15 Sep 2019 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Y2S9FkhEOnSEAmHTVKobghC7w3r00lpGjrXpv6Nv5A=;
 b=eQw9XrSmQeHBau97/QUkle378AItBzSeqLx6lfeKQLAckTNDQ349ZHog5iHSCqu/de
 Jfo2rCunkm+ZZDkBcgFwZ588G7eV8lZxj+rIWShL4bWaKMMJkqtaV+SYcFk4xtmrvgg/
 ox38JBdYFSeSCsSJh0jHH9cQwO0H89lI8lYZARX5CTmxe5fxZgYFQ3FqVotMRNxzloma
 a4qvm2KTo9IWMGm2jYA/h9FTNXgj5+p5OmcTRkHVrkYbYPPO+4ejmErlTexefwMKW60h
 gSBZQ9zpD0JwSkJBIDRVkEHF+cPKIlEXJ8smtSFgu/Yz73+MjqcTTTO/bb4FAkjDwJtz
 l49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3Y2S9FkhEOnSEAmHTVKobghC7w3r00lpGjrXpv6Nv5A=;
 b=Pi5sQgB/TI9MceEiKjVq1W9hng/LXqbesbM6ztkzWIGaMN5z2SRir1CGI6B+7eDDYg
 YcvWYaAODCHyMDlMqFh+p7uCbNyXcWSFON+Q4OMni1iNDHzFol7Eg8jJQFCRM3BNwyaQ
 EQe/ZtCs6NJ4/ADP/GAwnwYq3bTDvcK90/iEUNaUqMAVQZm+pPhJaUiIemehUwuJc6mI
 QmDjYq9T7vH55NDTXxdjVLvMTVLRiRSwypfiZn9MylixABLsDamuXJNA/6X6o2kGmN9/
 +Q9EaCh9fz+ZFxjt8fboSo6foIVQpQTTRlirzd2cXFXb+iR5/oAsVq15Wweg1j1+B9SD
 w6hw==
X-Gm-Message-State: APjAAAU70QOJyTDMOGrIobijPENTIdCbmuukkyGMjcdCPqAI2PUno1ST
 kmJr9o0gcs4jxZk5DJlK9EFEZiBY
X-Google-Smtp-Source: APXvYqz/sy7A29quu8YJqWi4Qo601W/iRwi5IqgzBKjqup0lBQoSgS1VqP27ybvcML4atY2wDA5Nfg==
X-Received: by 2002:a7b:cd12:: with SMTP id f18mr11980670wmj.111.1568582391222; 
 Sun, 15 Sep 2019 14:19:51 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s1sm50271021wrg.80.2019.09.15.14.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:19:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:19:38 +0200
Message-Id: <20190915211940.30427-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190915211940.30427-1-f4bug@amsat.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2 4/6] tests/acceptance: Test Sandalfoot
 initrd on the PReP/40p
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
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

User case from:
https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html

Sandalfoot info:
http://www.juneau-lug.org/sandalfoot.php

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/ppc_prep_40p.py | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index 87b5311b89..b78ad1383b 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -37,6 +37,11 @@ class IbmPrep40pMachine(Test):
                 fail = 'Failure message found in console: %s' % failure_message
                 self.fail(fail)
 
+    def exec_command_and_wait_for_pattern(self, command, success_message):
+        command += '\n'
+        self.vm.console_socket.sendall(command.encode())
+        self.wait_for_console_pattern(success_message)
+
     @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_factory_firmware_and_netbsd(self):
         """
@@ -114,3 +119,32 @@ class IbmPrep40pMachine(Test):
 
         self.vm.launch()
         self.wait_for_console_pattern('NetBSD/prep BOOT, Revision 1.9')
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
+        self.wait_for_console_pattern('Now booting the kernel')
+
+        msg = 'Please press Enter to activate this console.'
+        self.wait_for_console_pattern(msg)
+
+        version = 'BusyBox v0.60.0 (2001.08.19-09:26+0000) Built-in shell (ash)'
+        self.exec_command_and_wait_for_pattern('', version)
+
+        uname = 'Linux ppc 2.4.18 #5 Wed May 21 23:50:43 AKDT 2003 ppc unknown'
+        self.exec_command_and_wait_for_pattern('uname -a', uname)
+
+        cpu = 'PReP IBM 6015/7020 (Sandalfoot/Sandalbow)'
+        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo', cpu)
-- 
2.20.1


