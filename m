Received: from eggs.gnu.org ([2001:4830:134:3::10]:55337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fW1hZ-0003uL-V6
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fW1hX-00084U-B1
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:40:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fW1hX-00084I-4s
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:40:47 -0400
Date: Thu, 21 Jun 2018 16:40:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180621154043.GP3615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615154203.11347-1-berrange@redhat.com>
	<20180615154203.11347-10-berrange@redhat.com>
	<c32feaa0-3a5b-3781-0f9e-21274f87b58b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c32feaa0-3a5b-3781-0f9e-21274f87b58b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jun 21, 2018 at 10:30:59AM -0500, Eric Blake wrote:
> On 06/15/2018 10:42 AM, Daniel P. Berrang=C3=A9 wrote:
> > Add a QAuthZListFile object type that implements the QAuthZ interface=
. This
> > built-in implementation is a proxy around the QAtuhZList object type,
> > initializing it from an external file, and optionally, automatically
> > reloading it whenever it changes.
> >=20
> > To create an instance of this object via the QMP monitor, the syntax
> > used would be:
> >=20
> >        {
> >          "execute": "object-add",
> >          "arguments": {
> >            "qom-type": "authz-list",
> >            "id": "auth0",
> >            "parameters": {
> >              "filename": "/etc/qemu/vnc.acl",
> > 	    "refresh": "yes"
>=20
> Would this be better as a JSON bool instead of a "yes"/"no" string?

Quiet probably - I'll have to double check it does work

>=20
> TAB damage.
>=20
> >            }
> >          }
> >        }
> >=20
> > If "refresh" is "yes", inotify is used to monitor the file,
> > automatically reloading changes. If an error occurs during reloading,
> > all authorizations will fail until the file is next successfully
> > loaded.
> >=20
> > The /etc/qemu/vnc.acl file would contain a JSON representation of a
> > QAuthZList object
> >=20
> >      {
> >        "rules": [
> >           { "match": "fred", "policy": "allow", "format": "exact" },
> >           { "match": "bob", "policy": "allow", "format": "exact" },
> >           { "match": "danb", "policy": "deny", "format": "glob" },
> >           { "match": "dan*", "policy": "allow", "format": "exact" },
> >        ],
> >        "policy": "deny"
> >      }
> >=20
> > This sets up an authorization rule that allows 'fred', 'bob' and anyo=
ne
> > whose name starts with 'dan', except for 'danb'. Everyone unmatched i=
s
> > denied.
> >=20
> > The object can be loaded on the comand line using
>=20
> s/comand/command/
>=20
> >=20
> >     -object authz-list-file,id=3Dauthz0,filename=3D/etc/qemu/vnc.acl,=
refresh=3Dyes
>=20
> Double dash, for the sake of qemu-img
>=20
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
>=20
> > +/**
> > + * QAuthZListFile:
> > + *
> > + * This authorization driver provides a file mechanism
> > + * for granting access by matching user names against a
> > + * file of globs. Each match rule has an associated policy
> > + * and a catch all policy applies if no rule matches
> > + *
> > + * To create an instance of this class via QMP:
> > + *
> > + *  {
> > + *    "execute": "object-add",
> > + *    "arguments": {
> > + *      "qom-type": "authz-list-file",
> > + *      "id": "authz0",
> > + *      "parameters": {
> > + *        "filename": "/etc/qemu/myvm-vnc.acl",
> > + *        "refresh": "yes"
> > + *      }
>=20
> If you change the commit message to use bool, also change this comment =
to
> match.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
