Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5982468D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXI0UNdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5982468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWFT-0004hU-6c
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV87-0004ML-Aw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV85-0000Lh-Kc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV84-0000GP-L8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:24 -0500
Received: by mail-wm1-x344.google.com with SMTP id m10so2325415wmc.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sYzi85Y+ZjSdnrP0Posa6ZSiE8/MSZUOqDGD05wHtIY=;
 b=cXI0UNdvULGsutFSqOduLB8l4Exk9H9nmPUUOlhwnvtJb/TeNKH9WT25t2dFad1JjB
 BKDrqC1T1IPLt2vVbXmYut7b0khHXrHhuFHC63vcEZS6Y8pLt2330JAeRoMnty4Oxw+l
 8diqjPHQyaHo6uuEtnxg9tVlFwEWJyBG4mtZ/djANwgAfnJK7PcK6mNDjsEMe1Hj+6/O
 LmQ/sVibdpzqoHPhXGP1P2/Jvy4q7WaTXCx45sH02ywwh9ZIozTxooaf2+P/BRHT3Rws
 HRviTArnYWUQ9CfFa69viZiSsSPyQAj2t1dUohTEFZqGi1DQaHXJt7foNaDFd7cGnSnA
 H6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sYzi85Y+ZjSdnrP0Posa6ZSiE8/MSZUOqDGD05wHtIY=;
 b=QBVeG5M6yHpNcXb4c7g65vfJJQlcxIP0FeRizFMaUX+kIp1M0FKql86n0yQBvWGtOC
 yfhq0bAH0QZnFqUFqACREXNo1nhilm0KAxMCkPAd+JScUxZUQxFkVCVIwjET0CYQR/YI
 A9zLQKESVrw0dh6YTN0pOxebn22TflHX4kJ/YC16YPsQljKs+DL2HNEtm3+cjmQtyAEo
 U8+oYil+Eq77m5PiOGjBzq0oMI0/VgwSoZBq953/OtG5L/tLC/39WYsqtYym5FduNFUH
 bQT4Jn5GXvtF51j5af9dOMSBo7trtceBsRvBJhGan3BJre6rxPM+DUljUwl9dpwgaiJX
 KGRA==
X-Gm-Message-State: APjAAAXdZlU+oAh9f6wFfR5+hoTQg9sloPwTVWpqFDtaJASi4L/tnHml
 2rZXZz2/TdqJiFA7BqGOQvMFxQVC
X-Google-Smtp-Source: APXvYqz+txfIq2oCMIaUlX1K8eoZ4+pGyYQRy4oCTRV1Ni7GifADBzpnFYO1RILCg8orLFJomHeltg==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr6276923wmc.119.1580234302781; 
 Tue, 28 Jan 2020 09:58:22 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 117/142] meson: softmmu
Date: Tue, 28 Jan 2020 18:53:17 +0100
Message-Id: <20200128175342.9066-118-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target |  4 ----
 meson.build     | 12 ++++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 5c4ba3db54..c1b640bd99 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -136,10 +136,6 @@ endif #CONFIG_BSD_USER
 #########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
-obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
-obj-y += qtest.o
-obj-y += memory.o
-obj-y += memory_mapping.o
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Temporary until emulators are linked by Meson
diff --git a/meson.build b/meson.build
index 91326b12d8..48f2114091 100644
--- a/meson.build
+++ b/meson.build
@@ -508,6 +508,18 @@ specific_ss.add(when: 'CONFIG_TCG', if_true: files(
 ))
 specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('disas/tci.c', 'tcg/tci.c'))
 
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
+  'arch_init.c',
+  'balloon.c',
+  'cpus.c',
+  'gdbstub.c',
+  'ioport.c',
+  'memory.c',
+  'memory_mapping.c',
+  'migration/ram.c',
+  'qtest.c',
+))
+
 # TODO: add each directory to the subdirs from its own meson.build, once
 # we have those
 trace_events_subdirs = [
-- 
2.21.0



