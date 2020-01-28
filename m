Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7526C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73061207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeZfSfLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73061207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVoI-0004Um-DB
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV60-00013E-8V
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5y-0003qL-R3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:16 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5y-0003ny-Ik
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:14 -0500
Received: by mail-wm1-x344.google.com with SMTP id a9so3569850wmj.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TeH0JwK9IkWiUyAxej3j/G9tNh3AQcxNkFOZ44jNwuA=;
 b=YeZfSfLcuTsjX95g5SlE60zCyoG8x6rVc+/sDNMu0yCnqCvUepjkUInr0ssoqsMtKO
 Pxdrfe/j1ehM5R9wgPuV+MeWhlZNQ7MxgsQzJt9JmhqB+kaRSrk7+5OZBM/mWmbqBXpC
 dvah4Ema+9HgBfEpZZ3EWmjyUYsuVts9cE6H+7LqhxdGoX8uxi9haaV3yy/T83NeDHyc
 QFLEeu8DgBkJ+VFQypMUHJvo15aaGvxyNR0OqRzY6kWpHn9sdtJ8rqgW6DvtDg3m4pv2
 alqbFq+ym2TafIQMKVe20LTN6kUcSgbE6u0peDjgafOjVt9dSmd3Nxf+rKliVpyxdYug
 +uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TeH0JwK9IkWiUyAxej3j/G9tNh3AQcxNkFOZ44jNwuA=;
 b=XcZ/I3fvBCsy8kWH+Z4TQYO4pj5FOHxojRbgG3z2ifHNElHCojHSzZ58MTwJ7f2hHZ
 jDSGf4UX07yMqFfXhrWdFUEwegLrVbMJN8pCdkxGA2IQ+eI0WxQ5n1p5gruYzuJLCtL2
 ppiaZW51WiiDgTge/pfRpeOppIs5l/qsDOFqrQVJxUUGleNps70+q4wNsnYbY1WQi23p
 Tyr41npZkGycjl2Mf0RSC0rTgGFSm8PEyAmGSIE4tths4wzodxweNcWa2wY9iQTPUZ+M
 cZacfi4BJYl9d74KeyWNVeL39PTGmBsJAWxqmVc1J5jO86dlIb7uKBNaT3nEO1bauzYk
 UJ+A==
X-Gm-Message-State: APjAAAV1nQFvr37vx7DPUq+aysfwqJVsCnpBxuunPIHxm/DDKgUUUqhk
 9qg7qVHKBYeNfFG4frf+oXqH3DXR
X-Google-Smtp-Source: APXvYqycd7aCvNo8DOoCX7hxlLNXZ9LdcDO7nFvGmXU+GIhYof4YKlJmrRdTnqoXUMOPooq+Fl13OA==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr6513368wmb.33.1580234173330; 
 Tue, 28 Jan 2020 09:56:13 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 061/142] meson: convert replay directory to Meson
Date: Tue, 28 Jan 2020 18:52:21 +0100
Message-Id: <20200128175342.9066-62-pbonzini@redhat.com>
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs        |  1 -
 meson.build          |  1 +
 replay/Makefile.objs |  9 ---------
 replay/meson.build   | 11 +++++++++++
 4 files changed, 12 insertions(+), 10 deletions(-)
 delete mode 100644 replay/Makefile.objs
 create mode 100644 replay/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index c4cea8d046..7b6985b4fb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -62,7 +62,6 @@ common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 
 common-obj-y += hw/
-common-obj-y += replay/
 common-obj-y += backends/
 endif
 
diff --git a/meson.build b/meson.build
index 0532ab3101..d72edea6a8 100644
--- a/meson.build
+++ b/meson.build
@@ -601,6 +601,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('monitor')
+subdir('replay')
 
 mods = []
 block_mods = []
diff --git a/replay/Makefile.objs b/replay/Makefile.objs
deleted file mode 100644
index cee6539a23..0000000000
--- a/replay/Makefile.objs
+++ /dev/null
@@ -1,9 +0,0 @@
-common-obj-y += replay.o
-common-obj-y += replay-internal.o
-common-obj-y += replay-events.o
-common-obj-y += replay-time.o
-common-obj-y += replay-input.o
-common-obj-y += replay-char.o
-common-obj-y += replay-snapshot.o
-common-obj-y += replay-net.o
-common-obj-y += replay-audio.o
\ No newline at end of file
diff --git a/replay/meson.build b/replay/meson.build
new file mode 100644
index 0000000000..b53218940a
--- /dev/null
+++ b/replay/meson.build
@@ -0,0 +1,11 @@
+softmmu_ss.add(files(
+  'replay.c',
+  'replay-internal.c',
+  'replay-events.c',
+  'replay-time.c',
+  'replay-input.c',
+  'replay-char.c',
+  'replay-snapshot.c',
+  'replay-net.c',
+  'replay-audio.c',
+))
-- 
2.21.0



