Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D325C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573002177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bu7rlcPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573002177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3loR-00036V-BP
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOl-0005XP-DM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41420
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lOj-0006Vh-CX
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Hgz26lLspDRlfLbFP+kB4XdVpPCpfVJFfNl3yzttTY=;
 b=Bu7rlcPLzfuFS1cD/2EB8rck3ekmdXtfxvrQaS3dlIH6JMPcXdBOXbj3iQ/FEYqfuZKQou
 IH09qXZFVJMoDYsgTSlqrj9/xKcMAh3FvRm5gbBbyp2R8qXbId57FVm0ZEG8aohtb2k74a
 CTDz0/k7Zwo0RT1XxtjLQ7ouFcnVojo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-G3JVCA7tNauZcfdtg8c5eg-1; Thu, 06 Aug 2020 15:17:50 -0400
X-MC-Unique: G3JVCA7tNauZcfdtg8c5eg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75656100AA21
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:17:49 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 861D01D3;
 Thu,  6 Aug 2020 19:17:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 049/143] meson: convert qom directory to Meson (tools part)
Date: Thu,  6 Aug 2020 21:14:45 +0200
Message-Id: <1596741379-12902-50-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
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
 Makefile          |  2 +-
 Makefile.objs     |  2 +-
 Makefile.target   |  3 ++-
 meson.build       |  1 +
 qom/Makefile.objs |  3 ---
 qom/meson.build   | 15 +++++++++++++++
 6 files changed, 20 insertions(+), 6 deletions(-)
 create mode 100644 qom/meson.build

diff --git a/Makefile b/Makefile
index d277681..36f74aa 100644
--- a/Makefile
+++ b/Makefile
@@ -233,7 +233,6 @@ dummy := $(call unnest-vars,, \
                 storage-daemon-obj-y \
                 storage-daemon-obj-m \
                 crypto-obj-y \
-                qom-obj-y \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m)
@@ -254,6 +253,7 @@ $(SOFTMMU_ALL_RULES): $(storage-daemon-obj-y)
 $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
+$(SOFTMMU_ALL_RULES): $(qom-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
 
 SOFTMMU_FUZZ_RULES=$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
diff --git a/Makefile.objs b/Makefile.objs
index baf1565..84bfa2a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,6 +1,6 @@
 #######################################################################
 # Common libraries for tools and emulators
-qom-obj-y = qom/
+qom-obj-y = qom/libqom.fa
 
 #######################################################################
 # code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index 257afc2..1e04551 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -191,13 +191,14 @@ all-obj-y := $(obj-y)
 common-obj-m :=
 
 include $(SRC_PATH)/Makefile.objs
+dummy := $(call fix-paths,../,, \
+              qom-obj-y)
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
                crypto-obj-y \
-               qom-obj-y \
                io-obj-y \
                common-obj-y \
                common-obj-m)
diff --git a/meson.build b/meson.build
index fbf27a7..57475c8 100644
--- a/meson.build
+++ b/meson.build
@@ -312,6 +312,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+subdir('qom')
 subdir('fsdev')
 
 # Other build targets
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 1b45d10..b962904 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -1,5 +1,2 @@
-qom-obj-y = object.o container.o qom-qobject.o
-qom-obj-y += object_interfaces.o
-
 common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
 storage-daemon-obj-y += qom-qmp-cmds.o
diff --git a/qom/meson.build b/qom/meson.build
new file mode 100644
index 0000000..3c41ed3
--- /dev/null
+++ b/qom/meson.build
@@ -0,0 +1,15 @@
+qom_ss = ss.source_set()
+qom_ss.add(files(
+  'container.c',
+  'object.c',
+  'object_interfaces.c',
+  'qom-qobject.c',
+))
+
+qom_ss = qom_ss.apply(config_host, strict: false)
+libqom = static_library('qom', qom_ss.sources(),
+                        dependencies: [qom_ss.dependencies()],
+                        link_with: [libqemuutil],
+                        name_suffix: 'fa')
+
+qom = declare_dependency(link_whole: libqom)
-- 
1.8.3.1



