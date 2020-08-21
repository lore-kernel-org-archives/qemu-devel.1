Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5702AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CA0204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL72xK8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CA0204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94Mz-0003cy-BT
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94DR-0001VM-6R
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36714
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94DO-0001X4-0D
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jyv/dIMndkg4xeEOvVYoSrp7IFILHEetfFnzL+IGUfw=;
 b=DL72xK8CrRXYsE0+IFJqn14elB5BA8LgYYdKgBQN5nqSuaKE1aMvFtb/Nig9ANgkohplsI
 SnzolQOBDuvLnGJH3sQOX5wCUk314l0r6YGo6xaSurfh5ePNkLpHvWMVC6eVaRmI4ay2zw
 OXuR1nESuE2ontB54UxB5CA6MqiGuFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-02tpeWp1PfC_KwjOVDjqug-1; Fri, 21 Aug 2020 06:24:03 -0400
X-MC-Unique: 02tpeWp1PfC_KwjOVDjqug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4BFF10082E0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:02 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E35F19D6C;
 Fri, 21 Aug 2020 10:24:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 037/152] contrib/ivshmem: convert to meson
Date: Fri, 21 Aug 2020 06:21:34 -0400
Message-Id: <20200821102329.29777-38-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
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
index ed6494b771..e16cbe6191 100644
--- a/Makefile
+++ b/Makefile
@@ -303,8 +303,6 @@ dummy := $(call unnest-vars,, \
                 chardev-obj-y \
                 qga-obj-y \
                 elf2dmp-obj-y \
-                ivshmem-client-obj-y \
-                ivshmem-server-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -517,13 +515,6 @@ endif
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
index 40c033a48c..1d00af339c 100755
--- a/configure
+++ b/configure
@@ -6725,9 +6725,6 @@ if test "$want_tools" = "yes" ; then
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
index 71ef66e1d6..c1078b6759 100644
--- a/meson.build
+++ b/meson.build
@@ -94,6 +94,7 @@ libcap_ng = not_found
 if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
+rt = cc.find_library('rt', required: false)
 libiscsi = not_found
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
@@ -283,6 +284,10 @@ if have_tools
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



