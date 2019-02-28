Received: from eggs.gnu.org ([209.51.188.92]:46973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzQGu-0001Mi-T6
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzQGs-0002z7-Ma
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:19:03 -0500
Date: Thu, 28 Feb 2019 18:18:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190228181812.GJ9217@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227162035.18543-1-berrange@redhat.com>
	<20190227162035.18543-2-berrange@redhat.com>
	<e6944ece-e00e-643a-fa71-deb18841e2fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6944ece-e00e-643a-fa71-deb18841e2fb@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/3] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Juan Quintela <quintela@redhat.com>

On Thu, Feb 28, 2019 at 12:11:00PM -0600, Eric Blake wrote:
> On 2/27/19 10:20 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > Currently any client which can complete the TLS handshake is able to =
use
> > the NBD server. The server admin can turn on the 'verify-peer' option
> > for the x509 creds to require the client to provide a x509 certificat=
e.
> > This means the client will have to acquire a certificate from the CA
> > before they are permitted to use the NBD server. This is still a fair=
ly
> > low bar to cross.
> >=20
> > This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command wh=
ich
> > takes the ID of a previously added 'QAuthZ' object instance. This wil=
l
> > be used to validate the client's x509 distinguished name. Clients
> > failing the authorization check will not be permitted to use the NBD
> > server.
>=20
> It doesn't hold up this patch, but I note that with the qemu QMP comman=
d
> changes you make in 2/3, you document that the object can be
> created/removed on the fly, and the server will adjust which clients ca=
n
> then subsequently connect. Is there any need for the same sort of
> runtime configurability in qemu-nbd, and if so, how would we accomplish
> it?  Perhaps by having a command-line option to parse --tls-authz from =
a
> file, where you can send SIGHUP to qemu-nbd to force it to re-read the
> file?  Or am I worrying about something unlikely to be needed in practi=
ce?

Well the QAuthZListFile object type can store its contents in an external
file that gets auto-reloaded upon inotify triggers from the main loop.
The QAuthZPAM type can also be fairly dynamic depending on its backend.
I think any single process is unlikely  to need to switch between
different object types, so this is good enough dynamic support.

I can't help thinking we should add QMP to qemu-nbd one day though....

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
