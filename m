Received: from eggs.gnu.org ([209.51.188.92]:46054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkcvd-0002V3-0C
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkcvb-0002xD-Tt
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:47:56 -0500
References: <20190117193658.16413-1-eblake@redhat.com>
	<f10654ba-04d3-3212-94ca-e72c511d51c2@virtuozzo.com>
	<38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <928553ea-9694-acc6-1c5f-5a09afc2c64c@redhat.com>
Date: Fri, 18 Jan 2019 16:47:42 -0600
MIME-Version: 1.0
In-Reply-To: <38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bBBlU0QYJE0el3gxX4SsUAlX77DkOJFZV"
Subject: Re: [Qemu-devel] [PATCH v4 00/21] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bBBlU0QYJE0el3gxX4SsUAlX77DkOJFZV
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <928553ea-9694-acc6-1c5f-5a09afc2c64c@redhat.com>
Subject: Re: [PATCH v4 00/21] nbd: add qemu-nbd --list
References: <20190117193658.16413-1-eblake@redhat.com>
 <f10654ba-04d3-3212-94ca-e72c511d51c2@virtuozzo.com>
 <38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
In-Reply-To: <38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 7:47 AM, Vladimir Sementsov-Ogievskiy wrote:

>=20
>  > Only expose MBR partition @var{num}.  Understands physical partition=
s
>  > 1-4 and logical partitions 5-8.
>=20
> I'm afraid, I'm too lazy to sort out these things I don't know, so just=
 believe. It at least
> corresponds to limits in code that it should be 1 <=3D partition <=3D 8=
 ;)

It matches the code, but I just learned the code is buggy for anything
larger than 5.  According to
http://tldp.org/HOWTO/Large-Disk-HOWTO-13.html, MBR Extended/Logical
partitions form a linked-list, something like:

MBR:              EBR1              EBR2
+----------+      +----------+      +----------+
+ Part 1   +   |->+ Part 5   +   |->+ Part 6   +
+ Part 2   +   |  + Next --------|  + 0        +
+ Part 3   +   |  + 0        +      + 0        +
+ Part 4 -------  + 0        +      + 0        +
+----------+      +----------+      +----------+

In reality, ANY of part 1-4 can point to the first EBR, as long as there
is at most one primary partition pointing to the extended partition -
even crazier is that there are different magic numbers in historical
use, such as type 5 for Part 3 and type 85 for Part 4, where MS-DOS
would treat Partition 3 as the extended partition and ignore Part 4, but
Linux would follow both chains (where the second extended partition thus
allowed Linux access to logical partitions residing in space beyond what
DOS could access).  But once you start the extended partition chain, all
logical partitions within the chain each have their own EBR table with
one entry for the partition and the next entry pointing to the next EBR,
meaning you can have more than 8 logical partitions (provided your disk
is big enough).

But our find_partition() code stupidly assumes that if there is any
extended partition type in the MBR (recognizing only type 5 or type F,
but not Linux' type 85), then all four entries in that EBR are logical
partitions 5-8 (and no more, rather than a linked list chain, as in:

MBR:              EBR
+----------+      +----------+
+ Part 1   +   |->+ Part 5   +
+ Part 2   +   |  + Part 6   +
+ Part 3   +   |  + Part 7   +
+ Part 4 -------  + Part 8   +
+----------+      +----------+

It's highly unlikely that there are any BIOS implementations that would
actually recognize such a partition beyond 5 as being bootable (there
might be OSs which are a bit more tolerant, since MBR doesn't seem to
have any one hard canonical specification).  I'd have to compare what
the Linux kernel MBR code does, to see if we even stand a chance of
being interoperable in any manner.  It doesn't help that nbdkit does not
yet support Logical MBR partitions.

Oh well, another project for another day; this documentation change is
going in as-is because it at least matches the code, even if the code is
buggy.  (I'm tempted to fix nbdkit to fully support MBR logical
partitions, then rip out the partitioning code in qemu as redundant as
you could get it via nbdkit if you really need it - qemu-nbd's -P 8 has
unchanged, and thus buggy, since at least commit 7a5ca8648 in May 2008,
with no user complaining of a bug for 11 years)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--bBBlU0QYJE0el3gxX4SsUAlX77DkOJFZV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxCV44ACgkQp6FrSiUn
Q2o7qwf+N/Q83/KE0a0uJ5+7bhkfye0/+VsJBLZ03KL6WSNku81btxT2RVtqxjVB
GOODSwdGTdTTMTc7y3M5fka8BCM5d1zA5U+ZKA6l2veHBKJuchrG0i7PT0mAXh00
M3Qw9JG20RbusyYG6Gs1qD3IhPyYR79hP8Qvop5z1QPLpt/L2iRc7seFr6SHpuxy
EbPSvKZbnpGGS1Yg0OytJ1tBOqwj+dQkp1UF17RgipdTXOzQQa56CVhn5XFHmbFU
veQZDSNIyg47XkmNgcUFdhqfn0ga7PPnjtu2pEsgMj+W799YdjC/w1X8Vj4fRPjc
76d7o/v7vBIny5TpUEQdMc2pNvN9PQ==
=8V5+
-----END PGP SIGNATURE-----

--bBBlU0QYJE0el3gxX4SsUAlX77DkOJFZV--
