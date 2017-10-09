Received: from eggs.gnu.org ([2001:4830:134:3::10]:58862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1SQL-0003ol-7L
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1SQI-0003ri-0b
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:24:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-2-f4bug@amsat.org>
Date: Mon, 09 Oct 2017 09:24:16 +0200
In-Reply-To: <20171006235023.11952-2-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 6 Oct 2017 20:48:56
	-0300")
Message-ID: <871smcss0v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/88] cocci: script to use g_new() &
 friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Imported from Markus Armbruster commit b45c03f
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Signed-off-by: Markus Armbruster <armbru@redhat.com>?
>
>  scripts/coccinelle/g_new.cocci | 101 +++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 scripts/coccinelle/g_new.cocci
>
> diff --git a/scripts/coccinelle/g_new.cocci b/scripts/coccinelle/g_new.co=
cci
> new file mode 100644
> index 0000000000..1e57685a6b
> --- /dev/null
> +++ b/scripts/coccinelle/g_new.cocci
> @@ -0,0 +1,101 @@
> +/* transform g_new*() alloc with size arguments of the form sizeof(T) [*=
 N]

Confusing.  Sounds like we transform g_new() into something else.  Also,
wing both ends of the comment, and start with a capital letter.

> + *
> + *   g_new(T, n) is neater than g_malloc(sizeof(T) * n).  It's also safe=
r,
> + *   for two reasons.  One, it catches multiplication overflowing size_t.
> + *   two, it returns T * rather than void *, which lets the compiler cat=
ch

Start your sentences with a capital letter.  Or rather, keep my commit
message's capital letters intact ;)

> + *   more type errors.
> + *
> + *    Copyright: (C) 2017 Markus Armbruster <armbru@redhat.com>. GPLv2+.

If you want to put a copyright note into this file, you should stick to
the common format:

/*
 * Rewrite memory allocations to use g_new() & friends
 *
 * Copyright (C) 2014-2017 Red Hat, Inc.
 *
 * Authors:
 *  Markus Armbruster <armbru@redhat.com>,
 *
 * This work is licensed under the terms of the GNU GPL, version 2 or later.
 * See the COPYING file in the top-level directory.
 */

> + *    (Imported from b45c03f585ea9bb1af76c73e82195418c294919d)

Scratch this line.  It's in the commit message, and that suffices.

> + *
> + * See http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg00908.=
html:
> + *
> + *   g_new() advantages (from glib doc):
> + *   - the returned pointer is cast to a pointer to the given type.
> + *   - care is taken to avoid overflow when calculating the size of the
> + *   allocated block.

Repeats what you just said in the text pasted from my commit message.

> + *
> + *   p =3D g_malloc(sizeof(*p)) is idiomatic, and not obviously inferior=
 to
> + *   p =3D g_new(T, 1), where T is the type of *p.
> + *   But once you add multiplication, g_new() adds something useful: ove=
rflow
> + *   protection.  Conversion to g_new() might make sense then.
> + */

This part doesn't really apply, yet: the semantic patch doesn't deal
with sizeof(*p).

Please write a coherent introduction instead of a series of quotations.

> +
> +@@
> +type T;
> +@@
> +-g_malloc(sizeof(T))
> ++g_new(T, 1)
> +@@
> +type T;
> +@@
> +-g_try_malloc(sizeof(T))
> ++g_try_new(T, 1)
> +@@
> +type T;
> +@@
> +-g_malloc0(sizeof(T))
> ++g_new0(T, 1)
> +@@
> +type T;
> +@@
> +-g_try_malloc0(sizeof(T))
> ++g_try_new0(T, 1)
> +

Any particular reason for adding this blank line?

You add more below, and a comment.  Okay, but I'd commit the script
exactly as given in commit b45c03f, then add improvements on top.

> +@@
> +type T;
> +expression n;
> +@@
> +-g_malloc(sizeof(T) * (n))
> ++g_new(T, n)
> +@@
> +type T;
> +expression n;
> +@@
> +-g_try_malloc(sizeof(T) * (n))
> ++g_try_new(T, n)
> +@@
> +type T;
> +expression n;
> +@@
> +-g_malloc0(sizeof(T) * (n))
> ++g_new0(T, n)
> +@@
> +type T;
> +expression n;
> +@@
> +-g_try_malloc0(sizeof(T) * (n))
> ++g_try_new0(T, n)
> +
> +@@
> +type T;
> +expression p, n;
> +@@
> +-g_realloc(p, sizeof(T) * (n))
> ++g_renew(T, p, n)
> +@@
> +type T;
> +expression p, n;
> +@@
> +-g_try_realloc(p, sizeof(T) * (n))
> ++g_try_renew(T, p, n)
> +
> +// drop superfluous cast
> +@@
> +type T;
> +expression n;
> +@@
> +-(T *)g_new(T, n)
> ++g_new(T, n)
> +@@
> +type T;
> +expression n;
> +@@
> +-(T *)g_new0(T, n)
> ++g_new0(T, n)
> +@@
> +type T;
> +expression p, n;
> +@@
> +-(T *)g_renew(T, p, n)
> ++g_renew(T, p, n)
