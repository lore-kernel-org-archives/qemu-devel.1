Received: from eggs.gnu.org ([2001:4830:134:3::10]:46438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhX8l-0001jL-5T
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhX8i-0003SK-19
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:23:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dhX8h-0003Rz-Qa
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:23:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 252682CE920
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:23:50 +0000 (UTC)
Date: Tue, 15 Aug 2017 09:23:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170815082344.GA32702@stefanha-x1.localdomain>
References: <20170814162142.29666-1-stefanha@redhat.com>
	<20170814163908.GG8506@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20170814163908.GG8506@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] trace: fix simpletrace.stp
 flight recorder mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 05:39:08PM +0100, Daniel P. Berrange wrote:
> On Mon, Aug 14, 2017 at 05:21:40PM +0100, Stefan Hajnoczi wrote:
> > The SystemTap flight recorder mode no longer works with simpletrace.stp=
 because
> > the event ID mapping records are emitted the first time an event fires.
> > Chances are, the event ID mapping record will not be in ring buffer whe=
n the
> > users wants to print the trace.
> >=20
> > This series solves the issue by using the trace-events-all global event
> > ordering for event IDs for simpletrace.stp.
>=20
> I see the way you've written it means it'll still honour the event
> id mappings in the header, if present, but I wonder what's the point
> of keeping that anymore ? If we need to support this ring-buffer mode,
> there's no way we can take advantage of having the ID mappings dynamically
> defined - we must always guarantee a stable mapping.
>=20
> IOW, should we just revert
>=20
>   commit 7f1b588f20d027730676e627713ae3bbf6baab04
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Tue Oct 4 14:35:50 2016 +0100
>=20
>     trace: emit name <-> ID mapping in simpletrace header
>    =20
> entirely ?

We cannot revert the commit because QEMU dynamically assigns event IDs
on startup.  Event IDs are not known ahead of time when the 'simple'
tracer is used.

Event IDs are only static when simpletrace.stp is used with the 'dtrace'
tracer since simpletrace.stp has global knowledge of all trace events
ahead of time.

Stefan

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZkq+QAAoJEJykq7OBq3PIWmYH/3jLGChyafR4WF1FYx2AnhL3
iW/JHViGeYKhbZCVoxzFv7xMZMR8+TzWfSX3nKuj/rT7DMyRpDvnIStG9MCCC8FG
qqCebRt4UDEdcI3pPcWG2l10JbpRfoc2JrcNDs3RYUpJDeHcqPQC5Tvvm91FCSLO
R3qvkLKvXovRhaLsvd2rd/p3+9/v0gZHG+7ns8HPgLA5N4Xls14LAOidSB/9redF
IrrTs0lxr9QZ5jGkLof20coW1Xvc6oOJCIpNpbwD1Zt2Q3mu2+rGvibgttOV5bcK
Arzpu8KbVb5DGP1LfwNj9Gqwu3UOk487U+Bh5Eb6yDiGUju0RzlNfzxdg+zx7kE=
=qL6R
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
