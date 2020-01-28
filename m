Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B19C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE7E24681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7LtAvV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE7E24681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWAx-0005c0-Pm
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8F-0004bR-AJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8D-0000gL-KK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8D-0000dY-Bl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:33 -0500
Received: by mail-wr1-x42b.google.com with SMTP id q10so17105248wrm.11
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yhQi2rGOdPojCjODh7GiiSTPYtRBWy8XOB9tLmKvH5U=;
 b=o7LtAvV66Z90xuUZOti3mBvA1NVL8FV5ZcsHiqLunircCA12ZwksKNEAszXLlFLpu9
 uMJ/Gea9wqVk9Ym5V9rUNeR035u2VhXayED3n+lyCmI3EX/8iZhjpwC01fVJy+QF4XFP
 2o7dePX3TkWYlI8hDPTYd1YCmGb/nz797Lp5ga0edYBV6PszhIg2xW1oX2yAZP+KxHdk
 aJZ9MdweZUdZ/lfkfRfpQMjTIVYSjwlFL0O0BBQBzvAUSCnBbCUlWIPSjj4B0Bzh0/QA
 CJX0vTohIiEXud8E1x9SU9kl3oom4lK1JkqLo8ea6ojRo8vZN6BVeOtHKBTsjAC+cE4P
 wLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yhQi2rGOdPojCjODh7GiiSTPYtRBWy8XOB9tLmKvH5U=;
 b=EkkkKeeVjlULQ53ik2F1WCe5Xw+RO21fDMaj0WGSG3EYA9JEy1VakOWYoEOjlxq92n
 QQCj2n8LAEdkBis/71s2o/Gikv4VC4tnbQYG1ok/HbquIgZQF9FY1axdJ4uM4gFRDkVa
 p4oZWQlh45yAypHxb5KiwbuC88Te9TymXGyDvruBvK/J5nO3vZSUVDSck7M3aSPgTuTq
 ki8XgWqgiZS2g5HzrJo5RgsAjWVkp9f7FSYlQkfQ/M+/4JeBeBuBcCmP6Gs1OYvKo1E/
 /b3NgOLbExuw5zIpvDUc0Ey0vvNw7VgubdfHN3JQSRs7g9Q31mzzX2asYCAoar7ykF2H
 NEcw==
X-Gm-Message-State: APjAAAUC/qZeW1YvNKqhg0U+6VVH29D2z4ZY8Ndm/QrhrHMv7zMFfq1h
 6qI/MDpC5edzCbEjTI7Cf4HuLeor
X-Google-Smtp-Source: APXvYqwHbIMK3LMmmJ4Y3su3MK/He1Lz9wY95IYXQNzn0jxgqwkO3CPyuwm7EUmSTYiakx0kdc5J5w==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr31211727wrw.255.1580234312076; 
 Tue, 28 Jan 2020 09:58:32 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 120/142] meson: generate systemtap tapset files
Date: Tue, 28 Jan 2020 18:53:20 +0100
Message-Id: <20200128175342.9066-121-pbonzini@redhat.com>
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

Meson doesn't want to rename files on installations. Currently we're renaming
".stp-installed" to ".stp" and ".stp" to ".stp-build".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target   | 84 ++---------------------------------------------
 meson.build       | 26 +++++++++++++++
 trace/meson.build | 14 ++++----
 3 files changed, 35 insertions(+), 89 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 8ee4c78b3f..4f72a8950d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -6,88 +6,8 @@ include ../config-host.mak
 include config-target.mak
 include $(SRC_PATH)/rules.mak
 
-$(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
-
-ifdef CONFIG_USER_ONLY
-# user emulator name
-QEMU_PROG=qemu-$(TARGET_NAME)
-else
-# system emulator name
-QEMU_PROG=qemu-system-$(TARGET_NAME)$(EXESUF)
-endif
-
-STPFILES=
-
-ifdef CONFIG_TRACE_SYSTEMTAP
-stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace.stp $(QEMU_PROG)-log.stp
-
-ifdef CONFIG_USER_ONLY
-TARGET_TYPE=user
-else
-TARGET_TYPE=system
-endif
-
-tracetool-y = $(SRC_PATH)/scripts/tracetool.py
-tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
-
-$(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=stap \
-		--backends=$(TRACE_BACKENDS) \
-		--binary=$(bindir)/$(QEMU_PROG) \
-		--target-name=$(TARGET_NAME) \
-		--target-type=$(TARGET_TYPE) \
-		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp-installed")
-
-$(QEMU_PROG).stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=stap \
-		--backends=$(TRACE_BACKENDS) \
-		--binary=$(realpath .)/$(QEMU_PROG) \
-		--target-name=$(TARGET_NAME) \
-		--target-type=$(TARGET_TYPE) \
-		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp")
-
-$(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=simpletrace-stap \
-		--backends=$(TRACE_BACKENDS) \
-		--probe-prefix=qemu.$(TARGET_TYPE).$(TARGET_NAME) \
-		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG)-simpletrace.stp")
-
-$(QEMU_PROG)-log.stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=log-stap \
-		--backends=$(TRACE_BACKENDS) \
-		--probe-prefix=qemu.$(TARGET_TYPE).$(TARGET_NAME) \
-		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG)-log.stp")
-
-else
-stap:
-endif
-.PHONY: stap
-
-all: stap
-
+all:
 clean:
-	rm -f *.a *~
-	rm -f $(shell find . -name '*.[od]')
-	rm -f hmp-commands.h gdbstub-xml.c
-	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
-ifdef CONFIG_TRACE_SYSTEMTAP
-	rm -f *.stp
-endif
-
 install: all
-ifdef CONFIG_TRACE_SYSTEMTAP
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset"
-	$(INSTALL_DATA) $(QEMU_PROG).stp-installed "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG).stp"
-	$(INSTALL_DATA) $(QEMU_PROG)-simpletrace.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-simpletrace.stp"
-	$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-log.stp"
-endif
-
+	
 .PHONY: all clean install
diff --git a/meson.build b/meson.build
index 456d2c1eb8..0dd6d9f723 100644
--- a/meson.build
+++ b/meson.build
@@ -759,6 +759,7 @@ common_all = static_library('common',
                             name_suffix: 'fa')
 
 feature_to_c = find_program('scripts/feature_to_c.sh')
+tracetool = find_program('scripts/tracetool.py')
 
 emulators = []
 foreach target : target_dirs
@@ -860,6 +861,31 @@ foreach target : target_dirs
                link_depends: [block_syms, qemu_syms],
                link_args: link_args,
                gui_app: exe['gui'])
+
+    if 'CONFIG_TRACE_SYSTEMTAP' in config_host
+      foreach stp: [
+        {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_dir() / exe_name, 'install': false},
+        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_option('bindir') / exe_name, 'install': true},
+        {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '', 'install': true},
+        {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install': true},
+      ]
+        custom_target(exe_name + stp['ext'],
+                      input: trace_events_all,
+                      output: exe_name + stp['ext'],
+                      capture: true,
+                      install: stp['install'],
+                      install_dir: config_host['qemu_datadir'] / '../systemtap/tapset',
+                      command: [
+                        tracetool, '--group=all', '--format=' + stp['fmt'],
+                        '--backends=' + config_host['TRACE_BACKENDS'],
+                        '--binary=' + stp['bin'],
+                        '--target-name=' + target_name,
+                        '--target-type=' + target_type,
+                        '--probe-prefix=qemu.' + target_type + '.' + target_name,
+                        '@INPUT@',
+                      ])
+      endforeach
+    endif
   endforeach
 endforeach
 
diff --git a/trace/meson.build b/trace/meson.build
index b113425400..eb28affe81 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -55,13 +55,13 @@ foreach dir : [ '.' ] + trace_events_subdirs
   endif
 endforeach
 
-custom_target('trace-events-all',
-              output: 'trace-events-all',
-              input: trace_events_files,
-              command: [ 'cat', '@INPUT@' ],
-              capture: true,
-              install: true,
-              install_dir: config_host['qemu_datadir'])
+trace_events_all = custom_target('trace-events-all',
+                                 output: 'trace-events-all',
+                                 input: trace_events_files,
+                                 command: [ 'cat', '@INPUT@' ],
+                                 capture: true,
+                                 install: true,
+                                 install_dir: config_host['qemu_datadir'])
 
 foreach d : [
   ['generated-tcg-tracers.h', 'tcg-h'],
-- 
2.21.0



