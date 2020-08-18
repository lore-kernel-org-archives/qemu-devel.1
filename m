Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5283D20786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2XQerpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5283D20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82ap-0000mg-FF
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KZ-0003hR-Ec
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KT-0007NQ-VB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9u88BPJQIN0eqvFM3VWD9HWvKsYvVyyXQwKrGcInB4=;
 b=I2XQerpOHbSK0jDYIPt7YpNlHa5tLrxL64H2fx7OoHGSx/nfPXJYecH7/GAUeq8/czpOeZ
 McTzNzgYg32emwiFlyIxHOMsjIhuEPUEbV3q1JWyBpkCiCrx0cagrk4ffRmX6F3xwOSpzq
 0JatTugKEf/hBOD2TjTk4C/ZYm+EjkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-Ei7r0N8hOWiP5Li-rdQhKw-1; Tue, 18 Aug 2020 10:11:02 -0400
X-MC-Unique: Ei7r0N8hOWiP5Li-rdQhKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59D8E100CABB
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 133C077D4C;
 Tue, 18 Aug 2020 14:11:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 036/150] contrib/ivshmem: convert to meson
Date: Tue, 18 Aug 2020 10:08:31 -0400
Message-Id: <20200818141025.21608-37-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
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
 Makefile                             | 9 ---------
 Makefile.objs                        | 2 --
 configure                            | 3 ---
 contrib/ivshmem-client/Makefile.objs | 1 -
 contrib/ivshmem-client/meson.build   | 4 ++++
 contrib/ivshmem-server/Makefile.objs | 1 -
 contrib/ivshmem-server/meson.build   | 4 ++++
 meson.build                          | 5 +++++
 8 files changed, 13 insertions(+), 16 deletions(-)
 delete mode 100644 contrib/ivshmem-client/Makefile.objs
 create mode 100644 contrib/ivshmem-client/meson.build
 delete mode 100644 contrib/ivshmem-server/Makefile.objs
 create mode 100644 contrib/ivshmem-server/meson.build

diff --git a/Makefile b/Makefile
index 4ce8d2b0c6..208e98dd4d 100644
--- a/Makefile
+++ b/Makefile
@@ -294,8 +294,6 @@ dummy := $(call unnest-vars,, \
                 chardev-obj-y \
                 qga-obj-y \
                 elf2dmp-obj-y \
-                ivshmem-client-obj-y \
-                ivshmem-server-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -508,13 +506,6 @@ endif
 elf2dmp$(EXESUF): $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
-ifdef CONFIG_IVSHMEM
-ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index 2f2d4b2066..336a684ff3 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -104,7 +104,5 @@ qga-vss-dll-obj-y = qga/
 ######################################################################
 # contrib
 elf2dmp-obj-y = contrib/elf2dmp/
-ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
-ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 
 ######################################################################
diff --git a/configure b/configure
index c0ba3e8cc5..932c0743e4 100755
--- a/configure
+++ b/configure
@@ -6680,9 +6680,6 @@ if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) qemu-storage-daemon\$(EXESUF) $tools"
   fi
-  if [ "$ivshmem" = "yes" ]; then
-    tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
-  fi
   if [ "$curl" = "yes" ]; then
       tools="elf2dmp\$(EXESUF) $tools"
   fi
diff --git a/contrib/ivshmem-client/Makefile.objs b/contrib/ivshmem-client/Makefile.objs
deleted file mode 100644
index bfab2d20dd..0000000000
--- a/contrib/ivshmem-client/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-ivshmem-client-obj-y = ivshmem-client.o main.o
diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
new file mode 100644
index 0000000000..1b171efb4f
--- /dev/null
+++ b/contrib/ivshmem-client/meson.build
@@ -0,0 +1,4 @@
+executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
+           dependencies: glib,
+           build_by_default: targetos == 'linux',
+           install: false)
diff --git a/contrib/ivshmem-server/Makefile.objs b/contrib/ivshmem-server/Makefile.objs
deleted file mode 100644
index c060dd3698..0000000000
--- a/contrib/ivshmem-server/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-ivshmem-server-obj-y = ivshmem-server.o main.o
diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
new file mode 100644
index 0000000000..3a53942201
--- /dev/null
+++ b/contrib/ivshmem-server/meson.build
@@ -0,0 +1,4 @@
+executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
+           dependencies: [qemuutil, rt],
+           build_by_default: targetos == 'linux',
+           install: false)
diff --git a/meson.build b/meson.build
index 181fe09843..7bb5984652 100644
--- a/meson.build
+++ b/meson.build
@@ -91,6 +91,7 @@ libcap_ng = not_found
 if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
+rt = cc.find_library('rt', required: false)
 libiscsi = not_found
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
@@ -280,6 +281,10 @@ if have_tools
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
+  if 'CONFIG_IVSHMEM' in config_host
+    subdir('contrib/ivshmem-client')
+    subdir('contrib/ivshmem-server')
+  endif
 endif
 
 subdir('tools')
-- 
2.26.2



