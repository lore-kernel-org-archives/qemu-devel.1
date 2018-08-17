Received: from eggs.gnu.org ([2001:4830:134:3::10]:35369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqh2d-0006F0-8F
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqh2a-00018Q-1q
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:51:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqh2Z-000189-TD
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:51:55 -0400
Date: Fri, 17 Aug 2018 16:51:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817155152.GV11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180817150513.GT11124@redhat.com>
	<6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phillip Susi <psusi@ubuntu.com>
Cc: qemu-devel@nongnu.org

On Fri, Aug 17, 2018 at 11:16:29AM -0400, Phillip Susi wrote:
> On 8/17/2018 11:05 AM, Daniel P. Berrang=C3=A9 wrote:
> > Reading again, this is a bit odd. On most keyboards, holding down shi=
ft
> > key generally would NOT change the scan code that is reported (there =
are a
>=20
> Right; a real keyboard won't change the scan code, but it seems that
> European keyboards have this extra key that can also produce a |, so
> when qemu gets the key code for |, it has to pick one scan code or the
> other to translate the | into, and it picks the wrong one.
>=20
> Looking at the code it looks like qemu has its own qcode set and
> translates between that and all of these other sets.  I'm guessing
> either input-keymap-linux-to-qcode.c or input-keymap-x11-to-qcode.c is
> where the error is, but these do not exist so I guess they must be auto
> generated somehow by the build process?
>=20
> Actually, which one of those code sets is vnc using?

Since you're using tightvnc on Windows, it won't be using the raw scancod=
e
extension to RFB, so it'll be sending X keysyms across the wire eg=20

  "|" has X11 keysym 0x7c  (XK_bar)
  "\" has X11 keysym 0x5c  (XK_backslash)

First thing is the converting keysym number to a name, which
uses name2keysym[] data table.  This gives 'bar' and 'backslash'
as names, respectively

The names are now looked up in the keymap (pc-bios/keymaps/en-us)
which says

  backslash 0x2b
  bar 0x2b shift

QEMU now has a Qcode that it can pass to the ps2 frontend
which converts to the AT set 1/2 scancode for injection to
the guest.

Any one of those many steps could be going wrong and its hard
to see which, without being able to reproduce it myself

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
