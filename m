Received: from eggs.gnu.org ([2001:4830:134:3::10]:59779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1SUi-0005p8-N3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1SUf-0005rf-Ii
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:28:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-3-f4bug@amsat.org>
Date: Mon, 09 Oct 2017 09:28:48 +0200
In-Reply-To: <20171006235023.11952-3-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 6 Oct 2017 20:48:57
	-0300")
Message-ID: <87vajord8v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/88] cocci: add more g_new()
 transformations
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

The commit message should explain the additional transformations briefly
and informally.  In particular, why they're a good idea.  Same for PATCH
3-5.

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/coccinelle/g_new.cocci | 73 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/scripts/coccinelle/g_new.cocci b/scripts/coccinelle/g_new.co=
cci
> index 1e57685a6b..c767325a21 100644
> --- a/scripts/coccinelle/g_new.cocci
> +++ b/scripts/coccinelle/g_new.cocci
> @@ -80,6 +80,49 @@ expression p, n;
>  -g_try_realloc(p, sizeof(T) * (n))
>  +g_try_renew(T, p, n)
>=20=20
> +@@
> +type T;
> +expression n;
> +@@
> +(
> +-g_malloc_n(n, sizeof(T))
> ++g_new(T, n)
> +|
> +-g_malloc0_n(n, sizeof(T))
> ++g_new0(T, n)
> +|
> +-g_try_malloc_n(n, sizeof(T))
> ++g_try_new(T, n)
> +|
> +-g_try_malloc0_n(n, sizeof(T))
> ++g_try_new0(T, n)
> +)
> +
> +@@
> +type T;
> +identifier m;
> +@@
> +T *m;
> +...
> +(
> +-m =3D g_malloc(sizeof(*m));
> ++m =3D g_new(T, 1);
> +|
> +-m =3D g_malloc0(sizeof(*m));
> ++m =3D g_new0(T, 1);
> +|
> +-m =3D g_try_malloc(sizeof(*m));
> ++m =3D g_try_new(T, 1);
> +|
> +-m =3D g_try_malloc0(sizeof(*m));
> ++m =3D g_try_new0(T, 1);
> +)
> +
> +////////////////////////////////////////

Please scratch this line.  Overly elaborate comment decoration.

> +//
> +// last transformations: cleanups
> +//
> +
>  // drop superfluous cast
>  @@
>  type T;
> @@ -99,3 +142,33 @@ expression p, n;
>  @@
>  -(T *)g_renew(T, p, n)
>  +g_renew(T, p, n)
> +@@
> +type T;
> +expression n;
> +@@
> +(
> +-(T *)g_try_new(T, n)
> ++g_try_new(T, n)
> +|
> +-(T *)g_try_new0(T, n)
> ++g_try_new0(T, n)
> +)
> +
> +// drop superfluous parenthesis
> +@@
> +type T;
> +expression c;
> +@@
> +(
> +-g_new(T, (c))
> ++g_new(T, c)
> +|
> +-g_try_new(T, (c))
> ++g_try_new(T, c)
> +|
> +-g_new0(T, (c))
> ++g_new0(T, c)
> +|
> +-g_try_new0(T, (c))
> ++g_try_new0(T, c)
> +)
