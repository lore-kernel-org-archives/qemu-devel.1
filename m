Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E8BC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A9920774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHFgJ+4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A9920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6W4M-000387-Aj
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vmh-0005SM-Vd
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27379
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vmb-0002sv-Tg
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZZ4a3fRhvDYpBSpO6MSoS8JIop2FqIpkyUpSd7V8UY=;
 b=AHFgJ+4+mr7JM8swY+e/h3Y5VU10uz+d2D+kdYugeqWm5Xg8MG4gbg9/EZMlKYvJvzRWVE
 XutZMlsff2tmA1wPOb8tGb+mUMp0XL0hXhYpEk/mJNHJzjQgi2+J64sV3cvq/dZmrN+esq
 Oep1nlx8Tb6NEaws16wrud5/o9kBzHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Z4msxY2KOQeh9r1Kze9Hfw-1; Fri, 14 Aug 2020 05:13:49 -0400
X-MC-Unique: Z4msxY2KOQeh9r1Kze9Hfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A4B31015DBC
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3FD3747B9
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 029/150] tools/virtiofsd: convert to Meson
Date: Fri, 14 Aug 2020 05:11:25 -0400
Message-Id: <20200814091326.16173-30-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:57:54
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                                      | 12 ------------
 Makefile.objs                                 |  1 -
 configure                                     |  1 +
 meson.build                                   | 11 +++++++++++
 tools/meson.build                             | 10 ++++++++++
 tools/virtiofsd/Makefile.objs                 | 12 ------------
 tools/virtiofsd/meson.build                   | 19 +++++++++++++++++++
 tools/virtiofsd/passthrough_ll.c              |  2 +-
 .../{seccomp.c => passthrough_seccomp.c}      |  2 +-
 .../{seccomp.h => passthrough_seccomp.h}      |  0
 10 files changed, 43 insertions(+), 27 deletions(-)
 create mode 100644 tools/meson.build
 delete mode 100644 tools/virtiofsd/Makefile.objs
 create mode 100644 tools/virtiofsd/meson.build
 rename tools/virtiofsd/{seccomp.c => passthrough_seccomp.c} (99%)
 rename tools/virtiofsd/{seccomp.h => passthrough_seccomp.h} (100%)

diff --git a/Makefile b/Makefile
index b30de2fd5d..310989ce4d 100644
--- a/Makefile
+++ b/Makefile
@@ -196,11 +196,6 @@ HELPERS-y += vhost-user-gpu$(EXESUF)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
 
-ifeq ($(CONFIG_SOFTMMU)$(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyyy)
-HELPERS-y += virtiofsd$(EXESUF)
-vhost-user-json-y += tools/virtiofsd/50-qemu-virtiofsd.json
-endif
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -307,7 +302,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                virtiofsd-obj-y \
                 rdmacm-mux-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
@@ -540,12 +534,6 @@ rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
-# relies on Linux-specific syscalls
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-virtiofsd$(EXESUF): $(virtiofsd-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
-endif
-
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
diff --git a/Makefile.objs b/Makefile.objs
index 9489864967..fee0f71372 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -113,6 +113,5 @@ vhost-user-blk-obj-y = contrib/vhost-user-blk/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
-virtiofsd-obj-y = tools/virtiofsd/
 
 ######################################################################
diff --git a/configure b/configure
index 5062576d3f..ca397dbfa5 100755
--- a/configure
+++ b/configure
@@ -6998,6 +6998,7 @@ if test "$gprof" = "yes" ; then
 fi
 if test "$cap_ng" = "yes" ; then
   echo "CONFIG_LIBCAP_NG=y" >> $config_host_mak
+  echo "LIBCAP_NG_LIBS=$cap_libs" >> $config_host_mak
 fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
diff --git a/meson.build b/meson.build
index ac70973012..cf7d6de67d 100644
--- a/meson.build
+++ b/meson.build
@@ -79,6 +79,15 @@ if 'CONFIG_GNUTLS' in config_host
   gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
                               link_args: config_host['GNUTLS_LIBS'].split())
 endif
+seccomp = not_found
+if 'CONFIG_SECCOMP' in config_host
+  seccomp = declare_dependency(compile_args: config_host['SECCOMP_CFLAGS'].split(),
+                               link_args: config_host['SECCOMP_LIBS'].split())
+endif
+libcap_ng = not_found
+if 'CONFIG_LIBCAP_NG' in config_host
+  libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -247,6 +256,8 @@ if have_tools
   endif
 endif
 
+subdir('tools')
+
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
 summary_info += {'BIOS directory':    config_host['qemu_datadir']}
diff --git a/tools/meson.build b/tools/meson.build
new file mode 100644
index 0000000000..513bd2ff4f
--- /dev/null
+++ b/tools/meson.build
@@ -0,0 +1,10 @@
+have_virtiofsd = (have_system and
+    have_tools and
+    'CONFIG_LINUX' in config_host and 
+    'CONFIG_SECCOMP' in config_host and
+    'CONFIG_LIBCAP_NG' in config_host and
+    'CONFIG_VHOST_USER' in config_host)
+
+if have_virtiofsd
+  subdir('virtiofsd')
+endif
diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.objs
deleted file mode 100644
index 076f667e46..0000000000
--- a/tools/virtiofsd/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-virtiofsd-obj-y = buffer.o \
-                  fuse_opt.o \
-                  fuse_log.o \
-                  fuse_lowlevel.o \
-                  fuse_signals.o \
-                  fuse_virtio.o \
-                  helper.o \
-                  passthrough_ll.o \
-                  seccomp.o
-
-seccomp.o-cflags := $(SECCOMP_CFLAGS)
-seccomp.o-libs := $(SECCOMP_LIBS)
diff --git a/tools/virtiofsd/meson.build b/tools/virtiofsd/meson.build
new file mode 100644
index 0000000000..d1e23c5760
--- /dev/null
+++ b/tools/virtiofsd/meson.build
@@ -0,0 +1,19 @@
+executable('virtiofsd', files(
+  'buffer.c',
+  'fuse_opt.c',
+  'fuse_log.c',
+  'fuse_lowlevel.c',
+  'fuse_signals.c',
+  'fuse_virtio.c',
+  'helper.c',
+  'passthrough_ll.c',
+  'passthrough_seccomp.c'),
+  link_with: libvhost_user,
+  dependencies: [seccomp, qemuutil, libcap_ng],
+  install: true,
+  install_dir: get_option('libexecdir'))
+
+configure_file(input: '50-qemu-virtiofsd.json.in',
+               output: '50-qemu-virtiofsd.json',
+               configuration: config_host,
+               install_dir: config_host['qemu_datadir'] / 'vhost-user')
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 94e0de2d2b..63d1d00565 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -65,7 +65,7 @@
 #include <unistd.h>
 
 #include "passthrough_helpers.h"
-#include "seccomp.h"
+#include "passthrough_seccomp.h"
 
 /* Keep track of inode posix locks for each owner. */
 struct lo_inode_plock {
diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/passthrough_seccomp.c
similarity index 99%
rename from tools/virtiofsd/seccomp.c
rename to tools/virtiofsd/passthrough_seccomp.c
index 3b1522acdd..19fee60011 100644
--- a/tools/virtiofsd/seccomp.c
+++ b/tools/virtiofsd/passthrough_seccomp.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "seccomp.h"
+#include "passthrough_seccomp.h"
 #include "fuse_i.h"
 #include "fuse_log.h"
 #include <errno.h>
diff --git a/tools/virtiofsd/seccomp.h b/tools/virtiofsd/passthrough_seccomp.h
similarity index 100%
rename from tools/virtiofsd/seccomp.h
rename to tools/virtiofsd/passthrough_seccomp.h
-- 
2.26.2



