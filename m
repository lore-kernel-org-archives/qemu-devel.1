Received: from eggs.gnu.org ([2001:4830:134:3::10]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0TcV-0003xc-GK
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0TcR-00058S-H7
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e0TcR-00057L-7a
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:28:51 -0400
References: <150729895903.22243.5921581973131047310.malonedeb@gac.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5faae65d-7ab6-cc96-c85f-19f5514f8f8a@redhat.com>
Date: Fri, 6 Oct 2017 09:28:48 -0500
MIME-Version: 1.0
In-Reply-To: <150729895903.22243.5921581973131047310.malonedeb@gac.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WjfCppAUUv9N3qs8uEkQDJiMbhKMrMsN8"
Subject: Re: [Qemu-devel] [Bug 1721788] [NEW] Failed to get shared "write"
 lock with 'qemu-img info'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1721788 <1721788@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WjfCppAUUv9N3qs8uEkQDJiMbhKMrMsN8
From: Eric Blake <eblake@redhat.com>
To: Bug 1721788 <1721788@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <5faae65d-7ab6-cc96-c85f-19f5514f8f8a@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1721788] [NEW] Failed to get shared "write"
 lock with 'qemu-img info'
References: <150729895903.22243.5921581973131047310.malonedeb@gac.canonical.com>
In-Reply-To: <150729895903.22243.5921581973131047310.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2017 09:09 AM, Jan Heidbrink wrote:
> Public bug reported:
>=20
> When running 'qemu-img info test.qcow2' while test.qcow2 is currently
> used by a Qemu process, I get the error
>=20
> qemu-img: Could not open 'test.qcow2': Failed to get shared "write"
> lock.
>=20
>=20
> Why does displaying information about a disk image need a write lock fo=
r the file?

Because there is a risk (albeit rather slight) that what you read from
the disk is inconsistent due to being an intermediate state in-between
separate non-atomic write actions by the other process that has it open
for write.

If you are willing to ignore the risk, then use:

qemu-img info -U test.qcow2

which says that you are okay reading the image while it is shared with a
concurrent writer, even if the read fails spectacularly in the unlikely
case that it sees inconsistent information.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WjfCppAUUv9N3qs8uEkQDJiMbhKMrMsN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnXkyAACgkQp6FrSiUn
Q2rorAgAk8iRGvlsUjFEolE95ozbrLWNQAOiJqG2h0lYwmWp7r5ozh1nmcmP6Rm+
TRs4dJHKIqoCFeci/+GC3Y8QHVZVQlnICrRIpYLaI4KaHyyYdsjyb4YOtB471I/V
uuYpxIk0+JAa6QWAGD0z6pFYRHWTlrQVGc2bqj9CCR9zqxJ0/Y2KDxlWjed7kEdY
sF+IFoSsY97gc17unoJAu/AyuWoSULACPllQeFbOaQFO+svnYB+FGTQ9vqgjJLKQ
iGOA8UuJXuw14hTTBLp8t+mic3y4q4iA00C779C3Kcv79Xr4tYEnOiLXHwo0MZTE
a9tlnVGodFnAd7RjZLQo149F8vMt1Q==
=nHpW
-----END PGP SIGNATURE-----

--WjfCppAUUv9N3qs8uEkQDJiMbhKMrMsN8--
