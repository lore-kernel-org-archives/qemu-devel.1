Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2F4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499A92173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flLjnX4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499A92173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVpx-00007q-FQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV66-0001Ee-FE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV65-000472-7b
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:22 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV64-00040Q-VX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:21 -0500
Received: by mail-wr1-x42b.google.com with SMTP id y17so17108519wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xoczCtDwo/LLw3HXr+/2TLIhdeFkE4hJuDs5QLeOcp8=;
 b=flLjnX4wcFjQXbe3CanwRMmBqVuzhCbHSWBsVpOqz49r6TntMa/CA3/9qrdpeFGpSc
 feXc5AR+n0t8C14BYcDD2iIwYaoj6ONt48ziWmaSr2MVbalTxPnYZbSTcqr+NzghIZJi
 CTcTCISJVsez8N91RBE5ujqj2S1dwn1smgJDbcds8XUwctwfbtmFTgU3i9sABmMARRfe
 +csRWuGRkaVarJZ2qE70JIAY+ibCDoIaAtciv/ReXZkqAUpMZn1ZNGAZW0gOiP4+iV6m
 y12y0nWpeJdBXNLq2G/VqV1F/KTZpzqGWuBzERlYxMGX5owa3wR40dkodO8RQRKOafC/
 uOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xoczCtDwo/LLw3HXr+/2TLIhdeFkE4hJuDs5QLeOcp8=;
 b=VfkECY/bXNdRGFPCeLXn8802CPkHh4ZUYO6BgM+j3mOS7uNND0Bx296Wc70VsIBF+1
 MfGk0Xus0MEv4KIb3xtbgtsxrdxDm/z3CyH+X749JehO08uZ+rzUQchZ5CwxGr+GgiLC
 7grN8uStIZ/AhN9rsWYRCyCDlYwdv4YO348V497HEZWWlB/X735GdVOyvykZrGZGlZYt
 XrPqFZp552KkqjLlGiHajNjYbm/JOgLz2Gz1W2wkuojstdqjX652GHYXI/sPdZw8xVQ+
 ruqCz+q993Y28kqTc363KePI9SWvZiIWTl/gfgvSwbRfVzv9RQEHtTylr26pInqSPpPk
 6dsw==
X-Gm-Message-State: APjAAAUxh5p61/OHyg/AvE6zItWkrkqqV9HokN0QecTX+75Oo6X5xhNi
 wiWD4J/qqLocfHtso7YE0YaMuYXt
X-Google-Smtp-Source: APXvYqzXOLkkN9lK/1u4UQQgEHjEh2KTCuTpxdbUiJsypL05JCtmfOnyb/fCVwWi/ie46qZ/Zymv8g==
X-Received: by 2002:adf:8297:: with SMTP id 23mr28697996wrc.379.1580234177743; 
 Tue, 28 Jan 2020 09:56:17 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 063/142] meson: build softmmu-specific migration/ram.c
Date: Tue, 28 Jan 2020 18:52:23 +0100
Message-Id: <20200128175342.9066-64-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 Makefile.target       | 1 -
 configure             | 2 ++
 meson.build           | 5 +++++
 migration/meson.build | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Makefile.target b/Makefile.target
index d8afffbce5..3587da499e 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -159,7 +159,6 @@ obj-y += hw/
 obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
-obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Temporary until emulators are linked by Meson
diff --git a/configure b/configure
index 3868d60222..5f579b2ea3 100755
--- a/configure
+++ b/configure
@@ -7428,6 +7428,8 @@ fi
 
 if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
+  echo "LIBPMEM_LIBS=$libpmem_libs" >> $config_host_mak
+  echo "LIBPMEM_CFLAGS=$libpmem_cflags" >> $config_host_mak
 fi
 
 if test "$bochs" = "yes" ; then
diff --git a/meson.build b/meson.build
index 4472d0b311..40411f0960 100644
--- a/meson.build
+++ b/meson.build
@@ -276,6 +276,11 @@ rdma = declare_dependency()
 if 'CONFIG_RDMA' in config_host
   rdma = declare_dependency(link_args: config_host['RDMA_LIBS'].split())
 endif
+libpmem = declare_dependency()
+if 'CONFIG_LIBPMEM' in config_host
+  libpmem = declare_dependency(compile_args: config_host['LIBPMEM_CFLAGS'].split(),
+                               link_args: config_host['LIBPMEM_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
diff --git a/migration/meson.build b/migration/meson.build
index ee5a713069..1231e4389e 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -22,3 +22,5 @@ softmmu_ss.add(files(
 
 softmmu_ss.add(when: ['CONFIG_RDMA', rdma], if_true: files('rdma.c'))
 softmmu_ss.add(when: 'CONFIG_LIVE_BLOCK_MIGRATION', if_true: files('block.c'))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files('ram.c'), libpmem])
-- 
2.21.0



