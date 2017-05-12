Received: from eggs.gnu.org ([2001:4830:134:3::10]:45023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d946A-0001Tt-1q
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d9466-0002GF-Uw
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:30:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d9466-0002Fz-OL
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:30:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 772613D94E
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 06:30:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-5-marcandre.lureau@redhat.com>
Date: Fri, 12 May 2017 08:30:36 +0200
In-Reply-To: <20170509173559.31598-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 9 May 2017 20:35:46 +0300")
Message-ID: <87wp9mk2nn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>

Question for Luiz...

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

[...]
> diff --git a/tests/check-qnum.c b/tests/check-qnum.c
> new file mode 100644
> index 0000000000..d08d35e85a
> --- /dev/null
> +++ b/tests/check-qnum.c
> @@ -0,0 +1,131 @@
> +/*
> + * QNum unit-tests.
> + *
> + * Copyright (C) 2009 Red Hat Inc.
> + *
> + * Authors:
> + *  Luiz Capitulino <lcapitulino@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +
> +#include "qapi/qmp/qnum.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +
> +/*
> + * Public Interface test-cases
> + *
> + * (with some violations to access 'private' data)
> + */
> +
> +static void qnum_from_int_test(void)
> +{
> +    QNum *qi;
> +    const int value =3D -42;
> +
> +    qi =3D qnum_from_int(value);
> +    g_assert(qi !=3D NULL);
> +    g_assert_cmpint(qi->u.i64, =3D=3D, value);
> +    g_assert_cmpint(qi->base.refcnt, =3D=3D, 1);
> +    g_assert_cmpint(qobject_type(QOBJECT(qi)), =3D=3D, QTYPE_QNUM);
> +
> +    // destroy doesn't exit yet
> +    g_free(qi);
> +}

The comment is enigmatic.  It was first written in commit 33837ba
"Introduce QInt unit-tests", and got copied around since.  In
check-qlist.c, it's spelled "exist yet".

What is "destroy", why doesn't it exit / exist now, but will exit /
exist later?  It can't be qnum_destroy_obj(), because that certainly
exists already, exits already in the sense of returning, and shouldn't
ever exit in the sense of terminating the program.

The comment applies to a g_free().  Why do we free directly instead
decrementing the reference count?  Perhaps the comment tries to explain
that (if it does, it fails).

Luiz, any idea?

[...]
