Received: from eggs.gnu.org ([2001:4830:134:3::10]:39766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHZ5r-0007lB-JS
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHZ5q-00046D-Jf
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:41:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cHZ5q-00045F-EZ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:41:18 -0500
Message-ID: <1481820076.21413.23.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 15 Dec 2016 17:41:16 +0100
In-Reply-To: <3fcc534530370027118377dc24d4049a1cef590e.1481807806.git.ossman@cendio.se>
References: <3fcc534530370027118377dc24d4049a1cef590e.1481807806.git.ossman@cendio.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vnc: track LED state separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Ossman <ossman@cendio.se>
Cc: qemu-devel@nongnu.org

On Do, 2016-12-15 at 14:16 +0100, Pierre Ossman wrote:
> Piggy-backing on the modifier state array made it difficult to send
> out updates at the proper times. So keep track of the LED state in
> a separate variable.
>=20
> This also moves the handling up a layer in to the VNC Display object
> since the state is global, and also makes sure the state is readily
> available directly when a client connects.

Better, thanks.

>  static void kbd_leds(void *opaque, int ledstate)
>  {
> -    VncState *vs =3D opaque;
> -    int caps, num, scr;
> -    bool has_changed =3D (ledstate !=3D current_led_state(vs));
> +    VncDisplay *vd =3D opaque;
> +    VncState *client;
> =20
>      trace_vnc_key_guest_leds((ledstate & QEMU_CAPS_LOCK_LED),
>                               (ledstate & QEMU_NUM_LOCK_LED),
>                               (ledstate & QEMU_SCROLL_LOCK_LED));
> =20
> -    caps =3D ledstate & QEMU_CAPS_LOCK_LED ? 1 : 0;
> -    num  =3D ledstate & QEMU_NUM_LOCK_LED  ? 1 : 0;
> -    scr  =3D ledstate & QEMU_SCROLL_LOCK_LED ? 1 : 0;
> +    if (ledstate !=3D vd->ledstate)
> +        return;

Hmm?  Shouldn't that be (ledstate =3D=3D vd->ledstate)?

cheers,
  Gerd
