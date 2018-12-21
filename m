Received: from eggs.gnu.org ([2001:4830:134:3::10]:49134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaIor-0000us-IS
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaIol-0005sV-7Z
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gaIok-0005rP-U3
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:18:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1B3440F0D
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 11:18:09 +0000 (UTC)
Date: Fri, 21 Dec 2018 11:18:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181221111801.GI7439@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219120904.17643-6-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/7] kbd-state: use state tracker
 for vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Dec 19, 2018 at 01:09:02PM +0100, Gerd Hoffmann wrote:
> Use the new keyboard state tracked for vnc.  Allows to drop the
> vnc-specific modifier state tracking code.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/vnc.h |   5 ++-
>  ui/vnc.c | 120 ++++++++++++++++++---------------------------------------------
>  2 files changed, 35 insertions(+), 90 deletions(-)
> 
> diff --git a/ui/vnc.h b/ui/vnc.h
> index a86e0610e8..56111908ce 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -44,6 +44,7 @@
>  #include "keymaps.h"
>  #include "vnc-palette.h"
>  #include "vnc-enc-zrle.h"
> +#include "ui/kbd-state.h"
>  
>  // #define _VNC_DEBUG 1
>  
> @@ -155,7 +156,7 @@ struct VncDisplay
>      int lock_key_sync;
>      QEMUPutLEDEntry *led;
>      int ledstate;
> -    int key_delay_ms;
> +    KbdState *kbd;
>      QemuMutex mutex;
>  
>      QEMUCursor *cursor;
> @@ -326,8 +327,6 @@ struct VncState
>  
>      VncReadEvent *read_handler;
>      size_t read_handler_expect;
> -    /* input */
> -    uint8_t modifiers_state[256];
>  
>      bool abort;
>      QemuMutex output_mutex;
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 0c1b477425..b56431ce3b 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c


> @@ -1797,32 +1780,20 @@ static void kbd_leds(void *opaque, int ledstate)
>  
>  static void do_key_event(VncState *vs, int down, int keycode, int sym)
>  {
> +    QKeyCode qcode = qemu_input_key_number_to_qcode(keycode);
> +
>      /* QEMU console switch */
> -    switch(keycode) {
> -    case 0x2a:                          /* Left Shift */
> -    case 0x36:                          /* Right Shift */
> -    case 0x1d:                          /* Left CTRL */
> -    case 0x9d:                          /* Right CTRL */
> -    case 0x38:                          /* Left ALT */
> -    case 0xb8:                          /* Right ALT */
> -        if (down)
> -            vs->modifiers_state[keycode] = 1;
> -        else
> -            vs->modifiers_state[keycode] = 0;
> -        break;


This code updated modifier state as the first thing in do_key_event


[snip]

> @@ -1859,30 +1828,25 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
>             toggles capslock away from the VNC window.
>          */
>          int uppercase = !!(sym >= 'A' && sym <= 'Z');
> -        int shift = !!(vs->modifiers_state[0x2a] | vs->modifiers_state[0x36]);
> -        int capslock = !!(vs->modifiers_state[0x3a]);
> +        bool shift = kbd_state_modifier_get(vs->vd->kbd, KBD_MOD_SHIFT);
> +        bool capslock = kbd_state_modifier_get(vs->vd->kbd, KBD_MOD_CAPSLOCK);

This uses the modifier state

In old code it would use the newly updated modifier state

In new code it now uses the old modifier state.

>          if (capslock) {
>              if (uppercase == shift) {
>                  trace_vnc_key_sync_capslock(false);
> -                vs->modifiers_state[0x3a] = 0;
> -                press_key(vs, 0xffe5);
> +                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
>              }
>          } else {
>              if (uppercase != shift) {
>                  trace_vnc_key_sync_capslock(true);
> -                vs->modifiers_state[0x3a] = 1;
> -                press_key(vs, 0xffe5);
> +                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
>              }
>          }
>      }
>  
> -    if (qemu_console_is_graphic(NULL)) {
> -        qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, down);
> -        qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
> -    } else {
> -        bool numlock = vs->modifiers_state[0x45];
> -        bool control = (vs->modifiers_state[0x1d] ||
> -                        vs->modifiers_state[0x9d]);
> +    kbd_state_key_event(vs->vd->kbd, qcode, down);

This updates modifier state in the new code, after the code above that
uses modifier state.

Is this ordering change intentional ?


> +    if (!qemu_console_is_graphic(NULL)) {
> +        bool numlock = kbd_state_modifier_get(vs->vd->kbd, KBD_MOD_NUMLOCK);
> +        bool control = kbd_state_modifier_get(vs->vd->kbd, KBD_MOD_CTRL);
>          /* QEMU console emulation */
>          if (down) {
>              switch (keycode) {
> @@ -1983,27 +1947,6 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
>      }
>  }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
