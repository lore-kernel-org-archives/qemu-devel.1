Received: from eggs.gnu.org ([2001:4830:134:3::10]:57326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUap-0007TO-8V
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUak-000558-4A
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDUai-00053o-2P
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:13:24 -0400
Date: Fri, 19 Oct 2018 14:13:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019131313.GU13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-9-berrange@redhat.com>
	<7d4f2fcd-06c2-256b-1a0c-358365d90d41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d4f2fcd-06c2-256b-1a0c-358365d90d41@redhat.com>
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

On Fri, Oct 19, 2018 at 11:33:06AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
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
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  .gitignore              |   4 +
> >  MAINTAINERS             |   1 +
> >  Makefile                |   7 +-
> >  Makefile.objs           |   4 +
> >  authz/Makefile.objs     |   1 +
> >  authz/list.c            | 315 ++++++++++++++++++++++++++++++++++++++=
++
> >  authz/trace-events      |   4 +
> >  include/authz/list.h    | 106 ++++++++++++++

> > +static void
> > +qauthz_list_complete(UserCreatable *uc, Error **errp)
> > +{
>=20
> Is this useful?
>=20
> > +}

No, and it seems we can omit it safely. Same for the previous
patch in this series in fact.

> > +
> > +
> > +static void
> > +qauthz_list_finalize(Object *obj)
> > +{
>=20
> Ditto.

Opps, it should be freeing the 'rules' field.


> > +ssize_t qauthz_list_append_rule(QAuthZList *auth,
> > +                                const char *match,
> > +                                QAuthZListPolicy policy,
> > +                                QAuthZListFormat format,
> > +                                Error **errp)
> > +{
> > +    QAuthZListRule *rule;
> > +    QAuthZListRuleList *rules, *tmp;
> > +    size_t i =3D 0;
> > +
> > +#ifndef CONFIG_FNMATCH
> > +    if (format =3D=3D QAUTHZ_LIST_FORMAT_GLOB) {
> > +        error_setg(errp, "Glob format not supported on this platform=
");
> > +        return -1;
> > +    }
> > +#endif
> > +
> > +    rule =3D g_new0(QAuthZListRule, 1);
> > +    rule->policy =3D policy;
> > +    rule->match =3D g_strdup(match);
> > +    rule->format =3D format;
> > +    rule->has_format =3D true;
> > +
> > +    tmp =3D g_new0(QAuthZListRuleList, 1);
> > +    tmp->value =3D rule;
> > +
> > +    rules =3D auth->rules;
> > +    if (rules) {
> > +        while (rules->next) {
> > +            i++;
> > +            rules =3D rules->next;
> > +        }
> > +        rules->next =3D tmp;
> > +        return i + 1;
> > +    } else {
> > +        auth->rules =3D tmp;
> > +        return 0;
> > +    }
>=20
> Can we manage the rules with the QSLIST macros?

Those macros require specific struct field  names, and the
QAuthZListRuleList struct is auto-generated from QAPI so
lacking these fields.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
