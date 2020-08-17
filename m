Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3486CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E6B20760
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejavc9jO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E6B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hGo-0006IP-4h
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gL9-0003Wz-2s
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46757
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gL1-0006v2-D0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dg2JWI65NOsNjS/YwjpdPhY7QCsZlisOKNHsoupPru8=;
 b=ejavc9jOWD0/J6kRKtA23vIdJz0pJH7LAJq3yPPUsQeYc+zN5MuNQD7rBED0l7bqm0VlNQ
 FWwhQc++AbX8MUOTRcmJ0gym1Dgei+jXJ5BPDux6kCVI45pX7+NADbvUOeM4l4HW4IKiy2
 wCGhH6Fk3BIZcOawC75M1OFL3aENrW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-RlY2frIWMpyFOYNKvx8AVw-1; Mon, 17 Aug 2020 10:42:11 -0400
X-MC-Unique: RlY2frIWMpyFOYNKvx8AVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7565381F000
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:42:10 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C15E70C3D;
 Mon, 17 Aug 2020 14:42:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 131/150] meson: cpu-emu
Date: Mon, 17 Aug 2020 16:40:34 +0200
Message-Id: <20200817144053.345107-36-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
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
 Makefile.target         | 12 ------------
 configure               | 10 +++++++++-
 meson.build             | 37 +++++++++++++++++++++++++++++++++++++
 scripts/feature_to_c.sh | 24 ++++++++----------------
 4 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 5c099fa79f..c180b4cb38 100644
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
index 82dbdd50e3..1da66ee537 100755
--- a/configure
+++ b/configure
@@ -5429,9 +5429,13 @@ case "$capstone" in
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
@@ -7663,6 +7667,8 @@ if test "$ivshmem" = "yes" ; then
 fi
 if test "$capstone" != "no" ; then
   echo "CONFIG_CAPSTONE=y" >> $config_host_mak
+  echo "CAPSTONE_CFLAGS=$capstone_cflags" >> $config_host_mak
+  echo "CAPSTONE_LIBS=$capstone_libs" >> $config_host_mak
 fi
 if test "$debug_mutex" = "yes" ; then
   echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak
@@ -7683,6 +7689,8 @@ fi
 
 if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
+  echo "LIBPMEM_LIBS=$libpmem_libs" >> $config_host_mak
+  echo "LIBPMEM_CFLAGS=$libpmem_cflags" >> $config_host_mak
 fi
 
 if test "$libdaxctl" = "yes" ; then
@@ -8181,7 +8189,7 @@ fi
 list=""
 if test ! -z "$gdb_xml_files" ; then
   for x in $gdb_xml_files; do
-    list="$list $source_path/gdb-xml/$x"
+    list="$list gdb-xml/$x"
   done
   echo "TARGET_XML_FILES=$list" >> $config_target_mak
 fi
diff --git a/meson.build b/meson.build
index 10e06acff0..2cfc183e92 100644
--- a/meson.build
+++ b/meson.build
@@ -341,6 +341,16 @@ if 'CONFIG_USB_LIBUSB' in config_host
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
@@ -525,6 +535,8 @@ target_softmmu_arch = {}
 # Trace files #
 ###############
 
+# TODO: add each directory to the subdirs from its own meson.build, once
+# we have those
 trace_events_subdirs = [
   'accel/kvm',
   'accel/tcg',
@@ -693,6 +705,20 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
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
@@ -784,6 +810,8 @@ common_all = static_library('common',
                             dependencies: common_all.dependencies(),
                             name_suffix: 'fa')
 
+feature_to_c = find_program('scripts/feature_to_c.sh')
+
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -830,6 +858,15 @@ foreach target : target_dirs
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
index c8ce9b88f6..b1169899c1 100644
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
2.26.2



