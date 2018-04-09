Received: from eggs.gnu.org ([2001:4830:134:3::10]:44695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5QnO-0000K2-Ps
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5QnI-0005Ni-Qz
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:00:54 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f5QnI-0005Lu-JK
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:00:48 -0400
Received: by mail-pf0-x241.google.com with SMTP id g14so5339137pfh.3
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 00:00:48 -0700 (PDT)
Date: Mon, 9 Apr 2018 15:00:41 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180409070041.GE4848@stefanha-x1.localdomain>
References: <20180403050115.6037-1-peterx@redhat.com>
	<20180404142220.GT4467@stefanha-x1.localdomain>
	<20180408051207.GG10540@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <20180408051207.GG10540@xz-mi>
Subject: Re: [Qemu-devel] [PATCH for-2.12] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 01:12:07PM +0800, Peter Xu wrote:
> On Wed, Apr 04, 2018 at 03:22:20PM +0100, Stefan Hajnoczi wrote:
> > On Tue, Apr 03, 2018 at 01:01:15PM +0800, Peter Xu wrote:
> > > Eric Auger reported the problem days ago that OOB broke ARM when runn=
ing
> > > with libvirt:
> > >=20
> > > http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
>=20
> [1]
>=20
> > >=20
> > > This patch fixes the problem.
> > >=20
> > > It's not really needed now since we have turned OOB off now, but it's
> > > still a bug fix, and it'll start to work when we turn OOB on for ARM.
> > >=20
> > > The problem was that the monitor dispatcher bottom half was bound to
> > > qemu_aio_context, but that context seems to be for block only.
> >=20
> > No, it is not block-only.  iohandler_ctx is for the legacy
> > qemu_set_fd_handler() API only and modern code should use
> > qemu_aio_context.
> >=20
> > The difference between qemu_aio_context and iohandler_ctx is that
> > aio_poll(qemu_aio_context) does not process iohandler_ctx (since it's a
> > difference context).  That is the legacy behavior that
> > qemu_set_fd_handler() expects and it's implemented by keeping a separate
> > iohandler_ctx.
> >=20
> > > For the
> > > rest of the QEMU world we should be using iohandler context.  So
> > > assigning monitor dispatcher bottom half to that context.
> >=20
> > This patch relies on the side-effect that iohandler_ctx is only called
> > later by the main loop, which seems to prevent the crash below.
>=20
> Actually I thought that's why we need that iohandler_ctx, no?
>=20
> Any better suggestion would be welcomed...

iohandler_ctx is for the qemu_set_fd_handler() API.  Monitor code
doesn't use that API, it uses the chardev API.

The problem you've described is that monitor chardev handlers are being
invoked too early.  The straightforward fix is for monitor.c to set up
handlers at the right time - when we want the monitor to begin
processing commands.

> >=20
> > What is the actual crash/problem?  You mentioned the GIC, but what does
> > that have to do with monitor code crashing?
>=20
> The actually crash is mentioned above [1].  Please have a look on that
> thread for details.

The email you linked says there is a bug and git-bisect led to a commit.
It doesn't explain the bug.

If you want to get code merged, please make life easy for reviewers.
Don't link to email threads and expect reviewers to research the bug.

Put the root cause into the commit description so there's enough
information to understand the issue in your commit.

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJayw+ZAAoJEJykq7OBq3PIGS4H/2orGB9FomlajDRm8JtERfF1
ny997Kwztsnm88v1HxbZgCu+pre1UgZr0Ir7V1rTVEklDR/ofoANJVMm7Mtnyi6p
MX1CuJTRGi/7URIzvNGool03ShQPpLqUocMT8kr9SBlTOzSj1Att5Es0hALIOF7z
1YjN9JQx++qnDrWpd4UVrcNzrRchm0Esc66Hu0z2mVb/ypg+fPGT/6DBoXupMHye
kGbIUsg+7HBu8KOnGVmyyw+DATXfikDNmbkUfZmcp2ucBFbi8djl3H6Oyxv9U7bA
TlW6B2Z8VEmDsPDQSNCqcNeZa19KE1lZZV97Qhqq4Z189zeWaHgzOh14Q/T+vTE=
=KW09
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
