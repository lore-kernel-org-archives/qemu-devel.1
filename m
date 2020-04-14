Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E66C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C80A20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjdLmX2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C80A20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOVV-0001hP-NO
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOM-0005Ba-Mc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOG-0007C3-Sd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOOG-0007Bh-Lz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id k1so7843857wrx.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tQ88i9Gc2sOteI8WTccEItBNd95hLEm8yCcLQuCQWRs=;
 b=gjdLmX2ZMSNfKyO6GAsBxlQitcL2Kqgf5lLVAoCFJ2eZiNNeyvoTZJf91i6eZb5fl8
 jsRPZJo++deBi+JCQ0da839iSTRHM2j98T980mRx/Z+mjNUjVXdScyHXToDHePiJ+LTS
 mVuzJr+DpFTS5270ziGCcw0r87WAwkseDxI3RDrpANlmlYAd13KJmS0jy+MqZyaK10IY
 beoGm1VHXqX31hkmwhq8w03VCHtMHU9urXoeeV3xTc5waeM6C04Yn3iIgvE9MF+jegfQ
 naxdu4kKEUl5+056lg882j6bSeJD5IVxoGrM6k3wsempeQ1PiXvKkkNTpE7OaaW3Swhw
 Rw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tQ88i9Gc2sOteI8WTccEItBNd95hLEm8yCcLQuCQWRs=;
 b=E2RgCNbCEXTG7E+B4FUMI1Kxz5myL6ubqCB6i/adPdOyQLh+3LsVPUCzNsLqU93dW8
 cL2AUE8632DMhqeST81LUpbltiykeLjpr1GsL4Y7AB07wxawy1ydzS9tgweH0kgaZuF3
 FyCPBBvwO+5ftnyI9Q+V7Ju/I9GKzTQg+COVB0612fr/geCgOsrzvenyIoVEqB0CB2RA
 3tijZJg+l4V4VPTKO4hX0dgqXxh4vRRAh/EQ20sfIb//9L8rm1GOqEQYx6xvxnnCwijl
 ATQuP7T8kfPhVc9GKUhFymsDr8Jf8K0rqHC2fX2KCrIgiuHTwBBSiAKolGvWgQD1dvgL
 BCLQ==
X-Gm-Message-State: AGi0PuZ1s4fsI4WewWQZsnTfHVTU8KnHdbh3FlpT/d3/VG/TZeP5Ym/t
 xYRBgUF+LOMENbYTsaDiLwLgitHwZNIaXA==
X-Google-Smtp-Source: APiQypIR09Ao3ZJGjxkb9Tj9+7kOT0x/jwX7h91M5zKDDXj65iZoFeeZAozTvr/Odj7lr6iGV7+Trg==
X-Received: by 2002:adf:dd0c:: with SMTP id a12mr25575703wrm.144.1586881583254; 
 Tue, 14 Apr 2020 09:26:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] docs: Improve our gdbstub documentation
Date: Tue, 14 Apr 2020 17:26:08 +0100
Message-Id: <20200414162613.4479-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
References: <20200414162613.4479-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200403094014.9589-1-peter.maydell@linaro.org
---
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


