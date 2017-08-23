Received: from eggs.gnu.org ([2001:4830:134:3::10]:36902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkScJ-0003Cd-BJ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkScF-0001La-2C
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:10:31 -0400
Date: Wed, 23 Aug 2017 06:10:04 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1074469842.2477067.1503483004106.JavaMail.zimbra@redhat.com>
In-Reply-To: <87mv6qaf0b.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-7-marcandre.lureau@redhat.com>
	<87mv6qaf0b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/54] qapi: introduce qapi_enum_lookup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Josh Durgin <jdurgin@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Jason Wang <jasowang@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > This will help with the introduction of a new structure to handle
> > enum lookup.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> [...]
> >  45 files changed, 206 insertions(+), 122 deletions(-)
>=20
> Hmm.
>=20
> > diff --git a/include/qapi/util.h b/include/qapi/util.h
> > index 7436ed815c..60733b6a80 100644
> > --- a/include/qapi/util.h
> > +++ b/include/qapi/util.h
> > @@ -11,6 +11,8 @@
> >  #ifndef QAPI_UTIL_H
> >  #define QAPI_UTIL_H
> > =20
> > +const char *qapi_enum_lookup(const char * const lookup[], int val);
> > +
> >  int qapi_enum_parse(const char * const lookup[], const char *buf,
> >                      int max, int def, Error **errp);
> > =20
> > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > index 4606b73849..c4f795475c 100644
> > --- a/backends/hostmem.c
> > +++ b/backends/hostmem.c
> > @@ -13,6 +13,7 @@
> >  #include "sysemu/hostmem.h"
> >  #include "hw/boards.h"
> >  #include "qapi/error.h"
> > +#include "qapi/util.h"
> >  #include "qapi/visitor.h"
> >  #include "qapi-types.h"
> >  #include "qapi-visit.h"
> > @@ -304,7 +305,7 @@ host_memory_backend_memory_complete(UserCreatable *=
uc,
> > Error **errp)
> >              return;
> >          } else if (maxnode =3D=3D 0 && backend->policy !=3D MPOL_DEFAU=
LT) {
> >              error_setg(errp, "host-nodes must be set for policy %s",
> > -                       HostMemPolicy_lookup[backend->policy]);
> > +                qapi_enum_lookup(HostMemPolicy_lookup, backend->policy=
));
> >              return;
> >          }
> > =20
>=20
> Lookup becomes even more verbose.
>=20
> Could we claw back some readability with macros?  Say in addition to
>=20
>     typedef enum FOO {
>         ...
>     } FOO;
>=20
>     extern const char *const FOO_lookup[];
>=20
> generate
>=20
>     #define FOO_str(val) qapi_enum_lookup(FOO_lookup, (val))
>=20
> Needs a matching qapi-code-gen.txt update.
>=20
> With that, this patch hunk would become
>=20
>                error_setg(errp, "host-nodes must be set for policy %s",
>   -                       HostMemPolicy_lookup[backend->policy]);
>   +                       HostMemPolicy_str(backend->policy);
>=20
> Perhaps we could even throw in some type checking:
>=20
>     #define FOO_str(val) (type_check(typeof((val)), FOO) \
>                           + qapi_enum_lookup(FOO_lookup, (val)))
>=20
> What do you think?  Want me to explore a fixup patch you could squash
> in?
>=20

Yes, I had similar thoughts, but didn't spent too much time finding the bes=
t proposal, that wasn't my main goal in the series.=20

Indeed, I would prefer that further improvements be done as follow-up. Or i=
f you have a ready solution, I can squash it there. I can picture the confl=
icts with the next patch though...=20

> [Skipping lots of mechanical changes...]
>=20
> I think you missed test-qobject-input-visitor.c and
> string-input-visitor.c.
>=20
> In test-qobject-input-visitor.c's test_visitor_in_enum():
>=20
>         v =3D visitor_input_test_init(data, "%s", EnumOne_lookup[i]);
>=20
> You update it in PATCH 12, but the code only works as long as EnumOne
> has no holes.  Mapping the enum to string like we do everywhere else in
> this patch would be cleaner.
>=20

ok

> The loop control also subscripts EnumOne_lookup[i].  You take care of
> that one in PATCH 12.  That's okay.
>=20
> Same for test-string-input-visitor.c's test_visitor_in_enum().
>=20
> There's one more in test_native_list_integer_helper():
>=20
>     g_string_append_printf(gstr_union,  "{ 'type': '%s', 'data': [ %s ] }=
",
>                            UserDefNativeListUnionKind_lookup[kind],
>                            gstr_list->str);
>=20
> Same story.
>=20
> The patch doesn't touch the _lookup[] subscripts you're going to replace
> by qapi_enum_parse() in PATCH 07-11.  Understand, but I'd reorder the
> patches: first replace by qapi_enum_parse(), because DRY (no need to
> explain more at that point).  Then get rid of all the remaining
> subscripting into _lookup[], i.e. this patch (explain it helps the next
> one), then PATCH 12.
>=20

ok
