Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B801C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2E120674
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQystKGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2E120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVs6-0003d1-5N
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6I-0001YG-AY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6H-0004dy-8Z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:34 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6H-0004aR-0J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:33 -0500
Received: by mail-wr1-x441.google.com with SMTP id z7so17066612wrl.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NYeEmRYIFhKDY1XDa+ehZc2gMfO1YQ7blFj45dEKmLA=;
 b=VQystKGwSvIvXDpZjgO6/duHmppg1L3bM9QW4k9Rwt8x2bVdUZiFxq/J39IBiLXXOA
 OnPbdyXGuXaOW1LfxSADe/kuVYb8g/+F003XsuE+ju74lJAAiBeNIy8IVCGlQY6Sj1If
 BruOXhmnuJoMTcmNJLvsu1mjdbzkcDd3vZ/7CZP6ZnofNfKJj0oUDqDYNt6VYdbfrEGM
 Y9DfTba9X9gDWZUNaLvHM4YIikQ/UfITNaMcj5YNBK68bJk/M7e7evOBdwXbLsSErq1o
 xUYBM5CjobydMbsa2HIXFSsZxC4ECUQNxssHqhnE+TkjstPD4pfA2CJAmPBMK4v/xGWO
 XAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NYeEmRYIFhKDY1XDa+ehZc2gMfO1YQ7blFj45dEKmLA=;
 b=CQOpkJbTNGEK8EIW/cWiKOtS9QVT3LG2skiGzF/oR1PSdcal72qAk+Cs2WgmaLoZPy
 EaimRa89sAS8dhlNEV1YV0KMyqQScv2sZuHIXjyxKkaXBs35JV16IsZ0U8pNvljk/MP5
 TL1pSlB8h/5H7ZR6WjYX8BtHHtPkqrci++BRps6cPEvaXw2J590uCNiwSR4wE8iI2xzE
 mXu9pYG3z2aTuQtuNa6hWBw+BcAhhtP/CB3NGkyXRUPskdtzap4CgqK+H3GR5HM/5IEG
 NhwAHBv8yBHUe5etjUBEekPlYDTdVXbA0rMo31hlj+mowr6d7JyutYGvYUSS3mk7RyDu
 RVIQ==
X-Gm-Message-State: APjAAAXjEEwJNW0v1FKvDuk/QRGdI+0TRJ+Ldv4Qr0bzKuQ+3WTSUdnA
 b8qvgD0k22r+hsVFWHYPnt9NoW7h
X-Google-Smtp-Source: APXvYqzvGiIaGv0aUQ8+1DpNDGcR3GwaP9VwTU/cGeWYBNzb59Z7nqr3RLPVIQkZRLWKRyyQdl25vA==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr29347303wro.310.1580234190748; 
 Tue, 28 Jan 2020 09:56:30 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 068/142] meson: convert qapi-specific to meson
Date: Tue, 28 Jan 2020 18:52:28 +0100
Message-Id: <20200128175342.9066-69-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target    |  1 -
 qapi/Makefile.objs | 11 -----------
 qapi/meson.build   | 21 +++++++++++++++++++--
 3 files changed, 19 insertions(+), 14 deletions(-)
 delete mode 100644 qapi/Makefile.objs

diff --git a/Makefile.target b/Makefile.target
index 1a7102c27c..15e7c861f2 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -156,7 +156,6 @@ ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
 obj-y += qtest.o
 obj-y += hw/
-obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
 LIBS := $(libs_softmmu) $(LIBS)
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
deleted file mode 100644
index 10ca4f6495..0000000000
--- a/qapi/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-QAPI_TARGET_MODULES = machine-target misc-target
-
-obj-y = qapi-introspect.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-types-%.o)
-obj-y += qapi-types.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-visit-%.o)
-obj-y += qapi-visit.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-events-%.o)
-obj-y += qapi-events.o
-obj-y += $(QAPI_TARGET_MODULES:%=qapi-commands-%.o)
-obj-y += qapi-commands.o
diff --git a/qapi/meson.build b/qapi/meson.build
index 8431f2677e..4a335d9515 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -67,11 +67,17 @@ foreach module : qapi_common_modules + qapi_target_modules
   endif
 endforeach
 
-qapi_all_outputs += [
+qapi_specific_outputs = [
   'qapi-introspect.c', 'qapi-introspect.h',
-  'qapi-doc.texi'
+  'qapi-types.c', 'qapi-types.h',
+  'qapi-visit.c', 'qapi-visit.h',
+  'qapi-events.c', 'qapi-events.h',
+  'qapi-commands.c', 'qapi-commands.h',
 ]
 
+qapi_all_outputs += qapi_specific_outputs
+qapi_all_outputs += 'qapi-doc.texi'
+
 qapi_files = custom_target('QAPI files',
   output: qapi_all_outputs,
   input: [ files('qapi-schema.json') ],
@@ -87,3 +93,14 @@ foreach output : qapi_util_outputs
   endif
   i = i + 1
 endforeach
+
+i = 0
+foreach output : qapi_all_outputs
+  if output in qapi_specific_outputs
+    specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: qapi_files[i])
+  endif
+  if output.endswith('-target.c')
+    specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: qapi_files[i])
+  endif
+  i = i + 1
+endforeach
-- 
2.21.0



