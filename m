Received: from eggs.gnu.org ([209.51.188.92]:44381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi5aZ-0001MY-8t
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi5aY-0007g4-CP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:47:43 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-8-eblake@redhat.com>
	<b91e2cff-2d5c-f5dd-e8cc-7a8944c93de4@virtuozzo.com>
	<048303ff-cdc2-d0b6-a990-1453df29626b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab8a8d24-162e-8de7-bb90-7195ede9f471@redhat.com>
Date: Fri, 11 Jan 2019 16:47:34 -0600
MIME-Version: 1.0
In-Reply-To: <048303ff-cdc2-d0b6-a990-1453df29626b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="apnIeHjN4FCxxEhG3DE9twTXoRZs3bUG8"
Subject: Re: [Qemu-devel] [PATCH v2 07/22] qemu-nbd: Avoid strtol open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--apnIeHjN4FCxxEhG3DE9twTXoRZs3bUG8
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "rjones@redhat.com"
 <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <ab8a8d24-162e-8de7-bb90-7195ede9f471@redhat.com>
Subject: Re: [PATCH v2 07/22] qemu-nbd: Avoid strtol open-coding
References: <20181215135324.152629-1-eblake@redhat.com>
 <20181215135324.152629-8-eblake@redhat.com>
 <b91e2cff-2d5c-f5dd-e8cc-7a8944c93de4@virtuozzo.com>
 <048303ff-cdc2-d0b6-a990-1453df29626b@redhat.com>
In-Reply-To: <048303ff-cdc2-d0b6-a990-1453df29626b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/4/19 5:50 PM, Eric Blake wrote:

>> hmm, as I understand, even if this compatibility exists, it's not a pa=
rt
>> of standard and nothing about off_t size in POSIX..
>=20
> off_t allows you to run on older systems with 32-bit offsets and newer
> systems with 64-bit offsets; but these days, even on 32-bit systems, we=

> compile qemu to always ask for 64-bit off_t.  Using off_t instead of
> int64_t is probably a separate cleanup, but one that may be worth makin=
g
> prior to this patch, so I'll defer this one to my v3.
>=20
>>
>> Moreover: what is the reason for using off_t in NBD code? We don't hav=
e it
>> in NBD protocol, we don't have it in generic block layer interface. Is=
n't it
>> always casted to int64_t or like this?

Thanks again for asking this question. In auditing the use of off_t, I
found that 'qemu-nbd -P 1' happily tries to read beyond the bounds of
the BDS.  Thankfully, I can't find an exploit (escaped the CVE bullet -
no DoS assertion, overlarge malloc, information leak, or other nasty
problem), merely a permanent EIO down the road once the client tries to
access advertised available bytes; but I'm also adding a patch to my v3
series that does sanity checking (as we should NEVER blindly trust
values in a potentially-malicious image as being in bounds, so that
clients can't even connect to such images in the first place). [I also
think that qemu-nbd -P is seldom-used...]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--apnIeHjN4FCxxEhG3DE9twTXoRZs3bUG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw5HQYACgkQp6FrSiUn
Q2pGmgf/Z29/DKK6dBt1qiOEoFBU4Co5BOLWz16OKG/ehsKfrEbR+Q+BYCzLovqq
6TaE1o3ouNpZxk3ftds/A0edsh5zRYYC861O9CKNBm4UyPL50CS9qduoc1ZkWUav
yDyb0Ikbo1biJihQNIKjYoUSxrp3HpBN7fFV6puVOKqBOAsfo2VSdl7iTm14Mle3
ALiKfE6WbyPQpiH4PfQUfvbng9BsI3h37qjfpxYa73s3geTdaNzY7z2n2JUSgxxC
F7XPADOODSQNRLu0S/lwB7qbo3mELDNKMkGLrTgFWwcmcIGrRaKgHdQtuLCGoyk9
+OYj/597h65ro/1Kz0h8KvS/0Sba0g==
=NVyq
-----END PGP SIGNATURE-----

--apnIeHjN4FCxxEhG3DE9twTXoRZs3bUG8--
