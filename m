Received: from eggs.gnu.org ([2001:4830:134:3::10]:33998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fAdq7-0003PK-IH
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fAdq6-0004tJ-LY
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:57:15 -0400
References: <20180420220913.27000-1-mreitz@redhat.com>
	<w51muxuxdpc.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b29bbb7f-af87-0968-e4c3-2f13700d9769@redhat.com>
Date: Mon, 23 Apr 2018 17:56:54 +0200
MIME-Version: 1.0
In-Reply-To: <w51muxuxdpc.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BpGpDpzUA0Zk2bspjHSmtm2yNuGpuJIal"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] block/file-posix: File
 locking during creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BpGpDpzUA0Zk2bspjHSmtm2yNuGpuJIal
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b29bbb7f-af87-0968-e4c3-2f13700d9769@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/3] block/file-posix: File locking during
 creation
References: <20180420220913.27000-1-mreitz@redhat.com>
 <w51muxuxdpc.fsf@maestria.local.igalia.com>
In-Reply-To: <w51muxuxdpc.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-23 15:19, Alberto Garcia wrote:
> On Sat 21 Apr 2018 12:09:10 AM CEST, Max Reitz wrote:
>> Currently we do not take permissions on a file while it is being
>> created.  That is a bit sad.  The simplest way to test this is the
>> following:
>>
>>     $ qemu-img create -f qcow2 foo.qcow2 64M
>>     Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
65536 lazy_refcounts=3Doff refcount_bits=3D16
>>     $ qemu-img convert -f qcow2 -O qcow2 foo.qcow2 foo.qcow2
>>     qemu-img: foo.qcow2: error while converting qcow2: Failed to get "=
write" lock
>>     Is another process using the image?
>>     $ qemu-img info foo.qcow2
>>     image: foo.qcow2
>>     file format: raw
>>     virtual size: 0 (0 bytes)
>>     disk size: 0
>=20
> Not quite the same problem, but here's another example of QEMU creating=

> an image before checking if it can be created:
>=20
> $ qemu-img create -o cluster_size=3D2M -f qcow2 img.qcow2 7E
> Formatting 'img.qcow2', fmt=3Dqcow2 size=3D8070450532247928832 encrypti=
on=3Doff cluster_size=3D2097152 lazy_refcounts=3Doff refcount_bits=3D16
> qemu-img: img.qcow2: The image size is too large for file format 'qcow2=
' (try using a larger cluster size)
>=20
> $ qemu-img info img.qcow2=20
> image: img.qcow2
> file format: qcow2
> virtual size: 0 (0 bytes)
> disk size: 6.0M
> cluster_size: 2097152
> Format specific information:
>     compat: 1.1
>     lazy refcounts: false
>     refcount bits: 16
>     corrupt: false
>=20
> Berto

Actually a very different problem, and I think we are not going to
change this behavior -- especially considering the direction
blockdev-create is taking (that is, separating protocol file creation
and formatting).

The main reason why it's a different problem, though, is because it
doesn't mean any data loss.  You just get a stale file lying around.

(You could argue that in any case the file should at least be a raw file
of size 0, because the qcow2 driver should not start formatting until it
has checked all options, but, well...  I don't know how that would help
anyone.)

Max


--BpGpDpzUA0Zk2bspjHSmtm2yNuGpuJIal
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlreAkYACgkQ9AfbAGHV
z0Cxvgf/Qn9PBW171lzFkIoLnXOuaeJrOxWv3l2gdsjezVty1vh8WR/ARDyedqaZ
LCvUntSt3o0Ud7vfwN5SC6f1MMypAwgFsfsSwDFN65DcRnTPo5J3g7PHYcLiqr3b
fXOo2/Tk9AJCddKtTjumOUx74MICPtPURb82dzg1YiZIXTqwMBlLRo+WXy3KW9Xu
jzPMYz1qv7vIPRVd/H+M/K6RzcpHtrwNmEsvmROWpI1EIZuGnoHFhxVr0KszZC7i
xdqQ5TjHXs+FWJxpFiYbw/JY8f3u++gHhnCi4tVyYopluXwRF4VUmSr+8OvgSG/P
029uX8Ap4dqskf3dXBTM///YeKU8Tg==
=NTgE
-----END PGP SIGNATURE-----

--BpGpDpzUA0Zk2bspjHSmtm2yNuGpuJIal--
