Received: from eggs.gnu.org ([2001:4830:134:3::10]:56501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWIEl-0006K3-Lw
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWIEf-00026p-Ss
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:52:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWIEe-000267-6x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:52:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-2-marcandre.lureau@redhat.com>
Date: Mon, 10 Dec 2018 10:52:14 +0100
In-Reply-To: <20181208111606.8505-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 8 Dec 2018 15:15:40 +0400")
Message-ID: <875zw1lne9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 01/27] qapi: make sure osdep.h
 is included in type headers
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

> Now that the schema can be configured, it is crucial that all types
> are configured the same. Make sure config-host.h is included, by
> checking osdep.h inclusion. The build-sys tracks the dependency and
> rebuilds the types if the configuration changed.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/types.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index fd7808103c..3bb9cb6d47 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -201,6 +201,9 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
>  ''',
>                                        types=3Dtypes, visit=3Dvisit))
>          self._genh.preamble_add(mcgen('''
> +#ifndef QEMU_OSDEP_H
> +#error Please include osdep.h first!
> +#endif
>  #include "qapi/qapi-builtin-types.h"
>  '''))

I understand why you propose this patch.  The QAPI-generated headers use
#ifdef CONFIG_FOO.  The configuration header "qemu/osdep.h" must be
consistently included before the generated headers, or else you end up
with nasty bugs, such as the same enum having different values in
different .o, or the same struct having a different layout.

But this applies to *all* headers that use #ifdef.  Why check it here,
but not there?  What makes the QAPI-generated headers special?
