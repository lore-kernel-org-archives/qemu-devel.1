Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A60C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A95720870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A95720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8jp-0008SI-53
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7Ge-0001nB-HS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:12 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:47035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7GF-00061C-R3
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:12 -0400
Received: by mail-pl1-f176.google.com with SMTP id d6so9582516plo.13
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 16:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jWqVdHQoyHsP7HwjPTpZZR6nLfrh+meA4KPwnOVwA4A=;
 b=PexoPZIQRK1pApxZW71ehfKyJC1Pm1ObSy6qtzWay8xYf/Covr9ZGbvZEVeZgWd9xE
 CMZ9yUSUHHEi75EAzpSGo41b8nEdd5gwSB/b3R3ISJMHk5eDm1Yj5BmPJewmqkx/eY7h
 lcz/OKCQ+MSbF5pvSmnsQQYFaEOjuzglrzX46hbwKHRCLgGvgu4T3kX+I/GT4Z4Y3E4L
 G0A5rqN87Unvz8oMIIq4g8cqpoLTMap8fr40ZfFDgo2/6vIGpMU8gm3gonPrFSF9nHeJ
 qH/2UDLFIWaShSITsZmRMS5abjKgDBKJECkUaVELhistC+c//1lumpFddinqy6krLDBj
 Ccyw==
X-Gm-Message-State: AOAM532oscPs6i/E0LxBpTkLhQsuaWPTbUSq4UAMYXXVmyAinyNnBA5Z
 WpfWtvAmFPy86/PRIHIVIek6tp8Gi7U=
X-Google-Smtp-Source: ABdhPJyNlvrDxUlHnFuLqOCplO2HRMY0ntzafO0mrClEfmErE9yxDNnokualu35konH5QwYUPC2MOA==
X-Received: by 2002:a17:902:b111:b029:d4:cf7c:2ff1 with SMTP id
 q17-20020a170902b111b02900d4cf7c2ff1mr11936452plr.59.1602545386298; 
 Mon, 12 Oct 2020 16:29:46 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.174])
 by smtp.gmail.com with ESMTPSA id f21sm8088315pfk.169.2020.10.12.16.29.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 16:29:45 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] meson: option to build as shared library
Date: Mon, 12 Oct 2020 16:29:33 -0700
Message-Id: <20201012232939.48481-5-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012232939.48481-1-j@getutm.app>
References: <20201012232939.48481-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.176; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f176.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 19:29:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2020 20:56:29 -0400
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
Cc: Joelle van Dyne <j@getutm.app>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

On iOS, we cannot fork() new processes, so the best way to load QEMU into an
app is through a shared library. We add a new configure option
`--enable-shared-lib` that will build the bulk of QEMU into a shared lib.
The usual executables will then link to the library.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure         | 14 ++++++++++++--
 meson.build       | 40 ++++++++++++++++++++++++++++++++++------
 meson_options.txt |  2 ++
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index c474d7c221..37b27d9e35 100755
--- a/configure
+++ b/configure
@@ -448,6 +448,7 @@ ninja=""
 skip_meson=no
 gettext=""
 host_block_device_support="yes"
+shared_lib="false"
 
 bogus_os="no"
 malloc_trim="auto"
@@ -1563,6 +1564,10 @@ for opt do
   ;;
   --disable-libdaxctl) libdaxctl=no
   ;;
+  --enable-shared-lib) shared_lib=true
+  ;;
+  --disable-shared-lib) shared_lib=false
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1770,6 +1775,7 @@ Advanced options (experts only):
                            enable plugins via shared library loading
   --disable-containers     don't use containers for cross-building
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
+  --enable-shared-lib      build QEMU as a shared library
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -7211,7 +7217,11 @@ echo "ranlib = [$(meson_quote $ranlib)]" >> $cross
 if has $sdl2_config; then
   echo "sdl2-config = [$(meson_quote $sdl2_config)]" >> $cross
 fi
-echo "strip = [$(meson_quote $strip)]" >> $cross
+if test "$shared_lib" = "true"; then
+  echo "strip = [$(meson_quote $strip), '-x']" >> $cross
+else
+  echo "strip = [$(meson_quote $strip)]" >> $cross
+fi
 echo "windres = [$(meson_quote $windres)]" >> $cross
 if test "$cross_compile" = "yes"; then
     cross_arg="--cross-file config-meson.cross"
@@ -7273,7 +7283,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
-	-Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
+	-Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt -Dshared-lib=$shared_lib \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index 69a3c00cce..32cf08619f 100644
--- a/meson.build
+++ b/meson.build
@@ -1565,14 +1565,31 @@ foreach target : target_dirs
   arch_srcs += target_specific.sources()
   arch_deps += target_specific.dependencies()
 
-  lib = static_library('qemu-' + target,
+  if get_option('shared-lib')
+    build_lib_args = {
+      'target_type': 'shared_library',
+      'install': true,
+      'dependencies': arch_deps + deps,
+      'link_language': link_language,
+      'link_depends': [block_syms, qemu_syms],
+      'link_args': link_args + cc.get_supported_link_arguments(['-Wl,-U,_qemu_main'])
+    }
+  else
+    build_lib_args = {
+      'target_type': 'static_library',
+      'install': false,
+      'dependencies': arch_deps,
+      'name_suffix': 'fa'
+    }
+  endif
+
+  lib = build_target('qemu-' + target,
                  sources: arch_srcs + genh,
-                 dependencies: arch_deps,
                  objects: objects,
                  include_directories: target_inc,
                  c_args: c_args,
                  build_by_default: false,
-                 name_suffix: 'fa')
+                 kwargs: build_lib_args)
 
   if target.endswith('-softmmu')
     execs = [{
@@ -1606,17 +1623,27 @@ foreach target : target_dirs
       'dependencies': []
     }]
   endif
+  if get_option('shared-lib')
+    build_exe_args = {
+      'link_with': lib,
+      'link_args': link_args + cc.get_supported_link_arguments(['-Wl,--exclude-libs,ALL'])
+    }
+  else
+    build_exe_args = {
+      'objects': lib.extract_all_objects(recursive: true),
+      'link_args': link_args
+    }
+  endif
   foreach exe: execs
     emulators += {exe['name']:
          executable(exe['name'], exe['sources'],
                install: true,
                c_args: c_args,
                dependencies: arch_deps + deps + exe['dependencies'],
-               objects: lib.extract_all_objects(recursive: true),
                link_language: link_language,
                link_depends: [block_syms, qemu_syms] + exe.get('link_depends', []),
-               link_args: link_args,
-               gui_app: exe['gui'])
+               gui_app: exe['gui'],
+               kwargs: build_exe_args)
     }
 
     if 'CONFIG_TRACE_SYSTEMTAP' in config_host
@@ -1758,6 +1785,7 @@ endif
 summary_info += {'Doc directory':     get_option('docdir')}
 summary_info += {'Build directory':   meson.current_build_dir()}
 summary_info += {'Source path':       meson.current_source_dir()}
+summary_info += {'build shared lib':  get_option('shared-lib')}
 summary_info += {'GIT binary':        config_host['GIT']}
 summary_info += {'GIT submodules':    config_host['GIT_SUBMODULES']}
 summary_info += {'C compiler':        meson.get_compiler('c').cmd_array()[0]}
diff --git a/meson_options.txt b/meson_options.txt
index 1d3c94840a..bcecbd5e12 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -2,6 +2,8 @@ option('qemu_suffix', type : 'string', value: 'qemu',
        description: 'Suffix for QEMU data/modules/config directories (can be empty)')
 option('docdir', type : 'string', value : 'doc',
        description: 'Base directory for documentation installation (can be empty)')
+option('shared-lib', type : 'boolean', value : false,
+       description: 'build QEMU as a shared library')
 
 option('gettext', type : 'boolean', value : true,
        description: 'Localization of the GTK+ user interface')
-- 
2.24.3 (Apple Git-128)


