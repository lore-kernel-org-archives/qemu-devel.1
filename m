Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E98C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E07206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1IIyDpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E07206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOQx-0006Iq-Ek
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyN-0003Xx-PE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyM-0006nR-Hm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:39 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyM-0006lR-78
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:38 -0500
Received: by mail-wr1-x42f.google.com with SMTP id c9so2602770wrw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a83lx+Izf0EpmHILVXQryQUbXeFpne4U3rXNLiSgql8=;
 b=N1IIyDpgZ8J1ZZXRVeDpjQQdcdXTRwZc18708EC8wptmHb+tGV69ghepCt45v8Ig7b
 zYB2M6WV44TiPnuEhVsFH9rXWtqvwK9sGwz4Ra3ZdhJgxUSjRE+wxCyJkwMSVigTPLK0
 c4S8PS9SkgT2ZaNoexIae1PeWNdyaIuP2e8mGlo+tQEWhRTtRm2+Z7biHR/4xv5u7nhP
 Eq2XYhE6Cf8ne8tk0CoZD6lBIaIwPCFq6RuQt4bt4vKBc3zXTLImvs9qXaXSXu4EJKOL
 FVwJmAsEZCbhHIFKRAhoTPOWcPKF4GjuZryrP+9SbFdWi7FKGcjhTMpHi4wmvV4+O+Ls
 OgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=a83lx+Izf0EpmHILVXQryQUbXeFpne4U3rXNLiSgql8=;
 b=S0GZLQLdZvHxg8jV/YmTZVFLwMmEi8prd6FW9QSiL/RWLJsNSkBTJ+84LVSKUk9nzH
 6I0pK50JbRggar+tANVfImeK2iGrhDUoPZmMpAjKLs4AeDbqngKXMOyFIwKY4V5TOdBH
 2dZiUmISptwyn64lY1H1X7piMUEF6ckStIQDUYA1fIfhDifCxg69rWOSK6xiA8MAZ7j6
 VKeCsoZzYNyrsJTqTqAFzpPTwaYxgpSJNor2dKs/en+uBaOj6hpvSjsPJu/7HQQto7hY
 wpDIEIlmdV9hrQYcdIGsne4SjnuXz66soh1k7/uHF897dhBaik8Zovpndw9imagTA9dG
 2XuQ==
X-Gm-Message-State: APjAAAUvi14IfGUSMe8wqrschpDya7El9B9XsT8qcup9TvS27+lpaQWD
 WrBi2i7jbl5AQhM7pQE0XtYWr+6g
X-Google-Smtp-Source: APXvYqwGaox0HWrQAI1DnqFmNc9810ximwx8jjKRKlY/MYdhs1qltpQqZ2u7Bw9rWmmvv4eLOHYFfA==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr6561594wrt.100.1576155217009; 
 Thu, 12 Dec 2019 04:53:37 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 039/132] meson: add macos dependencies
Date: Thu, 12 Dec 2019 13:51:23 +0100
Message-Id: <1576155176-2464-40-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

There is no probing in configure, so no need to pass them as
variables to meson. Do a regular meson dependency() instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 5949e6d..8d5b28b 100644
--- a/meson.build
+++ b/meson.build
@@ -9,7 +9,7 @@ config_all_disas = kconfig.load(meson.current_build_dir() / 'config-all-disas.ma
 add_project_arguments(config_host['CFLAGS'].split(),
                       language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
-                      language: 'c')
+                      language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
                       language: 'cpp')
 add_project_link_arguments(config_host['LDFLAGS'].split(),
@@ -17,7 +17,7 @@ add_project_link_arguments(config_host['LDFLAGS'].split(),
 add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
                            language: ['c', 'cpp', 'objc'])
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
-                      language: ['c', 'cpp'])
+                      language: ['c', 'cpp', 'objc'])
 
 qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
                     meson.current_source_dir(),
@@ -37,6 +37,10 @@ m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 socket = []
 version_res = []
+coref = []
+iokit = []
+cocoa = []
+hvf = []
 if host_machine.system() == 'windows'
   socket = cc.find_library('ws2_32')
 
@@ -44,6 +48,12 @@ if host_machine.system() == 'windows'
   version_res = win.compile_resources('version.rc',
                                       depend_files: files('pc-bios/qemu-nsis.ico'),
                                       include_directories: include_directories('.'))
+elif host_machine.system() == 'darwin'
+  add_languages('objc', required: false)
+  coref = dependency('appleframeworks', modules: 'CoreFoundation')
+  iokit = dependency('appleframeworks', modules: 'IOKit')
+  cocoa = dependency('appleframeworks', modules: 'Cocoa')
+  hvf = dependency('appleframeworks', modules: 'Hypervisor')
 endif
 glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
                           link_args: config_host['GLIB_LIBS'].split())
-- 
1.8.3.1



