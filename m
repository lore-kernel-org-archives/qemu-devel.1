Received: from eggs.gnu.org ([2001:4830:134:3::10]:46159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaIdP-0005hx-60
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaIdK-0003mn-U6
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:06:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gaIdK-0003mD-Nf
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:06:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C08CF420A4
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 11:06:21 +0000 (UTC)
Date: Fri, 21 Dec 2018 11:06:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181221110613.GG7439@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219120904.17643-4-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/7] sdl2: use only QKeyCode in
 sdl2_process_key()
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

On Wed, Dec 19, 2018 at 01:09:00PM +0100, Gerd Hoffmann wrote:
> Small cleanup.  Also drop the special backspace handling,
> kbd_put_qcode_console() learned to handle that meanwhile.

I'm not seeing what backspace handlking is changed in this
patch - i guess this comment is left over from a previous
version of the patch.

> And sdl2_process_key is never called with scon =3D=3D NULL.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/sdl2-input.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
> index ae52d548f6..78241c2a98 100644
> --- a/ui/sdl2-input.c
> +++ b/ui/sdl2-input.c
> @@ -39,20 +39,19 @@ void sdl2_process_key(struct sdl2_console *scon,
>                        SDL_KeyboardEvent *ev)
>  {
>      int qcode;
> -    QemuConsole *con =3D scon ? scon->dcl.con : NULL;
> +    QemuConsole *con =3D scon->dcl.con;
> =20
>      if (ev->keysym.scancode >=3D qemu_input_map_usb_to_qcode_len) {
>          return;
>      }
> -
>      qcode =3D qemu_input_map_usb_to_qcode[ev->keysym.scancode];
>      kbd_state_key_event(scon->kbd, qcode, ev->type =3D=3D SDL_KEYDOWN)=
;
> =20
>      if (!qemu_console_is_graphic(con)) {
>          bool ctrl =3D kbd_state_modifier_get(scon->kbd, KBD_MOD_CTRL);
>          if (ev->type =3D=3D SDL_KEYDOWN) {
> -            switch (ev->keysym.scancode) {
> -            case SDL_SCANCODE_RETURN:
> +            switch (qcode) {
> +            case Q_KEY_CODE_RET:
>                  kbd_put_keysym_console(con, '\n');
>                  break;
>              default:

With fixed commit message

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
