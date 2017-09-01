Received: from eggs.gnu.org ([2001:4830:134:3::10]:50575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnZTu-0004xL-Q6
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnZTr-0000bF-Iv
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:06:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnZTr-0000at-DM
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:06:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88DB368B7
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 00:06:38 +0000 (UTC)
Date: Thu, 31 Aug 2017 21:06:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170901000634.GC17184@localhost.localdomain>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170824103350.16400-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/14] qlit: move qlit from check-qjson to
 qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Thu, Aug 24, 2017 at 12:33:38PM +0200, Marc-Andr=E9 Lureau wrote:
> Fix code style issues while at it, to please check-patch.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h | 49 +++++++++++++++++++++++++
>  qobject/qlit.c          | 89 +++++++++++++++++++++++++++++++++++++++++=
++++
>  tests/check-qjson.c     | 96 +----------------------------------------=
--------
>  qobject/Makefile.objs   |  2 +-
>  4 files changed, 140 insertions(+), 96 deletions(-)
>  create mode 100644 include/qapi/qmp/qlit.h
>  create mode 100644 qobject/qlit.c
>=20
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> new file mode 100644
> index 0000000000..4e2e760ef1
> --- /dev/null
> +++ b/include/qapi/qmp/qlit.h
> @@ -0,0 +1,49 @@
> +/*
> + * Copyright IBM, Corp. 2009
> + * Copyright (c) 2013, 2015, 2017 Red Hat Inc.
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *  Markus Armbruster <armbru@redhat.com>
> + *  Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +#ifndef QLIT_H_
> +#define QLIT_H_
> +
> +#include "qapi-types.h"
> +#include "qobject.h"
> +
> +typedef struct LiteralQDictEntry LiteralQDictEntry;
> +typedef struct LiteralQObject LiteralQObject;
> +
> +struct LiteralQObject {
> +    int type;
> +    union {
> +        int64_t qnum;
> +        const char *qstr;
> +        LiteralQDictEntry *qdict;
> +        LiteralQObject *qlist;
> +    } value;
> +};
> +
> +struct LiteralQDictEntry {
> +    const char *key;
> +    LiteralQObject value;
> +};
> +
> +#define QLIT_QNUM(val) \
> +    (LiteralQObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
> +#define QLIT_QSTR(val) \
> +    (LiteralQObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
> +#define QLIT_QDICT(val) \
> +    (LiteralQObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
> +#define QLIT_QLIST(val) \
> +    (LiteralQObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}

I'm still trying to understand why this exists.  Doesn't this
provide exactly the same functionality as QObject?

> [...]

--=20
Eduardo
