Received: from eggs.gnu.org ([209.51.188.92]:35129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobfa-0007tp-0m
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobfY-0000qX-59
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:15:49 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-7-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2462ab2-4579-aad1-99e8-a474587ec409@redhat.com>
Date: Tue, 29 Jan 2019 16:15:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-7-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mygbsIMeNO00CG8IZr2NFXkmJJUkZmZ5Z"
Subject: Re: [Qemu-devel] [PATCH v2 06/18] qemu-iotests: Improve portability
 by searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mygbsIMeNO00CG8IZr2NFXkmJJUkZmZ5Z
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <f2462ab2-4579-aad1-99e8-a474587ec409@redhat.com>
Subject: Re: [PATCH v2 06/18] qemu-iotests: Improve portability by searching
 bash in the $PATH
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-7-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 11:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Bash is not always installed as /bin/bash. In particular on OpenBSD,
> the package installs it in /usr/local/bin.
> Use the 'env' shebang to search bash in the $PATH.
>=20
> Patch created mechanically by running:
>=20
>   $ git grep -lE '#! ?/bin/bash' -- tests/qemu-iotests | \
>     while read f; do \
>       sed -i 's_#!.\?/bin/bash_#! /usr/bin/env bash_' $f; \

I prefer | over _ when writing a sed expression around something with
embedded / (why? Because | has to be quoted in shell, but _ does not,
and it makes it more likely that I'll notice if I botched quoting or the
intended sed command).  But for a commit message, pasting what you
actually ran is fine.

Why a space between #! and /usr/bin/env? That's not our prevailing style:=


$ git grep '^#! /' | wc
     13      30     541
$ git grep '^#!/' | wc
    337     448   13442

Mishandles instances of:

#!/bin/bash -x

or any other case where there is something after /bin/bash (since some
platforms permit at most 1 argument to the interpreter, and your
conversion would be trying to pass 2 arguments as 1).  BSD env (and more
recently GNU Coreutils env) added:

#!/usr/bin/env -S /bin/bash -x

to work around platforms with odd shebang limitations (the lone argument
"-S /bin/bash -x" is sensibly re-split by env before exec'ing bash with
an argument of -x) - but that's not portable yet.  Thankfully, it looks
like none of your conversions encountered that problem; but I might used
an explict end-of-line anchor to make sure, as in:

sed -i 's|^#!.\?/bin/bash$|#!/usr/bin/env bash|' $f

>     done
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Can 'env' be located elsewhere than /usr/bin/env?

Possibly, but #! requires absolute paths on some platforms, so you have
a chicken-and-egg problem if it is not, so in practice /usr/bin/env is
reliable; and we're already using it elsewhere, so any platform where it
does not exist will have a lot more than just this patch to fix up.

Comments are tied to the commit message, but the mechanical conversion
itself looks sound, therefore:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--mygbsIMeNO00CG8IZr2NFXkmJJUkZmZ5Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQ0H8ACgkQp6FrSiUn
Q2o73Af6A/jnr+7M7Dm/Tr+Zietx9g849uf2TWlz9fc9uN3o3hKD6jxEeA3CzTYx
TTi5iUfG2x7PfKf5j/gYhU5fiobgDKxZwChmLE+T/75cYQWyO5bVZ758qrdnNp24
GfUk5Mi4gktgLK41G3gEbDbU0DfJMaXbAelICx/GwELQuy4RERIO+rDLUbA53h8t
7OKgh5yY+irsaEYYWEhDyzISJ6GAFyDl4VMOOtc/Ijjhd4nRQHXGrzEW3k2cc3r0
2Lh5+PX5BuNd+V7JP3tdd5y9/xpDjpYrrDSol+aGgj/aJktzWU4vn2h+fH71Prin
1qW3ioIrTf/WPv84tb5iRL1iAgIMvg==
=Ml6M
-----END PGP SIGNATURE-----

--mygbsIMeNO00CG8IZr2NFXkmJJUkZmZ5Z--
