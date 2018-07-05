Received: from eggs.gnu.org ([2001:4830:134:3::10]:56622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1NJ-0003mo-4j
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1NI-00062D-5b
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:20:33 -0400
Date: Thu, 5 Jul 2018 12:20:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705102022.GE3309@localhost.localdomain>
References: <20180704150229.9948-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180704150229.9948-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/crypto: Simplify
 block_crypto_co_create_opts_luks to avoid a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

Am 04.07.2018 um 17:02 hat Philippe Mathieu-Daud=E9 geschrieben:
> After 1ec4f4160a1 Coverity reported:
>=20
>   Variable cryptoopts going out of scope leaks the storage it points to=
.
>=20
> Fixes: Coverity CID 1393782 (Resource leak)
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

I already sent a much simpler fix:
[PATCH] block/crypto: Fix memory leak in create error path

The only thing that is needed is replacing the return with a goto.
Splitting it in three different error paths is unnecessary because the
cleanup function handle NULL values just fine.

> I think this check is superfluous but I respected the previous code:
>=20
>      ret =3D block_crypto_co_create_generic(bs, size, create_opts, errp=
);
>      if (ret > 0) {
>          ret =3D 0;
>      }

It is wrong, too. The old code keep the error code, goto fail skipped
the ret =3D 0.

Kevin
