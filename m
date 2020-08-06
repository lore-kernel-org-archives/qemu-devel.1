Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138A22177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hid0Un/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138A22177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mLB-0000rQ-0s
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRP-0003Oy-Q8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRN-00071u-29
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=faNFfKXV4b8sg+ezVolPT9FPVgg+xhrG9FLJdDCewVs=;
 b=Hid0Un/a16st/FB5UjJhoJu7m0+26lb9Rto3heMbJtTKna+5McozBvhDb+Mjcbhe0Vkr7r
 fxwlimAEXf7Ht8LbWYWg0OS0eb5sfIsOTLyYE2Tmz4668X6zQ0JjVJIB2PT1q+pSstDUk0
 eV30h6zwcnjTIqCtPJkpRrlc3sRalkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-YQ-SBg6nNm-Q58JnT9bU9w-1; Thu, 06 Aug 2020 15:20:34 -0400
X-MC-Unique: YQ-SBg6nNm-Q58JnT9bU9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90DB8107BEF7
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:33 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D97341D3
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 140/143] meson: move SDL and SDL-image detection to meson
Date: Thu,  6 Aug 2020 21:16:16 +0200
Message-Id: <1596741379-12902-141-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
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
 chardev/meson.build |   2 +-
 configure           | 142 +++-------------------------------------------------
 meson.build         |  24 ++++++---
 meson_options.txt   |   2 +
 ui/meson.build      |   4 +-
 5 files changed, 30 insertions(+), 144 deletions(-)
 create mode 100644 meson_options.txt

diff --git a/chardev/meson.build b/chardev/meson.build
index 2122505..a0aaafa 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -36,7 +36,7 @@ softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
 
 chardev_modules = []
 
-if config_host.has_key('CONFIG_BRLAPI') and config_host.has_key('CONFIG_SDL')
+if config_host.has_key('CONFIG_BRLAPI') and sdl.found()
   chardev_modules += [['baum', files('baum.c'), [sdl, brlapi]]]
 endif
 
diff --git a/configure b/configure
index a0b51d0..288a75f 100755
--- a/configure
+++ b/configure
@@ -377,8 +377,8 @@ curses=""
 docs=""
 fdt=""
 netmap="no"
-sdl=""
-sdl_image=""
+sdl="auto"
+sdl_image="auto"
 virtfs=""
 mpath=""
 vnc="yes"
@@ -1092,13 +1092,13 @@ for opt do
     # configure to be used by RPM and similar macros that set
     # lots of directory switches by default.
   ;;
-  --disable-sdl) sdl="no"
+  --disable-sdl) sdl="disabled"
   ;;
-  --enable-sdl) sdl="yes"
+  --enable-sdl) sdl="enabled"
   ;;
-  --disable-sdl-image) sdl_image="no"
+  --disable-sdl-image) sdl_image="disabled"
   ;;
-  --enable-sdl-image) sdl_image="yes"
+  --enable-sdl-image) sdl_image="enabled"
   ;;
   --disable-qom-cast-debug) qom_cast_debug="no"
   ;;
@@ -2368,7 +2368,7 @@ if test "$cocoa" = "yes"; then
         error_exit "Cocoa and GTK UIs cannot both be enabled at once"
     fi
     gtk=no
-    sdl=no
+    sdl=disabled
 fi
 
 # Some versions of Mac OS X incorrectly define SIZE_MAX
@@ -3274,125 +3274,6 @@ if test "$vte" != "no"; then
 fi
 
 ##########################################
-# SDL probe
-
-# Look for sdl configuration program (pkg-config or sdl2-config).  Try
-# sdl2-config even without cross prefix, and favour pkg-config over sdl2-config.
-
-sdl_probe ()
-{
-  if $pkg_config sdl2 --exists; then
-    sdlconfig="$pkg_config sdl2"
-    sdlversion=$($sdlconfig --modversion 2>/dev/null)
-  elif has "$sdl2_config"; then
-    sdlconfig="$sdl2_config"
-    sdlversion=$($sdlconfig --version)
-  else
-    if test "$sdl" = "yes" ; then
-      feature_not_found "sdl" "Install SDL2-devel"
-    fi
-    sdl=no
-    # no need to do the rest
-    return
-  fi
-  if test -n "$cross_prefix" && test "$(basename "$sdlconfig")" = sdl2-config; then
-    echo warning: using "\"$sdlconfig\"" to detect cross-compiled sdl >&2
-  fi
-
-  cat > $TMPC << EOF
-#include <SDL.h>
-#undef main /* We don't want SDL to override our main() */
-int main( void ) { return SDL_Init (SDL_INIT_VIDEO); }
-EOF
-  sdl_cflags=$($sdlconfig --cflags 2>/dev/null)
-  sdl_cflags="$sdl_cflags -Wno-undef"  # workaround 2.0.8 bug
-  if test "$static" = "yes" ; then
-    if $pkg_config sdl2 --exists; then
-      sdl_libs=$($pkg_config sdl2 --static --libs 2>/dev/null)
-    else
-      sdl_libs=$($sdlconfig --static-libs 2>/dev/null)
-    fi
-  else
-    sdl_libs=$($sdlconfig --libs 2>/dev/null)
-  fi
-  if compile_prog "$sdl_cflags" "$sdl_libs" ; then
-    sdl=yes
-
-    # static link with sdl ? (note: sdl.pc's --static --libs is broken)
-    if test "$sdl" = "yes" && test "$static" = "yes" ; then
-      if test $? = 0 && echo $sdl_libs | grep -- -laa > /dev/null; then
-         sdl_libs="$sdl_libs $(aalib-config --static-libs 2>/dev/null)"
-         sdl_cflags="$sdl_cflags $(aalib-config --cflags 2>/dev/null)"
-      fi
-      if compile_prog "$sdl_cflags" "$sdl_libs" ; then
-	:
-      else
-        sdl=no
-      fi
-    fi # static link
-  else # sdl not found
-    if test "$sdl" = "yes" ; then
-      feature_not_found "sdl" "Install SDL2 devel"
-    fi
-    sdl=no
-  fi # sdl compile test
-}
-
-sdl_image_probe ()
-{
-    if test "$sdl_image" != "no" ; then
-        if $pkg_config SDL2_image --exists; then
-            if test "$static" = "yes"; then
-                sdl_image_libs=$($pkg_config SDL2_image --libs --static 2>/dev/null)
-            else
-                sdl_image_libs=$($pkg_config SDL2_image --libs 2>/dev/null)
-            fi
-            sdl_image_cflags=$($pkg_config SDL2_image --cflags 2>/dev/null)
-            sdl_image=yes
-
-            sdl_cflags="$sdl_cflags $sdl_image_cflags"
-            sdl_libs="$sdl_libs $sdl_image_libs"
-        else
-            if test "$sdl_image" = "yes" ; then
-                feature_not_found "sdl_image" "Install SDL Image devel"
-            else
-                sdl_image=no
-            fi
-        fi
-    fi
-}
-
-if test "$sdl" != "no" ; then
-  sdl_probe
-fi
-
-if test "$sdl" = "yes" ; then
-  sdl_image_probe
-else
-  if test "$sdl_image" = "yes"; then
-    echo "warning: SDL Image requested, but SDL is not available, disabling"
-  fi
-  sdl_image=no
-fi
-
-if test "$sdl" = "yes" ; then
-  cat > $TMPC <<EOF
-#include <SDL.h>
-#if defined(SDL_VIDEO_DRIVER_X11)
-#include <X11/XKBlib.h>
-#else
-#error No x11 support
-#endif
-int main(void) { return 0; }
-EOF
-  if compile_prog "$sdl_cflags $x11_cflags" "$sdl_libs $x11_libs" ; then
-    need_x11=yes
-    sdl_cflags="$sdl_cflags $x11_cflags"
-    sdl_libs="$sdl_libs $x11_libs"
-  fi
-fi
-
-##########################################
 # RDMA needs OpenFabrics libraries
 if test "$rdma" != "no" ; then
   cat > $TMPC <<EOF
@@ -7000,14 +6881,6 @@ if test "$have_x11" = "yes" && test "$need_x11" = "yes"; then
   echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
   echo "X11_LIBS=$x11_libs" >> $config_host_mak
 fi
-if test "$sdl" = "yes" ; then
-  echo "CONFIG_SDL=m" >> $config_host_mak
-  echo "SDL_CFLAGS=$sdl_cflags" >> $config_host_mak
-  echo "SDL_LIBS=$sdl_libs" >> $config_host_mak
-  if test "$sdl_image" = "yes" ; then
-      echo "CONFIG_SDL_IMAGE=y" >> $config_host_mak
-  fi
-fi
 if test "$cocoa" = "yes" ; then
   echo "CONFIG_COCOA=y" >> $config_host_mak
 fi
@@ -8424,6 +8297,7 @@ NINJA=$PWD/ninjatool $python $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
+	-Dsdl=$sdl -Dsdl_image=$sdl_image \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index cb2ffd6..8bb0c69 100644
--- a/meson.build
+++ b/meson.build
@@ -201,13 +201,21 @@ brlapi = not_found
 if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
 endif
+
+sdl = dependency('sdl2', method: 'config-tool', required: get_option('sdl'))
+sdl_image = not_found
 sdlwindows = false
-sdl = not_found
-if 'CONFIG_SDL' in config_host
-  sdl = declare_dependency(compile_args: config_host['SDL_CFLAGS'].split(),
-                           link_args: config_host['SDL_LIBS'].split())
-  sdlwindows = config_host['SDL_LIBS'].contains('-mwindows')
+if sdl.found()
+  sdlwindows = sdl.get_configtool_variable('libs').split().contains('-mwindows')
+  sdl_image = dependency('sdl-image', required: get_option('sdl_image'))
+else
+  if get_option('sdl_image').enabled()
+    error('sdl-image required, but SDL was @0@',
+          get_option('sdl').disabled() ? 'disabled' : 'not found')
+  endif
+  sdl_image = not_found
 endif
+
 rbd = not_found
 if 'CONFIG_RBD' in config_host
   rbd = declare_dependency(link_args: config_host['RBD_LIBS'].split())
@@ -346,6 +354,8 @@ endif
 
 # Create config-host.h
 
+config_host_data.set('CONFIG_SDL', sdl.found())
+config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
@@ -1219,8 +1229,8 @@ if targetos == 'darwin'
   summary_info += {'Cocoa support': config_host.has_key('CONFIG_COCOA')}
 endif
 # TODO: add back version
-summary_info += {'SDL support':       config_host.has_key('CONFIG_SDL')}
-summary_info += {'SDL image support': config_host.has_key('CONFIG_SDL_IMAGE')}
+summary_info += {'SDL support':       sdl.found()}
+summary_info += {'SDL image support': sdl_image.found()}
 # TODO: add back version
 summary_info += {'GTK support':       config_host.has_key('CONFIG_GTK')}
 summary_info += {'GTK GL support':    config_host.has_key('CONFIG_GTK_GL')}
diff --git a/meson_options.txt b/meson_options.txt
new file mode 100644
index 0000000..e548211
--- /dev/null
+++ b/meson_options.txt
@@ -0,0 +1,2 @@
+option('sdl', type : 'feature', value : 'auto')
+option('sdl_image', type : 'feature', value : 'auto')
diff --git a/ui/meson.build b/ui/meson.build
index 36a70c3..2822ad9 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -54,11 +54,11 @@ if config_host.has_key('CONFIG_GTK') and config_host.has_key('CONFIG_VTE')
   ui_modules += [['gtk', gtk_ss.sources(), gtk_ss.dependencies()]]
 endif
 
-if config_host.has_key('CONFIG_SDL')
+if sdl.found()
   softmmu_ss.add(when: 'CONFIG_WIN32', if_true: files('win32-kbd-hook.c'))
 
   sdl_ss = ss.source_set()
-  sdl_ss.add(pixman, glib, files(
+  sdl_ss.add(sdl, sdl_image, pixman, glib, files(
     'sdl2-2d.c',
     'sdl2-input.c',
     'sdl2.c',
-- 
1.8.3.1



