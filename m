Received: from eggs.gnu.org ([2001:4830:134:3::10]:43387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUvDb-0007lF-7R
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUvDY-0004k3-0y
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:33:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUvDX-0004jt-RF
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:33:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F4CC81A4EA0
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:33:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-3-marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 16:33:13 +0200
In-Reply-To: <20180321115211.17937-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 21 Mar 2018 12:51:24 +0100")
Message-ID: <87sh5k88ra.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/49] qapi/events: generate event enum
 in main module
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

> The event generator produces an enum, and put it in the last visited
> module. It fits better in the main module, since it's the set of all
> visited events, from all modules.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/events.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index 3dc523cf39..3e448ae523 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -180,8 +180,9 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
>                               types=3Dtypes))
>=20=20
>      def visit_end(self):
> -        self._genh.add(gen_enum(self._enum_name, self._event_names))
> -        self._genc.add(gen_enum_lookup(self._enum_name, self._event_name=
s))
> +        (genc, genh) =3D self._module[self._main_module]
> +        genh.add(gen_enum(self._enum_name, self._event_names))
> +        genc.add(gen_enum_lookup(self._enum_name, self._event_names))
>=20=20
>      def visit_event(self, name, info, arg_type, boxed):
>          self._genh.add(gen_event_send_decl(name, arg_type, boxed))

Much better indeed.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
