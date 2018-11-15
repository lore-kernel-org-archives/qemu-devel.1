Received: from eggs.gnu.org ([2001:4830:134:3::10]:54790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNEyB-0007Pr-Ne
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNEy7-0004dE-MA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:33:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gNEy7-0004TJ-EP
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:33:51 -0500
Date: Thu, 15 Nov 2018 10:33:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181115103314.GI10900@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-10-berrange@redhat.com>
	<CAJ+F1CKVJphrzaxsYpZCYOey-3uhW1Pn=QNOpNQRE0ZR5wHPhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKVJphrzaxsYpZCYOey-3uhW1Pn=QNOpNQRE0ZR5wHPhQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, philmd@redhat.com

On Thu, Nov 08, 2018 at 02:23:34AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> On Fri, Oct 19, 2018 at 5:42 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > Add a QAuthZListFile object type that implements the QAuthZ interface=
. This
> > built-in implementation is a proxy around the QAtuhZList object type,
> > initializing it from an external file, and optionally, automatically
> > reloading it whenever it changes.
> >
> > To create an instance of this object via the QMP monitor, the syntax
> > used would be:
> >
> >       {
> >         "execute": "object-add",
> >         "arguments": {
> >           "qom-type": "authz-list-file",
> >           "id": "authz0",
> >           "parameters": {
> >             "filename": "/etc/qemu/vnc.acl",
> >             "refresh": "yes"
> >           }
> >         }
> >       }
> >
> > If "refresh" is "yes", inotify is used to monitor the file,
> > automatically reloading changes. If an error occurs during reloading,
> > all authorizations will fail until the file is next successfully
> > loaded.
> >
> > The /etc/qemu/vnc.acl file would contain a JSON representation of a
> > QAuthZList object
> >
> >     {
> >       "rules": [
> >          { "match": "fred", "policy": "allow", "format": "exact" },
> >          { "match": "bob", "policy": "allow", "format": "exact" },
> >          { "match": "danb", "policy": "deny", "format": "glob" },
> >          { "match": "dan*", "policy": "allow", "format": "exact" },
> >       ],
> >       "policy": "deny"
> >     }
> >
> > This sets up an authorization rule that allows 'fred', 'bob' and anyo=
ne
> > whose name starts with 'dan', except for 'danb'. Everyone unmatched i=
s
> > denied.
> >
> > The object can be loaded on the comand line using
> >
> >    -object authz-list-file,id=3Dauthz0,filename=3D/etc/qemu/vnc.acl,r=
efresh=3Dyes
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  include/authz/listfile.h | 110 +++++++++++++++
> >  authz/listfile.c         | 286 +++++++++++++++++++++++++++++++++++++=
++
> >  authz/Makefile.objs      |   1 +
> >  authz/trace-events       |   4 +
> >  qemu-options.hx          |  46 +++++++
> >  5 files changed, 447 insertions(+)
> >  create mode 100644 include/authz/listfile.h
> >  create mode 100644 authz/listfile.c

> > +static void
> > +qauthz_list_file_prop_set_filename(Object *obj,
> > +                                   const char *value,
> > +                                   Error **errp G_GNUC_UNUSED)
> > +{
> > +    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(obj);
> > +
> > +    fauthz->filename =3D g_strdup(value);
>=20
> Either prevent from modifying the filename, or free the exisiting value=
.

I'm freeing existing value.

>=20
> other than that (and the lack of test)

...and adding a test

> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
