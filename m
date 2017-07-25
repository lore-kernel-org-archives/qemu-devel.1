Received: from eggs.gnu.org ([2001:4830:134:3::10]:54469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvH3-0006KY-ME
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvH0-0001WC-II
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:33:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZvH0-0001Vm-97
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:32:58 -0400
Date: Tue, 25 Jul 2017 09:32:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725083251.GB26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724164601.21063-1-berrange@redhat.com>
	<88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10] ps2: fix sending of PAUSE/BREAK
 scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Jul 24, 2017 at 09:55:20PM +0200, Herv=C3=A9 Poussineau wrote:
> Le 24/07/2017 =C3=A0 18:46, Daniel P. Berrange a =C3=A9crit :
> > The processing of the scancodes for PAUSE/BREAK  has been broken sinc=
e
> > the conversion to qcodes in:
> >=20
> >   commit 8c10e0baf0260b59a4e984744462a18016662e3e
> >   Author: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> >   Date:   Thu Sep 15 22:06:26 2016 +0200
> >=20
> >     ps2: use QEMU qcodes instead of scancodes
> >=20
> > When using a VNC client, with the raw scancode extension, the client
> > will send a scancode of 0xc6 for both PAUSE and BREAK. There is mista=
kenly
> > no entry in the qcode_to_number table for this scancode, so
> > ps2_keyboard_event() just generates a log message and discards the
> > scancode
> >=20
> > When using a SPICE client, it will also send 0xc6 for BREAK, but
> > will send 0xe1 0x1d 0x45 0xe1 0x9d 0xc5 for PAUSE. There is no
> > entry in the qcode_to_number table for the scancode 0xe1 because
> > it is a special XT keyboard prefix not mapping to any QKeyCode.
> > Again ps2_keyboard_event() just generates a log message and discards
> > the scancode. The following 0x1d, 0x45, 0x9d, 0xc5 scancodes get
> > handled correctly. Fixing this just requires special casing 0xe1 so
> > it is directly queued for sending to the guest, skipping any conversi=
on
> > to QKeyCode.
>=20
> Your commit message is divided in 2 parts, and you're touching 1 file f=
or each part of the commit message.
> Should it be 2 patches instead?
>=20
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  hw/input/ps2.c    | 7 +++++++
> >  ui/input-keymap.c | 1 +
> >  2 files changed, 8 insertions(+)
> >=20
> > diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> > index 3ba05efd06..a132d1ba72 100644
> > --- a/hw/input/ps2.c
> > +++ b/hw/input/ps2.c
> > @@ -607,6 +607,13 @@ static void ps2_keyboard_event(DeviceState *dev,=
 QemuConsole *src,
> >      assert(evt->type =3D=3D INPUT_EVENT_KIND_KEY);
> >      qcode =3D qemu_input_key_value_to_qcode(key->key);
> >=20
> > +    if (qcode =3D=3D 0 &&
> > +        key->key->type =3D=3D KEY_VALUE_KIND_NUMBER &&
> > +        key->key->u.number.data =3D=3D 0x61) {
> > +        ps2_put_keycode(s, 0xe1);
> > +        return;
> > +    }
> > +
>=20
> You're putting some specific code for spice in ps2 emulation.
> IMO, the workaround should be moved to spice keyboard handling (ui/spic=
e-input.c),
> which needs to generate a qcode instead of a scancode.

This isn't really a spice specific hack. QEMU internal code is *not* requ=
ired
to use qcodes - the KeyValue struct is a union that allows use of either =
qcodes
or XT scancodes, and the latter is what all the frontends (SPICE, VNC, GT=
k, SDL)
use. QCodes are really only input by the monitor (the sendkey command).

> Here, you're making ps2 emulation work again with spice, but you're mis=
sing all
> other emulations using qcodes. Do you want to also modify them?

I checked the USB keyboard device and that works fine. AFAIK, the PS/2
code is the only code that takes XT scancodes, converts to qcode and
then converts qcodes back to scancodes - most others avoid this kind of
roundtripping via qcodes.

> I understand that it may be the easiest way to fix the regression for 2=
.10, but
> it needs at least a comment.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
