Received: from eggs.gnu.org ([2001:4830:134:3::10]:45659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDU6B-0002AD-E7
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDU68-00021I-5p
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:41:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDU67-00020g-Rx
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:41:48 -0400
Date: Fri, 19 Oct 2018 13:41:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019124139.GQ13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-9-berrange@redhat.com>
	<2bf95805-02c8-2e69-9d31-139f2d34ca3e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bf95805-02c8-2e69-9d31-139f2d34ca3e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 08/11] authz: add QAuthZList object type
 for an access control list
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

On Fri, Oct 19, 2018 at 11:57:45AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 09/10/2018 15:04, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > Add a QAuthZList object type that implements the QAuthZ interface. Th=
is
> > built-in implementation maintains a trivial access control list with =
a
> > sequence of match rules and a final default policy. This replicates t=
he
> > functionality currently provided by the qemu_acl module.
> >=20
> > To create an instance of this object via the QMP monitor, the syntax
> > used would be:
> >=20
> >   {
> >     "execute": "object-add",
> >     "arguments": {
> >       "qom-type": "authz-list",
> >       "id": "authz0",
> >       "parameters": {
> >         "rules": [
> >            { "match": "fred", "policy": "allow", "format": "exact" },
> >            { "match": "bob", "policy": "allow", "format": "exact" },
> >            { "match": "danb", "policy": "deny", "format": "glob" },
> >            { "match": "dan*", "policy": "allow", "format": "exact" },
> >         ],
> >         "policy": "deny"
> >       }
> >     }
> >   }
> >=20
> > This sets up an authorization rule that allows 'fred', 'bob' and anyo=
ne
> > whose name starts with 'dan', except for 'danb'. Everyone unmatched i=
s
> > denied.
> >=20
> > It is not currently possible to create this via -object, since there =
is
> > no syntax supported to specify non-scalar properties for objects. Thi=
s
> > is likely to be addressed by later support for using JSON with -objec=
t,
> > or an equivalent approach.
> >=20
> > In any case the future "authz-listfile" object can be used from the
> > CLI and is likely a better choice, as it allows the ACL to be refresh=
ed
> > automatically on change.
> > +static void
> > +qauthz_list_prop_set_policy(Object *obj,
> > +                            int value,
> > +                            Error **errp G_GNUC_UNUSED)
> > +{
> > +    QAuthZList *bauthz =3D QAUTHZ_LIST(obj);
> > +
>=20
> Here:
>=20
>        g_free(bauthz->policy);

'policy' is an integer, so I don't think we need g_free(0x1) :-)

>=20
> > +    bauthz->policy =3D value;
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
