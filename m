Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7901F2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiLRcQdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7901F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CIY-0003a6-MN
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLx-0003Qe-0y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLv-0003N2-0m
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEn8HY0hbZnigh2zF+adrqHOxONI7ngTjgI9sOI65tg=;
 b=iiLRcQdc6W2W4SyP6zIc1eaRX151NH7+vKSqdeOvuTEshzhoaLVHgFgxBzRMgMK9X/+9bt
 NJCFxRUvXmMdnm+Jcfcb6oxmEG85WgbboUdQBmrElaQ+CqoBsdGP5k7Hi4nmWc/W2dcZp3
 XvpgjS5nhv/CVDmblicvGT7qIzExDPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-kkegG43VPRCswZ9UeofSzQ-1; Mon, 10 Aug 2020 13:12:48 -0400
X-MC-Unique: kkegG43VPRCswZ9UeofSzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C0A757
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:47 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9C045F1EA;
 Mon, 10 Aug 2020 17:12:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 132/147] meson: convert systemtap files
Date: Mon, 10 Aug 2020 19:08:50 +0200
Message-Id: <1597079345-42801-133-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Makefile.target   | 85 ++-----------------------------------------------------
 meson.build       | 26 +++++++++++++++++
 rules.mak         |  3 --
 trace/meson.build | 14 ++++-----
 4 files changed, 35 insertions(+), 93 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 8ee4c78..a07149c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -6,88 +6,7 @@ include ../config-host.mak
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
-clean:
-	rm -f *.a *~
-	rm -f $(shell find . -name '*.[od]')
-	rm -f hmp-commands.h gdbstub-xml.c
-	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
-ifdef CONFIG_TRACE_SYSTEMTAP
-	rm -f *.stp
-endif
-
+all:
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
index 797e69d..c3ef9b6 100644
--- a/meson.build
+++ b/meson.build
@@ -811,6 +811,7 @@ common_all = static_library('common',
                             name_suffix: 'fa')
 
 feature_to_c = find_program('scripts/feature_to_c.sh')
+tracetool = find_program('scripts/tracetool.py')
 
 emulators = []
 foreach target : target_dirs
@@ -946,6 +947,31 @@ foreach target : target_dirs
                link_depends: [block_syms, qemu_syms] + exe.get('link_depends', []),
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
 
diff --git a/rules.mak b/rules.mak
index 6488dc3..b983c7f 100644
--- a/rules.mak
+++ b/rules.mak
@@ -199,9 +199,6 @@ ne = $(if $(subst $2,,$1)$(subst $1,,$2),y,n)
 isempty = $(if $1,n,y)
 notempty = $(if $1,y,n)
 
-# Generate files with tracetool
-TRACETOOL=$(PYTHON) $(SRC_PATH)/scripts/tracetool.py
-
 .PHONY: clean-timestamp
 clean-timestamp:
 	rm -f *.timestamp
diff --git a/trace/meson.build b/trace/meson.build
index 9c3c128..56e8708 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -49,13 +49,13 @@ foreach dir : [ '.' ] + trace_events_subdirs
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
1.8.3.1



