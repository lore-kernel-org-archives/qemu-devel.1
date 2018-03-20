Received: from eggs.gnu.org ([2001:4830:134:3::10]:60460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyK9V-00086G-Hz
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyK9S-0008Ca-Dz
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:30:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eyK9S-0008CI-5j
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:30:18 -0400
Date: Tue, 20 Mar 2018 16:29:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180320162958.GA4530@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180320093135.26422-1-fl@n621.de>
	<d5ad61b8-1570-0234-fd2a-97dfb174de59@redhat.com>
	<20180320160243.GZ4530@redhat.com>
	<20180320162116.GD15157@nyx.n621.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180320162116.GD15157@nyx.n621.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Larysch <fl@n621.de>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, sw@weilnetz.de

On Tue, Mar 20, 2018 at 05:21:16PM +0100, Florian Larysch wrote:
> On Tue, Mar 20, 2018 at 04:02:44PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > No, it is unsafe - we rely on lockf() to get the mutual exclusion.
> > If a QEMU is running with pidfile locked, and its pid written into
> > it, then a 2nd QEMU comes along it will truncate the pidfile owned
> > by the original QEMU because the truncation happens before it has
> > tried to acquire the lock. The 2nd QEMU will still exit, but the
> > original QEMU's pid has now been lost.
>=20
> That's correct, thanks for pointing it out.
>=20
> > We must call ftruncate() after lockf(), but before writing the new
> > pid into the file. That ensures there is no window in which it is
> > possible to see the new & old pids mixed together.
>=20
> I'll send a revised version doing exactly that.
>=20
> From my reading of the Windows API documentation, this might not be a
> problem there: The file is opened with FILE_SHARE_READ, which prohibits
> opening the file in a writable mode and CREATE_ALWAYS will only recreat=
e
> the file if it is writable.

I don't think that's correct either I'm afraid.

FILE_SHARE_READ indicates whether other processes are allowed to open
the file in read-only mode, while we have it open for write.

We're passing GENERIC_WRITE so QEMU has it open for write, thus your
change will again cause the 2nd QEMU to blindly replace the file
owned by the original QEMU.

That said, I think the existing pidfile code for win32 is totally broken
because QEMU is closing it immediately after writing its pid. So the only
mutual exclusion is taking place in the tiny time window while QEMU is
writing the pid.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
