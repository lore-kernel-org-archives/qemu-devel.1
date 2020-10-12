Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C2EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFDD20870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFDD20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8na-0004Mz-I7
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7Gf-0001nb-0U
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7GI-00061P-3R
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id b19so9600857pld.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 16:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tAVnmb+iMQuskjKZgzOi0mAxFQ0ROV6QmFMx1bkm5KA=;
 b=sVyVQ2UB/yYW4ehedGJIdPYoU7YYwEezXmyxuPmHJSLAWuhiKUh75WZo3j///H6QqR
 MD2EcOPC4xBGYb6tDwRnjkVeZHUqTT3nR2+31Ep1E42kIl+hWSbyEemy0gjKn6CMaW8B
 i9uQ/wlDLivGhPov5S+UsEYXVaGQAduosGDZyxTvdtDWsYjJyBhUkmysLu4DiU5zRh+I
 gLSsYsBYsG3lrnK0bYwF3oNMY5cpJIk6QpMJZ7LJhiIDUXtOKpEUYxyt9MlEBIkmmUqE
 AdAitwGXcEb3oXOdZ+pQoIuLBAEZs0jFIrvNU8taPXErkx6nxIS5P1kaKnUEE3QM66sA
 EphQ==
X-Gm-Message-State: AOAM530p/MlzH+OWhQ/0Xc42fYdPhaIIM6X6Mh/tnW88rLN4A59J7dNm
 k3wN+VoQn4OusHk+1yiNoqc9mUmG9EE=
X-Google-Smtp-Source: ABdhPJznhdF8+/tiGRKqCns8ja9bwRomC1UdGlU/vhxcEYgywZoXdaMqrRcW4OKFEoSNigyBctCibQ==
X-Received: by 2002:a17:902:9306:b029:d4:df0f:f08f with SMTP id
 bc6-20020a1709029306b02900d4df0ff08fmr6262127plb.73.1602545388554; 
 Mon, 12 Oct 2020 16:29:48 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.174])
 by smtp.gmail.com with ESMTPSA id f21sm8088315pfk.169.2020.10.12.16.29.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 16:29:48 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/10] coroutine: add libucontext as external library
Date: Mon, 12 Oct 2020 16:29:35 -0700
Message-Id: <20201012232939.48481-7-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012232939.48481-1-j@getutm.app>
References: <20201012232939.48481-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.196; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 19:29:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Joelle van Dyne <j@getutm.app>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

iOS does not support ucontext natively for aarch64 and the sigaltstack is
also unsupported (even worse, it fails silently, see:
https://openradar.appspot.com/13002712 )

As a workaround we include a library implementation of ucontext and add it
as a build option.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 .gitmodules               |  3 +++
 configure                 | 23 ++++++++++++++++++++---
 libucontext               |  1 +
 meson.build               | 29 ++++++++++++++++++++++++++++-
 meson_options.txt         |  2 ++
 util/coroutine-ucontext.c |  9 +++++++++
 6 files changed, 63 insertions(+), 4 deletions(-)
 create mode 160000 libucontext

diff --git a/.gitmodules b/.gitmodules
index f23e859210..f5a1dc3c5a 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -64,3 +64,6 @@
 [submodule "roms/vbootrom"]
 	path = roms/vbootrom
 	url = https://git.qemu.org/git/vbootrom.git
+[submodule "libucontext"]
+	path = libucontext
+	url = https://github.com/utmapp/libucontext.git
diff --git a/configure b/configure
index 37b27d9e35..16c66b437c 100755
--- a/configure
+++ b/configure
@@ -1761,7 +1761,7 @@ Advanced options (experts only):
   --oss-lib                path to OSS library
   --cpu=CPU                Build for host CPU [$cpu]
   --with-coroutine=BACKEND coroutine backend. Supported options:
-                           ucontext, sigaltstack, windows
+                           ucontext, libucontext, sigaltstack, windows
   --enable-gcov            enable test coverage analysis with gcov
   --disable-blobs          disable installing provided firmware blobs
   --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
@@ -5064,6 +5064,8 @@ if test "$coroutine" = ""; then
     coroutine=win32
   elif test "$ucontext_works" = "yes"; then
     coroutine=ucontext
+  elif test "$ios" = "yes"; then
+    coroutine=libucontext
   else
     coroutine=sigaltstack
   fi
@@ -5087,12 +5089,27 @@ else
       error_exit "only the 'windows' coroutine backend is valid for Windows"
     fi
     ;;
+  libucontext)
+  ;;
   *)
     error_exit "unknown coroutine backend $coroutine"
     ;;
   esac
 fi
 
+case $coroutine in
+libucontext)
+  git_submodules="${git_submodules} libucontext"
+  mkdir -p libucontext
+  coroutine_impl=ucontext
+  libucontext="enabled"
+  ;;
+*)
+  coroutine_impl=$coroutine
+  libucontext="disabled"
+  ;;
+esac
+
 if test "$coroutine_pool" = ""; then
   coroutine_pool=yes
 fi
@@ -6682,7 +6699,7 @@ if test "$rbd" = "yes" ; then
   echo "RBD_LIBS=$rbd_libs" >> $config_host_mak
 fi
 
-echo "CONFIG_COROUTINE_BACKEND=$coroutine" >> $config_host_mak
+echo "CONFIG_COROUTINE_BACKEND=$coroutine_impl" >> $config_host_mak
 if test "$coroutine_pool" = "yes" ; then
   echo "CONFIG_COROUTINE_POOL=1" >> $config_host_mak
 else
@@ -7282,7 +7299,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
 	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
+	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f -Ducontext=$libucontext \
 	-Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt -Dshared-lib=$shared_lib \
         $cross_arg \
         "$PWD" "$source_path"
diff --git a/libucontext b/libucontext
new file mode 160000
index 0000000000..7094e4c427
--- /dev/null
+++ b/libucontext
@@ -0,0 +1 @@
+Subproject commit 7094e4c42723b6178a4e2b60d4631d8a88f40719
diff --git a/meson.build b/meson.build
index da96e296e0..118276edb7 100644
--- a/meson.build
+++ b/meson.build
@@ -1101,9 +1101,35 @@ if not fdt.found() and fdt_required.length() > 0
   error('fdt not available but required by targets ' + ', '.join(fdt_required))
 endif
 
+ucontext = not_found
+slirp_opt = 'disabled'
+if get_option('ucontext').enabled()
+  if not fs.is_dir(meson.current_source_dir() / 'libucontext/arch' / cpu)
+    error('libucontext is wanted but not implemented for host ' + cpu)
+  endif
+  arch = host_machine.cpu()
+  ucontext_cargs = ['-DG_LOG_DOMAIN="ucontext"', '-DCUSTOM_IMPL']
+  ucontext_files = [
+    'libucontext/arch' / arch / 'getcontext.S',
+    'libucontext/arch' / arch / 'setcontext.S',
+    'libucontext/arch' / arch / 'makecontext.c',
+    'libucontext/arch' / arch / 'startcontext.S',
+    'libucontext/arch' / arch / 'swapcontext.S',
+  ]
+
+  ucontext_inc = include_directories('libucontext/include')
+  libucontext = static_library('ucontext',
+                               sources: ucontext_files,
+                               c_args: ucontext_cargs,
+                               include_directories: ucontext_inc)
+  ucontext = declare_dependency(link_with: libucontext,
+                                include_directories: ucontext_inc)
+endif
+
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_FDT', fdt.found())
 config_host_data.set('CONFIG_SLIRP', slirp.found())
+config_host_data.set('CONFIG_LIBUCONTEXT', ucontext.found())
 
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
@@ -1323,7 +1349,7 @@ util_ss.add_all(trace_ss)
 util_ss = util_ss.apply(config_all, strict: false)
 libqemuutil = static_library('qemuutil',
                              sources: util_ss.sources() + stub_ss.sources() + genh,
-                             dependencies: [util_ss.dependencies(), m, glib, socket, malloc])
+                             dependencies: [util_ss.dependencies(), m, glib, socket, malloc, ucontext])
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
@@ -1946,6 +1972,7 @@ if targetos == 'windows'
   summary_info += {'QGA MSI support':   config_host.has_key('CONFIG_QGA_MSI')}
 endif
 summary_info += {'seccomp support':   config_host.has_key('CONFIG_SECCOMP')}
+summary_info += {'libucontext support': ucontext.found()}
 summary_info += {'coroutine backend': config_host['CONFIG_COROUTINE_BACKEND']}
 summary_info += {'coroutine pool':    config_host['CONFIG_COROUTINE_POOL'] == '1'}
 summary_info += {'debug stack usage': config_host.has_key('CONFIG_DEBUG_STACK_USAGE')}
diff --git a/meson_options.txt b/meson_options.txt
index bcecbd5e12..acd989dfa2 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -50,6 +50,8 @@ option('vnc_sasl', type : 'feature', value : 'auto',
        description: 'SASL authentication for VNC server')
 option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
+option('ucontext', type : 'feature', value : 'disabled',
+       description: 'libucontext support')
 
 option('capstone', type: 'combo', value: 'auto',
        choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 904b375192..1e1dd43512 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -23,7 +23,16 @@
 #undef _FORTIFY_SOURCE
 #endif
 #include "qemu/osdep.h"
+#if defined(CONFIG_LIBUCONTEXT)
+#include <libucontext.h>
+#define ucontext_t libucontext_ucontext_t
+#define getcontext libucontext_getcontext
+#define setcontext libucontext_setcontext
+#define swapcontext libucontext_swapcontext
+#define makecontext libucontext_makecontext
+#else
 #include <ucontext.h>
+#endif
 #include "qemu/coroutine_int.h"
 
 #ifdef CONFIG_VALGRIND_H
-- 
2.24.3 (Apple Git-128)


