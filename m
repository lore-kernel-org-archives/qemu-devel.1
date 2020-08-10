Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF366C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662F82080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1MVMj1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662F82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CHr-0002Ej-Id
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BM6-0003oI-Me
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BM3-0003OE-VR
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=SbNho+vCgH++MRH64CW0YogKLKmaN5l5ejCa0b1aPf8=;
 b=D1MVMj1UWk6U+jo2txOrP1zde5suDjNGlIsI793l9EqL3KNvrkmVGoIIDyQgXa4Z8pCOmc
 Tb3C0VXFfoqJdgZNXFccnxxhmf/ls7B2wE54ipv4/bW33wYuVQ9y2eeZNjBdAe7wFA6XW3
 ZUW3JtarZhfMfvjRK4/qpFqy+WYliQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-VDAqKGsjMlOzHTBgvff7xA-1; Mon, 10 Aug 2020 13:12:57 -0400
X-MC-Unique: VDAqKGsjMlOzHTBgvff7xA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A144F1005510
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:56 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6E175F1E9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 139/147] meson: replace create-config with meson configure_file
Date: Mon, 10 Aug 2020 19:08:57 +0200
Message-Id: <1597079345-42801-140-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
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

Move the create-config logic to meson.build; create a
configuration_data object and let meson handle the
quoting and output.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                       |   2 +-
 block.c                        |   4 +-
 configure                      |   9 ++-
 meson.build                    | 100 ++++++++++++++++++++++---------
 scripts/create_config          | 131 -----------------------------------------
 tests/qtest/bios-tables-test.c |   2 +-
 6 files changed, 80 insertions(+), 168 deletions(-)
 delete mode 100755 scripts/create_config

diff --git a/Makefile b/Makefile
index cd4eeb5..1eec727 100644
--- a/Makefile
+++ b/Makefile
@@ -189,7 +189,7 @@ clean: recurse-clean
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 
-VERSION ?= $(shell cat VERSION)
+VERSION = $(shell cat $(SRC_PATH)/VERSION)
 
 dist: qemu-$(VERSION).tar.bz2
 
diff --git a/block.c b/block.c
index 67c5028..67ca543 100644
--- a/block.c
+++ b/block.c
@@ -443,13 +443,13 @@ static int bdrv_format_is_whitelisted(const char *format_name, bool read_only)
         return 1;               /* no whitelist, anything goes */
     }
 
-    for (p = whitelist_rw; *p; p++) {
+    for (p = whitelist_rw; p < &whitelist_rw[ARRAY_SIZE(whitelist_rw)]; p++) {
         if (!strcmp(format_name, *p)) {
             return 1;
         }
     }
     if (read_only) {
-        for (p = whitelist_ro; *p; p++) {
+        for (p = whitelist_ro; p < &whitelist_ro[ARRAY_SIZE(whitelist_ro)]; p++) {
             if (!strcmp(format_name, *p)) {
                 return 1;
             }
diff --git a/configure b/configure
index a7f1e00..5d57990 100755
--- a/configure
+++ b/configure
@@ -6907,7 +6907,7 @@ if test "$slirp" != "no"; then
   echo "SLIRP_LIBS=$slirp_libs" >> $config_host_mak
 fi
 if [ "$slirp" = "git" -o "$slirp" = "internal" ]; then
-    echo "config-host.h: slirp/all" >> $config_host_mak
+    echo "qemu-version.h: slirp/all" >> $config_host_mak
 fi
 if test "$vde" = "yes" ; then
   echo "CONFIG_VDE=y" >> $config_host_mak
@@ -6985,7 +6985,6 @@ if test "$xfs" = "yes" ; then
   echo "CONFIG_XFS=y" >> $config_host_mak
 fi
 qemu_version=$(head $source_path/VERSION)
-echo "VERSION=$qemu_version" >>$config_host_mak
 echo "PKGVERSION=$pkgversion" >>$config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
@@ -7746,7 +7745,7 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
-  echo "IASL=$iasl" >> $config_host_mak
+  echo "CONFIG_IASL=$iasl" >> $config_host_mak
 fi
 echo "HOST_CC=$host_cc" >> $config_host_mak
 echo "CXX=$cxx" >> $config_host_mak
@@ -8273,10 +8272,10 @@ echo "PIXMAN_CFLAGS=$pixman_cflags" >> $config_host_mak
 echo "PIXMAN_LIBS=$pixman_libs" >> $config_host_mak
 
 if [ "$fdt" = "git" ]; then
-  echo "config-host.h: dtc/all" >> $config_host_mak
+  echo "qemu-version.h: dtc/all" >> $config_host_mak
 fi
 if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
-  echo "config-host.h: capstone/all" >> $config_host_mak
+  echo "qemu-version.h: capstone/all" >> $config_host_mak
 fi
 if test -n "$LIBCAPSTONE"; then
   echo "LIBCAPSTONE=$LIBCAPSTONE" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 9e37814..dc66c85 100644
--- a/meson.build
+++ b/meson.build
@@ -12,6 +12,8 @@ config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 config_all_disas = keyval.load(meson.current_build_dir() / 'config-all-disas.mak')
 enable_modules = 'CONFIG_MODULES' in config_host
 build_docs = 'BUILD_DOCS' in config_host
+config_host_data = configuration_data()
+genh = []
 
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       language: ['c', 'objc'])
@@ -347,13 +349,47 @@ if 'CONFIG_LIBPMEM' in config_host
                                link_args: config_host['LIBPMEM_LIBS'].split())
 endif
 
-create_config = find_program('scripts/create_config')
+# Create config-host.h
+
+config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
+config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
+config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
+config_host_data.set('QEMU_VERSION_MICRO', meson.project_version().split('.')[2])
+
+arrays = ['CONFIG_AUDIO_DRIVERS', 'CONFIG_BDRV_RW_WHITELIST', 'CONFIG_BDRV_RO_WHITELIST']
+ignored = ['HOST_USB', 'HOST_CC']
+strings = ['HOST_DSOSUF', 'CONFIG_IASL']
+foreach k, v: config_host
+  if arrays.contains(k)
+    if v != ''
+      v = '"' + '", "'.join(v.split()) + '", '
+    endif
+    config_host_data.set(k, v)
+  elif k == 'ARCH'
+    config_host_data.set('HOST_' + v.to_upper(), 1)
+  elif ignored.contains(k)
+    # do nothing
+  elif k.startswith('qemu') and (k.endswith('dir') or k.endswith('path'))
+    config_host_data.set_quoted('CONFIG_' + k.to_upper(), v)
+  elif strings.contains(k)
+    config_host_data.set_quoted(k, v)
+  elif k.startswith('CONFIG_') or k.startswith('HAVE_') or k.startswith('HOST_')
+    if v == 'y' or v == 'm'
+      config_host_data.set(k, 1)
+    else
+      config_host_data.set(k, v)
+    endif
+  endif
+endforeach
+genh += configure_file(output: 'config-host.h', configuration: config_host_data)
+
 minikconf = find_program('scripts/minikconf.py')
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
 have_system = false
 config_devices_mak_list = []
 config_devices_h = {}
+config_target_h = {}
 config_target_mak = {}
 kconfig_external_symbols = [
   'CONFIG_KVM',
@@ -369,16 +405,36 @@ kconfig_external_symbols = [
   'CONFIG_LINUX',
   'CONFIG_PVRDMA',
 ]
+ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
 foreach target : target_dirs
   have_user = have_user or target.endswith('-user')
-  config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak') + config_host
+  config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
+
+  config_target_data = configuration_data()
+  foreach k, v: config_target
+    if not k.startswith('TARGET_') and not k.startswith('CONFIG_')
+      # do nothing
+    elif ignored.contains(k)
+      # do nothing
+    elif k == 'TARGET_BASE_ARCH'
+      config_target_data.set('TARGET_' + v.to_upper(), 1)
+    elif k == 'TARGET_NAME'
+      config_target_data.set_quoted(k, v)
+    elif v == 'y'
+      config_target_data.set(k, 1)
+    else
+      config_target_data.set(k, v)
+    endif
+  endforeach
+  config_target_h += {target: configure_file(output: target + '-config-target.h',
+                                               configuration: config_target_data)}
 
   if target.endswith('-softmmu')
     have_system = true
 
     base_kconfig = []
     foreach sym : kconfig_external_symbols
-      if sym in config_target
+      if sym in config_target or sym in config_host
         base_kconfig += '@0@=y'.format(sym)
       endif
     endforeach
@@ -392,14 +448,16 @@ foreach target : target_dirs
       command: [minikconf, config_host['CONFIG_MINIKCONF_MODE'],
                 config_devices_mak, '@DEPFILE@', '@INPUT@',
                 base_kconfig])
-    config_devices_h += {target: custom_target(
-      target + '-config-devices.h',
-      input: config_devices_mak,
-      output: target + '-config-devices.h',
-      capture: true,
-      command: [create_config, '@INPUT@'])}
+
+    config_devices_data = configuration_data()
+    config_devices = keyval.load(config_devices_mak)
+    foreach k, v: config_devices
+      config_devices_data.set(k, 1)
+    endforeach
     config_devices_mak_list += config_devices_mak
-    config_target += keyval.load(config_devices_mak)
+    config_devices_h += {target: configure_file(output: target + '-config-devices.h',
+                                                configuration: config_devices_data)}
+    config_target += config_devices
   endif
   config_target_mak += {target: config_target}
 endforeach
@@ -439,7 +497,6 @@ config_all += {
 
 # Generators
 
-genh = []
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.pl')
 qapi_gen = find_program('scripts/qapi-gen.py')
@@ -469,7 +526,7 @@ tracetool = [
 
 qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
                     meson.current_source_dir(),
-                    config_host['PKGVERSION'], config_host['VERSION']]
+                    config_host['PKGVERSION'], meson.project_version()]
 qemu_version = custom_target('qemu-version.h',
                              output: 'qemu-version.h',
                              command: qemu_version_cmd,
@@ -478,13 +535,6 @@ qemu_version = custom_target('qemu-version.h',
                              build_always_stale: true)
 genh += qemu_version
 
-config_host_h = custom_target('config-host.h',
-                              input: meson.current_build_dir() / 'config-host.mak',
-                              output: 'config-host.h',
-                              capture: true,
-                              command: [create_config, '@INPUT@'])
-genh += config_host_h
-
 hxdep = []
 hx_headers = [
   ['qemu-options.hx', 'qemu-options.def'],
@@ -819,13 +869,14 @@ foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
   arch = config_target['TARGET_BASE_ARCH']
-  arch_srcs = []
+  arch_srcs = [config_target_h[target]]
   arch_deps = []
   c_args = config_target['QEMU_CFLAGS'].split() + ['-DNEED_CPU_H',
                   '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
                   '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
   link_args = config_target['QEMU_LDFLAGS'].split()
 
+  config_target += config_host
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
   if host_machine.system() == 'linux'
     target_inc += include_directories('linux-headers', is_system: true)
@@ -886,19 +937,12 @@ foreach target : target_dirs
   objects = common_all.extract_objects(target_common.sources())
   deps = target_common.dependencies()
 
-  # TODO: Change to generator once obj-y goes away
-  config_target_h = custom_target(target + '-config-target.h',
-                              input: meson.current_build_dir() / target / 'config-target.mak',
-                              output: target + '-config-target.h',
-                              capture: true,
-                              command: [create_config, '@INPUT@'])
-
   target_specific = specific_ss.apply(config_target, strict: false)
   arch_srcs += target_specific.sources()
   arch_deps += target_specific.dependencies()
 
   lib = static_library('qemu-' + target,
-                 sources: arch_srcs + [config_target_h] + genh,
+                 sources: arch_srcs + genh,
                  objects: objects,
                  include_directories: target_inc,
                  c_args: c_args,
diff --git a/scripts/create_config b/scripts/create_config
deleted file mode 100755
index ec5c0b4..0000000
--- a/scripts/create_config
+++ /dev/null
@@ -1,131 +0,0 @@
-#!/bin/sh
-
-test $# -gt 0 && exec < $1
-
-echo "/* Automatically generated by create_config - do not modify */"
-
-while read line; do
-
-case $line in
- VERSION=*) # configuration
-    version=${line#*=}
-    major=$(echo "$version" | cut -d. -f1)
-    minor=$(echo "$version" | cut -d. -f2)
-    micro=$(echo "$version" | cut -d. -f3)
-    echo "#define QEMU_VERSION \"$version\""
-    echo "#define QEMU_VERSION_MAJOR $major"
-    echo "#define QEMU_VERSION_MINOR $minor"
-    echo "#define QEMU_VERSION_MICRO $micro"
-    ;;
- qemu_*dir=* | qemu_*path=*) # qemu-specific directory configuration
-    name=${line%=*}
-    value=${line#*=}
-    define_name=$(echo $name | LC_ALL=C tr '[a-z]' '[A-Z]')
-    eval "define_value=\"$value\""
-    echo "#define CONFIG_$define_name \"$define_value\""
-    # save for the next definitions
-    eval "$name=\$define_value"
-    ;;
- prefix=*)
-    # save for the next definitions
-    prefix=${line#*=}
-    ;;
- IASL=*) # iasl executable
-    value=${line#*=}
-    echo "#define CONFIG_IASL $value"
-    ;;
- CONFIG_AUDIO_DRIVERS=*)
-    drivers=${line#*=}
-    echo "#define CONFIG_AUDIO_DRIVERS \\"
-    for drv in $drivers; do
-      echo "    \"${drv}\",\\"
-    done
-    echo ""
-    ;;
- CONFIG_BDRV_RW_WHITELIST=*)
-    echo "#define CONFIG_BDRV_RW_WHITELIST\\"
-    for drv in ${line#*=}; do
-      echo "    \"${drv}\",\\"
-    done
-    echo "    NULL"
-    ;;
- CONFIG_BDRV_RO_WHITELIST=*)
-    echo "#define CONFIG_BDRV_RO_WHITELIST\\"
-    for drv in ${line#*=}; do
-      echo "    \"${drv}\",\\"
-    done
-    echo "    NULL"
-    ;;
- CONFIG_*=y) # configuration
-    name=${line%=*}
-    echo "#define $name 1"
-    ;;
- CONFIG_*=n) # configuration
-    ;;
- CONFIG_*=*) # configuration
-    name=${line%=*}
-    value=${line#*=}
-    echo "#define $name $value"
-    ;;
- HAVE_*=y) # configuration
-    name=${line%=*}
-    echo "#define $name 1"
-    ;;
- HAVE_*=*) # configuration
-    name=${line%=*}
-    value=${line#*=}
-    echo "#define $name $value"
-    ;;
- ARCH=*) # configuration
-    arch=${line#*=}
-    arch_name=$(echo $arch | LC_ALL=C tr '[a-z]' '[A-Z]')
-    echo "#define HOST_$arch_name 1"
-    ;;
- HOST_USB=*)
-    # do nothing
-    ;;
- HOST_CC=*)
-    # do nothing
-    ;;
- HOST_*=y) # configuration
-    name=${line%=*}
-    echo "#define $name 1"
-    ;;
- HOST_DSOSUF=*)
-    echo "#define HOST_DSOSUF \"${line#*=}\""
-    ;;
- HOST_*=*) # configuration
-    name=${line%=*}
-    value=${line#*=}
-    echo "#define $name $value"
-    ;;
- TARGET_BASE_ARCH=*) # configuration
-    target_base_arch=${line#*=}
-    base_arch_name=$(echo $target_base_arch | LC_ALL=C tr '[a-z]' '[A-Z]')
-    echo "#define TARGET_$base_arch_name 1"
-    ;;
- TARGET_XML_FILES=*)
-    # do nothing
-    ;;
- TARGET_ABI_DIR=*)
-    # do nothing
-    ;;
- TARGET_NAME=*)
-    target_name=${line#*=}
-    echo "#define TARGET_NAME \"$target_name\""
-    ;;
- TARGET_DIRS=*)
-    # do nothing
-    ;;
- TARGET_*=y) # configuration
-    name=${line%=*}
-    echo "#define $name 1"
-    ;;
- TARGET_*=*) # configuration
-    name=${line%=*}
-    value=${line#*=}
-    echo "#define $name $value"
-    ;;
-esac
-
-done # read
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d49b398..d25ff35 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -88,7 +88,7 @@ typedef struct {
 static char disk[] = "tests/acpi-test-disk-XXXXXX";
 static const char *data_dir = "tests/data/acpi";
 #ifdef CONFIG_IASL
-static const char *iasl = stringify(CONFIG_IASL);
+static const char *iasl = CONFIG_IASL;
 #else
 static const char *iasl;
 #endif
-- 
1.8.3.1



