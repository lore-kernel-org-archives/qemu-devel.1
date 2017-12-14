Received: from eggs.gnu.org ([2001:4830:134:3::10]:51681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePWBn-0001L2-IP
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePWBj-0004ll-3c
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:16:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ePWBi-0004jv-Qc
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:16:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-43-marcandre.lureau@redhat.com>
Date: Thu, 14 Dec 2017 17:16:25 +0100
In-Reply-To: <20170911110623.24981-43-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:06:15 +0200")
Message-ID: <87y3m5uvxi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 42/50] qapi: add a -u/--unit option to
 specify which unit to visit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Allow to filter expressions based on unit name.
>
> By default, only default units are processed (unspecified pragma).
>
> 'all' will include all units. Anything else will filter by unit name.

You therefore can't have a unit called 'all'.  Hardly a loss, but I
suspect documenting and guarding against it is more trouble than the
feature's worth.

If we want to keep it, the previous patch needs to reject { 'pragma': {
'unit': 'all' } }.

> (add a FIXME to make implicit array types use the element type unit,
> not the unit of the first expression using that array type. This isn't
> necessary for now, and I am not sure how to best do it yet)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py      | 14 ++++++++++++--
>  scripts/qapi2texi.py |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 1d0defd638..7778585819 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -47,6 +47,9 @@ returns_whitelist =3D []
>  # Whitelist of entities allowed to violate case conventions
>  name_case_whitelist =3D []
>=20=20
> +# Unit to consider for the visit, 'all' for all units
> +visit_unit =3D None
> +
>  enum_types =3D {}
>  struct_types =3D {}
>  union_types =3D {}
> @@ -1796,6 +1799,10 @@ class QAPISchema(object):
>      def visit(self, visitor):
>          visitor.visit_begin(self)
>          for (name, entity) in sorted(self._entity_dict.items()):
> +            # FIXME: implicit array types should use element type unit
> +            unit =3D entity.info and entity.info.get('unit')

@unit is str, ensured by QAPISchemaParser.

> +            if visit_unit !=3D 'all' and visit_unit !=3D unit:
> +                continue

If visit_unit is still None, we don't visit anything.

>              if visitor.visit_needed(entity):
>                  entity.visit(visitor)
>          visitor.visit_end()
> @@ -2103,13 +2110,14 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
>=20=20
>      try:
>          opts, args =3D getopt.gnu_getopt(sys.argv[1:],
> -            'chp:o:i:' + extra_options,
> +            'chp:o:u:i:' + extra_options,
>              ['source', 'header', 'prefix=3D', 'output-dir=3D',
> -             'include=3D'] + extra_long_options)
> +             'unit=3D', 'include=3D'] + extra_long_options)
>      except getopt.GetoptError as err:
>          print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
>          sys.exit(1)
>=20=20
> +    global visit_unit
>      output_dir =3D ''
>      prefix =3D ''
>      do_c =3D False
> @@ -2129,6 +2137,8 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
>              prefix =3D a
>          elif o in ('-o', '--output-dir'):
>              output_dir =3D a + '/'
> +        elif o in ('-u', '--unit'):
> +            visit_unit =3D a
>          elif o in ('-c', '--source'):
>              do_c =3D True
>          elif o in ('-h', '--header'):

If the user doesn't give -u, @visit_unit remains None, and
QAPISchema.visit() won't visit anything.

I recommend to dumb this down as follows.  No special unit name 'all'.
If you want all, don't specify -u.  @visit_unit remains None then.

> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 4e7b1cda87..6c856d4cb7 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -293,6 +293,7 @@ def main(argv):
>          print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" % argv=
[0]
>          sys.exit(1)
>=20=20
> +    qapi.visit_unit =3D 'all'
>      schema =3D qapi.QAPISchema(argv[1])
>      if not qapi.doc_required:
>          print >>sys.stderr, ("%s: need pragma 'doc-required' "

Bonus: this hunk won't be needed then, because the default value just
works.
