Received: from eggs.gnu.org ([2001:4830:134:3::10]:53064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUFR3-0000xt-H9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUFR2-0004EU-JY
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:19:37 -0500
References: <20170119143816.21972-1-famz@redhat.com>
	<20170119143816.21972-15-famz@redhat.com>
	<20170119154900.GB16641@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d9d7b54-bc34-e0fe-79d9-1ec83472aca9@redhat.com>
Date: Thu, 19 Jan 2017 10:19:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170119154900.GB16641@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nrqkKRVjXGx1woTn5IWUUoSL24We7ecpm"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v10 14/16] file-posix:
 Implement image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nrqkKRVjXGx1woTn5IWUUoSL24We7ecpm
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com
Message-ID: <9d9d7b54-bc34-e0fe-79d9-1ec83472aca9@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH v10 14/16] file-posix: Implement
 image locking
References: <20170119143816.21972-1-famz@redhat.com>
 <20170119143816.21972-15-famz@redhat.com> <20170119154900.GB16641@redhat.com>
In-Reply-To: <20170119154900.GB16641@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 09:49 AM, Daniel P. Berrange wrote:
> On Thu, Jan 19, 2017 at 10:38:14PM +0800, Fam Zheng wrote:
>> This implements open flag sensible image locking for local file
>> and host device protocol.
>>
>> virtlockd in libvirt locks the first byte, so we start looking at the
>> file bytes from 1.
>>
>> Quoting what was proposed by Kevin Wolf <kwolf@redhat.com>, there are
>> four locking modes by combining two bits (BDRV_O_RDWR and
>> BDRV_O_SHARE_RW), and implemented by taking two locks:
>>

>> +/* Posix file locking bytes. Libvirt takes byte 0, so start from byte=
 1. */
>> +#define RAW_LOCK_BYTE_MIN             1
>> +#define RAW_LOCK_BYTE_NO_OTHER_WRITER 1
>> +#define RAW_LOCK_BYTE_WRITE           2
>=20
> ...would you mind if QEMU started from say byte 10, leaving the first 1=
0
> reserved for libvirt uses. This lets libvirt have a continuous space fo=
r
> its own usage if we want to use more bytes

Thankfully, fcntl() locks can be taken beyond end-of-file, so I think
we're okay making an arbitrarily larger range of bytes reserved for each
process, even in the unlikely corner case of passing files smaller than
512 bytes.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nrqkKRVjXGx1woTn5IWUUoSL24We7ecpm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgOcRAAoJEKeha0olJ0NqdZQIAKgVu93DO7i0VuM9oAWGw+Nd
jMiMWoDaaoYopwt4wPo02O8O62A+mudAYJ2SjeBAkylAx/IPdmD32iJvq7Ud/wUi
9LbSURhGl0qiKFJXwEawuQ+vbXbOQxXaWFJYaYAzbJH7dHmFpu8OLERnKWkHz9ra
+2zse8YnFpGNWhQYRP4JRRIvsIVc2JglQB/eCkn/9GV75ye+TNGsBLnsD/w6Q50O
Ksp0rdRcAnwbHEPXbm2YMyhR3FVWCXgZSh6WM+HVAnVO5w9wNp6N2FYMeuqcnyvh
SCObv+3Nn03nI9XIgU73pSD1YNnPxKcq+KbvKVrNiLs9Sw9Icjl/YLVJtquYzmM=
=bChz
-----END PGP SIGNATURE-----

--nrqkKRVjXGx1woTn5IWUUoSL24We7ecpm--
