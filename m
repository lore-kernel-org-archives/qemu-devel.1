Received: from eggs.gnu.org ([2001:4830:134:3::10]:59812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVbiG-000664-4d
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVbiC-00061K-7Y
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:55:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVbiC-000610-0b
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:55:44 -0400
Date: Wed, 20 Jun 2018 12:55:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180620115538.GL3441@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180620103555.1342-1-berrange@redhat.com>
	<20180620103555.1342-10-berrange@redhat.com>
	<20180620105800.GI2549@work-vm> <20180620111107.GJ3441@redhat.com>
	<20180620112938.GK2549@work-vm> <20180620113442.GK3441@redhat.com>
	<20180620113842.GL2549@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180620113842.GL2549@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Wed, Jun 20, 2018 at 12:38:42PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Wed, Jun 20, 2018 at 12:29:38PM +0100, Dr. David Alan Gilbert wrot=
e:
> > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > On Wed, Jun 20, 2018 at 11:58:01AM +0100, Dr. David Alan Gilbert =
wrote:
> > > > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > > > Add a QAuthZListFile object type that implements the QAuthZ i=
nterface. This
> > > > > > built-in implementation is a proxy around the QAtuhZList obje=
ct type,
> > > > > > initializing it from an external file, and optionally, automa=
tically
> > > > > > reloading it whenever it changes.
> > > > > >=20
> > > > > > To create an instance of this object via the QMP monitor, the=
 syntax
> > > > > > used would be:
> > > > > >=20
> > > > > >       {
> > > > > >         "execute": "object-add",
> > > > > >         "arguments": {
> > > > > >           "qom-type": "authz-list-file",
> > > > > >           "id": "authz0",
> > > > > >           "parameters": {
> > > > > >             "filename": "/etc/qemu/vnc.acl",
> > > > > > 	    "refresh": "yes"
> > > > > >           }
> > > > > >         }
> > > > > >       }
> > > > > >=20
> > > > > > If "refresh" is "yes", inotify is used to monitor the file,
> > > > > > automatically reloading changes. If an error occurs during re=
loading,
> > > > > > all authorizations will fail until the file is next successfu=
lly
> > > > > > loaded.
> > > > >=20
> > > > > I'm curious about the 'refresh' stuff:
> > > > >   a) If refresh=3Dno is there a way to explicitly ask for a ref=
resh
> > > > >      when some tool knows it's finished with fiddling with the =
file.
> > > >=20
> > > > If refresh=3Dno, then you can still use  object_del + object_add =
to
> > > > recreate the ACL object which will cause new content to be picked
> > > > up.
> > >=20
> > > But if I have a VNC/NBD/etc listening, won't it be bound to the old
> > > object, so I can't delete the old object?
> >=20
> > That's ok actually - the network servers merely record the ID of the
> > authz object. They resolve that to an actual object instance at the
> > time they do the authorization check, and failsafe to DENY if it is
> > missing. So you can safely delete & recreate on the fly.
>=20
> OK, that needs documenting; binding it at the time of parsing wouldn't
> be surprising to anyone except for that use.

I'll document that explicitly against each network service that I wire th=
is
functionality up to, in the second dependent patch series.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
