Received: from eggs.gnu.org ([2001:4830:134:3::10]:36756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8RUF-0004F8-TP
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8RUB-0003TK-SZ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8RUB-0003T6-J3
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:16:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-2-ehabkost@redhat.com>
Date: Wed, 10 May 2017 15:16:56 +0200
In-Reply-To: <20170505201128.12099-2-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Fri, 5 May 2017 17:11:26 -0300")
Message-ID: <87efvw26nr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] visitor: Add 'supported_qtypes'
 parameter to visit_start_alternate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <mlureau@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> This will allow visitors to make decisions based on the supported qtypes
> of a given alternate type. The new parameter can replace the old
> 'promote_int' argument, as qobject-input-visitor can simply check if
> QTYPE_QINT is set in supported_qtypes.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Might conflict with Marc-Andr=C3=A9's work, which I haven't reviewed, yet.
Should be easy enough to resolve, though.

> ---
> Changes v1 -> v2:
> * Change supported_qtypes to uint32_t (Eric Blake)
> * Replace assert() on all generated visitor functions with a
>   single QEMU_BUILD_BUG_ON() on visit_start_alternate()
> * Extra spaces around "|" on generated visitor code
>   (Eric Blake)
> * Don't use bitops.h and just use (1U << QTYPE_FOO)
>   (Markus Armbruster)
> ---
>  include/qapi/visitor.h       |  5 +++--
>  include/qapi/visitor-impl.h  |  2 +-
>  scripts/qapi-visit.py        | 12 ++++++------
>  qapi/qapi-visit-core.c       |  9 ++++++---
>  qapi/qapi-clone-visitor.c    |  3 ++-
>  qapi/qapi-dealloc-visitor.c  |  3 ++-
>  qapi/qobject-input-visitor.c |  6 ++++--
>  qapi/trace-events            |  2 +-
>  8 files changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index 1a1b62012b..8f5a223714 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -408,7 +408,8 @@ void visit_end_list(Visitor *v, void **list);
>   * the qtype of the next thing to be visited, stored in (*@obj)->type.
>   * Other visitors will leave @obj unchanged.
>   *
> - * If @promote_int, treat integers as QTYPE_FLOAT.
> + * @supported_qtypes is a bit mask indicating which QTypes are supported
> + * by the alternate.
>   *
>   * If successful, this must be paired with visit_end_alternate() with
>   * the same @obj to clean up, even if visiting the contents of the
> @@ -416,7 +417,7 @@ void visit_end_list(Visitor *v, void **list);
>   */
>  void visit_start_alternate(Visitor *v, const char *name,
>                             GenericAlternate **obj, size_t size,
> -                           bool promote_int, Error **errp);
> +                           uint32_t supported_qtypes, Error **errp);
>=20=20
>  /*
>   * Finish visiting an alternate type.
> diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
> index e87709db5c..8afcde0f5d 100644
> --- a/include/qapi/visitor-impl.h
> +++ b/include/qapi/visitor-impl.h
> @@ -71,7 +71,7 @@ struct Visitor
>       * optional for output visitors. */
>      void (*start_alternate)(Visitor *v, const char *name,
>                              GenericAlternate **obj, size_t size,
> -                            bool promote_int, Error **errp);
> +                            uint32_t supported_qtypes, Error **errp);
>=20=20
>      /* Optional, needed for dealloc visitor */
>      void (*end_alternate)(Visitor *v, void **obj);
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index 5737aefa05..41c54982e2 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -161,20 +161,20 @@ void visit_type_%(c_name)s(Visitor *v, const char *=
name, %(c_name)s *obj, Error
>=20=20
>=20=20
>  def gen_visit_alternate(name, variants):
> -    promote_int =3D 'true'
> +    qtypes =3D ['(1U << %s)' % (var.type.alternate_qtype())
> +              for var in variants.variants]
> +    supported_qtypes =3D ' | '.join(qtypes)
>      ret =3D ''
> -    for var in variants.variants:
> -        if var.type.alternate_qtype() =3D=3D 'QTYPE_QINT':
> -            promote_int =3D 'false'

Note for later:

* promote_int is true if and only if we have no integer variant.

* supported_qtypes is the set of the variants' qtypes

>=20=20
>      ret +=3D mcgen('''
>=20=20
>  void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **ob=
j, Error **errp)
>  {
>      Error *err =3D NULL;
> +    uint32_t supported_qtypes =3D %(supported_qtypes)s;

The initializer is of type unsigned.  I'd make the variable unsigned,
too.  Not worth a respin, though.

>=20=20
>      visit_start_alternate(v, name, (GenericAlternate **)obj, sizeof(**ob=
j),
> -                          %(promote_int)s, &err);
> +                          supported_qtypes, &err);
>      if (err) {
>          goto out;
>      }
> @@ -183,7 +183,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
>      }
>      switch ((*obj)->type) {
>  ''',
> -                 c_name=3Dc_name(name), promote_int=3Dpromote_int)
> +                 c_name=3Dc_name(name), supported_qtypes=3Dsupported_qty=
pes)
>=20=20
>      for var in variants.variants:
>          ret +=3D mcgen('''
> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
> index 43a09d147d..8d62914393 100644
> --- a/qapi/qapi-visit-core.c
> +++ b/qapi/qapi-visit-core.c
> @@ -106,15 +106,18 @@ void visit_end_list(Visitor *v, void **obj)
>=20=20
>  void visit_start_alternate(Visitor *v, const char *name,
>                             GenericAlternate **obj, size_t size,
> -                           bool promote_int, Error **errp)
> +                           uint32_t supported_qtypes,
> +                           Error **errp)
>  {
>      Error *err =3D NULL;
>=20=20
> +    QEMU_BUILD_BUG_ON(QTYPE__MAX > 32);

Aha, I guess this is why you picked uint32_t.  Nevermind then.

> +
>      assert(obj && size >=3D sizeof(GenericAlternate));
>      assert(!(v->type & VISITOR_OUTPUT) || *obj);
> -    trace_visit_start_alternate(v, name, obj, size, promote_int);
> +    trace_visit_start_alternate(v, name, obj, size, supported_qtypes);
>      if (v->start_alternate) {
> -        v->start_alternate(v, name, obj, size, promote_int, &err);
> +        v->start_alternate(v, name, obj, size, supported_qtypes, &err);
>      }
>      if (v->type & VISITOR_INPUT) {
>          assert(v->start_alternate && !err !=3D !*obj);
> diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
> index 34086cbfc0..2e40da5981 100644
> --- a/qapi/qapi-clone-visitor.c
> +++ b/qapi/qapi-clone-visitor.c
> @@ -70,7 +70,8 @@ static GenericList *qapi_clone_next_list(Visitor *v, Ge=
nericList *tail,
>=20=20
>  static void qapi_clone_start_alternate(Visitor *v, const char *name,
>                                         GenericAlternate **obj, size_t si=
ze,
> -                                       bool promote_int, Error **errp)
> +                                       uint32_t supported_qtypes,
> +                                       Error **errp)
>  {
>      qapi_clone_start_struct(v, name, (void **)obj, size, errp);
>  }
> diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
> index e39457bc79..23b64c21a4 100644
> --- a/qapi/qapi-dealloc-visitor.c
> +++ b/qapi/qapi-dealloc-visitor.c
> @@ -38,7 +38,8 @@ static void qapi_dealloc_end_struct(Visitor *v, void **=
obj)
>=20=20
>  static void qapi_dealloc_start_alternate(Visitor *v, const char *name,
>                                           GenericAlternate **obj, size_t =
size,
> -                                         bool promote_int, Error **errp)
> +                                         uint32_t supported_qtypes,
> +                                         Error **errp)
>  {
>  }
>=20=20
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index 865e948ac0..25997ee816 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -338,7 +338,8 @@ static void qobject_input_check_list(Visitor *v, Erro=
r **errp)
>=20=20
>  static void qobject_input_start_alternate(Visitor *v, const char *name,
>                                            GenericAlternate **obj, size_t=
 size,
> -                                          bool promote_int, Error **errp)
> +                                          uint32_t supported_qtypes,
> +                                          Error **errp)
>  {
>      QObjectInputVisitor *qiv =3D to_qiv(v);
>      QObject *qobj =3D qobject_input_get_object(qiv, name, false, errp);
> @@ -349,7 +350,8 @@ static void qobject_input_start_alternate(Visitor *v,=
 const char *name,
>      }
>      *obj =3D g_malloc0(size);
>      (*obj)->type =3D qobject_type(qobj);
> -    if (promote_int && (*obj)->type =3D=3D QTYPE_QINT) {

Old condition: the alternate has no integer variant, and we got an
integer value.

> +    if (!(supported_qtypes & (1U << QTYPE_QINT)) &&
> +        (*obj)->type =3D=3D QTYPE_QINT) {

New condition: same.  Good.

>          (*obj)->type =3D QTYPE_QFLOAT;
>      }
>  }
> diff --git a/qapi/trace-events b/qapi/trace-events
> index 339cacf0ad..b15a55b797 100644
> --- a/qapi/trace-events
> +++ b/qapi/trace-events
> @@ -11,7 +11,7 @@ visit_next_list(void *v, void *tail, size_t size) "v=3D=
%p tail=3D%p size=3D%zu"
>  visit_check_list(void *v) "v=3D%p"
>  visit_end_list(void *v, void *obj) "v=3D%p obj=3D%p"
>=20=20
> -visit_start_alternate(void *v, const char *name, void *obj, size_t size,=
 bool promote_int) "v=3D%p name=3D%s obj=3D%p size=3D%zu promote_int=3D%d"
> +visit_start_alternate(void *v, const char *name, void *obj, size_t size,=
 uint32_t supported_qtypes) "v=3D%p name=3D%s obj=3D%p size=3D%zu supported=
_qtypes=3D0x%x"
>  visit_end_alternate(void *v, void *obj) "v=3D%p obj=3D%p"
>=20=20
>  visit_optional(void *v, const char *name, bool *present) "v=3D%p name=3D=
%s present=3D%p"

Reviewed-by: Markus Armbruster <armbru@redhat.com>
