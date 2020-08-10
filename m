Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1FCC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC30D2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLZxhZdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC30D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CAr-0004W5-0t
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLv-0003LS-BW
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLs-0003MT-CC
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BGyMOleRKraS/VLuVwHLJo6BrzNvMRmHU3dardeanKQ=;
 b=eLZxhZdcuJyA/FUKQSyOWovhBwFuT1ZNULaziBA0yL9teMLuFx/7rDWNMfEPMkauNkAES1
 aZPpiP9dSdMbqlNPzHrVPjC5MyIhQ5cV7UO9HtOPMeKCo2KTULNstiAJMQhYFAr/RGpS8z
 MBb+UdDq6wf2ybMoZpAEldD+BmsFjug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-qE7jzfx1P0ihG0ORImTMwQ-1; Mon, 10 Aug 2020 13:12:44 -0400
X-MC-Unique: qE7jzfx1P0ihG0ORImTMwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADB938064B5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:43 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC8C187D61;
 Mon, 10 Aug 2020 17:12:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 129/147] meson: cpu-emu
Date: Mon, 10 Aug 2020 19:08:47 +0200
Message-Id: <1597079345-42801-130-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 13:09:25
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
 Makefile.target         | 12 ------------
 configure               |  8 ++++++++
 meson.build             | 37 +++++++++++++++++++++++++++++++++++++
 scripts/feature_to_c.sh | 24 ++++++++----------------
 4 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 5c099fa..c180b4c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -108,15 +108,6 @@ obj-y += $(LIBQEMU)
 obj-y += trace/
 
 #########################################################
-# cpu emulator library
-obj-y += exec.o exec-vary.o
-obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
-obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
-obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
-obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
-obj-$(CONFIG_TCG) += fpu/softfloat.o
-obj-y += disas.o
-obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 LIBS := $(libs_cpu) $(LIBS)
 
 obj-$(CONFIG_PLUGIN) += plugins/
@@ -200,9 +191,6 @@ ifdef CONFIG_DARWIN
 	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
 endif
 
-gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
-	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_to_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
-
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
diff --git a/configure b/configure
index ca3cd83..a912055 100755
--- a/configure
+++ b/configure
@@ -5418,9 +5418,13 @@ case "$capstone" in
       LIBCAPSTONE=libcapstone.a
     fi
     libs_cpu="-L$PWD/capstone -lcapstone $libs_cpu"
+    capstone_libs="-L$PWD/capstone -lcapstone"
+    capstone_cflags="-I${source_path}/capstone/include"
     ;;
 
   system)
+    capstone_libs="$($pkg_config --libs capstone)"
+    capstone_cflags="$($pkg_config --cflags capstone)"
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
     libs_cpu="$($pkg_config --libs capstone) $libs_cpu"
     ;;
@@ -7641,6 +7645,8 @@ if test "$ivshmem" = "yes" ; then
 fi
 if test "$capstone" != "no" ; then
   echo "CONFIG_CAPSTONE=y" >> $config_host_mak
+  echo "CAPSTONE_CFLAGS=$capstone_cflags" >> $config_host_mak
+  echo "CAPSTONE_LIBS=$capstone_libs" >> $config_host_mak
 fi
 if test "$debug_mutex" = "yes" ; then
   echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak
@@ -7661,6 +7667,8 @@ fi
 
 if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
+  echo "LIBPMEM_LIBS=$libpmem_libs" >> $config_host_mak
+  echo "LIBPMEM_CFLAGS=$libpmem_cflags" >> $config_host_mak
 fi
 
 if test "$libdaxctl" = "yes" ; then
diff --git a/meson.build b/meson.build
index 6490301..2190d98 100644
--- a/meson.build
+++ b/meson.build
@@ -333,6 +333,16 @@ if 'CONFIG_USB_LIBUSB' in config_host
   libusb = declare_dependency(compile_args: config_host['LIBUSB_CFLAGS'].split(),
                               link_args: config_host['LIBUSB_LIBS'].split())
 endif
+capstone = not_found
+if 'CONFIG_CAPSTONE' in config_host
+  capstone = declare_dependency(compile_args: config_host['CAPSTONE_CFLAGS'].split(),
+                                link_args: config_host['CAPSTONE_LIBS'].split())
+endif
+libpmem = not_found
+if 'CONFIG_LIBPMEM' in config_host
+  libpmem = declare_dependency(compile_args: config_host['LIBPMEM_CFLAGS'].split(),
+                               link_args: config_host['LIBPMEM_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -517,6 +527,8 @@ target_softmmu_arch = {}
 # Trace files #
 ###############
 
+# TODO: add each directory to the subdirs from its own meson.build, once
+# we have those
 trace_events_subdirs = [
   'accel/kvm',
   'accel/tcg',
@@ -685,6 +697,20 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
+
+specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone, libpmem)
+specific_ss.add(files('exec-vary.c'))
+specific_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'fpu/softfloat.c',
+  'tcg/optimize.c',
+  'tcg/tcg-common.c',
+  'tcg/tcg-op-gvec.c',
+  'tcg/tcg-op-vec.c',
+  'tcg/tcg-op.c',
+  'tcg/tcg.c',
+))
+specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('disas/tci.c', 'tcg/tci.c'))
+
 subdir('backends')
 subdir('disas')
 subdir('migration')
@@ -776,6 +802,8 @@ common_all = static_library('common',
                             dependencies: common_all.dependencies(),
                             name_suffix: 'fa')
 
+feature_to_c = find_program('scripts/feature_to_c.sh')
+
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -822,6 +850,15 @@ foreach target : target_dirs
     endif
   endif
 
+  if 'TARGET_XML_FILES' in config_target
+    gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
+                                output: target + '-gdbstub-xml.c',
+                                input: files(config_target['TARGET_XML_FILES'].split()),
+                                command: [feature_to_c, '@INPUT@'],
+                                capture: true)
+    arch_srcs += gdbstub_xml
+  endif
+
   t = target_arch[arch].apply(config_target, strict: false)
   arch_srcs += t.sources()
 
diff --git a/scripts/feature_to_c.sh b/scripts/feature_to_c.sh
index c8ce9b8..b116989 100644
--- a/scripts/feature_to_c.sh
+++ b/scripts/feature_to_c.sh
@@ -19,16 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, see <http://www.gnu.org/licenses/>.
 
-output=$1
-shift
-
-if test -z "$output" || test -z "$1"; then
-  echo "Usage: $0 OUTPUTFILE INPUTFILE..."
-  exit 1
-fi
-
-if test -e "$output"; then
-  echo "Output file \"$output\" already exists; refusing to overwrite."
+if test -z "$1"; then
+  echo "Usage: $0 INPUTFILE..."
   exit 1
 fi
 
@@ -60,17 +52,17 @@ for input; do
       printf "'\''\\n'\'', \n"
     } END {
       print "  0 };"
-    }' < $input >> $output
+    }' < $input
 done
 
-echo >> $output
-echo "const char *const xml_builtin[][2] = {" >> $output
+echo
+echo "const char *const xml_builtin[][2] = {"
 
 for input; do
   basename=$(echo $input | sed 's,.*/,,')
   arrayname=xml_feature_$(echo $input | sed 's,.*/,,; s/[-.]/_/g')
-  echo "  { \"$basename\", $arrayname }," >> $output
+  echo "  { \"$basename\", $arrayname },"
 done
 
-echo "  { (char *)0, (char *)0 }" >> $output
-echo "};" >> $output
+echo "  { (char *)0, (char *)0 }"
+echo "};"
-- 
1.8.3.1



