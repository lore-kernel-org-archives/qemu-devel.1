Received: from eggs.gnu.org ([209.51.188.92]:60728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtXr1-0001tR-N1
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:12:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtXqr-0007Wl-MM
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:12:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtXqr-0007Dx-59
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:11:53 -0500
Date: Tue, 12 Feb 2019 13:11:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190212131136.GH9386@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <RO1P152MB1483088A66FD63B63FD7279A97650@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <RO1P152MB1483088A66FD63B63FD7279A97650@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Key repeat is no longer working on TTY and grub
 menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonardo Soares =?utf-8?Q?M=C3=BCller?= <leozinho29_eu@hotmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Feb 12, 2019 at 01:02:42PM +0000, Leonardo Soares M=C3=BCller wro=
te:
> I noticed that the key inputs are no longer repeating when using defaul=
t
> setting on QEMU. For example, if I press "a" and keep it pressed it wil=
l
> print only one "a" instead of repeating them. Another example is when
> deleting text: instead of holding backspace pressed and the text is
> deleted, it's needed to press backspace once for each character.
>=20
> As this makes many tasks much slower, requiring many key presses for
> tasks that were done in a single press, I did a bisect to see when this
> change happened. The result is:
>=20
> 0c0d42737dfdcea872a987ecba6ef55047df8881 is the first bad commit
> commit 0c0d42737dfdcea872a987ecba6ef55047df8881
> Author: Gerd Hoffmann <kraxel@redhat.com>
> Date:   Tue Jan 22 10:28:11 2019 +0100
>=20
>     kbd-state: use state tracker for gtk
>=20
>     Use the new keyboard state tracked for gtk.  Allows to drop the
>     gtk-specific modifier state tracking code.
>=20
>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>     Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>     Message-id: 20190122092814.14919-6-kraxel@redhat.com
>=20
> :040000 040000 e882f144bafca90257a4604b5e62486a1ca038b2
> 0139afe1aee24256c3f711c080b0230ab104074a M	include
> :040000 040000 c258efc06107b944b0627792b9f2377600033118
> 4fd01a25a3e0d1fccca72c35ec58b205aa4fd882 M	ui
>=20
> I'm using the GTK interface and all guests without a Graphical User
> Interface (GUI) are affected by this. This happens on grub menu and on
> TTY of multiple Linux guests.

Yes, this is another regression accidentally introduced by the keyboard
state tracker.

When GTK does key repeat it omits the Up event for repeated keys.

IOW, you get

    Press (a)
    Press (a)
    Press (a)
    Release (a)

Not

    Press (a)
    Release (a)
    Press (a)
    Release (a)
    Press (a)
    Release (a)

The keyboard state tracker doesn't take this into account, so it is
surpressing all except the first Press event.

This might affect other frontends too if they use the same trick for
key repeat

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
