Received: from eggs.gnu.org ([2001:4830:134:3::10]:36185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fnM2F-0006BN-9Z
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 06:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fnM2A-00027b-I3
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 06:49:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fnM2A-00027T-92
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 06:49:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDEF0402315B
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 10:49:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  8 Aug 2018 11:49:30 +0100
Message-Id: <20180808104930.23133-4-berrange@redhat.com>
In-Reply-To: <20180808104930.23133-1-berrange@redhat.com>
References: <20180808104930.23133-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] ui: remove support for SDL1.2 in favour of
 SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

SDL1.2 was deprecated in the 2.12.0 release with:

  commit e52c6ba34149b4f39c3fd60e59ee32b809db2bfa
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Mon Jan 15 14:25:33 2018 +0000

    ui: deprecate use of SDL 1.2 in favour of 2.0 series

    The SDL 2.0 release was made in Aug, 2013:

      https://www.libsdl.org/release/

    That will soon be 4 + 1/2 years ago, which is enough time to consider
    the 2.0 series widely supported.

    Thus we deprecate the SDL 1.2 support, which will allow us to delete =
it
    in the last release of 2018. By this time, SDL 2.0 will be more than =
5
    years old.

    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Message-id: 20180115142533.24585-1-berrange@redhat.com
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

It is thus able to be removed in the 3.1.0 release.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure              |   60 +--
 qemu-deprecated.texi   |    9 -
 ui/Makefile.objs       |    5 -
 ui/sdl.c               | 1027 ----------------------------------------
 ui/sdl_zoom.c          |   93 ----
 ui/sdl_zoom.h          |   25 -
 ui/sdl_zoom_template.h |  219 ---------
 7 files changed, 7 insertions(+), 1431 deletions(-)
 delete mode 100644 ui/sdl.c
 delete mode 100644 ui/sdl_zoom.c
 delete mode 100644 ui/sdl_zoom.h
 delete mode 100644 ui/sdl_zoom_template.h

diff --git a/configure b/configure
index 3510036e06..d4760c5478 100755
--- a/configure
+++ b/configure
@@ -344,7 +344,6 @@ docs=3D""
 fdt=3D""
 netmap=3D"no"
 sdl=3D""
-sdlabi=3D""
 virtfs=3D""
 mpath=3D""
 vnc=3D"yes"
@@ -563,7 +562,6 @@ query_pkg_config() {
     "${pkg_config_exe}" ${QEMU_PKG_CONFIG_FLAGS} "$@"
 }
 pkg_config=3Dquery_pkg_config
-sdl_config=3D"${SDL_CONFIG-${cross_prefix}sdl-config}"
 sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
=20
 # If the user hasn't specified ARFLAGS, default to 'rv', just as make do=
es.
@@ -1026,8 +1024,6 @@ for opt do
   ;;
   --enable-sdl) sdl=3D"yes"
   ;;
-  --with-sdlabi=3D*) sdlabi=3D"$optarg"
-  ;;
   --disable-qom-cast-debug) qom_cast_debug=3D"no"
   ;;
   --enable-qom-cast-debug) qom_cast_debug=3D"yes"
@@ -1643,7 +1639,6 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   nettle          nettle cryptography support
   gcrypt          libgcrypt cryptography support
   sdl             SDL UI
-  --with-sdlabi     select preferred SDL ABI 1.2 or 2.0
   gtk             gtk UI
   vte             vte support for the gtk UI
   curses          curses UI
@@ -2904,37 +2899,11 @@ fi
=20
 sdl_probe ()
 {
-  sdl_too_old=3Dno
-  if test "$sdlabi" =3D ""; then
-      if $pkg_config --exists "sdl2"; then
-          sdlabi=3D2.0
-      elif $pkg_config --exists "sdl"; then
-          sdlabi=3D1.2
-      else
-          sdlabi=3D2.0
-      fi
-  fi
-
-  if test $sdlabi =3D "2.0"; then
-      sdl_config=3D$sdl2_config
-      sdlname=3Dsdl2
-      sdlconfigname=3Dsdl2_config
-  elif test $sdlabi =3D "1.2"; then
-      sdlname=3Dsdl
-      sdlconfigname=3Dsdl_config
-  else
-      error_exit "Unknown sdlabi $sdlabi, must be 1.2 or 2.0"
-  fi
-
-  if test "$(basename $sdl_config)" !=3D $sdlconfigname && ! has ${sdl_c=
onfig}; then
-    sdl_config=3D$sdlconfigname
-  fi
-
-  if $pkg_config $sdlname --exists; then
-    sdlconfig=3D"$pkg_config $sdlname"
+  if $pkg_config sdl2 --exists; then
+    sdlconfig=3D"$pkg_config sdl2"
     sdlversion=3D$($sdlconfig --modversion 2>/dev/null)
   elif has ${sdl_config}; then
-    sdlconfig=3D"$sdl_config"
+    sdlconfig=3D"$sdl2_config"
     sdlversion=3D$($sdlconfig --version)
   else
     if test "$sdl" =3D "yes" ; then
@@ -2956,8 +2925,8 @@ EOF
   sdl_cflags=3D$($sdlconfig --cflags 2>/dev/null)
   sdl_cflags=3D"$sdl_cflags -Wno-undef"  # workaround 2.0.8 bug
   if test "$static" =3D "yes" ; then
-    if $pkg_config $sdlname --exists; then
-      sdl_libs=3D$($pkg_config $sdlname --static --libs 2>/dev/null)
+    if $pkg_config sdl2 --exists; then
+      sdl_libs=3D$($pkg_config sdl2 --static --libs 2>/dev/null)
     else
       sdl_libs=3D$($sdlconfig --static-libs 2>/dev/null)
     fi
@@ -2965,11 +2934,7 @@ EOF
     sdl_libs=3D$($sdlconfig --libs 2>/dev/null)
   fi
   if compile_prog "$sdl_cflags" "$sdl_libs" ; then
-    if test $(echo $sdlversion | sed 's/[^0-9]//g') -lt 121 ; then
-      sdl_too_old=3Dyes
-    else
-      sdl=3Dyes
-    fi
+    sdl=3Dyes
=20
     # static link with sdl ? (note: sdl.pc's --static --libs is broken)
     if test "$sdl" =3D "yes" -a "$static" =3D "yes" ; then
@@ -2985,7 +2950,7 @@ EOF
     fi # static link
   else # sdl not found
     if test "$sdl" =3D "yes" ; then
-      feature_not_found "sdl" "Install SDL devel"
+      feature_not_found "sdl" "Install SDL2 devel"
     fi
     sdl=3Dno
   fi # sdl compile test
@@ -5983,16 +5948,6 @@ echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
 echo "docker            $docker"
=20
-if test "$sdl_too_old" =3D "yes"; then
-echo "-> Your SDL version is too old - please upgrade to have SDL suppor=
t"
-fi
-
-if test "$sdlabi" =3D "1.2"; then
-    echo
-    echo "WARNING: Use of SDL 1.2 is deprecated and will be removed in"
-    echo "WARNING: future releases. Please switch to using SDL 2.0"
-fi
-
 if test "$supported_cpu" =3D "no"; then
     echo
     echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELE=
ASES!"
@@ -6195,7 +6150,6 @@ if test "$have_x11" =3D "yes" -a "$need_x11" =3D "y=
es"; then
 fi
 if test "$sdl" =3D "yes" ; then
   echo "CONFIG_SDL=3Dm" >> $config_host_mak
-  echo "CONFIG_SDLABI=3D$sdlabi" >> $config_host_mak
   echo "SDL_CFLAGS=3D$sdl_cflags" >> $config_host_mak
   echo "SDL_LIBS=3D$sdl_libs" >> $config_host_mak
 fi
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index eb85733fcd..b101be0d02 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -17,15 +17,6 @@ they were first deprecated in the 2.10.0 release.
 What follows is a list of all features currently marked as
 deprecated.
=20
-@section Build options
-
-@subsection SDL 1.2
-
-Previously QEMU has supported building against both SDL 1.2
-and 2.0 series APIs. Support for the SDL 1.2 builds will be
-discontinued, so maintainers should switch to using SDL 2.0,
-which is the default.
-
 @section System emulator command line arguments
=20
 @subsection -no-kvm (since 1.3.0)
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 00f6976c30..9b6f0c6b67 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -17,15 +17,10 @@ common-obj-$(call lnot,$(CONFIG_VNC)) +=3D vnc-stubs.=
o
=20
 # ui-sdl module
 common-obj-$(CONFIG_SDL) +=3D sdl.mo
-ifeq ($(CONFIG_SDLABI),1.2)
-sdl.mo-objs :=3D sdl.o sdl_zoom.o
-endif
-ifeq ($(CONFIG_SDLABI),2.0)
 sdl.mo-objs :=3D sdl2.o sdl2-input.o sdl2-2d.o
 ifeq ($(CONFIG_OPENGL),y)
 sdl.mo-objs +=3D sdl2-gl.o
 endif
-endif
 sdl.mo-cflags :=3D $(SDL_CFLAGS)
 sdl.mo-libs :=3D $(SDL_LIBS)
=20
diff --git a/ui/sdl.c b/ui/sdl.c
deleted file mode 100644
index a5fd503c25..0000000000
--- a/ui/sdl.c
+++ /dev/null
@@ -1,1027 +0,0 @@
-/*
- * QEMU SDL display driver
- *
- * Copyright (c) 2003 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
- * of this software and associated documentation files (the "Software"),=
 to deal
- * in the Software without restriction, including without limitation the=
 rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be includ=
ed in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
- * THE SOFTWARE.
- */
-
-/* Avoid compiler warning because macro is redefined in SDL_syswm.h. */
-#undef WIN32_LEAN_AND_MEAN
-
-#include "qemu/osdep.h"
-#include <SDL.h>
-#include <SDL_syswm.h>
-
-#include "qemu-common.h"
-#include "qemu/cutils.h"
-#include "ui/console.h"
-#include "ui/input.h"
-#include "sysemu/sysemu.h"
-#ifndef WIN32
-#include "x_keymap.h"
-#endif
-#include "sdl_zoom.h"
-
-static DisplayChangeListener *dcl;
-static DisplaySurface *surface;
-static DisplayOptions *opts;
-static SDL_Surface *real_screen;
-static SDL_Surface *guest_screen =3D NULL;
-static int gui_grab; /* if true, all keyboard/mouse events are grabbed *=
/
-static int last_vm_running;
-static bool gui_saved_scaling;
-static int gui_saved_width;
-static int gui_saved_height;
-static int gui_saved_grab;
-static int gui_fullscreen;
-static int gui_key_modifier_pressed;
-static int gui_keysym;
-static int gui_grab_code =3D KMOD_LALT | KMOD_LCTRL;
-static uint8_t modifiers_state[256];
-static SDL_Cursor *sdl_cursor_normal;
-static SDL_Cursor *sdl_cursor_hidden;
-static int absolute_enabled =3D 0;
-static int guest_cursor =3D 0;
-static int guest_x, guest_y;
-static SDL_Cursor *guest_sprite =3D NULL;
-static SDL_PixelFormat host_format;
-static int scaling_active =3D 0;
-static Notifier mouse_mode_notifier;
-static int idle_counter;
-static const guint16 *keycode_map;
-static size_t keycode_maplen;
-
-#define SDL_REFRESH_INTERVAL_BUSY 10
-#define SDL_MAX_IDLE_COUNT (2 * GUI_REFRESH_INTERVAL_DEFAULT \
-                            / SDL_REFRESH_INTERVAL_BUSY + 1)
-
-#if 0
-#define DEBUG_SDL
-#endif
-
-static void sdl_update(DisplayChangeListener *dcl,
-                       int x, int y, int w, int h)
-{
-    SDL_Rect rec;
-    rec.x =3D x;
-    rec.y =3D y;
-    rec.w =3D w;
-    rec.h =3D h;
-
-#ifdef DEBUG_SDL
-    printf("SDL: Updating x=3D%d y=3D%d w=3D%d h=3D%d (scaling: %d)\n",
-           x, y, w, h, scaling_active);
-#endif
-
-    if (guest_screen) {
-        if (!scaling_active) {
-            SDL_BlitSurface(guest_screen, &rec, real_screen, &rec);
-        } else {
-            if (sdl_zoom_blit(guest_screen, real_screen, SMOOTHING_ON, &=
rec) < 0) {
-                fprintf(stderr, "Zoom blit failed\n");
-                exit(1);
-            }
-        }
-    }=20
-    SDL_UpdateRect(real_screen, rec.x, rec.y, rec.w, rec.h);
-}
-
-static void do_sdl_resize(int width, int height, int bpp)
-{
-    int flags;
-    SDL_Surface *tmp_screen;
-
-#ifdef DEBUG_SDL
-    printf("SDL: Resizing to %dx%d bpp %d\n", width, height, bpp);
-#endif
-
-    flags =3D SDL_HWSURFACE | SDL_ASYNCBLIT | SDL_HWACCEL;
-    if (gui_fullscreen) {
-        flags |=3D SDL_FULLSCREEN;
-    } else {
-        flags |=3D SDL_RESIZABLE;
-    }
-    if (no_frame) {
-        flags |=3D SDL_NOFRAME;
-    }
-
-    tmp_screen =3D SDL_SetVideoMode(width, height, bpp, flags);
-    if (!real_screen) {
-        if (!tmp_screen) {
-            fprintf(stderr, "Could not open SDL display (%dx%dx%d): %s\n=
",
-                    width, height, bpp, SDL_GetError());
-            exit(1);
-        }
-    } else {
-        /*
-         * Revert to the previous video mode if the change of resizing o=
r
-         * resolution failed.
-         */
-        if (!tmp_screen) {
-            fprintf(stderr, "Failed to set SDL display (%dx%dx%d): %s\n"=
,
-                    width, height, bpp, SDL_GetError());
-            return;
-        }
-    }
-
-    real_screen =3D tmp_screen;
-}
-
-static void sdl_switch(DisplayChangeListener *dcl,
-                       DisplaySurface *new_surface)
-{
-    PixelFormat pf;
-
-    /* temporary hack: allows to call sdl_switch to handle scaling chang=
es */
-    if (new_surface) {
-        surface =3D new_surface;
-    }
-    pf =3D qemu_pixelformat_from_pixman(surface->format);
-
-    if (!scaling_active) {
-        do_sdl_resize(surface_width(surface), surface_height(surface), 0=
);
-    } else if (real_screen->format->BitsPerPixel !=3D
-               surface_bits_per_pixel(surface)) {
-        do_sdl_resize(real_screen->w, real_screen->h,
-                      surface_bits_per_pixel(surface));
-    }
-
-    if (guest_screen !=3D NULL) {
-        SDL_FreeSurface(guest_screen);
-    }
-
-#ifdef DEBUG_SDL
-    printf("SDL: Creating surface with masks: %08x %08x %08x %08x\n",
-           pf.rmask, pf.gmask, pf.bmask, pf.amask);
-#endif
-
-    guest_screen =3D SDL_CreateRGBSurfaceFrom
-        (surface_data(surface),
-         surface_width(surface), surface_height(surface),
-         surface_bits_per_pixel(surface), surface_stride(surface),
-         pf.rmask, pf.gmask,
-         pf.bmask, pf.amask);
-}
-
-static bool sdl_check_format(DisplayChangeListener *dcl,
-                             pixman_format_code_t format)
-{
-    /*
-     * We let SDL convert for us a few more formats than,
-     * the native ones. Thes are the ones I have tested.
-     */
-    return (format =3D=3D PIXMAN_x8r8g8b8 ||
-            format =3D=3D PIXMAN_b8g8r8x8 ||
-            format =3D=3D PIXMAN_x1r5g5b5 ||
-            format =3D=3D PIXMAN_r5g6b5);
-}
-
-/* generic keyboard conversion */
-
-#include "sdl_keysym.h"
-
-static kbd_layout_t *kbd_layout =3D NULL;
-
-static uint8_t sdl_keyevent_to_keycode_generic(const SDL_KeyboardEvent *=
ev)
-{
-    bool shift =3D modifiers_state[0x2a] || modifiers_state[0x36];
-    bool altgr =3D modifiers_state[0xb8];
-    bool ctrl  =3D modifiers_state[0x1d] || modifiers_state[0x9d];
-    int keysym;
-    /* workaround for X11+SDL bug with AltGR */
-    keysym =3D ev->keysym.sym;
-    if (keysym =3D=3D 0 && ev->keysym.scancode =3D=3D 113)
-        keysym =3D SDLK_MODE;
-    /* For Japanese key '\' and '|' */
-    if (keysym =3D=3D 92 && ev->keysym.scancode =3D=3D 133) {
-        keysym =3D 0xa5;
-    }
-    return keysym2scancode(kbd_layout, keysym,
-                           shift, altgr, ctrl) & SCANCODE_KEYMASK;
-}
-
-
-static const guint16 *sdl_get_keymap(size_t *maplen)
-{
-#if defined(WIN32)
-    *maplen =3D qemu_input_map_atset1_to_qcode_len;
-    return qemu_input_map_atset1_to_qcode;
-#else
-#if defined(SDL_VIDEO_DRIVER_X11)
-    SDL_SysWMinfo info;
-
-    SDL_VERSION(&info.version);
-    if (SDL_GetWMInfo(&info) > 0) {
-        return qemu_xkeymap_mapping_table(
-            info.info.x11.display, maplen);
-    }
-#endif
-    g_warning("Unsupported SDL video driver / platform.\n"
-              "Assuming Linux KBD scancodes, but probably wrong.\n"
-              "Please report to qemu-devel@nongnu.org\n"
-              "including the following information:\n"
-              "\n"
-              "  - Operating system\n"
-              "  - SDL video driver\n");
-    *maplen =3D qemu_input_map_xorgkbd_to_qcode_len;
-    return qemu_input_map_xorgkbd_to_qcode;
-#endif
-}
-
-static uint8_t sdl_keyevent_to_keycode(const SDL_KeyboardEvent *ev)
-{
-    int qcode;
-    if (!keycode_map) {
-        return 0;
-    }
-    if (ev->keysym.scancode > keycode_maplen) {
-        return 0;
-    }
-
-    qcode =3D keycode_map[ev->keysym.scancode];
-
-    if (qcode > qemu_input_map_qcode_to_qnum_len) {
-        return 0;
-    }
-
-    return qemu_input_map_qcode_to_qnum[qcode];
-}
-
-static void reset_keys(void)
-{
-    int i;
-    for(i =3D 0; i < 256; i++) {
-        if (modifiers_state[i]) {
-            qemu_input_event_send_key_number(dcl->con, i, false);
-            modifiers_state[i] =3D 0;
-        }
-    }
-}
-
-static void sdl_process_key(SDL_KeyboardEvent *ev)
-{
-    int keycode;
-
-    if (ev->keysym.sym =3D=3D SDLK_PAUSE) {
-        /* specific case */
-        qemu_input_event_send_key_qcode(dcl->con, Q_KEY_CODE_PAUSE,
-                                        ev->type =3D=3D SDL_KEYDOWN);
-        return;
-    }
-
-    if (kbd_layout) {
-        keycode =3D sdl_keyevent_to_keycode_generic(ev);
-    } else {
-        keycode =3D sdl_keyevent_to_keycode(ev);
-    }
-
-    switch(keycode) {
-    case 0x00:
-        /* sent when leaving window: reset the modifiers state */
-        reset_keys();
-        return;
-    case 0x2a:                          /* Left Shift */
-    case 0x36:                          /* Right Shift */
-    case 0x1d:                          /* Left CTRL */
-    case 0x9d:                          /* Right CTRL */
-    case 0x38:                          /* Left ALT */
-    case 0xb8:                         /* Right ALT */
-        if (ev->type =3D=3D SDL_KEYUP)
-            modifiers_state[keycode] =3D 0;
-        else
-            modifiers_state[keycode] =3D 1;
-        break;
-#define QEMU_SDL_VERSION ((SDL_MAJOR_VERSION << 8) + SDL_MINOR_VERSION)
-#if QEMU_SDL_VERSION < 0x102 || QEMU_SDL_VERSION =3D=3D 0x102 && SDL_PAT=
CHLEVEL < 14
-        /* SDL versions before 1.2.14 don't support key up for caps/num =
lock. */
-    case 0x45: /* num lock */
-    case 0x3a: /* caps lock */
-        /* SDL does not send the key up event, so we generate it */
-        qemu_input_event_send_key_number(dcl->con, keycode, true);
-        qemu_input_event_send_key_number(dcl->con, keycode, false);
-        return;
-#endif
-    }
-
-    /* now send the key code */
-    qemu_input_event_send_key_number(dcl->con, keycode,
-                                     ev->type =3D=3D SDL_KEYDOWN);
-}
-
-static void sdl_update_caption(void)
-{
-    char win_title[1024];
-    char icon_title[1024];
-    const char *status =3D "";
-
-    if (!runstate_is_running())
-        status =3D " [Stopped]";
-    else if (gui_grab) {
-        if (alt_grab)
-            status =3D " - Press Ctrl-Alt-Shift-G to exit mouse grab";
-        else if (ctrl_grab)
-            status =3D " - Press Right-Ctrl-G to exit mouse grab";
-        else
-            status =3D " - Press Ctrl-Alt-G to exit mouse grab";
-    }
-
-    if (qemu_name) {
-        snprintf(win_title, sizeof(win_title), "QEMU (%s)%s", qemu_name,=
 status);
-        snprintf(icon_title, sizeof(icon_title), "QEMU (%s)", qemu_name)=
;
-    } else {
-        snprintf(win_title, sizeof(win_title), "QEMU%s", status);
-        snprintf(icon_title, sizeof(icon_title), "QEMU");
-    }
-
-    SDL_WM_SetCaption(win_title, icon_title);
-}
-
-static void sdl_hide_cursor(void)
-{
-    if (!cursor_hide)
-        return;
-
-    if (qemu_input_is_absolute()) {
-        SDL_ShowCursor(1);
-        SDL_SetCursor(sdl_cursor_hidden);
-    } else {
-        SDL_ShowCursor(0);
-    }
-}
-
-static void sdl_show_cursor(void)
-{
-    if (!cursor_hide)
-        return;
-
-    if (!qemu_input_is_absolute() || !qemu_console_is_graphic(NULL)) {
-        SDL_ShowCursor(1);
-        if (guest_cursor &&
-                (gui_grab || qemu_input_is_absolute() || absolute_enable=
d))
-            SDL_SetCursor(guest_sprite);
-        else
-            SDL_SetCursor(sdl_cursor_normal);
-    }
-}
-
-static void sdl_grab_start(void)
-{
-    /*
-     * If the application is not active, do not try to enter grab state.=
 This
-     * prevents 'SDL_WM_GrabInput(SDL_GRAB_ON)' from blocking all the
-     * application (SDL bug).
-     */
-    if (!(SDL_GetAppState() & SDL_APPINPUTFOCUS)) {
-        return;
-    }
-    if (guest_cursor) {
-        SDL_SetCursor(guest_sprite);
-        if (!qemu_input_is_absolute() && !absolute_enabled) {
-            SDL_WarpMouse(guest_x, guest_y);
-        }
-    } else
-        sdl_hide_cursor();
-    SDL_WM_GrabInput(SDL_GRAB_ON);
-    gui_grab =3D 1;
-    sdl_update_caption();
-}
-
-static void sdl_grab_end(void)
-{
-    SDL_WM_GrabInput(SDL_GRAB_OFF);
-    gui_grab =3D 0;
-    sdl_show_cursor();
-    sdl_update_caption();
-}
-
-static void absolute_mouse_grab(void)
-{
-    int mouse_x, mouse_y;
-
-    SDL_GetMouseState(&mouse_x, &mouse_y);
-    if (mouse_x > 0 && mouse_x < real_screen->w - 1 &&
-        mouse_y > 0 && mouse_y < real_screen->h - 1) {
-        sdl_grab_start();
-    }
-}
-
-static void sdl_mouse_mode_change(Notifier *notify, void *data)
-{
-    if (qemu_input_is_absolute()) {
-        if (!absolute_enabled) {
-            absolute_enabled =3D 1;
-            if (qemu_console_is_graphic(NULL)) {
-                absolute_mouse_grab();
-            }
-        }
-    } else if (absolute_enabled) {
-        if (!gui_fullscreen) {
-            sdl_grab_end();
-        }
-        absolute_enabled =3D 0;
-    }
-}
-
-static void sdl_send_mouse_event(int dx, int dy, int x, int y, int state=
)
-{
-    static uint32_t bmap[INPUT_BUTTON__MAX] =3D {
-        [INPUT_BUTTON_LEFT]       =3D SDL_BUTTON(SDL_BUTTON_LEFT),
-        [INPUT_BUTTON_MIDDLE]     =3D SDL_BUTTON(SDL_BUTTON_MIDDLE),
-        [INPUT_BUTTON_RIGHT]      =3D SDL_BUTTON(SDL_BUTTON_RIGHT),
-        [INPUT_BUTTON_WHEEL_UP]   =3D SDL_BUTTON(SDL_BUTTON_WHEELUP),
-        [INPUT_BUTTON_WHEEL_DOWN] =3D SDL_BUTTON(SDL_BUTTON_WHEELDOWN),
-    };
-    static uint32_t prev_state;
-
-    if (prev_state !=3D state) {
-        qemu_input_update_buttons(dcl->con, bmap, prev_state, state);
-        prev_state =3D state;
-    }
-
-    if (qemu_input_is_absolute()) {
-        qemu_input_queue_abs(dcl->con, INPUT_AXIS_X, x,
-                             0, real_screen->w);
-        qemu_input_queue_abs(dcl->con, INPUT_AXIS_Y, y,
-                             0, real_screen->h);
-    } else {
-        if (guest_cursor) {
-            x -=3D guest_x;
-            y -=3D guest_y;
-            guest_x +=3D x;
-            guest_y +=3D y;
-            dx =3D x;
-            dy =3D y;
-        }
-        qemu_input_queue_rel(dcl->con, INPUT_AXIS_X, dx);
-        qemu_input_queue_rel(dcl->con, INPUT_AXIS_Y, dy);
-    }
-    qemu_input_event_sync();
-}
-
-static void sdl_scale(int width, int height)
-{
-    int bpp =3D real_screen->format->BitsPerPixel;
-
-#ifdef DEBUG_SDL
-    printf("SDL: Scaling to %dx%d bpp %d\n", width, height, bpp);
-#endif
-
-    if (bpp !=3D 16 && bpp !=3D 32) {
-        bpp =3D 32;
-    }
-    do_sdl_resize(width, height, bpp);
-    scaling_active =3D 1;
-}
-
-static void toggle_full_screen(void)
-{
-    int width =3D surface_width(surface);
-    int height =3D surface_height(surface);
-    int bpp =3D surface_bits_per_pixel(surface);
-
-    gui_fullscreen =3D !gui_fullscreen;
-    if (gui_fullscreen) {
-        gui_saved_width =3D real_screen->w;
-        gui_saved_height =3D real_screen->h;
-        gui_saved_scaling =3D scaling_active;
-
-        do_sdl_resize(width, height, bpp);
-        scaling_active =3D 0;
-
-        gui_saved_grab =3D gui_grab;
-        sdl_grab_start();
-    } else {
-        if (gui_saved_scaling) {
-            sdl_scale(gui_saved_width, gui_saved_height);
-        } else {
-            do_sdl_resize(width, height, 0);
-        }
-        if (!gui_saved_grab || !qemu_console_is_graphic(NULL)) {
-            sdl_grab_end();
-        }
-    }
-    graphic_hw_invalidate(NULL);
-    graphic_hw_update(NULL);
-}
-
-static void handle_keydown(SDL_Event *ev)
-{
-    int mod_state;
-    int keycode;
-
-    if (alt_grab) {
-        mod_state =3D (SDL_GetModState() & (gui_grab_code | KMOD_LSHIFT)=
) =3D=3D
-                    (gui_grab_code | KMOD_LSHIFT);
-    } else if (ctrl_grab) {
-        mod_state =3D (SDL_GetModState() & KMOD_RCTRL) =3D=3D KMOD_RCTRL=
;
-    } else {
-        mod_state =3D (SDL_GetModState() & gui_grab_code) =3D=3D gui_gra=
b_code;
-    }
-    gui_key_modifier_pressed =3D mod_state;
-
-    if (gui_key_modifier_pressed) {
-        keycode =3D sdl_keyevent_to_keycode(&ev->key);
-        switch (keycode) {
-        case 0x21: /* 'f' key on US keyboard */
-            toggle_full_screen();
-            gui_keysym =3D 1;
-            break;
-        case 0x22: /* 'g' key */
-            if (!gui_grab) {
-                if (qemu_console_is_graphic(NULL)) {
-                    sdl_grab_start();
-                }
-            } else if (!gui_fullscreen) {
-                sdl_grab_end();
-            }
-            gui_keysym =3D 1;
-            break;
-        case 0x16: /* 'u' key on US keyboard */
-            if (scaling_active) {
-                scaling_active =3D 0;
-                sdl_switch(dcl, NULL);
-                graphic_hw_invalidate(NULL);
-                graphic_hw_update(NULL);
-            }
-            gui_keysym =3D 1;
-            break;
-        case 0x02 ... 0x0a: /* '1' to '9' keys */
-            /* Reset the modifiers sent to the current console */
-            reset_keys();
-            console_select(keycode - 0x02);
-            gui_keysym =3D 1;
-            if (gui_fullscreen) {
-                break;
-            }
-            if (!qemu_console_is_graphic(NULL)) {
-                /* release grab if going to a text console */
-                if (gui_grab) {
-                    sdl_grab_end();
-                } else if (absolute_enabled) {
-                    sdl_show_cursor();
-                }
-            } else if (absolute_enabled) {
-                sdl_hide_cursor();
-                absolute_mouse_grab();
-            }
-            break;
-        case 0x1b: /* '+' */
-        case 0x35: /* '-' */
-            if (!gui_fullscreen) {
-                int width =3D MAX(real_screen->w + (keycode =3D=3D 0x1b =
? 50 : -50),
-                                160);
-                int height =3D (surface_height(surface) * width) /
-                    surface_width(surface);
-
-                sdl_scale(width, height);
-                graphic_hw_invalidate(NULL);
-                graphic_hw_update(NULL);
-                gui_keysym =3D 1;
-            }
-        default:
-            break;
-        }
-    } else if (!qemu_console_is_graphic(NULL)) {
-        int keysym =3D 0;
-
-        if (ev->key.keysym.mod & (KMOD_LCTRL | KMOD_RCTRL)) {
-            switch (ev->key.keysym.sym) {
-            case SDLK_UP:
-                keysym =3D QEMU_KEY_CTRL_UP;
-                break;
-            case SDLK_DOWN:
-                keysym =3D QEMU_KEY_CTRL_DOWN;
-                break;
-            case SDLK_LEFT:
-                keysym =3D QEMU_KEY_CTRL_LEFT;
-                break;
-            case SDLK_RIGHT:
-                keysym =3D QEMU_KEY_CTRL_RIGHT;
-                break;
-            case SDLK_HOME:
-                keysym =3D QEMU_KEY_CTRL_HOME;
-                break;
-            case SDLK_END:
-                keysym =3D QEMU_KEY_CTRL_END;
-                break;
-            case SDLK_PAGEUP:
-                keysym =3D QEMU_KEY_CTRL_PAGEUP;
-                break;
-            case SDLK_PAGEDOWN:
-                keysym =3D QEMU_KEY_CTRL_PAGEDOWN;
-                break;
-            default:
-                break;
-            }
-        } else {
-            switch (ev->key.keysym.sym) {
-            case SDLK_UP:
-                keysym =3D QEMU_KEY_UP;
-                break;
-            case SDLK_DOWN:
-                keysym =3D QEMU_KEY_DOWN;
-                break;
-            case SDLK_LEFT:
-                keysym =3D QEMU_KEY_LEFT;
-                break;
-            case SDLK_RIGHT:
-                keysym =3D QEMU_KEY_RIGHT;
-                break;
-            case SDLK_HOME:
-                keysym =3D QEMU_KEY_HOME;
-                break;
-            case SDLK_END:
-                keysym =3D QEMU_KEY_END;
-                break;
-            case SDLK_PAGEUP:
-                keysym =3D QEMU_KEY_PAGEUP;
-                break;
-            case SDLK_PAGEDOWN:
-                keysym =3D QEMU_KEY_PAGEDOWN;
-                break;
-            case SDLK_BACKSPACE:
-                keysym =3D QEMU_KEY_BACKSPACE;
-                break;
-            case SDLK_DELETE:
-                keysym =3D QEMU_KEY_DELETE;
-                break;
-            default:
-                break;
-            }
-        }
-        if (keysym) {
-            kbd_put_keysym(keysym);
-        } else if (ev->key.keysym.unicode !=3D 0) {
-            kbd_put_keysym(ev->key.keysym.unicode);
-        }
-    }
-    if (qemu_console_is_graphic(NULL) && !gui_keysym) {
-        sdl_process_key(&ev->key);
-    }
-}
-
-static void handle_keyup(SDL_Event *ev)
-{
-    int mod_state;
-
-    if (!alt_grab) {
-        mod_state =3D (ev->key.keysym.mod & gui_grab_code);
-    } else {
-        mod_state =3D (ev->key.keysym.mod & (gui_grab_code | KMOD_LSHIFT=
));
-    }
-    if (!mod_state && gui_key_modifier_pressed) {
-        gui_key_modifier_pressed =3D 0;
-        gui_keysym =3D 0;
-    }
-    if (qemu_console_is_graphic(NULL) && !gui_keysym) {
-        sdl_process_key(&ev->key);
-    }
-}
-
-static void handle_mousemotion(SDL_Event *ev)
-{
-    int max_x, max_y;
-
-    if (qemu_console_is_graphic(NULL) &&
-        (qemu_input_is_absolute() || absolute_enabled)) {
-        max_x =3D real_screen->w - 1;
-        max_y =3D real_screen->h - 1;
-        if (gui_grab && (ev->motion.x =3D=3D 0 || ev->motion.y =3D=3D 0 =
||
-            ev->motion.x =3D=3D max_x || ev->motion.y =3D=3D max_y)) {
-            sdl_grab_end();
-        }
-        if (!gui_grab &&
-            (ev->motion.x > 0 && ev->motion.x < max_x &&
-            ev->motion.y > 0 && ev->motion.y < max_y)) {
-            sdl_grab_start();
-        }
-    }
-    if (gui_grab || qemu_input_is_absolute() || absolute_enabled) {
-        sdl_send_mouse_event(ev->motion.xrel, ev->motion.yrel,
-                             ev->motion.x, ev->motion.y, ev->motion.stat=
e);
-    }
-}
-
-static void handle_mousebutton(SDL_Event *ev)
-{
-    int buttonstate =3D SDL_GetMouseState(NULL, NULL);
-    SDL_MouseButtonEvent *bev;
-
-    if (!qemu_console_is_graphic(NULL)) {
-        return;
-    }
-
-    bev =3D &ev->button;
-    if (!gui_grab && !qemu_input_is_absolute()) {
-        if (ev->type =3D=3D SDL_MOUSEBUTTONUP && bev->button =3D=3D SDL_=
BUTTON_LEFT) {
-            /* start grabbing all events */
-            sdl_grab_start();
-        }
-    } else {
-        if (ev->type =3D=3D SDL_MOUSEBUTTONDOWN) {
-            buttonstate |=3D SDL_BUTTON(bev->button);
-        } else {
-            buttonstate &=3D ~SDL_BUTTON(bev->button);
-        }
-        sdl_send_mouse_event(0, 0, bev->x, bev->y, buttonstate);
-    }
-}
-
-static void handle_activation(SDL_Event *ev)
-{
-#ifdef _WIN32
-    /* Disable grab if the window no longer has the focus
-     * (Windows-only workaround) */
-    if (gui_grab && ev->active.state =3D=3D SDL_APPINPUTFOCUS &&
-        !ev->active.gain && !gui_fullscreen) {
-        sdl_grab_end();
-    }
-#endif
-    if (!gui_grab && ev->active.gain && qemu_console_is_graphic(NULL) &&
-        (qemu_input_is_absolute() || absolute_enabled)) {
-        absolute_mouse_grab();
-    }
-    if (ev->active.state & SDL_APPACTIVE) {
-        if (ev->active.gain) {
-            /* Back to default interval */
-            update_displaychangelistener(dcl, GUI_REFRESH_INTERVAL_DEFAU=
LT);
-        } else {
-            /* Sleeping interval.  Not using the long default here as
-             * sdl_refresh does not only update the guest screen, but
-             * also checks for gui events. */
-            update_displaychangelistener(dcl, 500);
-        }
-    }
-}
-
-static void sdl_refresh(DisplayChangeListener *dcl)
-{
-    SDL_Event ev1, *ev =3D &ev1;
-    bool allow_close =3D true;
-    int idle =3D 1;
-
-    if (last_vm_running !=3D runstate_is_running()) {
-        last_vm_running =3D runstate_is_running();
-        sdl_update_caption();
-    }
-
-    graphic_hw_update(NULL);
-    SDL_EnableUNICODE(!qemu_console_is_graphic(NULL));
-
-    while (SDL_PollEvent(ev)) {
-        switch (ev->type) {
-        case SDL_VIDEOEXPOSE:
-            sdl_update(dcl, 0, 0, real_screen->w, real_screen->h);
-            break;
-        case SDL_KEYDOWN:
-            idle =3D 0;
-            handle_keydown(ev);
-            break;
-        case SDL_KEYUP:
-            idle =3D 0;
-            handle_keyup(ev);
-            break;
-        case SDL_QUIT:
-            if (opts->has_window_close && !opts->window_close) {
-                allow_close =3D false;
-            }
-            if (allow_close) {
-                no_shutdown =3D 0;
-                qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
-            }
-            break;
-        case SDL_MOUSEMOTION:
-            idle =3D 0;
-            handle_mousemotion(ev);
-            break;
-        case SDL_MOUSEBUTTONDOWN:
-        case SDL_MOUSEBUTTONUP:
-            idle =3D 0;
-            handle_mousebutton(ev);
-            break;
-        case SDL_ACTIVEEVENT:
-            handle_activation(ev);
-            break;
-        case SDL_VIDEORESIZE:
-            sdl_scale(ev->resize.w, ev->resize.h);
-            graphic_hw_invalidate(NULL);
-            graphic_hw_update(NULL);
-            break;
-        default:
-            break;
-        }
-    }
-
-    if (idle) {
-        if (idle_counter < SDL_MAX_IDLE_COUNT) {
-            idle_counter++;
-            if (idle_counter >=3D SDL_MAX_IDLE_COUNT) {
-                dcl->update_interval =3D GUI_REFRESH_INTERVAL_DEFAULT;
-            }
-        }
-    } else {
-        idle_counter =3D 0;
-        dcl->update_interval =3D SDL_REFRESH_INTERVAL_BUSY;
-    }
-}
-
-static void sdl_mouse_warp(DisplayChangeListener *dcl,
-                           int x, int y, int on)
-{
-    if (on) {
-        if (!guest_cursor)
-            sdl_show_cursor();
-        if (gui_grab || qemu_input_is_absolute() || absolute_enabled) {
-            SDL_SetCursor(guest_sprite);
-            if (!qemu_input_is_absolute() && !absolute_enabled) {
-                SDL_WarpMouse(x, y);
-            }
-        }
-    } else if (gui_grab)
-        sdl_hide_cursor();
-    guest_cursor =3D on;
-    guest_x =3D x, guest_y =3D y;
-}
-
-static void sdl_mouse_define(DisplayChangeListener *dcl,
-                             QEMUCursor *c)
-{
-    uint8_t *image, *mask;
-    int bpl;
-
-    if (guest_sprite)
-        SDL_FreeCursor(guest_sprite);
-
-    bpl =3D cursor_get_mono_bpl(c);
-    image =3D g_malloc0(bpl * c->height);
-    mask  =3D g_malloc0(bpl * c->height);
-    cursor_get_mono_image(c, 0x000000, image);
-    cursor_get_mono_mask(c, 0, mask);
-    guest_sprite =3D SDL_CreateCursor(image, mask, c->width, c->height,
-                                    c->hot_x, c->hot_y);
-    g_free(image);
-    g_free(mask);
-
-    if (guest_cursor &&
-            (gui_grab || qemu_input_is_absolute() || absolute_enabled))
-        SDL_SetCursor(guest_sprite);
-}
-
-static void sdl_cleanup(void)
-{
-    if (guest_sprite)
-        SDL_FreeCursor(guest_sprite);
-    SDL_QuitSubSystem(SDL_INIT_VIDEO);
-}
-
-static const DisplayChangeListenerOps dcl_ops =3D {
-    .dpy_name             =3D "sdl",
-    .dpy_gfx_update       =3D sdl_update,
-    .dpy_gfx_switch       =3D sdl_switch,
-    .dpy_gfx_check_format =3D sdl_check_format,
-    .dpy_refresh          =3D sdl_refresh,
-    .dpy_mouse_set        =3D sdl_mouse_warp,
-    .dpy_cursor_define    =3D sdl_mouse_define,
-};
-
-static void sdl1_display_init(DisplayState *ds, DisplayOptions *o)
-{
-    int flags;
-    uint8_t data =3D 0;
-    const SDL_VideoInfo *vi;
-    SDL_SysWMinfo info;
-    char *filename;
-
-    assert(o->type =3D=3D DISPLAY_TYPE_SDL);
-    opts =3D o;
-#if defined(__APPLE__)
-    /* always use generic keymaps */
-    if (!keyboard_layout)
-        keyboard_layout =3D "en-us";
-#endif
-    if(keyboard_layout) {
-        kbd_layout =3D init_keyboard_layout(name2keysym, keyboard_layout=
);
-        if (!kbd_layout)
-            exit(1);
-    }
-
-    g_printerr("Running QEMU with SDL 1.2 is deprecated, and will be rem=
oved\n"
-               "in a future release. Please switch to SDL 2.0 instead\n"=
);
-
-    if (opts->has_full_screen && opts->full_screen) {
-        setenv("SDL_VIDEO_ALLOW_SCREENSAVER", "1", 0);
-    }
-#ifdef __linux__
-    /* on Linux, SDL may use fbcon|directfb|svgalib when run without
-     * accessible $DISPLAY to open X11 window.  This is often the case
-     * when qemu is run using sudo.  But in this case, and when actually
-     * run in X11 environment, SDL fights with X11 for the video card,
-     * making current display unavailable, often until reboot.
-     * So make x11 the default SDL video driver if this variable is unse=
t.
-     * This is a bit hackish but saves us from bigger problem.
-     * Maybe it's a good idea to fix this in SDL instead.
-     */
-    setenv("SDL_VIDEODRIVER", "x11", 0);
-#endif
-
-    /* Enable normal up/down events for Caps-Lock and Num-Lock keys.
-     * This requires SDL >=3D 1.2.14. */
-    setenv("SDL_DISABLE_LOCK_KEYS", "1", 1);
-
-    flags =3D SDL_INIT_VIDEO | SDL_INIT_NOPARACHUTE;
-    if (SDL_Init (flags)) {
-        fprintf(stderr, "Could not initialize SDL(%s) - exiting\n",
-                SDL_GetError());
-        exit(1);
-    }
-    vi =3D SDL_GetVideoInfo();
-    host_format =3D *(vi->vfmt);
-
-    keycode_map =3D sdl_get_keymap(&keycode_maplen);
-
-    /* Load a 32x32x4 image. White pixels are transparent. */
-    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, "qemu-icon.bmp");
-    if (filename) {
-        SDL_Surface *image =3D SDL_LoadBMP(filename);
-        if (image) {
-            uint32_t colorkey =3D SDL_MapRGB(image->format, 255, 255, 25=
5);
-            SDL_SetColorKey(image, SDL_SRCCOLORKEY, colorkey);
-            SDL_WM_SetIcon(image, NULL);
-        }
-        g_free(filename);
-    }
-
-    if (opts->has_full_screen && opts->full_screen) {
-        gui_fullscreen =3D 1;
-        sdl_grab_start();
-    }
-
-    dcl =3D g_new0(DisplayChangeListener, 1);
-    dcl->ops =3D &dcl_ops;
-    register_displaychangelistener(dcl);
-
-    mouse_mode_notifier.notify =3D sdl_mouse_mode_change;
-    qemu_add_mouse_mode_change_notifier(&mouse_mode_notifier);
-
-    sdl_update_caption();
-    SDL_EnableKeyRepeat(250, 50);
-    gui_grab =3D 0;
-
-    sdl_cursor_hidden =3D SDL_CreateCursor(&data, &data, 8, 1, 0, 0);
-    sdl_cursor_normal =3D SDL_GetCursor();
-
-    memset(&info, 0, sizeof(info));
-    SDL_VERSION(&info.version);
-    if (SDL_GetWMInfo(&info)) {
-        int i;
-        for (i =3D 0; ; i++) {
-            /* All consoles share the same window */
-            QemuConsole *con =3D qemu_console_lookup_by_index(i);
-            if (con) {
-#if defined(SDL_VIDEO_DRIVER_X11)
-                qemu_console_set_window_id(con, info.info.x11.wmwindow);
-#elif defined(SDL_VIDEO_DRIVER_NANOX) || \
-      defined(SDL_VIDEO_DRIVER_WINDIB) || defined(SDL_VIDEO_DRIVER_DDRAW=
) || \
-      defined(SDL_VIDEO_DRIVER_GAPI) || \
-      defined(SDL_VIDEO_DRIVER_RISCOS)
-                qemu_console_set_window_id(con, (int) (uintptr_t) info.w=
indow);
-#else
-                qemu_console_set_window_id(con, info.data);
-#endif
-            } else {
-                break;
-            }
-        }
-    }
-
-    atexit(sdl_cleanup);
-}
-
-static QemuDisplay qemu_display_sdl1 =3D {
-    .type       =3D DISPLAY_TYPE_SDL,
-    .init       =3D sdl1_display_init,
-};
-
-static void register_sdl1(void)
-{
-    qemu_display_register(&qemu_display_sdl1);
-}
-
-type_init(register_sdl1);
diff --git a/ui/sdl_zoom.c b/ui/sdl_zoom.c
deleted file mode 100644
index b96196bac5..0000000000
--- a/ui/sdl_zoom.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * SDL_zoom - surface scaling
- *=20
- * Copyright (c) 2009 Citrix Systems, Inc.
- *
- * Derived from: SDL_rotozoom,  LGPL (c) A. Schiffler from the SDL_gfx l=
ibrary.
- * Modifications by Stefano Stabellini.
- *
- * This work is licensed under the terms of the GNU GPL version 2.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "sdl_zoom.h"
-
-static void sdl_zoom_rgb16(SDL_Surface *src, SDL_Surface *dst, int smoot=
h,
-                           SDL_Rect *dst_rect);
-static void sdl_zoom_rgb32(SDL_Surface *src, SDL_Surface *dst, int smoot=
h,
-                           SDL_Rect *dst_rect);
-
-#define BPP 32
-#include  "sdl_zoom_template.h"
-#undef BPP
-#define BPP 16
-#include  "sdl_zoom_template.h"
-#undef BPP
-
-int sdl_zoom_blit(SDL_Surface *src_sfc, SDL_Surface *dst_sfc, int smooth=
,
-                  SDL_Rect *in_rect)
-{
-    SDL_Rect zoom, src_rect;
-    int extra;
-
-    /* Grow the size of the modified rectangle to avoid edge artefacts *=
/
-    src_rect.x =3D (in_rect->x > 0) ? (in_rect->x - 1) : 0;
-    src_rect.y =3D (in_rect->y > 0) ? (in_rect->y - 1) : 0;
-
-    src_rect.w =3D in_rect->w + 1;
-    if (src_rect.x + src_rect.w > src_sfc->w)
-        src_rect.w =3D src_sfc->w - src_rect.x;
-
-    src_rect.h =3D in_rect->h + 1;
-    if (src_rect.y + src_rect.h > src_sfc->h)
-        src_rect.h =3D src_sfc->h - src_rect.y;
-
-    /* (x,y) : round down */
-    zoom.x =3D (int)(((float)(src_rect.x * dst_sfc->w)) / (float)(src_sf=
c->w));
-    zoom.y =3D (int)(((float)(src_rect.y * dst_sfc->h)) / (float)(src_sf=
c->h));
-
-    /* (w,h) : round up */
-    zoom.w =3D (int)( ((double)((src_rect.w * dst_sfc->w) + (src_sfc->w =
- 1))) /
-                     (double)(src_sfc->w));
-
-    zoom.h =3D (int)( ((double)((src_rect.h * dst_sfc->h) + (src_sfc->h =
- 1))) /
-                     (double)(src_sfc->h));
-
-    /* Account for any (x,y) rounding by adding one-source-pixel's worth
-     * of destination pixels and then edge checking.
-     */
-
-    extra =3D ((dst_sfc->w-1) / src_sfc->w) + 1;
-
-    if ((zoom.x + zoom.w) < (dst_sfc->w - extra))
-        zoom.w +=3D extra;
-    else
-        zoom.w =3D dst_sfc->w - zoom.x;
-
-    extra =3D ((dst_sfc->h-1) / src_sfc->h) + 1;
-
-    if ((zoom.y + zoom.h) < (dst_sfc->h - extra))
-        zoom.h +=3D extra;
-    else
-        zoom.h =3D dst_sfc->h - zoom.y;
-
-    /* The rectangle (zoom.x, zoom.y, zoom.w, zoom.h) is the area on the
-     * destination surface that needs to be updated.
-     */
-    if (src_sfc->format->BitsPerPixel =3D=3D 32)
-        sdl_zoom_rgb32(src_sfc, dst_sfc, smooth, &zoom);
-    else if (src_sfc->format->BitsPerPixel =3D=3D 16)
-        sdl_zoom_rgb16(src_sfc, dst_sfc, smooth, &zoom);
-    else {
-        fprintf(stderr, "pixel format not supported\n");
-        return -1;
-    }
-
-    /* Return the rectangle of the update to the caller */
-    *in_rect =3D zoom;
-
-    return 0;
-}
-
diff --git a/ui/sdl_zoom.h b/ui/sdl_zoom.h
deleted file mode 100644
index 39696ddb08..0000000000
--- a/ui/sdl_zoom.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * SDL_zoom - surface scaling
- *=20
- * Copyright (c) 2009 Citrix Systems, Inc.
- *
- * Derived from: SDL_rotozoom,  LGPL (c) A. Schiffler from the SDL_gfx l=
ibrary.
- * Modifications by Stefano Stabellini.
- *
- * This work is licensed under the terms of the GNU GPL version 2.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#ifndef SDL_ZOOM_H
-#define SDL_ZOOM_H
-
-#include <SDL.h>
-
-#define SMOOTHING_OFF		0
-#define SMOOTHING_ON		1
-
-int sdl_zoom_blit(SDL_Surface *src_sfc, SDL_Surface *dst_sfc,
-                  int smooth, SDL_Rect *src_rect);
-
-#endif /* SDL_ZOOM_H */
diff --git a/ui/sdl_zoom_template.h b/ui/sdl_zoom_template.h
deleted file mode 100644
index 6a424adfb4..0000000000
--- a/ui/sdl_zoom_template.h
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
- * SDL_zoom_template - surface scaling
- *=20
- * Copyright (c) 2009 Citrix Systems, Inc.
- *
- * Derived from: SDL_rotozoom,  LGPL (c) A. Schiffler from the SDL_gfx l=
ibrary.
- * Modifications by Stefano Stabellini.
- *
- * This work is licensed under the terms of the GNU GPL version 2.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#if BPP =3D=3D 16
-#define SDL_TYPE Uint16
-#elif BPP =3D=3D 32
-#define SDL_TYPE Uint32
-#else
-#error unsupport depth
-#endif
-
-/* =20
- *  Simple helper functions to make the code looks nicer
- *
- *  Assume spf =3D source SDL_PixelFormat
- *         dpf =3D dest SDL_PixelFormat
- *
- */
-#define getRed(color)   (((color) & spf->Rmask) >> spf->Rshift)
-#define getGreen(color) (((color) & spf->Gmask) >> spf->Gshift)
-#define getBlue(color)  (((color) & spf->Bmask) >> spf->Bshift)
-#define getAlpha(color) (((color) & spf->Amask) >> spf->Ashift)
-
-#define setRed(r, pcolor) do { \
-    *pcolor =3D ((*pcolor) & (~(dpf->Rmask))) + \
-              (((r) & (dpf->Rmask >> dpf->Rshift)) << dpf->Rshift); \
-} while (0)
-
-#define setGreen(g, pcolor) do { \
-    *pcolor =3D ((*pcolor) & (~(dpf->Gmask))) + \
-              (((g) & (dpf->Gmask >> dpf->Gshift)) << dpf->Gshift); \
-} while (0)
-
-#define setBlue(b, pcolor) do { \
-    *pcolor =3D ((*pcolor) & (~(dpf->Bmask))) + \
-              (((b) & (dpf->Bmask >> dpf->Bshift)) << dpf->Bshift); \
-} while (0)
-
-#define setAlpha(a, pcolor) do { \
-    *pcolor =3D ((*pcolor) & (~(dpf->Amask))) + \
-              (((a) & (dpf->Amask >> dpf->Ashift)) << dpf->Ashift); \
-} while (0)
-
-static void glue(sdl_zoom_rgb, BPP)(SDL_Surface *src, SDL_Surface *dst, =
int smooth,
-                                   SDL_Rect *dst_rect)
-{
-    int x, y, sx, sy, *sax, *say, *csax, *csay, csx, csy, ex, ey, t1, t2=
, sstep, sstep_jump;
-    SDL_TYPE *c00, *c01, *c10, *c11, *sp, *csp, *dp;
-    int d_gap;
-    SDL_PixelFormat *spf =3D src->format;
-    SDL_PixelFormat *dpf =3D dst->format;
-
-    if (smooth) {=20
-        /* For interpolation: assume source dimension is one pixel.
-         * Smaller here to avoid overflow on right and bottom edge.
-         */
-        sx =3D (int) (65536.0 * (float) (src->w - 1) / (float) dst->w);
-        sy =3D (int) (65536.0 * (float) (src->h - 1) / (float) dst->h);
-    } else {
-        sx =3D (int) (65536.0 * (float) src->w / (float) dst->w);
-        sy =3D (int) (65536.0 * (float) src->h / (float) dst->h);
-    }
-
-    sax =3D g_new(int, dst->w + 1);
-    say =3D g_new(int, dst->h + 1);
-
-    sp =3D csp =3D (SDL_TYPE *) src->pixels;
-    dp =3D (SDL_TYPE *) (dst->pixels + dst_rect->y * dst->pitch +
-                       dst_rect->x * dst->format->BytesPerPixel);
-
-    csx =3D 0;
-    csax =3D sax;
-    for (x =3D 0; x <=3D dst->w; x++) {
-        *csax =3D csx;
-        csax++;
-        csx &=3D 0xffff;
-        csx +=3D sx;
-    }
-    csy =3D 0;
-    csay =3D say;
-    for (y =3D 0; y <=3D dst->h; y++) {
-        *csay =3D csy;
-        csay++;
-        csy &=3D 0xffff;
-        csy +=3D sy;
-    }
-
-    d_gap =3D dst->pitch - dst_rect->w * dst->format->BytesPerPixel;
-
-    if (smooth) {
-        csay =3D say;
-        for (y =3D 0; y < dst_rect->y; y++) {
-            csay++;
-            sstep =3D (*csay >> 16) * src->pitch;
-            csp =3D (SDL_TYPE *) ((Uint8 *) csp + sstep);
-        }
-
-        /* Calculate sstep_jump */
-        csax =3D sax;=20
-        sstep_jump =3D 0;
-        for (x =3D 0; x < dst_rect->x; x++) {
-            csax++;=20
-            sstep =3D (*csax >> 16);
-            sstep_jump +=3D sstep;
-        }
-
-        for (y =3D 0; y < dst_rect->h ; y++) {
-            /* Setup colour source pointers */
-            c00 =3D csp + sstep_jump;
-            c01 =3D c00 + 1;
-            c10 =3D (SDL_TYPE *) ((Uint8 *) csp + src->pitch) + sstep_ju=
mp;
-            c11 =3D c10 + 1;
-            csax =3D sax + dst_rect->x;=20
-
-            for (x =3D 0; x < dst_rect->w; x++) {
-
-                /* Interpolate colours */
-                ex =3D (*csax & 0xffff);
-                ey =3D (*csay & 0xffff);
-                t1 =3D ((((getRed(*c01) - getRed(*c00)) * ex) >> 16) +
-                     getRed(*c00)) & (dpf->Rmask >> dpf->Rshift);
-                t2 =3D ((((getRed(*c11) - getRed(*c10)) * ex) >> 16) +
-                     getRed(*c10)) & (dpf->Rmask >> dpf->Rshift);
-                setRed((((t2 - t1) * ey) >> 16) + t1, dp);
-                t1 =3D ((((getGreen(*c01) - getGreen(*c00)) * ex) >> 16)=
 +
-                     getGreen(*c00)) & (dpf->Gmask >> dpf->Gshift);
-                t2 =3D ((((getGreen(*c11) - getGreen(*c10)) * ex) >> 16)=
 +
-                     getGreen(*c10)) & (dpf->Gmask >> dpf->Gshift);
-                setGreen((((t2 - t1) * ey) >> 16) + t1, dp);
-                t1 =3D ((((getBlue(*c01) - getBlue(*c00)) * ex) >> 16) +
-                     getBlue(*c00)) & (dpf->Bmask >> dpf->Bshift);
-                t2 =3D ((((getBlue(*c11) - getBlue(*c10)) * ex) >> 16) +
-                     getBlue(*c10)) & (dpf->Bmask >> dpf->Bshift);
-                setBlue((((t2 - t1) * ey) >> 16) + t1, dp);
-                t1 =3D ((((getAlpha(*c01) - getAlpha(*c00)) * ex) >> 16)=
 +
-                     getAlpha(*c00)) & (dpf->Amask >> dpf->Ashift);
-                t2 =3D ((((getAlpha(*c11) - getAlpha(*c10)) * ex) >> 16)=
 +
-                     getAlpha(*c10)) & (dpf->Amask >> dpf->Ashift);
-                setAlpha((((t2 - t1) * ey) >> 16) + t1, dp);=20
-
-                /* Advance source pointers */
-                csax++;=20
-                sstep =3D (*csax >> 16);
-                c00 +=3D sstep;
-                c01 +=3D sstep;
-                c10 +=3D sstep;
-                c11 +=3D sstep;
-                /* Advance destination pointer */
-                dp++;
-            }
-            /* Advance source pointer */
-            csay++;
-            csp =3D (SDL_TYPE *) ((Uint8 *) csp + (*csay >> 16) * src->p=
itch);
-            /* Advance destination pointers */
-            dp =3D (SDL_TYPE *) ((Uint8 *) dp + d_gap);
-        }
-
-
-    } else {
-        csay =3D say;
-
-        for (y =3D 0; y < dst_rect->y; y++) {
-            csay++;
-            sstep =3D (*csay >> 16) * src->pitch;
-            csp =3D (SDL_TYPE *) ((Uint8 *) csp + sstep);
-        }
-
-        /* Calculate sstep_jump */
-        csax =3D sax;=20
-        sstep_jump =3D 0;
-        for (x =3D 0; x < dst_rect->x; x++) {
-            csax++;=20
-            sstep =3D (*csax >> 16);
-            sstep_jump +=3D sstep;
-        }
-
-        for (y =3D 0 ; y < dst_rect->h ; y++) {
-            sp =3D csp + sstep_jump;
-            csax =3D sax + dst_rect->x;
-
-            for (x =3D 0; x < dst_rect->w; x++) {
-
-                /* Draw */
-                *dp =3D *sp;
-
-                /* Advance source pointers */
-                csax++;
-                sstep =3D (*csax >> 16);
-                sp +=3D sstep;
-
-                /* Advance destination pointer */
-                dp++;
-            }
-            /* Advance source pointers */
-            csay++;
-            sstep =3D (*csay >> 16) * src->pitch;
-            csp =3D (SDL_TYPE *) ((Uint8 *) csp + sstep);
-
-            /* Advance destination pointer */
-            dp =3D (SDL_TYPE *) ((Uint8 *) dp + d_gap);
-        }
-    }
-
-    g_free(sax);
-    g_free(say);
-}
-
-#undef SDL_TYPE
-
--=20
2.17.1
