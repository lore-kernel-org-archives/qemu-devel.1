Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC619C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B555424692
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAMnVUbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B555424692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVw6-0001EP-QV
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5p-0000gr-Bw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5m-0003Ir-UA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:04 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:32914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5m-0003F7-BH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id m10so2320907wmc.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yGtAyZoFQPIkYp5G+VA3Nu767W4Pof2UzTRSB+m9bG8=;
 b=QAMnVUbteNeizGwJ1BpC/9+PXD+KGs/qoNqoM8t0Iaorusf3MJfwGzb2f5u7fZtc6x
 qyvr9+RRH3HnEkcFEna2yjP/m4dUtnhCmwieukNVrxRXKQCBT7jrYjXid5tqGPrvokqu
 6B1+OQMQmLk6DHDjxFIFOZstX3WqZ5fnamkqZT0bUSS6WkbhVFdt7XGjJQfDLh777bWY
 2/k615/sUFPIqugFCj2o4xtLnft5HNfdBoEXTAXXJfYwdlFNhZXanb1etTaOt855k6tC
 u13kxDvgZsB7szFP+lOSQcz/CMp6Q1tBzRbyAaUcRleQjiE7XSCxAAC5/Kdm73ksCbXl
 yQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yGtAyZoFQPIkYp5G+VA3Nu767W4Pof2UzTRSB+m9bG8=;
 b=Ldsr3Z76SY4bKl4jOtfcPfafDIryZvW66PUY0aXNMxHoScDeHlJDqRBqcx1xN1O2iL
 un8aqDv2Y+Ru/7Std85FVqZ1DRA8JyTcwVAwIXTzfVLw7j9V0I9DHL36mva4TSGp0CGa
 nYD6Ymg2CDrbmjCgBwYYvYw94LODFq7lJbKXVIYAyX29xqKn/kYBQfP3VWulv2cVlNhU
 GRsWNdBxmDfglCZqE7djOj4d4ZQ7x61YrC5QsZdUbODT1Lp5NFjF2ACKjvosAybOXgck
 vCW2bf6pO9GYxxrl+M0Rlmh2Fg2E1psYfBsvrfKkNntKys9c91tIDTxZ1JLwfnpPY5CV
 tsWg==
X-Gm-Message-State: APjAAAXkW5g2RZV+0aVdPmfKuD8O5JRQ5gIDghc6oFbhT7jLbpEqhhbt
 G8jqXM5oVZ7PHKH2esvQAKpLtsFc
X-Google-Smtp-Source: APXvYqyyZD7h3mUKxJzp7QVKC082mcB9sNKgr+5H1I4BPNA4AKfWeASWnMSMr9YYjto66DIaGU9k8A==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr6286610wml.171.1580234161156; 
 Tue, 28 Jan 2020 09:56:01 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 056/142] meson: convert trace/
Date: Tue, 28 Jan 2020 18:52:16 +0100
Message-Id: <20200128175342.9066-57-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
 Makefile.objs       | 4 ----
 trace/Makefile.objs | 8 --------
 trace/meson.build   | 5 ++++-
 3 files changed, 4 insertions(+), 13 deletions(-)
 delete mode 100644 trace/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index bdfb6410de..ada5d795f2 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -79,7 +79,3 @@ common-obj-y += disas/
 ######################################################################
 # Resource file for Windows executables
 version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
-
-######################################################################
-# tracing
-util-obj-y +=  trace/
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
deleted file mode 100644
index a429474618..0000000000
--- a/trace/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-# -*- mode: makefile -*-
-
-
-##################################################
-# Translation level
-
-obj-y += generated-helpers.o
-obj-y += control-target.o
diff --git a/trace/meson.build b/trace/meson.build
index 8ea8db7a23..b113425400 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -1,3 +1,5 @@
+specific_ss.add(files('control-target.c'))
+
 # common options
 tracetool = [
   find_program('scripts/tracetool.py'),
@@ -67,12 +69,13 @@ foreach d : [
   ['generated-helpers.h', 'tcg-helper-h'],
   ['generated-helpers-wrappers.h', 'tcg-helper-wrapper-h'],
 ]
-  custom_target(d[0],
+  gen = custom_target(d[0],
                 output: d[0],
                 input: meson.source_root() / 'trace-events',
                 command: [ tracetool, '--group=root', '--format=@0@'.format(d[1]), '@INPUT@' ],
                 build_by_default: true, # to be removed when added to a target
                 capture: true)
+  specific_ss.add(gen)
 endforeach
 
 if 'CONFIG_TRACE_UST' in config_host
-- 
2.21.0



