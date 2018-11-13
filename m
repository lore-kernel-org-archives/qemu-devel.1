Received: from eggs.gnu.org ([2001:4830:134:3::10]:45530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMcVl-0000wK-CI
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMcVf-0002XJ-Ji
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:29:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMcVf-0002SN-7N
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:29:55 -0500
Date: Tue, 13 Nov 2018 17:29:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181113172930.GL14591@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-9-berrange@redhat.com>
	<CAJ+F1C+Wcp5jueeP-smg88sbc5KssULKKG7gF6kEXYGtqdANKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+Wcp5jueeP-smg88sbc5KssULKKG7gF6kEXYGtqdANKw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 08/11] authz: add QAuthZList object type
 for an access control list
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

On Thu, Nov 08, 2018 at 02:23:43AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Oct 19, 2018 at 5:45 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote
> > ---
> >  Makefile                |   7 +-
> >  Makefile.objs           |   4 +
> >  qapi/authz.json         |  58 ++++++++
> >  qapi/qapi-schema.json   |   1 +
> >  include/authz/list.h    | 106 ++++++++++++++
> >  authz/list.c            | 309 ++++++++++++++++++++++++++++++++++++++=
++
> >  tests/test-authz-list.c | 171 ++++++++++++++++++++++
> >  .gitignore              |   4 +
> >  MAINTAINERS             |   1 +
> >  authz/Makefile.objs     |   1 +
> >  authz/trace-events      |   4 +
> >  tests/Makefile.include  |   4 +
> >  12 files changed, 669 insertions(+), 1 deletion(-)
> >  create mode 100644 qapi/authz.json
> >  create mode 100644 include/authz/list.h
> >  create mode 100644 authz/list.c
> >  create mode 100644 tests/test-authz-list.c
> >

> > diff --git a/qapi/authz.json b/qapi/authz.json
> > new file mode 100644
> > index 0000000000..607839c627
> > --- /dev/null
> > +++ b/qapi/authz.json
> > @@ -0,0 +1,58 @@
> > +# -*- Mode: Python -*-
> > +#
> > +# QAPI authz definitions
> > +
> > +##
> > +# @QAuthZListPolicy:
> > +#
> > +# The authorization policy result
> > +#
> > +# @deny: deny access
> > +# @allow: allow access
> > +#
> > +# Since: 3.0
>=20
> obviously, you'll have to update to 3.2

4.0 in fact since we bump at the start of each year


> > +##
> > +# @QAuthZListRuleListHack:
> > +#
> > +# Not exposed via QMP; hack to generate QAuthZListRuleList
> > +# for use internally by the code.
>=20
> Well, this will probably end in the documentation (it's already in the
> .json, which is one source of documentation ;).
>=20
> What about adding a 'gen-list' field, or a 'pragma' listing the
> structs that should have list code generated?

I'll leave that for future motivated contributors, as I'm just
following pre-existing best practice here.


> > +static bool qauthz_list_is_allowed(QAuthZ *authz,
> > +                                   const char *identity,
> > +                                   Error **errp)
> > +{
> > +    QAuthZList *lauthz =3D QAUTHZ_LIST(authz);
> > +    QAuthZListRuleList *rules =3D lauthz->rules;
> > +
> > +    while (rules) {
> > +        QAuthZListRule *rule =3D rules->value;
> > +        QAuthZListFormat format =3D rule->has_format ? rule->format =
:
> > +            QAUTHZ_LIST_FORMAT_EXACT;
> > +
> > +        trace_qauthz_list_check_rule(authz, rule->match, identity,
> > +                                     format, rule->policy);
> > +        switch (format) {
> > +        case QAUTHZ_LIST_FORMAT_EXACT:
> > +            if (strcmp(rule->match, identity) =3D=3D 0) {
>=20
> g_str_equal() ?

Yes.

>=20
> > +                return rule->policy =3D=3D QAUTHZ_LIST_POLICY_ALLOW;
> > +            }
> > +            break;
> > +#ifdef CONFIG_FNMATCH
> > +        case QAUTHZ_LIST_FORMAT_GLOB:
> > +            if (fnmatch(rule->match, identity, 0) =3D=3D 0) {
>=20
> Would GPatternSpec be a good alternative?

Excellent, I didn't know about it

> > +                return rule->policy =3D=3D QAUTHZ_LIST_POLICY_ALLOW;
> > +            }
> > +            break;
> > +#else
> > +            return false;
> > +#endif
> > +        default:
>=20
>=20
> No g_warn_if_reached() ?Then perhaps add a comment why.

I guess we could.

> > +ssize_t qauthz_list_delete_rule(QAuthZList *auth, const char *match)
> > +{
> > +    QAuthZListRule *rule;
> > +    QAuthZListRuleList *rules, *prev;
> > +    size_t i =3D 0;
> > +
> > +    prev =3D NULL;
> > +    rules =3D auth->rules;
> > +    while (rules) {
> > +        rule =3D rules->value;
> > +        if (g_str_equal(rule->match, match)) {
> > +            if (prev) {
> > +                prev->next =3D rules->next;
> > +            } else {
> > +                auth->rules =3D rules->next;
> > +            }
> > +            rules->next =3D NULL;
> > +            qapi_free_QAuthZListRuleList(rules);
> > +            return i;
>=20
> What's the point in returning the old index? Maybe true/false along
> with an Error would be more convenient?

It is required for the conversion of the existing acl_remove API
in the HMP monitor.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
