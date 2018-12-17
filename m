Received: from eggs.gnu.org ([2001:4830:134:3::10]:36981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gYmyj-0008NS-MB
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gYmye-00064l-Dn
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:06:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gYmye-00063y-6O
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:06:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AE78356CA
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 07:06:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
	<20181216140902.23986-2-marcandre.lureau@redhat.com>
Date: Mon, 17 Dec 2018 08:06:00 +0100
In-Reply-To: <20181216140902.23986-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sun, 16 Dec 2018 18:08:50 +0400")
Message-ID: <8736qw8wfb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/13] build-sys: move qmp-introspect per
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The following patches are going to introduce per-target #ifdef in the
> schemas.
>
> The introspection data is statically generated once, and must thus be
> built per-target to reflect target-specific configuration.
>
> Drop "do_test_visitor_in_qmp_introspect(&qmp_schema_qlit)" since the
> schema is no longer in a common object. It is covered by the per-target
> query-qmp-schema test instead.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 1 -
>  Makefile.objs                      | 2 --
>  Makefile.target                    | 2 ++
>  3 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
> index caa90b3d7e..609334adf6 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -1271,7 +1271,6 @@ static void test_visitor_in_qmp_introspect(TestInpu=
tVisitorData *data,
>                                             const void *unused)
>  {
>      do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
> -    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
>  }
>=20=20
>  int main(int argc, char **argv)
> diff --git a/Makefile.objs b/Makefile.objs
> index 56af0347d3..0388d5157d 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -13,7 +13,6 @@ util-obj-y +=3D qapi/qapi-visit.o
>  util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.o)
>  util-obj-y +=3D qapi/qapi-events.o
>  util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o)
> -util-obj-y +=3D qapi/qapi-introspect.o
>=20=20
>  chardev-obj-y =3D chardev/
>=20=20
> @@ -94,7 +93,6 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
>=20=20
>  common-obj-y +=3D qapi/qapi-commands.o
>  common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.o)
> -common-obj-y +=3D qapi/qapi-introspect.o
>  common-obj-y +=3D qmp.o hmp.o
>  endif
>=20=20
> diff --git a/Makefile.target b/Makefile.target
> index 44ec4b630c..c882292ae1 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -156,6 +156,8 @@ endif
>=20=20
>  GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
>=20=20
> +obj-y +=3D qapi/qapi-introspect.o
> +
>  endif # CONFIG_SOFTMMU
>=20=20
>  dummy :=3D $(call unnest-vars,,obj-y)

Having to compile this multiple times is a bit sad, since it's fairly
big:

$ ls -lh qapi/qapi-introspect.c
-rw-rw-r--. 1 armbru armbru 518K Dec 17 07:56 qapi/qapi-introspect.c
$ size x86_64-softmmu/qapi/qapi-introspect.o
   text	   data	    bss	    dec	    hex	filename
  16302	 289472	     48	 305822	  4aa9e	x86_64-softmmu/qapi/qapi-introspect=
.o

To compile its target-independent part just once, we'd have to split it
up.  May or may not improve compile time.  We can figure it out when
compiling all of it multiple times bother us.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
