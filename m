Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8D2207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCW4zviE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8D2207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82bj-0002e8-1U
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Kj-00045i-1y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KZ-0007P0-49
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUTh2dDNIkbqxOEXwQ6DpDnENqKp3nDxgFtrj3oGYn8=;
 b=PCW4zviEjRiUQ45f5Bx6ehZXl2P0fbT46CEhEZAvcyj2U+76saN28usr5EUiEfEYjvBTv1
 T+d4SOiXPlSHxbmb8Yz/69KcrQiQsTo+XqFGRdQiie9gxuPpB4/cfDf7+xtm654upRUWc8
 lDjRdtZNRe9gxLCvoHInUa1CtCO1vbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-HJNjOWrdOQOfAOKSktGTOA-1; Tue, 18 Aug 2020 10:11:11 -0400
X-MC-Unique: HJNjOWrdOQOfAOKSktGTOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49D8F807332
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE20B5C64D;
 Tue, 18 Aug 2020 14:11:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 049/150] meson: generate qemu-version.h
Date: Tue, 18 Aug 2020 10:08:44 -0400
Message-Id: <20200818141025.21608-50-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:01:06
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
 Makefile                | 27 +--------------------------
 meson.build             | 14 ++++++++++++--
 scripts/qemu-version.sh | 25 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 28 deletions(-)
 create mode 100755 scripts/qemu-version.sh

diff --git a/Makefile b/Makefile
index 5fbf5e4bbd..9abf7be598 100644
--- a/Makefile
+++ b/Makefile
@@ -112,21 +112,7 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-# Create QEMU_PKGVERSION and FULL_VERSION strings
-# If PKGVERSION is set, use that; otherwise get version and -dirty status from git
-QEMU_PKGVERSION := $(if $(PKGVERSION),$(PKGVERSION),$(shell \
-  cd $(SRC_PATH); \
-  if test -e .git; then \
-    git describe --match 'v*' 2>/dev/null | tr -d '\n'; \
-    if ! git diff-index --quiet HEAD &>/dev/null; then \
-      echo "-dirty"; \
-    fi; \
-  fi))
-
-# Either "version (pkgversion)", or just "version" if pkgversion not set
-FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSION))
-
-generated-files-y = qemu-version.h config-host.h qemu-options.def
+generated-files-y = config-host.h qemu-options.def
 
 generated-files-y += module_block.h
 
@@ -266,17 +252,6 @@ include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
 
-qemu-version.h: FORCE
-	$(call quiet-command, \
-                (printf '#define QEMU_PKGVERSION "$(QEMU_PKGVERSION)"\n'; \
-		printf '#define QEMU_FULL_VERSION "$(FULL_VERSION)"\n'; \
-		) > $@.tmp)
-	$(call quiet-command, if ! cmp -s $@ $@.tmp; then \
-	  mv $@.tmp $@; \
-	 else \
-	  rm $@.tmp; \
-	 fi)
-
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
diff --git a/meson.build b/meson.build
index d3104165fc..73660bafc1 100644
--- a/meson.build
+++ b/meson.build
@@ -155,6 +155,7 @@ have_block = have_system or have_tools
 
 # Generators
 
+genh = []
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/commands.py',
@@ -180,6 +181,17 @@ tracetool = [
    '--backend=' + config_host['TRACE_BACKENDS']
 ]
 
+qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
+                    meson.current_source_dir(),
+                    config_host['PKGVERSION'], config_host['VERSION']]
+qemu_version = custom_target('qemu-version.h',
+                             output: 'qemu-version.h',
+                             command: qemu_version_cmd,
+                             capture: true,
+                             build_by_default: true,
+                             build_always_stale: true)
+genh += qemu_version
+
 # Collect sourcesets.
 
 util_ss = ss.source_set()
@@ -280,8 +292,6 @@ trace_events_subdirs += [
   'util',
 ]
 
-genh = []
-
 subdir('qapi')
 subdir('qobject')
 subdir('stubs')
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
new file mode 100755
index 0000000000..4847385e42
--- /dev/null
+++ b/scripts/qemu-version.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+set -eu
+
+dir="$1"
+pkgversion="$2"
+version="$3"
+
+if [ -z "$pkgversion"]; then
+    cd "$dir"
+    if [ -e .git ]; then
+        pkgversion=$(git describe --match 'v*' --dirty | echo "")
+    fi
+fi
+
+if [ -n "$pkgversion" ]; then
+    fullversion="$version ($pkgversion)"
+else
+    fullversion="$version"
+fi
+
+cat <<EOF
+#define QEMU_PKGVERSION "$pkgversion"
+#define QEMU_FULL_VERSION "$fullversion"
+EOF
-- 
2.26.2



