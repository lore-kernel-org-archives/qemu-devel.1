Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A0CC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 10:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AF72098B
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 10:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVmTeNhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AF72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHOvs-0003hl-Nd
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 06:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kHOtD-0000f3-Sv
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 06:05:43 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:35601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kHOtB-0002F9-QG
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 06:05:43 -0400
Received: by mail-ej1-x62d.google.com with SMTP id u21so19198133eja.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r1N7Ev4rCsSdVnTtJcqJ0WOCgfujEqoUaKWiju4ZvBA=;
 b=aVmTeNhd28RbgODF5B496tbOGt5xmgqFWlm5qbkAeJ5wRgaKrCVbKfDtYrm3DzsFMQ
 HgrFTtl4XxteLE1PhNEw5XsJP6q9+T8wCi/lbNKY+bkDhTDNoTjjP9TkHFNK6Y9FH3x4
 3CfcAV7bno4It+6H8DvgOrAkOewr7kl68nNKwLT4CQi90REDZpSy2nsVUfyfr8lH9gFL
 UTiO/5jzHQm9TMfMqmO9smJYo+PgmFgNh6XxqPs2VyGkBStiZ+hfTk7p0mLdvHBi2ImY
 Qe7UlntJAt4v6mhsu+GGMcMeiGPU5eSzqhcAnlbghQXm0bKvx8c9qvXFKl8CmkWCEDtp
 6Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=r1N7Ev4rCsSdVnTtJcqJ0WOCgfujEqoUaKWiju4ZvBA=;
 b=GZtuaO5Z2lPZzHkykWL88lPXwhpikOvGpIPpz1porwcICbP5HbmiWL80fweQo/7BsN
 Imz8xmO58evf9TxBUO6LeLsUhuY6h59jrdjWyyszoJ4yO1cxVhVNm9eaaF5XcmZUm3x6
 2S2xIXVrCI5dtbNa44mec5LJFkzg6ANX/M68KNm+iFiUFwe2KlrF3etDVkRFkJ0ylh+0
 UXbF9pWy0Vc9S8WxeYYYJpii1ehr5kujtZO/CgNntBR7ceySyaBKYHJJ4dQLPgEsm8ZO
 sm4r+9PGkEJJxsireGTu7A3YLNVyoCTMba57iYZKGlp0iAQ2BcDTJorIfuBYBijD8cC6
 n4NQ==
X-Gm-Message-State: AOAM531E+/Kfr+09SdlcZAEY3NfVGwg2ZcaF4VBSWWgOIo4YlAHosjDx
 pCM0YTDxkBYhkEBjh9ze6L3EL8+n9wo=
X-Google-Smtp-Source: ABdhPJxr8cyZflKOO6j9mftc8D379EHLqmcFSq8mQD4G9ffhagq1hF5MvFkDX8uqcM/ir5StMNTiFQ==
X-Received: by 2002:a17:906:ce3b:: with SMTP id
 sd27mr9650668ejb.433.1599991540007; 
 Sun, 13 Sep 2020 03:05:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:9c8:f845:9041:a5ee])
 by smtp.gmail.com with ESMTPSA id
 g11sm6690286edj.85.2020.09.13.03.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 03:05:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] configure: automatically parse command line for meson -D
 options
Date: Sun, 13 Sep 2020 12:05:34 +0200
Message-Id: <20200913100534.22084-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200913100534.22084-1-pbonzini@redhat.com>
References: <20200913100534.22084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                                |   6 ++
 configure                               |  71 +++++--------
 docs/devel/build-system.rst             |  35 +------
 meson-buildoptions.json                 | 130 ++++++++++++++++++++++++
 scripts/configure-parse-buildoptions.py |  94 +++++++++++++++++
 5 files changed, 258 insertions(+), 78 deletions(-)
 create mode 100644 meson-buildoptions.json
 create mode 100644 scripts/configure-parse-buildoptions.py

diff --git a/Makefile b/Makefile
index d6c5c9fdef..b22e5b272e 100644
--- a/Makefile
+++ b/Makefile
@@ -80,6 +80,12 @@ ifneq ($(MESON),)
 Makefile.mtest: build.ninja scripts/mtest2make.py
 	$(MESON) introspect --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
 -include Makefile.mtest
+
+# jq is used to keep the result stable
+meson-buildoptions.json: meson_options.txt
+	$(MESON) introspect --buildoptions . | \
+	    jq 'map(select(.section == "user")) | sort_by(.name)' \
+	    > $(SRC_PATH)/meson-buildoptions.json
 endif
 
 Makefile: .git-submodule-status
diff --git a/configure b/configure
index b4f5d2e272..54958bfc17 100755
--- a/configure
+++ b/configure
@@ -396,16 +396,10 @@ docs=""
 fdt=""
 netmap="no"
 sdl="auto"
-sdl_image="auto"
 virtfs=""
 mpath=""
-vnc="enabled"
 sparse="no"
 vde=""
-vnc_sasl="auto"
-vnc_jpeg="auto"
-vnc_png="auto"
-xkbcommon="auto"
 xen=""
 xen_ctrl_version=""
 xen_pci_passthrough=""
@@ -466,7 +460,6 @@ trace_file="trace"
 spice=""
 rbd=""
 smartcard=""
-u2f="auto"
 libusb=""
 usb_redir=""
 opengl=""
@@ -539,6 +532,7 @@ rng_none="no"
 secret_keyring=""
 libdaxctl=""
 meson=""
+meson_args=""
 ninja=""
 skip_meson=no
 gettext=""
@@ -1100,10 +1094,6 @@ for opt do
   ;;
   --enable-sdl) sdl="enabled"
   ;;
-  --disable-sdl-image) sdl_image="disabled"
-  ;;
-  --enable-sdl-image) sdl_image="enabled"
-  ;;
   --disable-qom-cast-debug) qom_cast_debug="no"
   ;;
   --enable-qom-cast-debug) qom_cast_debug="yes"
@@ -1116,10 +1106,6 @@ for opt do
   ;;
   --enable-mpath) mpath="yes"
   ;;
-  --disable-vnc) vnc="disabled"
-  ;;
-  --enable-vnc) vnc="enabled"
-  ;;
   --disable-gettext) gettext="false"
   ;;
   --enable-gettext) gettext="true"
@@ -1158,18 +1144,6 @@ for opt do
   ;;
   --disable-strip) strip_opt="no"
   ;;
-  --disable-vnc-sasl) vnc_sasl="disabled"
-  ;;
-  --enable-vnc-sasl) vnc_sasl="enabled"
-  ;;
-  --disable-vnc-jpeg) vnc_jpeg="disabled"
-  ;;
-  --enable-vnc-jpeg) vnc_jpeg="enabled"
-  ;;
-  --disable-vnc-png) vnc_png="disabled"
-  ;;
-  --enable-vnc-png) vnc_png="enabled"
-  ;;
   --disable-slirp) slirp="no"
   ;;
   --enable-slirp=git) slirp="git"
@@ -1369,10 +1343,6 @@ for opt do
   ;;
   --enable-smartcard) smartcard="yes"
   ;;
-  --disable-u2f) u2f="disabled"
-  ;;
-  --enable-u2f) u2f="enabled"
-  ;;
   --disable-libusb) libusb="no"
   ;;
   --enable-libusb) libusb="yes"
@@ -1593,10 +1563,6 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
-  --enable-xkbcommon) xkbcommon="enabled"
-  ;;
-  --disable-xkbcommon) xkbcommon="disabled"
-  ;;
   --enable-plugins) plugins="yes"
   ;;
   --disable-plugins) plugins="no"
@@ -1623,6 +1589,9 @@ for opt do
   ;;
   --disable-libdaxctl) libdaxctl=no
   ;;
+  --enable-* | --disable-*)
+      meson_args="$meson_args $(quote_sh "$opt")"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1648,6 +1617,16 @@ then
     fi
 fi
 
+# Convert unknown --enable/--disable arguments to Meson build options.
+meson_options=$(eval \
+    \$python \
+    \$source_path/scripts/configure-parse-buildoptions.py \
+    \< \$source_path/meson-buildoptions.json $meson_args)
+if test $? = 1; then
+    echo "Try '$0 --help' for more information"
+    exit 1
+fi
+
 firmwarepath="${firmwarepath:-$prefix/share/qemu-firmware}"
 libdir="${libdir:-$prefix/lib}"
 libexecdir="${libexecdir:-$prefix/libexec}"
@@ -1853,10 +1831,14 @@ Advanced options (experts only):
                            enable plugins via shared library loading
   --disable-containers     don't use containers for cross-building
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
-
-Optional features, enabled with --enable-FEATURE and
-disabled with --disable-FEATURE, default is enabled if available:
-
+EOF
+  if test -z "$python"; then
+    echo
+    echo "Python not found. Use --python=/path/to/python to see complete help"
+    exit 0
+  fi
+  $python $source_path/scripts/configure-parse-buildoptions.py --print-help < $source_path/meson-buildoptions.json
+cat << EOF
   system          all system emulation targets
   user            supported user emulation targets
   linux-user      all linux usermode emulation targets
@@ -1883,10 +1865,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   vte             vte support for the gtk UI
   curses          curses UI
   iconv           font glyph conversion support
-  vnc             VNC UI support
-  vnc-sasl        SASL encryption for VNC server
-  vnc-jpeg        JPEG lossy compression for VNC server
-  vnc-png         PNG compression for VNC server
   cocoa           Cocoa UI (Mac OS X only)
   virtfs          VirtFS
   mpath           Multipath persistent reservation passthrough
@@ -1920,7 +1898,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   libiscsi        iscsi support
   libnfs          nfs support
   smartcard       smartcard support (libcacard)
-  u2f             U2F support (u2f-emu)
   libusb          libusb (for usb passthrough)
   live-block-migration   Block migration in the main migration stream
   usb-redir       usb network redirection support
@@ -1962,7 +1939,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
   libpmem         libpmem support
-  xkbcommon       xkbcommon support
   rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
   libdaxctl       libdaxctl support
 
@@ -8008,9 +7984,8 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dsdl=$sdl -Dsdl_image=$sdl_image \
-	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
+	$meson_args \
+	-Dsdl=$sdl -Dgettext=$gettext \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 08e85c69e1..9fd321f227 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -52,12 +52,6 @@ following tasks:
 
  - Add a Meson build option to meson_options.txt.
 
- - Add support to the command line arg parser to handle any new
-   `--enable-XXX`/`--disable-XXX` flags required by the feature.
-
- - Add information to the help output message to report on the new
-   feature flag.
-
  - Add code to perform the actual feature check.
 
  - Add code to include the feature status in `config-host.h`
@@ -66,30 +60,6 @@ following tasks:
    upon completion.
 
 
-Taking the probe for SDL2_Image as an example, we have the following pieces
-in configure::
-
-  # Initial variable state
-  sdl_image=auto
-
-  ..snip..
-
-  # Configure flag processing
-  --disable-sdl-image) sdl_image=disabled
-  ;;
-  --enable-sdl-image) sdl_image=enabled
-  ;;
-
-  ..snip..
-
-  # Help output feature message
-  sdl-image         SDL Image support for icons
-
-  ..snip..
-
-  # Meson invocation
-  -Dsdl_image=$sdl_image
-
 In meson_options.txt::
 
   option('sdl', type : 'feature', value : 'auto',
@@ -108,6 +78,11 @@ In meson.build::
   # Summary
   summary_info += {'SDL image support': sdl_image.found()}
 
+The configure script automatically converts command line options to
+Meson options as long as the `meson-buildoptions.json` file in the
+root source directory is up-to-date.  You can simply type
+`make meson-buildoptions.json` to update it; the `jq` program
+is needed.
 
 
 Helper functions
diff --git a/meson-buildoptions.json b/meson-buildoptions.json
new file mode 100644
index 0000000000..dbaf5bc71e
--- /dev/null
+++ b/meson-buildoptions.json
@@ -0,0 +1,130 @@
+[
+  {
+    "name": "docdir",
+    "value": "doc",
+    "section": "user",
+    "machine": "any",
+    "type": "string",
+    "description": "Base directory for documentation installation (can be empty)"
+  },
+  {
+    "name": "gettext",
+    "value": true,
+    "section": "user",
+    "machine": "any",
+    "type": "boolean",
+    "description": "Localization of the GTK+ user interface"
+  },
+  {
+    "name": "qemu_suffix",
+    "value": "qemu",
+    "section": "user",
+    "machine": "any",
+    "type": "string",
+    "description": "Suffix for QEMU data/modules/config directories (can be empty)"
+  },
+  {
+    "name": "sdl",
+    "value": "auto",
+    "section": "user",
+    "machine": "any",
+    "choices": [
+      "enabled",
+      "disabled",
+      "auto"
+    ],
+    "type": "combo",
+    "description": "SDL user interface"
+  },
+  {
+    "name": "sdl_image",
+    "value": "auto",
+    "section": "user",
+    "machine": "any",
+    "choices": [
+      "enabled",
+      "disabled",
+      "auto"
+    ],
+    "type": "combo",
+    "description": "SDL Image support for icons"
+  },
+  {
+    "name": "u2f",
+    "value": "auto",
+    "section": "user",
+    "machine": "any",
+    "choices": [
+      "enabled",
+      "disabled",
+      "auto"
+    ],
+    "type": "combo",
+    "description": "U2F emulation support"
+  },
+  {
+    "name": "vnc",
+    "value": "enabled",
+    "section": "user",
+    "machine": "any",
+    "choices": [
+      "enabled",
+      "disabled",
+      "auto"
+    ],
+    "type": "combo",
+    "description": "VNC server"
+  },
+  {
+    "name": "vnc_jpeg",
+    "value": "auto",
+    "section": "user",
+    "machine": "any",
+    "choices": [
+      "enabled",
+      "disabled",
+      "auto"
+    ],
+    "type": "combo",
+    "description": "JPEG lossy compression for VNC server"
+  },
+  {
+    "name": "vnc_png",
+    "value": "auto",
+    "section": "user",
+    "machine": "any",
+    "choices": [
+      "enabled",
+      "disabled",
+      "auto"
+    ],
+    "type": "combo",
+    "description": "PNG compression for VNC server"
+  },
+  {
+    "name": "vnc_sasl",
+    "value": "auto",
+    "section": "user",
+    "machine": "any",
+    "choices": [
+      "enabled",
+      "disabled",
+      "auto"
+    ],
+    "type": "combo",
+    "description": "SASL authentication for VNC server"
+  },
+  {
+    "name": "xkbcommon",
+    "value": "auto",
+    "section": "user",
+    "machine": "any",
+    "choices": [
+      "enabled",
+      "disabled",
+      "auto"
+    ],
+    "type": "combo",
+    "description": "xkbcommon support"
+  }
+]
diff --git a/scripts/configure-parse-buildoptions.py b/scripts/configure-parse-buildoptions.py
new file mode 100644
index 0000000000..4171312d75
--- /dev/null
+++ b/scripts/configure-parse-buildoptions.py
@@ -0,0 +1,94 @@
+#! /usr/bin/env python3
+
+# Parse configure command line options based on Meson's user build options
+# introspection data (passed on stdin).
+#
+# Copyright (C) 2020 Red Hat, Inc.
+#
+# Author: Paolo Bonzini <pbonzini@redhat.com>
+
+import json
+import re
+import shlex
+import sys
+import textwrap
+
+SKIP_OPTIONS = [ 'docdir', 'qemu_suffix' ]
+FEATURE_CHOICES = [ 'auto', 'disabled', 'enabled' ]
+
+options = { x['name']: x
+            for x in json.load(sys.stdin)
+            if x['section'] == 'user' and x['name'] not in SKIP_OPTIONS }
+
+for x in options.values():
+    if x['type'] == 'combo' and sorted(x['choices']) == FEATURE_CHOICES:
+        x['type'] = 'feature'
+
+def value_to_help(x):
+    if x == True:
+        return 'enabled'
+    if x == False:
+        return 'disabled'
+    return str(x)
+
+def print_help_line(key, opt, indent):
+    key = '  ' + key
+    value = '%s [%s]' % (opt['description'], value_to_help(opt['value']))
+    if len(key) >= indent:
+        print(key)
+        key = ''
+    spaces = ' ' * indent
+    key = (key + spaces)[0:indent]
+    print(textwrap.fill(value, initial_indent=key, subsequent_indent=spaces))
+
+def print_help():
+    for o, x in options.items():
+        if x['type'] not in ('boolean', 'feature'):
+            print_help_line('--enable-' + o, x, 24)
+
+    print()
+    print('Optional features, enabled with --enable-FEATURE and')
+    print('disabled with --disable-FEATURE:')
+    for o, x in options.items():
+        if x['type'] in ('boolean', 'feature'):
+            print_help_line(o, x, 18)
+
+def error(s, *args):
+    print('ERROR:', s % args, file=sys.stderr)
+    sys.exit(1)
+
+def main(argv):
+    if not argv:
+        return
+
+    if argv[0] == '--print-help':
+        print_help()
+        return
+
+    args = []
+    for arg in sys.argv[1:]:
+        m = re.search('--(enable|disable)-([^=]*)(?:=(.*))?', arg)
+        if not m:
+            error('internal error parsing command line')
+        opt = m.group(2).replace('-', '_')
+        if opt not in options:
+            error('Unknown option --%s-%s', m.group(1), m.group(2))
+        opt_type = options[opt]['type']
+        if opt_type in ('boolean', 'feature'):
+            if m.group(3) is not None:
+                error('option --%s-%s does not take an argument', m.group(1), m.group(2))
+            if opt_type == 'feature':
+                value = m.group(1) + 'd'
+            else:
+                value = 'true' if m.group(1) == 'enable' else 'false'
+        else:
+            if m.group(1) == 'disable':
+                error('Unknown option --disable-%s', m.group(2))
+            if m.group(3) is None:
+                error('option --enable-%s takes an argument', m.group(2))
+
+        args.append(shlex.quote('-D%s=%s' % (opt, value)))
+    print(' '.join(args))
+
+if __name__ == "__main__":
+    main(sys.argv[1:])
-- 
2.26.2


