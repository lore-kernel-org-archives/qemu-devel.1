Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C44C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7FA2065C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAQFUn80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7FA2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Bf6-0002Ap-QT
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJp-0008BK-Cl
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJl-0002zl-O7
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BExYD+jYRnltvzX/J1apmJ6spW8unIA0zrj1JMhdZQ=;
 b=WAQFUn80vwsM3mSSIEbC2VYQK6dyP3KBe5LzQSLIDnTj1vi2n+4sh12LDet7kNbvRHiTzl
 3Aa2MtVTlLlm0y5jUKJaAL9G2ZRouQMEWJilR9dPxKyarecryRH+8wIf+zZpISxWTmVk6q
 xXbRcn0krwstMwQWqGINuiH5ohlreh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-wWYdnWRNPMmThpsSkMeHGA-1; Mon, 10 Aug 2020 13:10:34 -0400
X-MC-Unique: wWYdnWRNPMmThpsSkMeHGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 036E619067E1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:34 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EB515F1E9;
 Mon, 10 Aug 2020 17:10:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 052/147] meson: convert qom directory to Meson (tools part)
Date: Mon, 10 Aug 2020 19:07:30 +0200
Message-Id: <1597079345-42801-53-git-send-email-pbonzini@redhat.com>
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
 helo=us-smtp-1.mimecast.com
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
 Makefile          |  2 +-
 Makefile.objs     |  2 +-
 Makefile.target   |  3 ++-
 meson.build       |  1 +
 qom/Makefile.objs |  3 ---
 qom/meson.build   | 15 +++++++++++++++
 6 files changed, 20 insertions(+), 6 deletions(-)
 create mode 100644 qom/meson.build

diff --git a/Makefile b/Makefile
index 62e0ef0..1be6019 100644
--- a/Makefile
+++ b/Makefile
@@ -232,7 +232,6 @@ dummy := $(call unnest-vars,, \
                 storage-daemon-obj-y \
                 storage-daemon-obj-m \
                 crypto-obj-y \
-                qom-obj-y \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m)
@@ -253,6 +252,7 @@ $(SOFTMMU_ALL_RULES): $(storage-daemon-obj-y)
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
index 6f1e199..6517d7e 100644
--- a/meson.build
+++ b/meson.build
@@ -319,6 +319,7 @@ libqemuutil = static_library('qemuutil',
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



