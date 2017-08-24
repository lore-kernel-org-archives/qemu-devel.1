Received: from eggs.gnu.org ([2001:4830:134:3::10]:39990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkq5z-0004LE-EF
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkq5y-0006Od-FM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:14:43 -0400
Date: Thu, 24 Aug 2017 12:14:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170824111414.GD2088@work-vm>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-7-marcandre.lureau@redhat.com>
	<87mv6qaf0b.fsf@dusky.pond.sub.org>
	<1074469842.2477067.1503483004106.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1074469842.2477067.1503483004106.JavaMail.zimbra@redhat.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Josh Durgin <jdurgin@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Jason Wang <jasowang@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Hi
>=20
> ----- Original Message -----
> > Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> writes:
> >=20
> > > This will help with the introduction of a new structure to handle
> > > enum lookup.

It would be good to make that comment explain why it's necessary.

> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > [...]
> > >  45 files changed, 206 insertions(+), 122 deletions(-)
> >=20
> > Hmm.
> >=20
> > > diff --git a/include/qapi/util.h b/include/qapi/util.h
> > > index 7436ed815c..60733b6a80 100644
> > > --- a/include/qapi/util.h
> > > +++ b/include/qapi/util.h
> > > @@ -11,6 +11,8 @@
> > >  #ifndef QAPI_UTIL_H
> > >  #define QAPI_UTIL_H
> > > =20
> > > +const char *qapi_enum_lookup(const char * const lookup[], int val)=
;
> > > +
> > >  int qapi_enum_parse(const char * const lookup[], const char *buf,
> > >                      int max, int def, Error **errp);
> > > =20
> > > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > > index 4606b73849..c4f795475c 100644
> > > --- a/backends/hostmem.c
> > > +++ b/backends/hostmem.c
> > > @@ -13,6 +13,7 @@
> > >  #include "sysemu/hostmem.h"
> > >  #include "hw/boards.h"
> > >  #include "qapi/error.h"
> > > +#include "qapi/util.h"
> > >  #include "qapi/visitor.h"
> > >  #include "qapi-types.h"
> > >  #include "qapi-visit.h"
> > > @@ -304,7 +305,7 @@ host_memory_backend_memory_complete(UserCreatab=
le *uc,
> > > Error **errp)
> > >              return;
> > >          } else if (maxnode =3D=3D 0 && backend->policy !=3D MPOL_D=
EFAULT) {
> > >              error_setg(errp, "host-nodes must be set for policy %s=
",
> > > -                       HostMemPolicy_lookup[backend->policy]);
> > > +                qapi_enum_lookup(HostMemPolicy_lookup, backend->po=
licy));
> > >              return;
> > >          }
> > > =20
> >=20
> > Lookup becomes even more verbose.
> >=20
> > Could we claw back some readability with macros?  Say in addition to
> >=20
> >     typedef enum FOO {
> >         ...
> >     } FOO;
> >=20
> >     extern const char *const FOO_lookup[];
> >=20
> > generate
> >=20
> >     #define FOO_str(val) qapi_enum_lookup(FOO_lookup, (val))
> >=20
> > Needs a matching qapi-code-gen.txt update.
> >=20
> > With that, this patch hunk would become
> >=20
> >                error_setg(errp, "host-nodes must be set for policy %s=
",
> >   -                       HostMemPolicy_lookup[backend->policy]);
> >   +                       HostMemPolicy_str(backend->policy);
> >=20
> > Perhaps we could even throw in some type checking:
> >=20
> >     #define FOO_str(val) (type_check(typeof((val)), FOO) \
> >                           + qapi_enum_lookup(FOO_lookup, (val)))
> >=20
> > What do you think?  Want me to explore a fixup patch you could squash
> > in?
> >=20
>=20
> Yes, I had similar thoughts, but didn't spent too much time finding the=
 best proposal, that wasn't my main goal in the series.=20
>=20
> Indeed, I would prefer that further improvements be done as follow-up. =
Or if you have a ready solution, I can squash it there. I can picture the=
 conflicts with the next patch though...=20

If you did it as a separate patch it would have to be another
huge patch changing lots of areas.
I think the use of the macro to keep it simple should be in this one;
you can add the type check change later.

Dave

> > [Skipping lots of mechanical changes...]
> >=20
> > I think you missed test-qobject-input-visitor.c and
> > string-input-visitor.c.
> >=20
> > In test-qobject-input-visitor.c's test_visitor_in_enum():
> >=20
> >         v =3D visitor_input_test_init(data, "%s", EnumOne_lookup[i]);
> >=20
> > You update it in PATCH 12, but the code only works as long as EnumOne
> > has no holes.  Mapping the enum to string like we do everywhere else =
in
> > this patch would be cleaner.
> >=20
>=20
> ok
>=20
> > The loop control also subscripts EnumOne_lookup[i].  You take care of
> > that one in PATCH 12.  That's okay.
> >=20
> > Same for test-string-input-visitor.c's test_visitor_in_enum().
> >=20
> > There's one more in test_native_list_integer_helper():
> >=20
> >     g_string_append_printf(gstr_union,  "{ 'type': '%s', 'data': [ %s=
 ] }",
> >                            UserDefNativeListUnionKind_lookup[kind],
> >                            gstr_list->str);
> >=20
> > Same story.
> >=20
> > The patch doesn't touch the _lookup[] subscripts you're going to repl=
ace
> > by qapi_enum_parse() in PATCH 07-11.  Understand, but I'd reorder the
> > patches: first replace by qapi_enum_parse(), because DRY (no need to
> > explain more at that point).  Then get rid of all the remaining
> > subscripting into _lookup[], i.e. this patch (explain it helps the ne=
xt
> > one), then PATCH 12.
> >=20
>=20
> ok
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
