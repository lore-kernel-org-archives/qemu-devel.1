Received: from eggs.gnu.org ([2001:4830:134:3::10]:53041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db44n-0003fw-N6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db44k-0002Ad-U2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:09:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db44k-00028r-Kk
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:09:02 -0400
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
	<CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06a9ae13-4279-1210-0664-0faf5f55f830@redhat.com>
Date: Fri, 28 Jul 2017 07:08:57 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3QN328n7RnrP6IPC7R1MM4Tp42cedc2Sc"
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3QN328n7RnrP6IPC7R1MM4Tp42cedc2Sc
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <06a9ae13-4279-1210-0664-0faf5f55f830@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
 <CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
In-Reply-To: <CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 04:04 AM, Peter Maydell wrote:
> On 28 July 2017 at 09:55, Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
>> To make logs more readable prefix all hex values with '0x' mark.
>> This is needed for consistency too, as a lot of hex values are already=

>> prefixed with '0x'. Also, bring all hex outputs to the common form -
>> use '%#', not '0x%'.
>>
>> This patch is done by two commands:
>> find . -name trace-events | \
>>  xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRIx\=
)\)/%#\1/g'

Why PRIx32 but not PRIX32?

>> find . -name trace-events | xargs sed -i 's/0x%#/%#/g'
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>=20
> There seem to be an order of magnitude more trace format strings
> using 0x% rather than %#, so maybe converting in the other direction
> would be better? I think the patch would also be easier to review
> if the "no change to the printed value" switches between 0x% and %#

Umm, 0x%x and %#x are not identical.  The difference is visible when
printing 0; the former produces 0x0 while the latter produces 0.

Fortunately, both forms are unambiguous, and the point of this exercise
is to make it unambiguous when a value must be read as hex to be
interpreted correctly.  I kind of like %#x, but agree that it is not as
commonly used; and from the consistency standpoint, seeing a series of
traces that report 0x0 vs. 0x1 is nicer than 0 vs 0x1.

> were not in the same patch as "changing the printed value which
> didn't have an 0x before".

I definitely agree with this advice of splitting things.

>=20
> thanks
> -- PMM
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3QN328n7RnrP6IPC7R1MM4Tp42cedc2Sc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7KVkACgkQp6FrSiUn
Q2pTQAf9HD8u3mdVfvGeKy+k9noQae5e69ZOcE7tq+0BTBS9JGFLCUnXx8yE2Ny4
d5B7dfpV+NvTYmwYh9NgtjiA9XDL3Cxwm1i9hTv9x9oDj6da4p6rz7a2xBQyasA4
voWHPkdn+KMpv4zwrIoS3OysoqEyPklZ5tU1rU2tTSWK+NqB/B5K7DJ612w7TOrh
V3brHWDdl7wEBJXrBJZICzQzEpDMDytzetvI+IF8xPgMWQyGJATZ0pAoEbD11tPW
U91lK3JhWo7NkW+yhut8KuDTn0UgdK4Aivj7UwI6Osy++bgVKaRU2uHDj89isS4j
WBJzyeI0kCGCkCT2l66LPvKLjfyKjQ==
=8U/5
-----END PGP SIGNATURE-----

--3QN328n7RnrP6IPC7R1MM4Tp42cedc2Sc--
