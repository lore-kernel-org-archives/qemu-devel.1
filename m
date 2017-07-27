Received: from eggs.gnu.org ([2001:4830:134:3::10]:35402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dai9X-0006G4-Ch
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dai9T-00081k-FX
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:44:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dai9T-00080Z-5t
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:44:27 -0400
References: <CAB3eZfszxeKpkXHfm-EVtfeZCL1Spz0z2x2vS5KbVezLPjwfXQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb4b797e-d9f9-4599-6696-c4a29d9e2fac@redhat.com>
Date: Thu, 27 Jul 2017 07:44:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfszxeKpkXHfm-EVtfeZCL1Spz0z2x2vS5KbVezLPjwfXQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fqK2rI2NwXHcNNe6E0k8iRKXdHTUp2kD6"
Subject: Re: [Qemu-devel] why marking qcow2 img as corrupted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fqK2rI2NwXHcNNe6E0k8iRKXdHTUp2kD6
From: Eric Blake <eblake@redhat.com>
To: lampahome <pahome.chen@mirlab.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <bb4b797e-d9f9-4599-6696-c4a29d9e2fac@redhat.com>
Subject: Re: [Qemu-devel] why marking qcow2 img as corrupted
References: <CAB3eZfszxeKpkXHfm-EVtfeZCL1Spz0z2x2vS5KbVezLPjwfXQ@mail.gmail.com>
In-Reply-To: <CAB3eZfszxeKpkXHfm-EVtfeZCL1Spz0z2x2vS5KbVezLPjwfXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 10:53 PM, lampahome wrote:
> I tried take snapshots on a demo.qcow2 10 times.
> cmd is below:
>=20
>> qemu-img snapshots -c tag_1 demo.qcow2

Which version of qemu-img?  Also, can you show 'qemu-img info
demo.qcow2'? Is your guest running at the same time, or is qemu-img the
only process touching the file?

If you were using something older than qemu 2.9 (where we enabled image
locking protection), then I suspect what happened is that you corrupted
your image because you had multiple writer processes acting on the file
at once.  If so, your image really is corrupted, and I hope you have a
good backup.  qemu stopped making the damage worse, but recovering data
from a corrupted image is not always possible.  (Even with newer qemu,
you can still override multiple writer protection, but you really
shouldn't, as it is really there for your protection.)

You are creating internal snapshots, which don't get quite as much
testing, but you SHOULD be able to create multiple internal snapshots in
a row (certainly more than 7) without it causing internal corruption
(there is a finite limit based on your choice of refcount_order in the
qcow2 header; the default order of 4 permits up to nearly 64k snapshots,
while setting the order to 0 prohibits snapshots - but you should get a
sane error message about exceeding limits, rather than image corruption).=


Also, see if you can adjust your workflow to use external snapshots
instead of internal, to avoid running into the issue.

>=20
>=20
> when I take snapshots 7 times and console shows:
>=20
>> mark image as corrupted and preventing from invalid write
>=20
>=20
> and I can't take snapshots anymore then.
> Can I avoid this situation or remove the limit?

At any rate, I couldn't reproduce your problem when not violating
multiple writer constraints:

$ ./qemu-img --version
qemu-img version 2.9.90 (v2.10.0-rc0-1-g0f0f0a5335)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
$ ./qemu-img create -f qcow2 example 1M
Formatting 'example', fmt=3Dqcow2 size=3D1048576 cluster_size=3D65536
lazy_refcounts=3Doff refcount_bits=3D16
$ # An empty file is no fun, add some data
$ ./qemu-io -f qcow2 -c 'w 0 64k' example
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0428 sec (1.458 MiB/sec and 23.3236 ops/sec)
$ # Create lots of internal snapshots
$ for i in `seq 16`; do ./qemu-img snapshot -c tag_$i example; done
$ ./qemu-img info example
image: example
file format: qcow2
virtual size: 1.0M (1048576 bytes)
disk size: 396K
cluster_size: 65536
Snapshot list:
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         tag_1                     0 2017-07-27 07:35:00   00:00:00.000
2         tag_2                     0 2017-07-27 07:35:00   00:00:00.000
3         tag_3                     0 2017-07-27 07:35:00   00:00:00.000
4         tag_4                     0 2017-07-27 07:35:00   00:00:00.000
5         tag_5                     0 2017-07-27 07:35:00   00:00:00.000
6         tag_6                     0 2017-07-27 07:35:01   00:00:00.000
7         tag_7                     0 2017-07-27 07:35:01   00:00:00.000
8         tag_8                     0 2017-07-27 07:35:01   00:00:00.000
9         tag_9                     0 2017-07-27 07:35:01   00:00:00.000
10        tag_10                    0 2017-07-27 07:35:01   00:00:00.000
11        tag_11                    0 2017-07-27 07:35:01   00:00:00.000
12        tag_12                    0 2017-07-27 07:35:01   00:00:00.000
13        tag_13                    0 2017-07-27 07:35:01   00:00:00.000
14        tag_14                    0 2017-07-27 07:35:01   00:00:00.000
15        tag_15                    0 2017-07-27 07:35:01   00:00:00.000
16        tag_16                    0 2017-07-27 07:35:01   00:00:00.000
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

And demonstrating the smaller refcount_order:

$ rm example
$ ./qemu-img create -f qcow2 -o refcount_bits=3D2 example 1M
Formatting 'example', fmt=3Dqcow2 size=3D1048576 cluster_size=3D65536
lazy_refcounts=3Doff refcount_bits=3D2
$ ./qemu-io -f qcow2 -c 'w 0 64k' example
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0324 sec (1.925 MiB/sec and 30.7967 ops/sec)
$ for i in `seq 3`; do ./qemu-img snapshot -c tag_$i example; done
qemu-img: Could not create snapshot 'tag_3': -22 (Invalid argument)

Not the nicest of error messages ("-22 (Invalid argument)" could
probably be something saner like "refcount_bits exceeded"), but the
image is still not corrupted:

$ qemu-img info example
image: example
file format: qcow2
virtual size: 1.0M (1048576 bytes)
disk size: 344K
cluster_size: 65536
Snapshot list:
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         tag_1                     0 2017-07-27 07:40:41   00:00:00.000
2         tag_2                     0 2017-07-27 07:40:41   00:00:00.000
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 2
    corrupt: false

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fqK2rI2NwXHcNNe6E0k8iRKXdHTUp2kD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll54CgACgkQp6FrSiUn
Q2rF1AgAjFy2C3zJ8fyEEElPj6VPEC4Re7iAKsTU6dFy6IIylULOcLaOpIeHLp6N
Kl4171J7skeJpCiO2Lp6CE+2LIWTVFPmUxQQE7yjPW/KPeIdexj7oeU4zzFSjnZf
E4yTsaplcVCXLWcMl0+bLyKfeo3icBAwDlm6Ib0W7T7GiNSePq3c7RrG7F2glF/4
uD7xklzpWrJ5WFQavL8KKHkoIr+c5AaCh/DZCypbges+m0UQHTnHKHPuJCfjV/W7
YfRu2z56G31D/LRah6AES5IZPcUUB0aQEGGm8Qq47tJRqSHGzaUrheTBF0B4FeNZ
djh4c8Aw3cDuD9nykotbZHwQNPaQkA==
=Gsnh
-----END PGP SIGNATURE-----

--fqK2rI2NwXHcNNe6E0k8iRKXdHTUp2kD6--
