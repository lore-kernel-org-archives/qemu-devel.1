Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47E2204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBLa5Zu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47E2204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WPO-0004w7-30
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnB-0006Rt-93
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vn7-00030A-U4
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlv8VbTOIGLnwf98IicPgKpjnPIRf6I2CRVJqzvKgds=;
 b=YBLa5Zu70ClchEPVoQGFKsGe/GyLAreqDEsVG/lArbJlN9r88HVA9mwqR0TdsFnztzWFqO
 QWkbGEBKbN2tygnk3lcqXzzpAim+CxkoTyTRckiwhqIcYxso+MSPaXAx2X0Bf+D+M1N/JP
 7vZ0Ilz15mPJ1QmCsOHqEPVYKG8txDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-gEYDhEqqMxWo_WgpkRh5ng-1; Fri, 14 Aug 2020 05:14:23 -0400
X-MC-Unique: gEYDhEqqMxWo_WgpkRh5ng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 706811005E63
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA47747B9;
 Fri, 14 Aug 2020 09:14:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 075/150] meson: convert dump/
Date: Fri, 14 Aug 2020 05:12:11 -0400
Message-Id: <20200814091326.16173-76-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 Makefile.objs      | 3 +--
 Makefile.target    | 1 -
 configure          | 4 ++++
 dump/Makefile.objs | 3 ---
 dump/meson.build   | 4 ++++
 meson.build        | 9 +++++++++
 6 files changed, 18 insertions(+), 6 deletions(-)
 delete mode 100644 dump/Makefile.objs
 create mode 100644 dump/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index ec15ebc4b4..6657a6cce3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -48,8 +48,7 @@ storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = dump/
-common-obj-y += monitor/
+common-obj-y = monitor/
 common-obj-y += net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 
diff --git a/Makefile.target b/Makefile.target
index 5f926e5bfa..c8f7a6c04b 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -156,7 +156,6 @@ endif #CONFIG_BSD_USER
 ifdef CONFIG_SOFTMMU
 obj-y += softmmu/
 obj-y += gdbstub.o
-obj-y += dump/
 obj-y += hw/
 obj-y += monitor/
 obj-y += qapi/
diff --git a/configure b/configure
index 454a244141..ebce9e6766 100755
--- a/configure
+++ b/configure
@@ -2571,6 +2571,7 @@ int main(void) { lzo_version(); return 0; }
 EOF
     if compile_prog "" "-llzo2" ; then
         libs_softmmu="$libs_softmmu -llzo2"
+        lzo_libs="-llzo2"
         lzo="yes"
     else
         if test "$lzo" = "yes"; then
@@ -2590,6 +2591,7 @@ int main(void) { snappy_max_compressed_length(4096); return 0; }
 EOF
     if compile_prog "" "-lsnappy" ; then
         libs_softmmu="$libs_softmmu -lsnappy"
+        snappy_libs='-lsnappy'
         snappy="yes"
     else
         if test "$snappy" = "yes"; then
@@ -7419,10 +7421,12 @@ fi
 
 if test "$lzo" = "yes" ; then
   echo "CONFIG_LZO=y" >> $config_host_mak
+  echo "LZO_LIBS=$lzo_libs" >> $config_host_mak
 fi
 
 if test "$snappy" = "yes" ; then
   echo "CONFIG_SNAPPY=y" >> $config_host_mak
+  echo "SNAPPY_LIBS=$snappy_libs" >> $config_host_mak
 fi
 
 if test "$bzip2" = "yes" ; then
diff --git a/dump/Makefile.objs b/dump/Makefile.objs
deleted file mode 100644
index d2a5db3b81..0000000000
--- a/dump/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += dump.o
-common-obj-y += dump-hmp-cmds.o
-obj-$(TARGET_X86_64) += win_dump.o
diff --git a/dump/meson.build b/dump/meson.build
new file mode 100644
index 0000000000..2eff29c3ea
--- /dev/null
+++ b/dump/meson.build
@@ -0,0 +1,4 @@
+softmmu_ss.add(files('dump-hmp-cmds.c'))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files('dump.c'), snappy, lzo])
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'TARGET_X86_64'], if_true: files('win_dump.c'))
diff --git a/meson.build b/meson.build
index 98ba7a09f6..648febf65b 100644
--- a/meson.build
+++ b/meson.build
@@ -296,6 +296,14 @@ if 'CONFIG_FDT' in config_host
   fdt = declare_dependency(compile_args: config_host['FDT_CFLAGS'].split(),
                            link_args: config_host['FDT_LIBS'].split())
 endif
+snappy = not_found
+if 'CONFIG_SNAPPY' in config_host
+  snappy = declare_dependency(link_args: config_host['SNAPPY_LIBS'].split())
+endif
+lzo = not_found
+if 'CONFIG_LZO' in config_host
+  lzo = declare_dependency(link_args: config_host['LZO_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -603,6 +611,7 @@ subdir('io')
 subdir('chardev')
 subdir('fsdev')
 subdir('target')
+subdir('dump')
 
 block_ss.add(files(
   'block.c',
-- 
2.26.2



