Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21B82173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jop9rQOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21B82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lk6-0001ND-GB
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOb-0005A4-VR
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOZ-0006Uo-Uh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7k/OC0i7r4vbxe3Sk4vtVKcmtpjqIWJmdLQavsE+ro=;
 b=Jop9rQOEReR4JKbSmPSQBEFdzRBlx8lJdwgEMurAAHje+AW9d3NHHsT/c8zkB3aeWuKhnr
 qPNHH8kAvItIPMi8W2d0wRlSExqfzgrorqqK+d+rj64Yk8wL+7HZ/B5aDExMfATaXc1STR
 vaPDaHhOHAYLpEgGUWGThM+yIWcTSl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-YTssgmHWMYmbXWTb3533HQ-1; Thu, 06 Aug 2020 15:17:41 -0400
X-MC-Unique: YTssgmHWMYmbXWTb3533HQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7978519200C1
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:17:40 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A2FC5F9DC;
 Thu,  6 Aug 2020 19:17:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 042/143] meson: generate qemu-version.h
Date: Thu,  6 Aug 2020 21:14:38 +0200
Message-Id: <1596741379-12902-43-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
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
 Makefile                | 27 +--------------------------
 meson.build             | 14 ++++++++++++--
 scripts/qemu-version.sh | 25 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 28 deletions(-)
 create mode 100755 scripts/qemu-version.sh

diff --git a/Makefile b/Makefile
index 3837f80..d9a8633 100644
--- a/Makefile
+++ b/Makefile
@@ -105,21 +105,7 @@ include $(SRC_PATH)/rules.mak
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
 
@@ -259,17 +245,6 @@ include $(SRC_PATH)/tests/Makefile.include
 
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
index 4448bfe..f90bc23 100644
--- a/meson.build
+++ b/meson.build
@@ -137,6 +137,7 @@ have_block = have_system or have_tools
 
 # Generators
 
+genh = []
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/commands.py',
@@ -156,6 +157,17 @@ qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/doc.py',
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
@@ -256,8 +268,6 @@ trace_events_subdirs += [
   'util',
 ]
 
-genh = []
-
 subdir('qapi')
 subdir('qobject')
 subdir('stubs')
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
new file mode 100755
index 0000000..4847385
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
1.8.3.1



