Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB012C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9212F206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrYOthCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9212F206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BiY-0001rv-Ku
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BK0-00009h-Iu
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJy-00031i-9v
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePJ3VEWz0NOI2SzM4kvU5UV6QHTzOKUZ0A5s9X+LNsU=;
 b=NrYOthCh03pHTKcLygGBhZd1fb/zkfW7sp0UUBeCpdehfUpnzQCsIjShSBMRl9g2PGYYyZ
 /Vh3h6VSdcGCNPtL/hBLAKAnJmUbZwCFCTEExSFRNDCzyPsOFqsYHsJaMy2azoyu2B/6c2
 c9s8EQVI72m69YerGCtInc3p5LS0wtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-hqne5gBAMr606Zm8p8i07g-1; Mon, 10 Aug 2020 13:10:47 -0400
X-MC-Unique: hqne5gBAMr606Zm8p8i07g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F42057
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:46 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C6DA5F1E9;
 Mon, 10 Aug 2020 17:10:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 059/147] meson: add modules infrastructure
Date: Mon, 10 Aug 2020 19:07:37 +0200
Message-Id: <1597079345-42801-60-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Makefile            | 10 +---------
 Makefile.target     |  6 ++++++
 meson.build         | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 rules.mak           | 10 +++++-----
 scripts/undefsym.sh | 20 ++++++++++++++++++++
 5 files changed, 84 insertions(+), 14 deletions(-)
 create mode 100755 scripts/undefsym.sh

diff --git a/Makefile b/Makefile
index f0fed55..6d58b43 100644
--- a/Makefile
+++ b/Makefile
@@ -250,7 +250,7 @@ slirp/all: .git-submodule-status
 		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
 
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
-	$(qom-obj-y)
+	$(qom-obj-y) block.syms qemu.syms
 
 $(filter %/fuzz, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
@@ -454,14 +454,6 @@ install: all $(if $(BUILD_DOCS),install-doc) \
 ifneq ($(TOOLS),)
 	$(call install-prog,$(TOOLS),$(DESTDIR)$(bindir))
 endif
-ifneq ($(CONFIG_MODULES),)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_moddir)"
-	for s in $(modules-m:.mo=$(DSOSUF)); do \
-		t="$(DESTDIR)$(qemu_moddir)/$$(echo $$s | tr / -)"; \
-		$(INSTALL_LIB) $$s "$$t"; \
-		test -z "$(STRIP)" || $(STRIP) "$$t"; \
-	done
-endif
 ifneq ($(HELPERS-y),)
 	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
 endif
diff --git a/Makefile.target b/Makefile.target
index 43d2f97..d1d8906 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -162,6 +162,12 @@ obj-y += qapi/
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
+# Temporary until emulators are linked by Meson
+LIBS := $(LIBS) @../block.syms @../qemu.syms
+ifneq ($(CONFIG_MODULES),y)
+LIBS := $(LIBS)
+endif
+
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
 obj-y += hw/sparc64/
diff --git a/meson.build b/meson.build
index 74be140..ccf5a63 100644
--- a/meson.build
+++ b/meson.build
@@ -10,6 +10,7 @@ sh = find_program('sh')
 cc = meson.get_compiler('c')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 config_all_disas = keyval.load(meson.current_build_dir() / 'config-all-disas.mak')
+enable_modules = 'CONFIG_MODULES' in config_host
 
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       language: ['c', 'objc'])
@@ -304,6 +305,7 @@ genh += hxdep
 util_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
+block_ss = ss.source_set()
 common_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 user_ss = ss.source_set()
@@ -311,6 +313,7 @@ bsd_user_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 specific_ss = ss.source_set()
 
+modules = {}
 hw_arch = {}
 target_arch = {}
 target_softmmu_arch = {}
@@ -420,6 +423,12 @@ subdir('crypto')
 subdir('storage-daemon')
 subdir('ui')
 
+
+if enable_modules
+  libmodulecommon = static_library('module-common', files('module-common.c') + genh, pic: true, c_args: '-DBUILD_DSO')
+  modulecommon = declare_dependency(link_whole: libmodulecommon, compile_args: '-DBUILD_DSO')
+endif
+
 # Build targets from sourcesets
 
 stub_ss = stub_ss.apply(config_all, strict: false)
@@ -436,6 +445,49 @@ subdir('io')
 subdir('fsdev')
 subdir('target')
 
+mods = []
+block_mods = []
+softmmu_mods = []
+foreach d, list : modules
+  foreach m : list
+    if enable_modules and host_machine.system() != 'windows'
+      sl = static_library(d + '-' + m[0], m[1], dependencies: m[2], pic: true)
+      if d == 'block'
+        block_mods += sl
+      else
+        softmmu_mods += sl
+      endif
+      mods += {'dir': d, 'name': m[0], 'lib': sl, 'deps': m[2]}
+    else
+      if d == 'block'
+        block_ss.add(when: [m.get(3, []), m[2]], if_true: m[1])
+      else
+        softmmu_ss.add(when: [m.get(3, []), m[2]], if_true: m[1])
+      endif
+    endif
+  endforeach
+endforeach
+
+nm = find_program('nm')
+undefsym = find_program('scripts/undefsym.sh')
+block_syms = custom_target('block.syms', output: 'block.syms',
+                             input: [libqemuutil, block_mods],
+                             capture: true,
+                             command: [undefsym, nm, '@INPUT@'])
+qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
+                             input: [libqemuutil, softmmu_mods],
+                             capture: true,
+                             command: [undefsym, nm, '@INPUT@'])
+
+
+foreach m : mods
+  shared_module(m['dir'] + '-' + m['name'],
+                name_prefix: '',
+                link_whole: m['lib'],
+                install: true,
+                install_dir: config_host['qemu_moddir'])
+endforeach
+
 common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: softmmu_ss)
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
diff --git a/rules.mak b/rules.mak
index d8d35f7..9da9dcd 100644
--- a/rules.mak
+++ b/rules.mak
@@ -61,17 +61,17 @@ endif
 # This is necessary because the exectuable itself may not use the function, in
 # which case the function would not be linked in. Then the DSO loading will
 # fail because of the missing symbol.
-process-archive-undefs = $(filter-out %.a %.fa %.mo,$1) \
+process-archive-undefs = $(filter-out %.a %.fa %.mo %$(DSOSUF),$1) \
                 $(addprefix $(WL_U), \
                      $(filter $(call defined-symbols,$(filter %.a %.fa, $1)), \
-                              $(call undefined-symbols,$(filter %.mo,$1)))) \
+		$(call undefined-symbols,$(filter %.mo %$(DSOSUF),$1)))) \
 		$(foreach l,$(filter %.fa,$1),$(call whole-archive,$l)) \
 		$(filter %.a,$1)
 
-extract-libs = $(strip $(foreach o,$(filter-out %.mo,$1),$($o-libs)))
+extract-libs = $(strip $(foreach o,$(filter-out %.mo %$(DSOSUF),$1),$($o-libs)))
 expand-objs = $(strip $(sort $(filter %.o,$1)) \
-                  $(foreach o,$(filter %.mo,$1),$($o-objs)) \
-                  $(filter-out %.o %.mo,$1))
+		$(foreach o,$(filter %.mo %$(DSOSUF),$1),$($o-objs)) \
+		$(filter-out %.o %.mo %$(DSOSUF),$1))
 
 %.o: %.c
 	@mkdir -p $(dir $@)
diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh
new file mode 100755
index 0000000..b9ec332
--- /dev/null
+++ b/scripts/undefsym.sh
@@ -0,0 +1,20 @@
+#! /usr/bin/env bash
+
+# Before a shared module's DSO is produced, a static library is built for it
+# and passed to this script.  The script generates -Wl,-u options to force
+# the inclusion of symbol from libqemuutil.a if the shared modules need them,
+# This is necessary because the modules may use functions not needed by the
+# executable itself, which would cause the function to not be linked in.
+# Then the DSO loading would fail because of the missing symbol.
+
+if test $# -le 2; then
+  exit 0
+fi
+
+NM=$1
+staticlib=$2
+shift 2
+# Find symbols defined in static libraries and undefined in shared modules
+comm -12 \
+  <( $NM -P -g $staticlib | awk '$2!="U"{print "-Wl,-u," $1}' | sort -u) \
+  <( $NM -P -g "$@" | awk '$2=="U"{print "-Wl,-u," $1}' | sort -u)
-- 
1.8.3.1



