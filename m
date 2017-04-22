Received: from eggs.gnu.org ([2001:4830:134:3::10]:50263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d1yHE-0005GO-F9
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 12:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d1yHD-00089w-GG
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 12:52:52 -0400
References: <1492814072-4276-1-git-send-email-li.ping288@zte.com.cn>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3258e8fb-d144-c36f-1847-0695d16ceb35@redhat.com>
Date: Sat, 22 Apr 2017 18:52:42 +0200
MIME-Version: 1.0
In-Reply-To: <1492814072-4276-1-git-send-email-li.ping288@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QFOB0hXlw1xK3QcnDpDfko6d0QV9vrPcM"
Subject: Re: [Qemu-devel] [PATCH] Block layer core: Fix qemu-img 'amend'
 subcommand failure of adjusting backing file in different path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ping Li <li.ping288@zte.com.cn>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QFOB0hXlw1xK3QcnDpDfko6d0QV9vrPcM
From: Max Reitz <mreitz@redhat.com>
To: Ping Li <li.ping288@zte.com.cn>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <3258e8fb-d144-c36f-1847-0695d16ceb35@redhat.com>
Subject: Re: [PATCH] Block layer core: Fix qemu-img 'amend' subcommand failure
 of adjusting backing file in different path
References: <1492814072-4276-1-git-send-email-li.ping288@zte.com.cn>
In-Reply-To: <1492814072-4276-1-git-send-email-li.ping288@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.04.2017 00:34, Ping Li wrote:
> Currently, qemu-img 'amend' subcommand would fail to adjust image's bac=
king file
> which was moved into different path.
> For example, parent.qcow2, the backing file of leaf.qcow2, first is at =
/home/a/,
> then moved into /home/b/. Originally this command,
>  "qemu-img amend -f qcow2 -o backing_fmt=3Dqcow2,backing_file=3D/home/b=
/parent.qcow2 leaf.qcow2",
>  would fail because qemu-img failed to open the old backing file of lea=
f.qcow2.
> Give the 'amend' subcommand a '-u' option to not open the old backing f=
ile
>  while openning leaf.qcow2.
>=20
> Signed-off-by: Li Ping<li.ping288@zte.com.cn>
> ---
>  qemu-img.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

So why can't you just use rebase -u?

I'm not completely opposed to adding this functionality to amend, but
I'd actually rather remove the ability to change the backing file from
amend than to add functionality that may turn out to be rather
complicated to implement...

As Eric has proposed, I also think we could turn on BDRV_O_NO_BACKING
automatically if the option list consists of nothing but backing_file
and backing_fmt. But then we'd have to think about the case where the
user gives both backing_file and some other option at the same time; it
may be unexpected that we do open the backing file in that case. The
best might actually to error out so the user is forced to do both
changes separately -- but at that point the logic gets so complicated
that I think we should at most add a note to qemu-img's man page that
qemu-img amend will open the backing file and that users should use
rebase -u if that is not desired...

Max


--QFOB0hXlw1xK3QcnDpDfko6d0QV9vrPcM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj7iloSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AL6sH/3WXaVZjgJu42JqaPS3jACdturbRMviL
RanTMLwIEe7ZqhyPQSUuIsbTthuIzdZg1PmIRfUi8MSsLokhbzvNKAc1YU2jjrDA
QyeQ/PfJDGLoUX2mt/5gpUc4iWmdSYIhoOeKJqAsZ7aOUnwat8husc9MNXSZGtbm
d6vjG7zF0i6dAgfHxrdGRMgiJNKgmgsFxqhTRDg1DGNfrMN2hPrH2nX+kCzOarEU
e42z4Bpp8zQvhAiS6JOLIF8l+pmuHKggI1FeqcZ5kWGmM3XigdF4wE5FkE1lhZsu
3ZrYAQp9zG8GSlKw0mx4p0UPQCk0mYUhYm22HdW3lA/QkxsHawtwn1k=
=RUZC
-----END PGP SIGNATURE-----

--QFOB0hXlw1xK3QcnDpDfko6d0QV9vrPcM--
