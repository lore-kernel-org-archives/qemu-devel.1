Received: from eggs.gnu.org ([2001:4830:134:3::10]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUHr-0003UD-I5
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUHo-0007LH-31
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:53:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDUHn-0007Jt-ON
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:53:51 -0400
Date: Fri, 19 Oct 2018 13:53:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019125342.GS13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-10-berrange@redhat.com>
	<b1d61bfd-cc34-2103-35a1-86bd828e7a93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1d61bfd-cc34-2103-35a1-86bd828e7a93@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Fri, Oct 19, 2018 at 11:41:45AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 09/10/2018 15:04, Daniel P. Berrang=C3=A9 wrote:
> > Add a QAuthZListFile object type that implements the QAuthZ interface=
. This
> > built-in implementation is a proxy around the QAtuhZList object type,
> > initializing it from an external file, and optionally, automatically
> > reloading it whenever it changes.
> >=20
> > To create an instance of this object via the QMP monitor, the syntax
> > used would be:
> >=20
> >       {
> >         "execute": "object-add",
> >         "arguments": {
> >           "qom-type": "authz-list-file",
> >           "id": "authz0",
> >           "parameters": {
> >             "filename": "/etc/qemu/vnc.acl",
> > 	    "refresh": "yes"
> >           }
> >         }
> >       }
> >=20
> > If "refresh" is "yes", inotify is used to monitor the file,
> > automatically reloading changes. If an error occurs during reloading,
> > all authorizations will fail until the file is next successfully
> > loaded.
> >=20
> > The /etc/qemu/vnc.acl file would contain a JSON representation of a
> > QAuthZList object
> >=20
> >     {
> >       "rules": [
> >          { "match": "fred", "policy": "allow", "format": "exact" },
> >          { "match": "bob", "policy": "allow", "format": "exact" },
> >          { "match": "danb", "policy": "deny", "format": "glob" },
> >          { "match": "dan*", "policy": "allow", "format": "exact" },
> >       ],
> >       "policy": "deny"
> >     }
> >=20
> > This sets up an authorization rule that allows 'fred', 'bob' and anyo=
ne
> > whose name starts with 'dan', except for 'danb'. Everyone unmatched i=
s
> > denied.
> >=20
> > The object can be loaded on the comand line using
> >=20
> >    -object authz-list-file,id=3Dauthz0,filename=3D/etc/qemu/vnc.acl,r=
efresh=3Dyes
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  authz/Makefile.objs      |   1 +
> >  authz/listfile.c         | 284 +++++++++++++++++++++++++++++++++++++=
++
> >  authz/trace-events       |   4 +
> >  include/authz/listfile.h | 110 +++++++++++++++
> >  qemu-options.hx          |  47 +++++++
> >  5 files changed, 446 insertions(+)
> >  create mode 100644 authz/listfile.c
> >  create mode 100644 include/authz/listfile.h
> >=20

> > +static void
> > +qauthz_list_file_event(int wd G_GNUC_UNUSED,
> > +                       QFileMonitorEvent ev G_GNUC_UNUSED,
> > +                       const char *name G_GNUC_UNUSED,
> > +                       void *opaque)
> > +{
> > +    QAuthZListFile *fauthz =3D opaque;
> > +    Error *err =3D NULL;
> > +
> > +    if (ev !=3D QFILE_MONITOR_EVENT_MODIFIED &&
> > +        ev !=3D QFILE_MONITOR_EVENT_CREATED)
>=20
> You missed:
>=20
>                                               {
>=20
> > +        return;
>=20
>        }

Opps, yes.


> > +static void
> > +qauthz_list_file_complete(UserCreatable *uc, Error **errp)
> > +{
> > +    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(uc);
> > +
> > +    fauthz->list =3D qauthz_list_file_load(fauthz, errp);
> > +
> > +    if (fauthz->refresh) {
>=20
> Can we invert this condition?

Yes, will do

>=20
> > +        gchar *dir, *file;
> > +        fauthz->file_monitor =3D qemu_file_monitor_get_instance(errp=
);
> > +        if (!fauthz->file_monitor) {
> > +            return;
> > +        }
> > +
> > +        dir =3D g_path_get_dirname(fauthz->filename);
> > +        if (g_str_equal(dir, ".")) {
> > +            error_setg(errp, "Filename must be an absolute path");
>=20
> What about:
>=20
>                goto cleanup;

Yep.

>=20
> > +            g_free(dir);
> > +            return;
> > +        }
> > +        file =3D g_path_get_basename(fauthz->filename);
> > +        if (g_str_equal(file, ".")) {
> > +            error_setg(errp, "Path has no trailing filename componen=
t");
>=20
>                goto cleanup;
>=20
> > +            g_free(file);
> > +            g_free(dir);
> > +            return;
> > +        }
> > +
> > +        fauthz->file_watch =3D qemu_file_monitor_add_watch(
> > +            fauthz->file_monitor, dir, file,
> > +            qauthz_list_file_event, fauthz, errp);
> > +        g_free(file);
> > +        g_free(dir);
> > +        if (fauthz->file_watch < 0) {
>=20
> Is this really useful? Do you plan to add more code here?

I just want to make it clear to anyone who changes the code
in future that there's an expected failure condition here.

> > +            return;
> > +        }
> > +    }
> > +}

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
