Received: from eggs.gnu.org ([2001:4830:134:3::10]:39276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e73Ah-0001PV-4M
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e73Ad-0002zc-SO
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:39:23 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:45565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1e73Ad-0002yy-HI
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:39:19 -0400
Received: by mail-wm0-x243.google.com with SMTP id q124so17232331wmb.0
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 10:39:19 -0700 (PDT)
Date: Tue, 24 Oct 2017 19:39:13 +0200
From: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>
Message-ID: <20171024193913.2aca85bf@holly>
In-Reply-To: <e8fd3ada-8f06-eb10-c5f3-cee3d9ef0c17@amsat.org>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-4-makovick@gmail.com>
	<e8fd3ada-8f06-eb10-c5f3-cee3d9ef0c17@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/HPAb4/w1L_mn2O6MIxdZr0j"
Subject: Re: [Qemu-devel] [PATCH 3/7] sdl2: Do not hide the cursor on
 auxilliary windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

--MP_/HPAb4/w1L_mn2O6MIxdZr0j
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 23 Oct 2017 23:38:16 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Jindrich,
>=20
> This looks like 2 different patches, can you split?

Hi,

here is the split version.

>=20
> On 10/23/2017 06:07 PM, Jindrich Makovicka wrote:
> > ---
> >  ui/sdl2.c | 41 ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 30 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index aa37b39547..685e4fabec 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -169,10 +169,10 @@ static void sdl_hide_cursor(void)
> >          return;
> >      }
> > =20
> > -    if (qemu_input_is_absolute()) {
> > -        SDL_ShowCursor(1);
> > -        SDL_SetCursor(sdl_cursor_hidden);
> > -    } else {
> > +    SDL_ShowCursor(SDL_DISABLE);
> > +    SDL_SetCursor(sdl_cursor_hidden);
> > +
> > +    if (!qemu_input_is_absolute()) {
> >          SDL_SetRelativeMouseMode(SDL_TRUE);
> >      }
> >  }
> > @@ -185,14 +185,16 @@ static void sdl_show_cursor(void)
> > =20
> >      if (!qemu_input_is_absolute()) {
> >          SDL_SetRelativeMouseMode(SDL_FALSE);
> > -        SDL_ShowCursor(1);
> > -        if (guest_cursor &&
> > -            (gui_grab || qemu_input_is_absolute() ||
> > absolute_enabled)) {
> > -            SDL_SetCursor(guest_sprite);
> > -        } else {
> > -            SDL_SetCursor(sdl_cursor_normal);
> > -        }
> >      }
> > +
> > +    if (guest_cursor &&
> > +        (gui_grab || qemu_input_is_absolute() ||
> > absolute_enabled)) {
> > +        SDL_SetCursor(guest_sprite);
> > +    } else {
> > +        SDL_SetCursor(sdl_cursor_normal);
> > +    }
> > +
> > +    SDL_ShowCursor(SDL_ENABLE);
> >  } =20
>=20
> first patch:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> ---
>=20
> second patch:
>=20
> > =20
> >  static void sdl_grab_start(struct sdl2_console *scon)
> > @@ -463,6 +465,10 @@ static void handle_mousemotion(SDL_Event *ev)
> >      int max_x, max_y;
> >      struct sdl2_console *scon =3D
> > get_scon_from_window(ev->key.windowID);=20
> > +    if (!qemu_console_is_graphic(scon->dcl.con)) {
> > +        return;
> > +    }
> > +   =20
> >      if (qemu_input_is_absolute() || absolute_enabled) {
> >          int scr_w, scr_h;
> >          SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
> > @@ -490,6 +496,10 @@ static void handle_mousebutton(SDL_Event *ev)
> >      SDL_MouseButtonEvent *bev;
> >      struct sdl2_console *scon =3D
> > get_scon_from_window(ev->key.windowID);=20
> > +    if (!qemu_console_is_graphic(scon->dcl.con)) {
> > +        return;
> > +    }
> > +   =20
> >      bev =3D &ev->button;
> >      if (!gui_grab && !qemu_input_is_absolute()) {
> >          if (ev->type =3D=3D SDL_MOUSEBUTTONUP && bev->button =3D=3D
> > SDL_BUTTON_LEFT) { @@ -512,6 +522,10 @@ static void
> > handle_mousewheel(SDL_Event *ev) SDL_MouseWheelEvent *wev =3D
> > &ev->wheel; InputButton btn;
> > =20
> > +    if (!qemu_console_is_graphic(scon->dcl.con)) {
> > +        return;
> > +    }
> > +   =20
> >      if (wev->y > 0) {
> >          btn =3D INPUT_BUTTON_WHEEL_UP;
> >      } else if (wev->y < 0) {
> > @@ -651,6 +665,11 @@ static void
> > sdl_mouse_warp(DisplayChangeListener *dcl, int x, int y, int on)
> >  {
> >      struct sdl2_console *scon =3D container_of(dcl, struct
> > sdl2_console, dcl); +
> > +    if (!qemu_console_is_graphic(scon->dcl.con)) {
> > +        return;
> > +    }
> > +   =20
> >      if (on) {
> >          if (!guest_cursor) {
> >              sdl_show_cursor();
> >  =20
>=20
> Regards,
>=20
> Phil.



--=20
Jindrich Makovicka

--MP_/HPAb4/w1L_mn2O6MIxdZr0j
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0003-sdl2-Use-the-same-pointer-show-hide-logic-for-absolu.patch

>From 746858b932706f49f320c34a4e1259fd005625a3 Mon Sep 17 00:00:00 2001
From: Jindrich Makovicka <makovick@gmail.com>
Date: Tue, 24 Oct 2017 19:30:58 +0200
Subject: [PATCH 3/8] sdl2: Use the same pointer show/hide logic for absolute
 and relative mode

Also use a proper enum parameter for SDL_ShowCursor
---
 ui/sdl2.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index aa37b39547..2d0470189f 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -169,10 +169,10 @@ static void sdl_hide_cursor(void)
         return;
     }
 
-    if (qemu_input_is_absolute()) {
-        SDL_ShowCursor(1);
-        SDL_SetCursor(sdl_cursor_hidden);
-    } else {
+    SDL_ShowCursor(SDL_DISABLE);
+    SDL_SetCursor(sdl_cursor_hidden);
+
+    if (!qemu_input_is_absolute()) {
         SDL_SetRelativeMouseMode(SDL_TRUE);
     }
 }
@@ -185,14 +185,16 @@ static void sdl_show_cursor(void)
 
     if (!qemu_input_is_absolute()) {
         SDL_SetRelativeMouseMode(SDL_FALSE);
-        SDL_ShowCursor(1);
-        if (guest_cursor &&
-            (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
-            SDL_SetCursor(guest_sprite);
-        } else {
-            SDL_SetCursor(sdl_cursor_normal);
-        }
     }
+
+    if (guest_cursor &&
+        (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
+        SDL_SetCursor(guest_sprite);
+    } else {
+        SDL_SetCursor(sdl_cursor_normal);
+    }
+
+    SDL_ShowCursor(SDL_ENABLE);
 }
 
 static void sdl_grab_start(struct sdl2_console *scon)
-- 
2.15.0.rc2


--MP_/HPAb4/w1L_mn2O6MIxdZr0j
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0004-sdl2-Do-not-hide-the-cursor-on-auxilliary-windows.patch

>From 30174a668c17d230f8e55909f1406c9897baf395 Mon Sep 17 00:00:00 2001
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sat, 14 Oct 2017 16:27:23 +0200
Subject: [PATCH 4/8] sdl2: Do not hide the cursor on auxilliary windows

---
 ui/sdl2.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 2d0470189f..685e4fabec 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -465,6 +465,10 @@ static void handle_mousemotion(SDL_Event *ev)
     int max_x, max_y;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     if (qemu_input_is_absolute() || absolute_enabled) {
         int scr_w, scr_h;
         SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
@@ -492,6 +496,10 @@ static void handle_mousebutton(SDL_Event *ev)
     SDL_MouseButtonEvent *bev;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     bev = &ev->button;
     if (!gui_grab && !qemu_input_is_absolute()) {
         if (ev->type == SDL_MOUSEBUTTONUP && bev->button == SDL_BUTTON_LEFT) {
@@ -514,6 +522,10 @@ static void handle_mousewheel(SDL_Event *ev)
     SDL_MouseWheelEvent *wev = &ev->wheel;
     InputButton btn;
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     if (wev->y > 0) {
         btn = INPUT_BUTTON_WHEEL_UP;
     } else if (wev->y < 0) {
@@ -653,6 +665,11 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
                            int x, int y, int on)
 {
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
+
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     if (on) {
         if (!guest_cursor) {
             sdl_show_cursor();
-- 
2.15.0.rc2


--MP_/HPAb4/w1L_mn2O6MIxdZr0j--
