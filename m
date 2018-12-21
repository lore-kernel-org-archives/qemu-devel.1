Received: from eggs.gnu.org ([2001:4830:134:3::10]:43586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaIU1-00032o-Qu
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 05:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaITx-0000AI-Cl
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 05:56:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gaITx-00008B-4r
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 05:56:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0116673A8F
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 10:56:39 +0000 (UTC)
Date: Fri, 21 Dec 2018 10:56:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181221105631.GE7439@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219120904.17643-2-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/7] kbd-state: add keyboard state
 tracker
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

On Wed, Dec 19, 2018 at 01:08:58PM +0100, Gerd Hoffmann wrote:
> Now that most user interfaces are using QKeyCodes it is easier to have
> common keyboard code useable by all user interfaces.
> 
> This patch adds helper code to track the state of all keyboard keys,
> using a bitmap indexed by QKeyCode.  Modifier state is tracked too,
> as separate bitmap.  That makes checking modifier state easier.
> Likewise we can easily apply special handling for capslock & numlock
> (toggles on keypress) and ctrl + shift (we have two keys for that).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/kbd-state.h |  32 +++++++++++++
>  ui/kbd-state.c         | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
>  ui/Makefile.objs       |   2 +-
>  3 files changed, 158 insertions(+), 1 deletion(-)
>  create mode 100644 include/ui/kbd-state.h
>  create mode 100644 ui/kbd-state.c
> 
> diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
> new file mode 100644
> index 0000000000..0bef75a5d5
> --- /dev/null
> +++ b/include/ui/kbd-state.h
> @@ -0,0 +1,32 @@
> +#ifndef QEMU_UI_KBD_STATE_H
> +#define QEMU_UI_KBD_STATE_H 1
> +
> +#include "qapi/qapi-types-ui.h"
> +
> +typedef enum KbdModifier KbdModifier;
> +
> +enum KbdModifier {
> +    KBD_MOD_NONE = 0,
> +
> +    KBD_MOD_SHIFT,
> +    KBD_MOD_CTRL,
> +    KBD_MOD_ALT,
> +    KBD_MOD_ALTGR,
> +
> +    KBD_MOD_NUMLOCK,
> +    KBD_MOD_CAPSLOCK,
> +
> +    KBD_MOD__MAX
> +};
> +
> +typedef struct KbdState KbdState;
> +
> +bool kbd_state_modifier_get(KbdState *kbd, KbdModifier mod);
> +bool kbd_state_key_get(KbdState *kbd, QKeyCode qcode);
> +void kbd_state_key_event(KbdState *kbd, QKeyCode qcode, bool down);
> +void kbd_state_lift_all_keys(KbdState *kbd);
> +void kbd_state_set_delay(KbdState *kbd, int delay_ms);
> +void kbd_state_free(KbdState *kbd);
> +KbdState *kbd_state_init(QemuConsole *con);

I would suggest using a slightly more QEMU specific namespace "qkbd_"
methods, m"QKBD_" constants, & "QKbd" struct, as 'kbd' is very generic,
but upto you if you want to, or ignore it.

I would, however, like to see API docs written in the header file for
each of these methods.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
