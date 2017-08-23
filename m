Received: from eggs.gnu.org ([2001:4830:134:3::10]:35716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkQcd-0004IM-S7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkQcX-0003xf-SZ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:02:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-7-marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 10:02:12 +0200
In-Reply-To: <20170822132255.23945-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 22 Aug 2017 15:22:07 +0200")
Message-ID: <87mv6qaf0b.fsf@dusky.pond.sub.org>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Josh Durgin <jdurgin@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Jason Wang <jasowang@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> This will help with the introduction of a new structure to handle
> enum lookup.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
[...]
>  45 files changed, 206 insertions(+), 122 deletions(-)

Hmm.

> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index 7436ed815c..60733b6a80 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -11,6 +11,8 @@
>  #ifndef QAPI_UTIL_H
>  #define QAPI_UTIL_H
>=20=20
> +const char *qapi_enum_lookup(const char * const lookup[], int val);
> +
>  int qapi_enum_parse(const char * const lookup[], const char *buf,
>                      int max, int def, Error **errp);
>=20=20
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 4606b73849..c4f795475c 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -13,6 +13,7 @@
>  #include "sysemu/hostmem.h"
>  #include "hw/boards.h"
>  #include "qapi/error.h"
> +#include "qapi/util.h"
>  #include "qapi/visitor.h"
>  #include "qapi-types.h"
>  #include "qapi-visit.h"
> @@ -304,7 +305,7 @@ host_memory_backend_memory_complete(UserCreatable *uc=
, Error **errp)
>              return;
>          } else if (maxnode =3D=3D 0 && backend->policy !=3D MPOL_DEFAULT=
) {
>              error_setg(errp, "host-nodes must be set for policy %s",
> -                       HostMemPolicy_lookup[backend->policy]);
> +                qapi_enum_lookup(HostMemPolicy_lookup, backend->policy));
>              return;
>          }
>=20=20

Lookup becomes even more verbose.

Could we claw back some readability with macros?  Say in addition to

    typedef enum FOO {
        ...
    } FOO;

    extern const char *const FOO_lookup[];

generate

    #define FOO_str(val) qapi_enum_lookup(FOO_lookup, (val))

Needs a matching qapi-code-gen.txt update.

With that, this patch hunk would become

               error_setg(errp, "host-nodes must be set for policy %s",
  -                       HostMemPolicy_lookup[backend->policy]);
  +                       HostMemPolicy_str(backend->policy);

Perhaps we could even throw in some type checking:

    #define FOO_str(val) (type_check(typeof((val)), FOO) \
                          + qapi_enum_lookup(FOO_lookup, (val)))

What do you think?  Want me to explore a fixup patch you could squash
in?

[Skipping lots of mechanical changes...]

I think you missed test-qobject-input-visitor.c and
string-input-visitor.c.

In test-qobject-input-visitor.c's test_visitor_in_enum():

        v =3D visitor_input_test_init(data, "%s", EnumOne_lookup[i]);

You update it in PATCH 12, but the code only works as long as EnumOne
has no holes.  Mapping the enum to string like we do everywhere else in
this patch would be cleaner.

The loop control also subscripts EnumOne_lookup[i].  You take care of
that one in PATCH 12.  That's okay.

Same for test-string-input-visitor.c's test_visitor_in_enum().

There's one more in test_native_list_integer_helper():

    g_string_append_printf(gstr_union,  "{ 'type': '%s', 'data': [ %s ] }",
                           UserDefNativeListUnionKind_lookup[kind],
                           gstr_list->str);

Same story.

The patch doesn't touch the _lookup[] subscripts you're going to replace
by qapi_enum_parse() in PATCH 07-11.  Understand, but I'd reorder the
patches: first replace by qapi_enum_parse(), because DRY (no need to
explain more at that point).  Then get rid of all the remaining
subscripting into _lookup[], i.e. this patch (explain it helps the next
one), then PATCH 12.
