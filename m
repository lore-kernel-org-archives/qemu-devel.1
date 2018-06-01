Received: from eggs.gnu.org ([2001:4830:134:3::10]:40203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fOpMo-0007Na-T8
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fOpMl-0000Jl-KS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:05:38 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:42293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fOpMl-0000Iy-DG
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 15:05:35 -0400
Received: by mail-io0-x244.google.com with SMTP id a10-v6so30856912ioc.9
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 12:05:35 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180221170820.15365-3-kraxel@redhat.com>
Date: Fri, 1 Jun 2018 15:05:32 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <78856018-DE4F-42C2-899F-428FE7E55141@gmail.com>
References: <20180221170820.15365-1-kraxel@redhat.com>
	<20180221170820.15365-3-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/5] kbd-state: add hotkey registry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peter.maydell@linaro.org


> On Feb 21, 2018, at 12:08 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> Add support to register hotkeys and to check whenever a given QKeyCode
> combined with the current modifier state is a hotkey.  A hotkey can be
> any key combined with up to three modifier keys.

I have finally reviewed the patches you sent to me. Sorry it took so =
long. The patches you sent look good.=20

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> include/ui/kbd-state.h | 27 +++++++++++++++++++++++++++
> ui/kbd-state.c         | 41 +++++++++++++++++++++++++++++++++++++----
> 2 files changed, 64 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
> index c961da45b2..3f13649b63 100644
> --- a/include/ui/kbd-state.h
> +++ b/include/ui/kbd-state.h
> @@ -20,3 +20,30 @@ bool kbd_state_key_get(KbdState *kbd, QKeyCode =
qcode);
> void kbd_state_key_event(KbdState *kbd, QKeyCode qcode, bool down);
> void kbd_state_lift_all_keys(KbdState *kbd);
> KbdState *kbd_state_init(QemuConsole *con);
> +
> +/* ------------------------------------------------------------------ =
*/
> +
> +typedef enum KbdHotkey KbdHotkey;
> +
> +enum KbdHotkey {
> +    KBD_HOTKEY_NONE =3D 0,
> +
> +    KBD_HOTKEY_GRAB,
> +    KBD_HOTKEY_FULLSCREEN,
> +    KBD_HOTKEY_REDRAW,
> +
> +    KBD_HOTKEY_CONSOLE_1,
> +    KBD_HOTKEY_CONSOLE_2,
> +    KBD_HOTKEY_CONSOLE_3,
> +    KBD_HOTKEY_CONSOLE_4,
> +    KBD_HOTKEY_CONSOLE_5,
> +    KBD_HOTKEY_CONSOLE_6,
> +    KBD_HOTKEY_CONSOLE_7,
> +    KBD_HOTKEY_CONSOLE_8,
> +    KBD_HOTKEY_CONSOLE_9,
> +};
> +
> +void kbd_state_hotkey_register(KbdState *kbd, KbdHotkey, QKeyCode =
qcode,
> +                               KbdModifier mod1, KbdModifier mod2,
> +                               KbdModifier mod3);
> +KbdHotkey kbd_state_hotkey_get(KbdState *kbd, QKeyCode qcode);
> diff --git a/ui/kbd-state.c b/ui/kbd-state.c
> index 7a9fe268c2..812cb368e3 100644
> --- a/ui/kbd-state.c
> +++ b/ui/kbd-state.c
> @@ -6,20 +6,20 @@
> #include "ui/input.h"
> #include "ui/kbd-state.h"
>=20
> -typedef struct KbdHotkey KbdHotkey;
> +typedef struct KbdHotkeyEntry KbdHotkeyEntry;
>=20
> -struct KbdHotkey {
> +struct KbdHotkeyEntry {
>     uint32_t id;
>     QKeyCode qcode;
>     DECLARE_BITMAP(mods, KBD_MOD__MAX);
> -    QTAILQ_ENTRY(KbdHotkey) next;
> +    QTAILQ_ENTRY(KbdHotkeyEntry) next;
> };
>=20
> struct KbdState {
>     QemuConsole *con;
>     DECLARE_BITMAP(keys, Q_KEY_CODE__MAX);
>     DECLARE_BITMAP(mods, KBD_MOD__MAX);
> -    QTAILQ_HEAD(,KbdHotkey) hotkeys;
> +    QTAILQ_HEAD(, KbdHotkeyEntry) hotkeys;
> };
>=20
> static void kbd_state_modifier_update(KbdState *kbd,
> @@ -117,3 +117,36 @@ KbdState *kbd_state_init(QemuConsole *con)
>=20
>     return kbd;
> }
> +
> +void kbd_state_hotkey_register(KbdState *kbd, KbdHotkey id, QKeyCode =
qcode,
> +                               KbdModifier mod1, KbdModifier mod2,
> +                               KbdModifier mod3)
> +{
> +    KbdHotkeyEntry *hotkey =3D g_new0(KbdHotkeyEntry, 1);
> +
> +    hotkey->id    =3D id;
> +    hotkey->qcode =3D qcode;
> +    if (mod1 !=3D KBD_MOD_NONE) {
> +        set_bit(mod1, hotkey->mods);
> +    }
> +    if (mod2 !=3D KBD_MOD_NONE) {
> +        set_bit(mod2, hotkey->mods);
> +    }
> +    if (mod3 !=3D KBD_MOD_NONE) {
> +        set_bit(mod3, hotkey->mods);
> +    }
> +    QTAILQ_INSERT_TAIL(&kbd->hotkeys, hotkey, next);
> +}

You say the hotkey is a QKeyCode and a modifier key combined. But it =
looks like a single QKeyCode would be supported. I would prefer being =
able to use a single key like F16 to ungrab the mouse. Would that be =
possible here?

Kbd_state_hotkey_register(kbd, KBD_HOTKEY_GRAB, Q_KEY_CODE_F16, =
KBD_MOD_NONE, KBD_MOD_NONE, KBD_MOD_NONE);

> +
> +KbdHotkey kbd_state_hotkey_get(KbdState *kbd, QKeyCode qcode)
> +{
> +    KbdHotkeyEntry *hotkey;
> +
> +    QTAILQ_FOREACH(hotkey, &kbd->hotkeys, next) {
> +        if (qcode =3D=3D hotkey->qcode &&
> +            bitmap_equal(kbd->mods, hotkey->mods, KBD_MOD__MAX)) {
> +            return hotkey->id;
> +        }
> +    }
> +    return KBD_HOTKEY_NONE;
> +}
> --=20
> 2.9.3
>=20

=20
