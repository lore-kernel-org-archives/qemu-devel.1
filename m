Received: from eggs.gnu.org ([2001:4830:134:3::10]:59893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb70E-0006AA-Nk
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb70D-0005CY-Ly
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:21:06 -0400
Date: Thu, 5 Jul 2018 18:21:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705162100.GO3309@localhost.localdomain>
References: <20180704150229.9948-1-f4bug@amsat.org>
	<20180705102022.GE3309@localhost.localdomain>
	<b7b181c1-7383-c76b-efd4-002f928707ac@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b7b181c1-7383-c76b-efd4-002f928707ac@amsat.org>
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

Am 05.07.2018 um 18:04 hat Philippe Mathieu-Daud=E9 geschrieben:
> On 07/05/2018 07:20 AM, Kevin Wolf wrote:
> > Am 04.07.2018 um 17:02 hat Philippe Mathieu-Daud=E9 geschrieben:
> >> After 1ec4f4160a1 Coverity reported:
> >>
> >>   Variable cryptoopts going out of scope leaks the storage it points=
 to.
> >>
> >> Fixes: Coverity CID 1393782 (Resource leak)
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >=20
> > I already sent a much simpler fix:
> > [PATCH] block/crypto: Fix memory leak in create error path
>=20
> Oh OK I searched a bit but missed it.
>=20
> > The only thing that is needed is replacing the return with a goto.
> > Splitting it in three different error paths is unnecessary because th=
e
> > cleanup function handle NULL values just fine.
>=20
> OK, good to know.
>=20
> >> I think this check is superfluous but I respected the previous code:
> >>
> >>      ret =3D block_crypto_co_create_generic(bs, size, create_opts, e=
rrp);
> >>      if (ret > 0) {
> >>          ret =3D 0;
> >>      }
> >=20
> > It is wrong, too. The old code keep the error code, goto fail skipped
> > the ret =3D 0.
>=20
> So this is not particularly wrong but as superfluous as the current use=
 :)
>=20
> ret =3D 0 is only useful if block_crypto_co_create_generic() returned a
> value > 0, which seems unlikely.

Sorry, yes, you're right. I read 'if (ret < 0)' in your patch.

The reason for the seemingly superfluous error path is that you can add
new code behind it without having to modify the existing code.

Kevin
