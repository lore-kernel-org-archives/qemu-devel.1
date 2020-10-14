Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A88520BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTTa0t1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A88520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSc4Y-0001qm-Ck
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSc2v-0008VI-79
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSc2p-0007b1-W1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602663718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfR4xE5HUEPlenjSLENKIoyeONC3PaofoybMBPE8qtY=;
 b=QTTa0t1TooiHL5BWKirhGlVKG3w1dFAVPKR7UKlbOTpq0yo356WIk4YRrvUkGf4MWJJQ36
 ORwRBxIhgCXNaeQK966P51ZTP/fEIUzS8jZEHiyb9lzYAxPq5ZayTJsK/CBYezyVTOT9Vw
 ntL8m2ytCB1rB9nFrbu04zoZsRx7V/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-_jeFF_8JN7Oew-xbpD_4MA-1; Wed, 14 Oct 2020 04:21:56 -0400
X-MC-Unique: _jeFF_8JN7Oew-xbpD_4MA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F78D56BFA;
 Wed, 14 Oct 2020 08:21:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09E7E5578D;
 Wed, 14 Oct 2020 08:21:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3C4EC43BFBA; Wed, 14 Oct 2020 10:21:50 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] configure: Fixes ncursesw detection under msys2/mingw by
 convert them to meson
Date: Wed, 14 Oct 2020 10:21:45 +0200
Message-Id: <20201014082149.26853-6-kraxel@redhat.com>
In-Reply-To: <20201014082149.26853-1-kraxel@redhat.com>
References: <20201014082149.26853-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

The mingw pkg-config are showing following absolute path and contains : as the separator,

-D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC:/CI-Tools/msys64/mingw64/include/ncursesw:-I/usr/include/ncursesw:
-DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -pipe -lncursesw -lgnurx -ltre -lintl -liconv
-DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -lncursesw
-DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -lcursesw
-DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
-DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lncursesw
-DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lcursesw
-DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
-DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw
-DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20201012234348.1427-6-luoyonggang@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure         | 118 +++-------------------------------------------
 meson_options.txt |   4 ++
 meson.build       |  83 +++++++++++++++++++++++++++-----
 ui/meson.build    |   2 +-
 4 files changed, 83 insertions(+), 124 deletions(-)

diff --git a/configure b/configure
index 9a87685517ee..f839c2a557c3 100755
--- a/configure
+++ b/configure
@@ -295,7 +295,8 @@ unset target_list_exclude
 
 brlapi=""
 curl=""
-curses=""
+iconv="auto"
+curses="auto"
 docs=""
 fdt="auto"
 netmap="no"
@@ -1173,13 +1174,13 @@ for opt do
   ;;
   --disable-safe-stack) safe_stack="no"
   ;;
-  --disable-curses) curses="no"
+  --disable-curses) curses="disabled"
   ;;
-  --enable-curses) curses="yes"
+  --enable-curses) curses="enabled"
   ;;
-  --disable-iconv) iconv="no"
+  --disable-iconv) iconv="disabled"
   ;;
-  --enable-iconv) iconv="yes"
+  --enable-iconv) iconv="enabled"
   ;;
   --disable-curl) curl="no"
   ;;
@@ -3440,102 +3441,6 @@ EOF
   fi
 fi
 
-##########################################
-# iconv probe
-if test "$iconv" != "no" ; then
-  cat > $TMPC << EOF
-#include <iconv.h>
-int main(void) {
-  iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
-  return conv != (iconv_t) -1;
-}
-EOF
-  iconv_prefix_list="/usr/local:/usr"
-  iconv_lib_list=":-liconv"
-  IFS=:
-  for iconv_prefix in $iconv_prefix_list; do
-    IFS=:
-    iconv_cflags="-I$iconv_prefix/include"
-    iconv_ldflags="-L$iconv_prefix/lib"
-    for iconv_link in $iconv_lib_list; do
-      unset IFS
-      iconv_lib="$iconv_ldflags $iconv_link"
-      echo "looking at iconv in '$iconv_cflags' '$iconv_lib'" >> config.log
-      if compile_prog "$iconv_cflags" "$iconv_lib" ; then
-        iconv_found=yes
-        break
-      fi
-    done
-    if test "$iconv_found" = yes ; then
-      break
-    fi
-  done
-  if test "$iconv_found" = "yes" ; then
-    iconv=yes
-  else
-    if test "$iconv" = "yes" ; then
-      feature_not_found "iconv" "Install iconv devel"
-    fi
-    iconv=no
-  fi
-fi
-
-##########################################
-# curses probe
-if test "$iconv" = "no" ; then
-  # curses will need iconv
-  curses=no
-fi
-if test "$curses" != "no" ; then
-  if test "$mingw32" = "yes" ; then
-    curses_inc_list="$($pkg_config --cflags ncurses 2>/dev/null):"
-    curses_lib_list="$($pkg_config --libs ncurses 2>/dev/null):-lpdcurses"
-  else
-    curses_inc_list="$($pkg_config --cflags ncursesw 2>/dev/null):-I/usr/include/ncursesw:"
-    curses_lib_list="$($pkg_config --libs ncursesw 2>/dev/null):-lncursesw:-lcursesw"
-  fi
-  curses_found=no
-  cat > $TMPC << EOF
-#include <locale.h>
-#include <curses.h>
-#include <wchar.h>
-int main(void) {
-  wchar_t wch = L'w';
-  setlocale(LC_ALL, "");
-  resize_term(0, 0);
-  addwstr(L"wide chars\n");
-  addnwstr(&wch, 1);
-  add_wch(WACS_DEGREE);
-  return 0;
-}
-EOF
-  IFS=:
-  for curses_inc in $curses_inc_list; do
-    # Make sure we get the wide character prototypes
-    curses_inc="-DNCURSES_WIDECHAR $curses_inc"
-    IFS=:
-    for curses_lib in $curses_lib_list; do
-      unset IFS
-      if compile_prog "$curses_inc" "$curses_lib" ; then
-        curses_found=yes
-        break
-      fi
-    done
-    if test "$curses_found" = yes ; then
-      break
-    fi
-  done
-  unset IFS
-  if test "$curses_found" = "yes" ; then
-    curses=yes
-  else
-    if test "$curses" = "yes" ; then
-      feature_not_found "curses" "Install ncurses devel"
-    fi
-    curses=no
-  fi
-fi
-
 ##########################################
 # curl probe
 if test "$curl" != "no" ; then
@@ -6200,16 +6105,6 @@ if test "$have_x11" = "yes" && test "$need_x11" = "yes"; then
   echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
   echo "X11_LIBS=$x11_libs" >> $config_host_mak
 fi
-if test "$iconv" = "yes" ; then
-  echo "CONFIG_ICONV=y" >> $config_host_mak
-  echo "ICONV_CFLAGS=$iconv_cflags" >> $config_host_mak
-  echo "ICONV_LIBS=$iconv_lib" >> $config_host_mak
-fi
-if test "$curses" = "yes" ; then
-  echo "CONFIG_CURSES=y" >> $config_host_mak
-  echo "CURSES_CFLAGS=$curses_inc" >> $config_host_mak
-  echo "CURSES_LIBS=$curses_lib" >> $config_host_mak
-fi
 if test "$pipe2" = "yes" ; then
   echo "CONFIG_PIPE2=y" >> $config_host_mak
 fi
@@ -7181,6 +7076,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
         -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
         -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
+        -Diconv=$iconv -Dcurses=$curses \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson_options.txt b/meson_options.txt
index 1d3c94840a90..e6cb1e589b4e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -32,6 +32,10 @@ option('cocoa', type : 'feature', value : 'auto',
        description: 'Cocoa user interface (macOS only)')
 option('mpath', type : 'feature', value : 'auto',
        description: 'Multipath persistent reservation passthrough')
+option('iconv', type : 'feature', value : 'auto',
+       description: 'Font glyph conversion support')
+option('curses', type : 'feature', value : 'auto',
+       description: 'curses UI')
 option('sdl', type : 'feature', value : 'auto',
        description: 'SDL user interface')
 option('sdl_image', type : 'feature', value : 'auto',
diff --git a/meson.build b/meson.build
index ad6c7c90c787..1a4a48249243 100644
--- a/meson.build
+++ b/meson.build
@@ -426,6 +426,74 @@ if targetos == 'linux' and have_tools and not get_option('mpath').disabled()
   endif
 endif
 
+iconv = not_found
+if not get_option('iconv').disabled()
+  libiconv = cc.find_library('iconv',
+                             required: false,
+                             static: enable_static)
+  if libiconv.found()
+    if cc.links('''
+      #include <iconv.h>
+      int main(void) {
+        iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
+        return conv != (iconv_t) -1;
+      }''', dependencies: [libiconv])
+      iconv = declare_dependency(dependencies: [libiconv])
+    endif
+  endif
+endif
+if get_option('iconv').enabled() and not iconv.found()
+  error('Cannot detect iconv API')
+endif
+
+curses = not_found
+if iconv.found() and not get_option('curses').disabled()
+  curses_libname_list = ['ncursesw', 'ncurses', 'cursesw', 'pdcurses']
+  curses_test = '''
+    #include <locale.h>
+    #include <curses.h>
+    #include <wchar.h>
+    int main(void) {
+      wchar_t wch = L'w';
+      setlocale(LC_ALL, "");
+      resize_term(0, 0);
+      addwstr(L"wide chars\n");
+      addnwstr(&wch, 1);
+      add_wch(WACS_DEGREE);
+      return 0;
+    }'''
+  foreach curses_libname : curses_libname_list
+      libcurses = dependency(curses_libname,
+                             required: false,
+                             method: 'pkg-config',
+                             static: enable_static)
+
+      if not libcurses.found()
+        dirs = ['/usr/include/ncursesw']
+        if targetos == 'windows'
+          dirs = []
+        endif
+        libcurses = cc.find_library(curses_libname,
+                                    required: false,
+                                    dirs: dirs,
+                                    static: enable_static)
+      endif
+      if libcurses.found()
+        if cc.links(curses_test, dependencies: [libcurses])
+          curses = declare_dependency(compile_args: '-DNCURSES_WIDECHAR', dependencies: [libcurses])
+          break
+        endif
+      endif
+  endforeach
+endif
+if get_option('curses').enabled() and not curses.found()
+  if not iconv.found()
+    error('Cannot detect iconv API')
+  else
+    error('Cannot detect curses API')
+  endif
+endif
+
 brlapi = not_found
 if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
@@ -504,16 +572,6 @@ if 'CONFIG_X11' in config_host
   x11 = declare_dependency(compile_args: config_host['X11_CFLAGS'].split(),
                            link_args: config_host['X11_LIBS'].split())
 endif
-curses = not_found
-if 'CONFIG_CURSES' in config_host
-  curses = declare_dependency(compile_args: config_host['CURSES_CFLAGS'].split(),
-                              link_args: config_host['CURSES_LIBS'].split())
-endif
-iconv = not_found
-if 'CONFIG_ICONV' in config_host
-  iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
-                             link_args: config_host['ICONV_LIBS'].split())
-endif
 vnc = not_found
 png = not_found
 jpeg = not_found
@@ -622,6 +680,7 @@ config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
+config_host_data.set('CONFIG_CURSES', curses.found())
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
@@ -1905,8 +1964,8 @@ if config_host.has_key('CONFIG_NETTLE')
 endif
 summary_info += {'libtasn1':          config_host.has_key('CONFIG_TASN1')}
 summary_info += {'PAM':               config_host.has_key('CONFIG_AUTH_PAM')}
-summary_info += {'iconv support':     config_host.has_key('CONFIG_ICONV')}
-summary_info += {'curses support':    config_host.has_key('CONFIG_CURSES')}
+summary_info += {'iconv support':     iconv.found()}
+summary_info += {'curses support':    curses.found()}
 # TODO: add back version
 summary_info += {'virgl support':     config_host.has_key('CONFIG_VIRGL')}
 summary_info += {'curl support':      config_host.has_key('CONFIG_CURL')}
diff --git a/ui/meson.build b/ui/meson.build
index 8a080c38e325..78ad792ffb8d 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -39,7 +39,7 @@ specific_ss.add(when: ['CONFIG_SOFTMMU'], if_true: opengl)
 
 ui_modules = {}
 
-if config_host.has_key('CONFIG_CURSES')
+if curses.found()
   curses_ss = ss.source_set()
   curses_ss.add(when: [curses, iconv], if_true: [files('curses.c'), pixman])
   ui_modules += {'curses' : curses_ss}
-- 
2.27.0


