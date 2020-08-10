Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A37207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6DnJ2o5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A37207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BnL-0003Q9-IA
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKT-0000y7-77
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKQ-00038w-TS
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+245kvQBfju4/tihW3VV3ixBAqWOWOYn47kIichErTE=;
 b=b6DnJ2o53BwxmEUBtjCg/TGeeMqvpqlvdL7xt6rfRztePXFvUyWIWZBqQo6KU4aryZGq7F
 MB64XHIRBi6dusBzlHMEbrorkPRmHEenCBCVy2IOdW44CAsSelu1sDufmQCCC/E7+172jN
 qCLl5qO9UpKcxxlR6mjh259kNlEkhGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-AE8XyxC-MAuUNVcfyykjIg-1; Mon, 10 Aug 2020 13:11:16 -0400
X-MC-Unique: AE8XyxC-MAuUNVcfyykjIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A7C491270
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:15 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27C625F1E9;
 Mon, 10 Aug 2020 17:11:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 076/147] meson: convert migration directory to Meson
Date: Mon, 10 Aug 2020 19:07:54 +0200
Message-Id: <1597079345-42801-77-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
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
 Makefile.objs           |  1 -
 Makefile.target         |  1 -
 meson.build             |  5 +++++
 migration/Makefile.objs | 18 ------------------
 migration/meson.build   | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include  |  7 +++----
 6 files changed, 48 insertions(+), 24 deletions(-)
 delete mode 100644 migration/Makefile.objs
 create mode 100644 migration/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index cfb2cf2..9d0a82d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -43,7 +43,6 @@ common-obj-y = net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
-common-obj-y += migration/
 
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
 common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
diff --git a/Makefile.target b/Makefile.target
index 54a9ef1..4d912df 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -158,7 +158,6 @@ obj-y += softmmu/
 obj-y += gdbstub.o
 obj-y += hw/
 obj-y += qapi/
-obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Temporary until emulators are linked by Meson
diff --git a/meson.build b/meson.build
index 634281f..d264d9e 100644
--- a/meson.build
+++ b/meson.build
@@ -296,6 +296,10 @@ lzo = not_found
 if 'CONFIG_LZO' in config_host
   lzo = declare_dependency(link_args: config_host['LZO_LIBS'].split())
 endif
+rdma = not_found
+if 'CONFIG_RDMA' in config_host
+  rdma = declare_dependency(link_args: config_host['RDMA_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -643,6 +647,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
+subdir('migration')
 subdir('monitor')
 subdir('replay')
 
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
deleted file mode 100644
index 0fc619e..0000000
--- a/migration/Makefile.objs
+++ /dev/null
@@ -1,18 +0,0 @@
-common-obj-y += migration.o socket.o fd.o exec.o
-common-obj-y += tls.o channel.o savevm.o
-common-obj-y += colo.o colo-failover.o
-common-obj-y += vmstate.o vmstate-types.o page_cache.o
-common-obj-y += qemu-file.o global_state.o
-common-obj-y += qemu-file-channel.o
-common-obj-y += xbzrle.o postcopy-ram.o
-common-obj-y += qjson.o
-common-obj-y += block-dirty-bitmap.o
-common-obj-y += multifd.o
-common-obj-y += multifd-zlib.o
-common-obj-$(CONFIG_ZSTD) += multifd-zstd.o
-
-common-obj-$(CONFIG_RDMA) += rdma.o
-
-common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
-
-rdma.o-libs := $(RDMA_LIBS)
diff --git a/migration/meson.build b/migration/meson.build
new file mode 100644
index 0000000..ac8ff14
--- /dev/null
+++ b/migration/meson.build
@@ -0,0 +1,40 @@
+# Files needed by unit tests
+migration_files = files(
+  'page_cache.c',
+  'xbzrle.c',
+  'vmstate-types.c',
+  'vmstate.c',
+  'qemu-file-channel.c',
+  'qemu-file.c',
+  'qjson.c',
+)
+
+libmigration = static_library('migration', sources: migration_files + genh,
+                              name_suffix: 'fa',
+                              build_by_default: false)
+migration = declare_dependency(link_with: libmigration,
+                               dependencies: [zlib, qom, io])
+softmmu_ss.add(migration)
+
+softmmu_ss.add(files(
+  'block-dirty-bitmap.c',
+  'channel.c',
+  'colo-failover.c',
+  'colo.c',
+  'exec.c',
+  'fd.c',
+  'global_state.c',
+  'migration.c',
+  'multifd.c',
+  'multifd-zlib.c',
+  'postcopy-ram.c',
+  'savevm.c',
+  'socket.c',
+  'tls.c',
+))
+
+softmmu_ss.add(when: ['CONFIG_RDMA', rdma], if_true: files('rdma.c'))
+softmmu_ss.add(when: 'CONFIG_LIVE_BLOCK_MIGRATION', if_true: files('block.c'))
+softmmu_ss.add(when: 'CONFIG_ZSTD', if_true: [files('multifd-zstd.c'), zstd])
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('ram.c'))
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 66acf9c..425c8ce 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -227,7 +227,8 @@ tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
 tests/test-bitmap$(EXESUF): tests/test-bitmap.o $(test-util-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
-tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
+tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/libmigration.fa $(test-util-obj-y) \
+	$(test-io-obj-y)
 tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
 tests/test-int128$(EXESUF): tests/test-int128.o
 tests/rcutorture$(EXESUF): tests/rcutorture.o $(test-util-obj-y)
@@ -253,9 +254,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/vmstate-if.o \
 	hw/core/clock.o hw/core/qdev-clock.o \
 	$(test-qapi-obj-y)
-tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
-	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
-        migration/qemu-file-channel.o migration/qjson.o \
+tests/test-vmstate$(EXESUF): tests/test-vmstate.o migration/libmigration.fa \
 	$(test-io-obj-y)
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o $(test-util-obj-y)
-- 
1.8.3.1



