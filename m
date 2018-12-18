Received: from eggs.gnu.org ([2001:4830:134:3::10]:51666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZKNH-0005V0-J5
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZKNE-00054S-Pz
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:45:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZKNC-0004nW-O1
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:45:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F42032D80B
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 18:45:40 +0000 (UTC)
Date: Tue, 18 Dec 2018 18:45:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181218184532.GA18660@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180222070513.8740-1-kraxel@redhat.com>
	<20180222070513.8740-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180222070513.8740-6-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/5] keymap: consider modifier state
 when picking a mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Adam Williamson <awilliam@redhat.com>



On Thu, Feb 22, 2018 at 08:05:13AM +0100, Gerd Hoffmann wrote:
> Pass the modifier state to the keymap lookup function.  In case multipl=
e
> keysym -> keycode mappings exist look at the modifier state and prefer
> the mapping where the modifier state matches.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  ui/keymaps.h |  3 ++-
>  ui/curses.c  |  3 ++-
>  ui/keymaps.c | 33 ++++++++++++++++++++++++++++++++-
>  ui/sdl.c     |  6 +++++-
>  ui/vnc.c     |  9 +++++++--
>  5 files changed, 48 insertions(+), 6 deletions(-)

[snip]

> diff --git a/ui/vnc.c b/ui/vnc.c
> index a77b568b57..d19f86c7f4 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1734,7 +1734,8 @@ static void reset_keys(VncState *vs)
> =20
>  static void press_key(VncState *vs, int keysym)
>  {
> -    int keycode =3D keysym2scancode(vs->vd->kbd_layout, keysym) & SCAN=
CODE_KEYMASK;
> +    int keycode =3D keysym2scancode(vs->vd->kbd_layout, keysym,
> +                                  false, false, false) & SCANCODE_KEYM=
ASK;
>      qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, true);
>      qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
>      qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, false);
> @@ -1993,6 +1994,9 @@ static const char *code2name(int keycode)
> =20
>  static void key_event(VncState *vs, int down, uint32_t sym)
>  {
> +    bool shift =3D vs->modifiers_state[0x2a] || vs->modifiers_state[0x=
36];
> +    bool altgr =3D vs->modifiers_state[0xb8];
> +    bool ctrl  =3D vs->modifiers_state[0x1d] || vs->modifiers_state[0x=
9d];
>      int keycode;
>      int lsym =3D sym;
> =20
> @@ -2000,7 +2004,8 @@ static void key_event(VncState *vs, int down, uin=
t32_t sym)
>          lsym =3D lsym - 'A' + 'a';
>      }
> =20
> -    keycode =3D keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF) & S=
CANCODE_KEYMASK;
> +    keycode =3D keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF,
> +                              shift, altgr, ctrl) & SCANCODE_KEYMASK;
>      trace_vnc_key_event_map(down, sym, keycode, code2name(keycode));
>      do_key_event(vs, down, keycode, sym);
>  }

It looks like this patch is causing some buggy input handling behaviour
with VNC (and probably SDL though I didn't test)


Consider the user wants to type a "<" character.  There are two valid
key sequences for this

 down  0xffe1      (shift)
 down  0x3c        (dot)
 up    0x3c        (dot)
 up    0xffe1      (shift)

Or

 down  0xffe1      (shift)
 down  0x3c        (dot)
 up    0xffe1      (shift)
 up    0x3c        (dot)


With the original code, the "dot" character would be intepreted the
same way in both sequences.

With this patch applied, the "dot", the second sequence is broken.
The "dot" character is interpreted with no modifiers on down, and
interpreted with the shift modifier on release. This is then causing
QEMU to see a different QKeyCode on down vs up.

The trace events show the problem:

Before this patch, the two sequences show:

  18544@1545157940.945319:vnc_key_event_map down 1, sym 0xffe1 -> keycode=
 0x2a [shift]
  18544@1545157941.186608:vnc_key_event_map down 1, sym 0x3c -> keycode 0=
x56 [less]
  18544@1545157941.346898:vnc_key_event_map down 0, sym 0x3c -> keycode 0=
x56 [less]
  18544@1545157941.810041:vnc_key_event_map down 0, sym 0xffe1 -> keycode=
 0x2a [shift]

  18544@1545157943.447085:vnc_key_event_map down 1, sym 0xffe1 -> keycode=
 0x2a [shift]
  18544@1545157943.752193:vnc_key_event_map down 1, sym 0x3c -> keycode 0=
x56 [less]
  18544@1545157943.986145:vnc_key_event_map down 0, sym 0xffe1 -> keycode=
 0x2a [shift]
  18544@1545157944.258757:vnc_key_event_map down 0, sym 0x3c -> keycode 0=
x56 [less]

IOW, in both sequences we have matched pairs of events


After this patch the two sequences now show:

  19237@1545158356.679095:vnc_key_event_map down 1, sym 0xffe1 -> keycode=
 0x2a [shift]
  19237@1545158356.896528:vnc_key_event_map down 1, sym 0x3c -> keycode 0=
x33 [comma]
  19237@1545158356.993672:vnc_key_event_map down 0, sym 0x3c -> keycode 0=
x33 [comma]
  19237@1545158357.233437:vnc_key_event_map down 0, sym 0xffe1 -> keycode=
 0x2a [shift]

  19237@1545158358.726002:vnc_key_event_map down 1, sym 0xffe1 -> keycode=
 0x2a [shift]
  19237@1545158358.999542:vnc_key_event_map down 1, sym 0x3c -> keycode 0=
x33 [comma]
  19237@1545158359.201503:vnc_key_event_map down 0, sym 0xffe1 -> keycode=
 0x2a [shift]
  19237@1545158359.435021:vnc_key_event_map down 0, sym 0x3c -> keycode 0=
x56 [less]

Notice how we sent a "down(comma)" and paired it with an "up(less)". This
causes the guest to consider the key stuck down, so next time you type
a "<" it will get lost.

This is easily reproduced with gtk-vnc and the following QEMU command
line:

  ./x86_64-softmmu/qemu-system-x86_64 -vnc :1 -d trace:vnc*=20


I don't see any nice way to fix the problem without having to keep a
memory of modifier state with every "down" event, so you can use the
same modifier state with the later "up" event to ensure you get a
matching key up.  This is quite horrible though. I'm more inclined
to revert this patch and find another way to fix the original problem
which won't require the UI frontends to track modifier state.

This problem is reported in

  https://bugs.launchpad.net/bugs/1738283
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1658676

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
