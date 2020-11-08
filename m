Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3057C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED5420897
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5420897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbdM2-000087-IN
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 00:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDU-0001ST-DA
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 00:26:16 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:43204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDS-0004vm-HJ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 00:26:16 -0500
Received: by mail-pf1-f180.google.com with SMTP id z3so5079448pfb.10
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 21:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2EGdgJu0Lqq71e+aPYEq0GYxDtNLTm9bz2zccPRlgqk=;
 b=qg/0WxDrhU0mrcrVaCnsGWhHnmwZQweBaegATVzDfGamZe8aBvmP9j0/t4Jbmi+DUl
 1x0ExEh0qlmnpQswjHuTRKkeJyIi74MxY8hPoE6yhpBJbEtIDByL+d07jlQ0my3N0PKC
 1SHPKfkVpvWbP3r2YOD5kMv3MRcJksop1DFQEClCMhSsaIt6uAOqUGepkk1ldHWmxDux
 Mh7MzbaHle5vyDH5My9NCidAnhVpBA67StNLF4g7SooZYZvfTxe2sNfD1BqL+fD0O5Nu
 +cN5ypwiQvGi3VIc4BKQvWklNbLDEOHUxQHy3W+W5KE16B7ZgVEhN9Of5ZXbVB93rlQV
 +xxw==
X-Gm-Message-State: AOAM532RI4H9R+7U2qX8d0fgA+2Wo20GFfre2O9nAtQcymIaM5fGhXQt
 iCnElFuw9r1cG7qtGwywJmKE98RTZWM=
X-Google-Smtp-Source: ABdhPJxp9yK+bYDVSR7ZqnclJIDOJkB3zQreNcB43ej4qjodzjkA2SOhqabVhU7PPmhee0w7sLVqgA==
X-Received: by 2002:aa7:8e87:0:b029:18b:cfd8:261c with SMTP id
 a7-20020aa78e870000b029018bcfd8261cmr4476186pfr.61.1604813173007; 
 Sat, 07 Nov 2020 21:26:13 -0800 (PST)
Received: from localhost.localdomain ([73.93.155.42])
 by smtp.gmail.com with ESMTPSA id hz18sm6994406pjb.13.2020.11.07.21.26.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Nov 2020 21:26:12 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/7] coroutine: add libucontext as external library
Date: Sat,  7 Nov 2020 21:26:02 -0800
Message-Id: <20201108052605.45840-5-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108052605.45840-1-j@getutm.app>
References: <20201108052605.45840-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.180;
 envelope-from=osy86github@gmail.com; helo=mail-pf1-f180.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 00:26:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Joelle van Dyne <j@getutm.app>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

iOS does not support ucontext natively for aarch64 and the sigaltstack is
also unsupported (even worse, it fails silently, see:
https://openradar.appspot.com/13002712 )

As a workaround we include a library implementation of ucontext and add it
as a build option.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure                 | 23 ++++++++++++++++++++---
 meson.build               | 28 +++++++++++++++++++++++++++-
 util/coroutine-ucontext.c |  9 +++++++++
 .gitmodules               |  3 +++
 libucontext               |  1 +
 meson_options.txt         |  2 ++
 6 files changed, 62 insertions(+), 4 deletions(-)
 create mode 160000 libucontext

diff --git a/configure b/configure
index 2a6db88a46..d1c6aa9750 100755
--- a/configure
+++ b/configure
@@ -1750,7 +1750,7 @@ Advanced options (experts only):
   --oss-lib                path to OSS library
   --cpu=CPU                Build for host CPU [$cpu]
   --with-coroutine=BACKEND coroutine backend. Supported options:
-                           ucontext, sigaltstack, windows
+                           ucontext, libucontext, sigaltstack, windows
   --enable-gcov            enable test coverage analysis with gcov
   --disable-blobs          disable installing provided firmware blobs
   --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
@@ -4883,6 +4883,8 @@ if test "$coroutine" = ""; then
     coroutine=win32
   elif test "$ucontext_works" = "yes"; then
     coroutine=ucontext
+  elif test "$ios" = "yes"; then
+    coroutine=libucontext
   else
     coroutine=sigaltstack
   fi
@@ -4906,12 +4908,27 @@ else
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
@@ -6457,7 +6474,7 @@ if test "$rbd" = "yes" ; then
   echo "RBD_LIBS=$rbd_libs" >> $config_host_mak
 fi
 
-echo "CONFIG_COROUTINE_BACKEND=$coroutine" >> $config_host_mak
+echo "CONFIG_COROUTINE_BACKEND=$coroutine_impl" >> $config_host_mak
 if test "$coroutine_pool" = "yes" ; then
   echo "CONFIG_COROUTINE_POOL=1" >> $config_host_mak
 else
@@ -7035,7 +7052,7 @@ NINJA=$ninja $meson setup \
         -Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
         -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
         -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f -Dvirtiofsd=$virtiofsd \
-        -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
+        -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt -Ducontext=$libucontext \
         -Diconv=$iconv -Dcurses=$curses -Dlibudev=$libudev\
         -Ddocs=$docs -Dsphinx_build=$sphinx_build -Dinstall_blobs=$blobs \
         $cross_arg \
diff --git a/meson.build b/meson.build
index 8894171bd1..e62324d5ac 100644
--- a/meson.build
+++ b/meson.build
@@ -1259,9 +1259,34 @@ if not fdt.found() and fdt_required.length() > 0
   error('fdt not available but required by targets ' + ', '.join(fdt_required))
 endif
 
+ucontext = not_found
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
 
 #####################
 # Generated sources #
@@ -1477,7 +1502,7 @@ util_ss.add_all(trace_ss)
 util_ss = util_ss.apply(config_all, strict: false)
 libqemuutil = static_library('qemuutil',
                              sources: util_ss.sources() + stub_ss.sources() + genh,
-                             dependencies: [util_ss.dependencies(), m, glib, socket, malloc])
+                             dependencies: [util_ss.dependencies(), m, glib, socket, malloc, ucontext])
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
@@ -2135,6 +2160,7 @@ if targetos == 'windows'
   summary_info += {'QGA MSI support':   config_host.has_key('CONFIG_QGA_MSI')}
 endif
 summary_info += {'seccomp support':   config_host.has_key('CONFIG_SECCOMP')}
+summary_info += {'libucontext support': ucontext.found()}
 summary_info += {'coroutine backend': config_host['CONFIG_COROUTINE_BACKEND']}
 summary_info += {'coroutine pool':    config_host['CONFIG_COROUTINE_POOL'] == '1'}
 summary_info += {'debug stack usage': config_host.has_key('CONFIG_DEBUG_STACK_USAGE')}
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
diff --git a/.gitmodules b/.gitmodules
index 2bdeeacef8..065b52867f 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -64,3 +64,6 @@
 [submodule "roms/vbootrom"]
 	path = roms/vbootrom
 	url = https://git.qemu.org/git/vbootrom.git
+[submodule "libucontext"]
+	path = libucontext
+	url = https://github.com/utmapp/libucontext.git
diff --git a/libucontext b/libucontext
new file mode 160000
index 0000000000..7094e4c427
--- /dev/null
+++ b/libucontext
@@ -0,0 +1 @@
+Subproject commit 7094e4c42723b6178a4e2b60d4631d8a88f40719
diff --git a/meson_options.txt b/meson_options.txt
index b4f1801875..da24102898 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -64,6 +64,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
 option('virtiofsd', type: 'feature', value: 'auto',
        description: 'build virtiofs daemon (virtiofsd)')
+option('ucontext', type : 'feature', value : 'disabled',
+       description: 'libucontext support')
 
 option('capstone', type: 'combo', value: 'auto',
        choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
-- 
2.28.0


