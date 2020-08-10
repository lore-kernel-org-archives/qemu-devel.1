Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BA0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681D520825
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM6QFhrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681D520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BVw-0006Yz-KY
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJE-0006ps-NO
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56424
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJB-0002mt-2j
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=UbJoM8nL0JljaEpUKx9bnee2VZCeZ0/qw6mJCz1ROOU=;
 b=cM6QFhrZbCl5Fz8vwYa/7Hh1gP/WhEQS7VjBWlmHE0UFgZRkvNVI4vb7R96jbwVKulJK8U
 SkMfGOJhwYmyvy07vQquVB6WNJ+3lcWS4InIujct3K3omz++IYYWF2gnIUz6pKCOx5Ar+t
 3FSI4+m7kx7HSzbHfOM7u5mLBggbWck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542--QFB5FuOMsuvxQy-1eccJQ-1; Mon, 10 Aug 2020 13:09:57 -0400
X-MC-Unique: -QFB5FuOMsuvxQy-1eccJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3784419200E2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:55 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA028BD6F
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:09:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 028/147] tools/virtiofsd: convert to Meson
Date: Mon, 10 Aug 2020 19:07:06 +0200
Message-Id: <1597079345-42801-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                                             | 12 ------------
 Makefile.objs                                        |  1 -
 configure                                            |  1 +
 meson.build                                          | 11 +++++++++++
 tools/meson.build                                    | 10 ++++++++++
 tools/virtiofsd/Makefile.objs                        | 12 ------------
 tools/virtiofsd/meson.build                          | 19 +++++++++++++++++++
 tools/virtiofsd/passthrough_ll.c                     |  2 +-
 tools/virtiofsd/{seccomp.c => passthrough_seccomp.c} |  2 +-
 tools/virtiofsd/{seccomp.h => passthrough_seccomp.h} |  0
 10 files changed, 43 insertions(+), 27 deletions(-)
 create mode 100644 tools/meson.build
 delete mode 100644 tools/virtiofsd/Makefile.objs
 create mode 100644 tools/virtiofsd/meson.build
 rename tools/virtiofsd/{seccomp.c => passthrough_seccomp.c} (99%)
 rename tools/virtiofsd/{seccomp.h => passthrough_seccomp.h} (100%)

diff --git a/Makefile b/Makefile
index e189d24..6a3dfc4 100644
--- a/Makefile
+++ b/Makefile
@@ -189,11 +189,6 @@ HELPERS-y += vhost-user-gpu$(EXESUF)
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
@@ -300,7 +295,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                virtiofsd-obj-y \
                 rdmacm-mux-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
@@ -533,12 +527,6 @@ rdmacm-mux$(EXESUF): LIBS += "-libumad"
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
index 9489864..fee0f71 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -113,6 +113,5 @@ vhost-user-blk-obj-y = contrib/vhost-user-blk/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
-virtiofsd-obj-y = tools/virtiofsd/
 
 ######################################################################
diff --git a/configure b/configure
index 685bd28..86a8c8b 100755
--- a/configure
+++ b/configure
@@ -6970,6 +6970,7 @@ if test "$gprof" = "yes" ; then
 fi
 if test "$cap_ng" = "yes" ; then
   echo "CONFIG_LIBCAP_NG=y" >> $config_host_mak
+  echo "LIBCAP_NG_LIBS=$cap_libs" >> $config_host_mak
 fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
diff --git a/meson.build b/meson.build
index 2a19433..c6b5292 100644
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
index 0000000..513bd2f
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
index 076f667..0000000
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
index 0000000..d1e23c5
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
index 94e0de2..63d1d00 100644
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
index 3b1522a..19fee60 100644
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
1.8.3.1



