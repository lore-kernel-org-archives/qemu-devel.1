Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF55C2D0E8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F112220787
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3s7tGe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F112220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKIp0-0001TM-9g
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKIoG-0000QO-D8
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKIoF-00037O-0x
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:40:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKIoE-00036f-NG
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:40:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id c7so7692901wrx.5
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=urTdOG8/AKfDySZVWZoH4F9NK6OheNZjgqwxfBn3rfo=;
 b=O3s7tGe1kMfenrjwTUSS2NcDNxbBQImmp4gCUeR+g1Pz4YR4RzV2LbLiTMEcvQnSSG
 LZdknxd//Z3QSmUMBBrzvl8rFnKmTuHtr62vkvfptABrGjkscHBR+Cwgvewvx8VUmpBe
 N9scdlKd92rWAJoWLe66LKmXiYDUHo+5K3zgVLbu1qOYgVtWHwnqPHEdDpYgtl7/7G21
 fmWUIIYY2DPjs4ukISFKExMpdywM5gRAXw44wkGjCM7em8Nf1smWDE7YCWrZh5zVaif7
 vMFDhHaM2qoCI27Q5/6WVcfQvxPVHjOn8sUPaJFAw9t/JEZefQXgMM/45k0tBWxfn25k
 TeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=urTdOG8/AKfDySZVWZoH4F9NK6OheNZjgqwxfBn3rfo=;
 b=e5ze6b5Mw6++EUvRUr/NpeUKwJk2Shakz7iMFgfeo5I02E2j7EK2TlSfxhlgaA/Jd3
 N65xuN7RcSAKjRqfdLQeBAy58YyFfqSsp6O/LR5ShwwHhAMLsLG3g+q7FH7LwxAlpsjS
 RbiM6yLvepmyVQ0DnbyRhYxNf5ckAKjRHUxLx2VRiW0eM1VtSDtZOKm/CmL5z9iCzen6
 clp4xkdWNlT/DSLqGdlW5MCgwkY2siCEaRM7fOmyWxbL44/7HZL4vGrfzQ4bzuGPLMzr
 KXX2oeyqL+xGf645R996ZcjrbOucpz+26dOkNaud612VPGkLpza11adf6eRHCd3g4pci
 wFSA==
X-Gm-Message-State: AGi0Pua0aCs/xy2R9zvhbDMIUVt9Ijn9D5Vxj+YquGrpaFcZit5EiE0j
 MNnSSFRfh8P+YblFtiCeCQTjGa1RoPPkgA==
X-Google-Smtp-Source: APiQypIyMHWBe3U8YKiTL0v3qbJrLKMBI+S3M8nbibUQ3/1RHSFtPRsQr4T60hRCVT7WSOqJQumuHQ==
X-Received: by 2002:adf:e445:: with SMTP id t5mr8214267wrm.352.1585906816819; 
 Fri, 03 Apr 2020 02:40:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i1sm11043322wrq.89.2020.04.03.02.40.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 02:40:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0?] docs: Improve our gdbstub documentation
Date: Fri,  3 Apr 2020 10:40:14 +0100
Message-Id: <20200403094014.9589-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation of our -s and -gdb options is quite old; in
particular it still claims that it will cause QEMU to stop and wait
for the gdb connection, when this has not been true for some time:
you also need to pass -S if you want to make QEMU not launch the
guest on startup.

Improve the documentation to mention this requirement in the
executable's --help output, the documentation of the -gdb option in
the manual, and in the "GDB usage" chapter.

Includes some minor tweaks to these paragraphs of documentation
since I was editing them anyway (such as dropping the description
of our gdb support as "primitive").

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Maybe 5.0 material since it's just a docs improvement?

 docs/system/gdb.rst | 22 +++++++++++++++-------
 qemu-options.hx     | 24 ++++++++++++++++++------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index 639f814b32d..a40145fcf84 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -3,17 +3,25 @@
 GDB usage
 ---------
 
-QEMU has a primitive support to work with gdb, so that you can do
-'Ctrl-C' while the virtual machine is running and inspect its state.
+QEMU supports working with gdb via gdb's remote-connection facility
+(the "gdbstub"). This allows you to debug guest code in the same
+way that you might with a low-level debug facility like JTAG
+on real hardware. You can stop and start the virtual machine,
+examine state like registers and memory, and set breakpoints and
+watchpoints.
 
-In order to use gdb, launch QEMU with the '-s' option. It will wait for
-a gdb connection:
+In order to use gdb, launch QEMU with the ``-s`` and ``-S`` options.
+The ``-s`` option will make QEMU listen for an incoming connection
+from gdb on TCP port 1234, and ``-S`` will make QEMU not start the
+guest until you tell it to from gdb. (If you want to specify which
+TCP port to use or to use something other than TCP for the gdbstub
+connection, use the ``-gdb dev`` option instead of ``-s``.)
 
 .. parsed-literal::
 
-   |qemu_system| -s -kernel bzImage -hda rootdisk.img -append "root=/dev/hda"
-   Connected to host network interface: tun0
-   Waiting gdb connection on port 1234
+   |qemu_system| -s -S -kernel bzImage -hda rootdisk.img -append "root=/dev/hda"
+
+QEMU will launch but will silently wait for gdb to connect.
 
 Then launch gdb on the 'vmlinux' executable::
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 16debd03cb6..292d4e7c0ce 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3680,14 +3680,26 @@ SRST
 ERST
 
 DEF("gdb", HAS_ARG, QEMU_OPTION_gdb, \
-    "-gdb dev        wait for gdb connection on 'dev'\n", QEMU_ARCH_ALL)
+    "-gdb dev        accept gdb connection on 'dev'. (QEMU defaults to starting\n"
+    "                the guest without waiting for gdb to connect; use -S too\n"
+    "                if you want it to not start execution.)\n",
+    QEMU_ARCH_ALL)
 SRST
 ``-gdb dev``
-    Wait for gdb connection on device dev (see
-    :ref:`gdb_005fusage`). Typical connections will likely be
-    TCP-based, but also UDP, pseudo TTY, or even stdio are reasonable
-    use case. The latter is allowing to start QEMU from within gdb and
-    establish the connection via a pipe:
+    Accept a gdb connection on device dev (see
+    :ref:`gdb_005fusage`). Note that this option does not pause QEMU
+    execution -- if you want QEMU to not start the guest until you
+    connect with gdb and issue a ``continue`` command, you will need to
+    also pass the ``-S`` option to QEMU.
+
+    The most usual configuration is to listen on a local TCP socket::
+
+        -gdb tcp::3117
+
+    but you can specify other backends; UDP, pseudo TTY, or even stdio
+    are all reasonable use cases. For example, a stdio connection
+    allows you to start QEMU from within gdb and establish the
+    connection via a pipe:
 
     .. parsed-literal::
 
-- 
2.20.1


