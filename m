Received: from eggs.gnu.org ([2001:4830:134:3::10]:45722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaIba-0004nH-M1
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaIbU-0000uT-ND
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:04:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gaIbS-0000dF-Mj
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:04:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB266C059B6F
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 11:04:13 +0000 (UTC)
Date: Fri, 21 Dec 2018 11:04:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181221110406.GF7439@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219120904.17643-3-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/7] kbd-state: use state tracker
 for sdl2
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

On Wed, Dec 19, 2018 at 01:08:59PM +0100, Gerd Hoffmann wrote:
> Use the new keyboard state tracked for sdl2.  We can drop the modifier
> state tracking from sdl2.  Also keyup code is simpler, the state tracke=
r
> will take care to not send suspious keyup events to the guest.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/sdl2.h |  2 ++
>  ui/sdl2-input.c   | 40 +++-------------------------------------
>  ui/sdl2.c         | 12 +++---------
>  3 files changed, 8 insertions(+), 46 deletions(-)
>=20
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index f43eecdbd6..393f4b0fd5 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -7,6 +7,7 @@

> diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
> index 1378b63dd9..ae52d548f6 100644
> --- a/ui/sdl2-input.c
> +++ b/ui/sdl2-input.c
> @@ -30,22 +30,9 @@
>  #include "ui/sdl2.h"
>  #include "sysemu/sysemu.h"
> =20
> -static uint8_t modifiers_state[SDL_NUM_SCANCODES];
> -
>  void sdl2_reset_keys(struct sdl2_console *scon)
>  {
> -    QemuConsole *con =3D scon ? scon->dcl.con : NULL;
> -    int i;
> -
> -    for (i =3D 0 ;
> -         i < SDL_NUM_SCANCODES && i < qemu_input_map_usb_to_qcode_len =
;
> -         i++) {
> -        if (modifiers_state[i]) {
> -            int qcode =3D qemu_input_map_usb_to_qcode[i];
> -            qemu_input_event_send_key_qcode(con, qcode, false);
> -            modifiers_state[i] =3D 0;
> -        }
> -    }
> +    kbd_state_lift_all_keys(scon->kbd);
>  }

I was wondering if we could just make the callers of sdl2_reset_keys
call  kbd_state_lift_all_keys directly. I can't find any callers of
sdl2_reset_keys at all though. It appears you removed all callers
in

  commit f8d2c9369b8302f65f4f43f14ed3987c2268a02a
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Mon Jan 15 16:48:54 2018 +0100

    sdl: use ctrl-alt-g as grab hotkey

So I guess we could have a prior patch that just deletes this method
entirely.


For the rest of the patch

  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
