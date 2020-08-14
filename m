Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7B1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FA8206B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FekaD1k/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FA8206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6W7i-0001TO-Cg
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vmp-0005bX-HC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vmf-0002u5-16
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFGe9LxwhTYLsd29b1P0cfRjNig2g/iQ36dkoE47X7E=;
 b=FekaD1k/mZ1sMcIUzl12sD9DKCKJhRzPTa+WZFftFtPEpPBfS17uEUJCEdb1c5eQiDpW6Q
 k4k9e8uHKgDnb0s/ZGocMbwLZdLmPOfEyqtjmuiuM25likMOskTBGQgPiPf143bV6Sr0uo
 IYfGilHPbKfyQxa/JHNRN/Tuz8VHT9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-hG4e-vFWN8mrIpovb0pnsw-1; Fri, 14 Aug 2020 05:13:52 -0400
X-MC-Unique: hG4e-vFWN8mrIpovb0pnsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DEE685B66C
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0F3747B9;
 Fri, 14 Aug 2020 09:13:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 035/150] contrib/vhost-user-gpu: convert to meson
Date: Fri, 14 Aug 2020 05:11:31 -0400
Message-Id: <20200814091326.16173-36-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
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
 Makefile                             | 18 +-----------------
 Makefile.objs                        |  1 -
 contrib/vhost-user-gpu/Makefile.objs | 10 ----------
 contrib/vhost-user-gpu/meson.build   | 13 +++++++++++++
 meson.build                          | 15 +++++++++++++++
 rules.mak                            |  7 -------
 6 files changed, 29 insertions(+), 35 deletions(-)
 delete mode 100644 contrib/vhost-user-gpu/Makefile.objs
 create mode 100644 contrib/vhost-user-gpu/meson.build

diff --git a/Makefile b/Makefile
index 8da297f149..4ce8d2b0c6 100644
--- a/Makefile
+++ b/Makefile
@@ -186,16 +186,10 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-vhost-user-json-y =
 HELPERS-y = $(HELPERS)
 
 HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) += qemu-bridge-helper$(EXESUF)
 
-ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
-HELPERS-y += vhost-user-gpu$(EXESUF)
-vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
-endif
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -302,7 +296,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -316,7 +309,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules $(vhost-user-json-y)
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
 
 qemu-version.h: FORCE
 	$(call quiet-command, \
@@ -522,9 +515,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
@@ -722,12 +712,6 @@ endif
 ifneq ($(HELPERS-y),)
 	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
 endif
-ifneq ($(vhost-user-json-y),)
-	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/vhost-user/"
-	for x in $(vhost-user-json-y); do \
-		$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)/vhost-user/"; \
-	done
-endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
 endif
diff --git a/Makefile.objs b/Makefile.objs
index 0922c3ed00..2f2d4b2066 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -106,6 +106,5 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
 ######################################################################
diff --git a/contrib/vhost-user-gpu/Makefile.objs b/contrib/vhost-user-gpu/Makefile.objs
deleted file mode 100644
index 09296091be..0000000000
--- a/contrib/vhost-user-gpu/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-vhost-user-gpu-obj-y = vhost-user-gpu.o virgl.o vugbm.o
-
-vhost-user-gpu.o-cflags := $(PIXMAN_CFLAGS) $(GBM_CFLAGS)
-vhost-user-gpu.o-libs := $(PIXMAN_LIBS)
-
-virgl.o-cflags := $(VIRGL_CFLAGS) $(GBM_CFLAGS)
-virgl.o-libs := $(VIRGL_LIBS)
-
-vugbm.o-cflags := $(GBM_CFLAGS)
-vugbm.o-libs := $(GBM_LIBS)
diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
new file mode 100644
index 0000000000..6c1459f54a
--- /dev/null
+++ b/contrib/vhost-user-gpu/meson.build
@@ -0,0 +1,13 @@
+if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
+    and 'CONFIG_GBM' in config_host and 'CONFIG_LINUX' in config_host
+  executable('vhost-user-gpu', files('vhost-user-gpu.c', 'virgl.c', 'vugbm.c'),
+             link_with: libvhost_user,
+             dependencies: [qemuutil, pixman, gbm, virgl],
+             install: true,
+             install_dir: get_option('libexecdir'))
+
+  configure_file(input: '50-qemu-gpu.json.in',
+                 output: '50-qemu-gpu.json',
+                 configuration: config_host,
+                 install_dir: config_host['qemu_datadir'] / 'vhost-user')
+endif
diff --git a/meson.build b/meson.build
index 4c952c7264..c28285d797 100644
--- a/meson.build
+++ b/meson.build
@@ -79,6 +79,8 @@ if 'CONFIG_GNUTLS' in config_host
   gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
                               link_args: config_host['GNUTLS_LIBS'].split())
 endif
+pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
+                            link_args: config_host['PIXMAN_LIBS'].split())
 seccomp = not_found
 if 'CONFIG_SECCOMP' in config_host
   seccomp = declare_dependency(compile_args: config_host['SECCOMP_CFLAGS'].split(),
@@ -93,6 +95,16 @@ if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
                                 link_args: config_host['LIBISCSI_LIBS'].split())
 endif
+gbm = not_found
+if 'CONFIG_GBM' in config_host
+  gbm = declare_dependency(compile_args: config_host['GBM_CFLAGS'].split(),
+                           link_args: config_host['GBM_LIBS'].split())
+endif
+virgl = not_found
+if 'CONFIG_VIRGL' in config_host
+  virgl = declare_dependency(compile_args: config_host['VIRGL_CFLAGS'].split(),
+                             link_args: config_host['VIRGL_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -261,6 +273,9 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
+    if 'CONFIG_LINUX' in config_host
+      subdir('contrib/vhost-user-gpu')
+    endif
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
diff --git a/rules.mak b/rules.mak
index 7aefd37b5d..1aa6394079 100644
--- a/rules.mak
+++ b/rules.mak
@@ -402,13 +402,6 @@ TEXI2MAN = $(call quiet-command, \
 %.8:
 	$(call TEXI2MAN)
 
-GEN_SUBST = $(call quiet-command, \
-	sed -e "s!@libexecdir@!$(libexecdir)!g" < $< > $@, \
-	"GEN","$@")
-
-%.json: %.json.in
-	$(call GEN_SUBST)
-
 # Support for building multiple output files by atomically executing
 # a single rule which depends on several input files (so the rule
 # will be executed exactly once, not once per output file, and
-- 
2.26.2



