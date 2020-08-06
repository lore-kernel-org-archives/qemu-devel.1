Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE4EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09233221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H79+MGrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09233221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mEP-0004kf-20
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRB-0002uX-1K
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lR8-0006tf-UJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=9d4OMmwTQF35/7jkUv6krr+da86weRcSC2GuhLAFSlg=;
 b=H79+MGrKWILqgnWRTpJ/MbWBLw4Z+Co9/OMfVEkxNVDv/c0pXLdSFPFWLMbCHZihYK/TCg
 ZVQZCauhrVT6MKA3wg0Ij0kmRYGCHJHlo6l4LVfMtXiPEKKFVnr8676h6JV5ifUmgbrqTy
 Ms0bPvAliKq1+9DCIjWBEPVP3z76K2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-aF81fbKiOQeFQm8YXe3YPQ-1; Thu, 06 Aug 2020 15:20:20 -0400
X-MC-Unique: aF81fbKiOQeFQm8YXe3YPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEF87107BEF5
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:19 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12E8E69315
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 129/143] meson: plugins
Date: Thu,  6 Aug 2020 21:16:05 +0200
Message-Id: <1596741379-12902-130-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now link arguments end up in Makefile.target, they will move to the
right place soon.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |  8 +-------
 Makefile.target       | 12 ++++++++++--
 meson.build           |  5 +++++
 plugins/Makefile.objs | 21 ---------------------
 plugins/meson.build   |  5 +++++
 5 files changed, 21 insertions(+), 30 deletions(-)
 delete mode 100644 plugins/Makefile.objs
 create mode 100644 plugins/meson.build

diff --git a/Makefile b/Makefile
index 2aaa3f8..5320a06 100644
--- a/Makefile
+++ b/Makefile
@@ -419,13 +419,10 @@ endif
 
 ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
-install-includedir:
-	$(INSTALL_DIR) "$(DESTDIR)$(includedir)"
-
 # Needed by "meson install"
 export DESTDIR
 install: all $(if $(BUILD_DOCS),install-doc) \
-	install-datadir install-localstatedir install-includedir \
+	install-datadir install-localstatedir \
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 	recurse-install
 ifdef CONFIG_TRACE_SYSTEMTAP
@@ -468,9 +465,6 @@ endif
 ifdef CONFIG_GTK
 	$(MAKE) -C po $@
 endif
-ifeq ($(CONFIG_PLUGIN),y)
-	$(INSTALL_DATA) $(SRC_PATH)/include/qemu/qemu-plugin.h "$(DESTDIR)$(includedir)/qemu-plugin.h"
-endif
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
 	set -e; for x in $(KEYMAPS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
diff --git a/Makefile.target b/Makefile.target
index c180b4c..2b7280b 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -110,8 +110,6 @@ obj-y += trace/
 #########################################################
 LIBS := $(libs_cpu) $(LIBS)
 
-obj-$(CONFIG_PLUGIN) += plugins/
-
 #########################################################
 # Linux user emulator target
 
@@ -153,6 +151,16 @@ LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
 LIBS := $(LIBS) $(VIRGL_LIBS) $(CURSES_LIBS)
 
+ifeq ($(CONFIG_PLUGIN),y)
+ifdef CONFIG_HAS_LD_DYNAMIC_LIST
+LIBS += -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
+else
+ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
+LIBS += -Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
+endif
+endif
+endif
+
 generated-files-y += hmp-commands.h hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
diff --git a/meson.build b/meson.build
index 7ed8276..58f84e8 100644
--- a/meson.build
+++ b/meson.build
@@ -704,6 +704,7 @@ subdir('net')
 subdir('replay')
 subdir('hw')
 subdir('accel')
+subdir('plugins')
 subdir('bsd-user')
 subdir('linux-user')
 
@@ -872,6 +873,10 @@ endforeach
 
 # Other build targets
 
+if 'CONFIG_PLUGIN' in config_host
+  install_headers('include/qemu/qemu-plugin.h')
+endif
+
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
diff --git a/plugins/Makefile.objs b/plugins/Makefile.objs
deleted file mode 100644
index 6f14d91..0000000
--- a/plugins/Makefile.objs
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# Plugin Support
-#
-
-obj-y += loader.o
-obj-y += core.o
-obj-y += api.o
-
-# Abuse -libs suffix to only link with --dynamic-list/-exported_symbols_list
-# when the final binary includes the plugin object.
-#
-# Note that simply setting LDFLAGS is not enough: we build binaries that
-# never link plugin.o, and the linker might fail (at least ld64 does)
-# if the symbols in the list are not in the output binary.
-ifdef CONFIG_HAS_LD_DYNAMIC_LIST
-api.o-libs := -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
-else
-ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
-api.o-libs := -Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
-endif
-endif
diff --git a/plugins/meson.build b/plugins/meson.build
new file mode 100644
index 0000000..9608e52
--- /dev/null
+++ b/plugins/meson.build
@@ -0,0 +1,5 @@
+specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
+  'loader.c',
+  'core.c',
+  'api.c',
+)])
-- 
1.8.3.1



