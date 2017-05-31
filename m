Received: from eggs.gnu.org ([2001:4830:134:3::10]:36640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG669-00020x-Am
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG668-0002la-6R
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:03:49 -0400
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
	<a3ee5a6d-b16f-c4fd-b66e-da80d06f30a9@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b82b36b-e186-c493-ece4-28f027505ae7@redhat.com>
Date: Wed, 31 May 2017 18:03:37 +0200
MIME-Version: 1.0
In-Reply-To: <a3ee5a6d-b16f-c4fd-b66e-da80d06f30a9@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jTUJVCnxoqinucqfJNDd62Xrf02hbBWTi"
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jTUJVCnxoqinucqfJNDd62Xrf02hbBWTi
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com
Message-ID: <9b82b36b-e186-c493-ece4-28f027505ae7@redhat.com>
Subject: Re: [PATCH 0/2] Add reduce image for qcow2
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
 <5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
 <a3ee5a6d-b16f-c4fd-b66e-da80d06f30a9@virtuozzo.com>
In-Reply-To: <a3ee5a6d-b16f-c4fd-b66e-da80d06f30a9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-31 17:54, Pavel Butsykin wrote:
> On 31.05.2017 18:03, Eric Blake wrote:
>> On 05/31/2017 09:43 AM, Pavel Butsykin wrote:
>>> This patch adds the reduction of the image file for qcow2. As a
>>> result, this
>>> allows us to reduce the virtual image size and free up space on the
>>> disk without
>>> copying the image. Image can be fragmented and reduction is done by
>>> punching
>>> holes in the image file.
>>>
>>> # ./qemu-img create -f qcow2 -o size=3D4G image.qcow2
>>> Formatting 'image.qcow2', fmt=3Dqcow2 size=3D4294967296 encryption=3D=
off
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>>
>>> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
>>
>> So this is 1G of guest-visible data...
>>
>>> # ./qemu-img resize image.qcow2 128M
>>> Image resized.
>>
>> ...and you are truncating the image by throwing away guest-visible
>> content, with no warning or double-checking (such as requiring a -f
>> force parameter or something) about the data loss.  Shrinking images i=
s
>> something we should allow, but it feels like is a rare enough operatio=
n
>> that you don't want it to be casually easy to throw away data.
>=20
> It is assumed that the user has already made a preparatory with the
> image:
> 1. freeing space at the end of the image
> 2. reducing the last partition on the disk
> 3. rebuilding fs
> Only after these steps, the user can reduce the image by qemu-img.

But your implementation allows the user to reduce it anyway, even if
these steps have not been performed.

I very much agree that we have to be careful because otherwise you might
ruin all your data if you hand-type a resize command and drop a digit.

> I think it's not so rare case, sometimes people run out of disk space
> and this is another way to solve the problem (along with the use of
> trim).
>=20
> We already have all the interfaces, left them only to support :)
>=20
>> Is it feasible to require that a shrink operation will not be performe=
d
>> unless all clusters being eliminated have been previously discarded (o=
r
>> maybe written to zero), as an assurance that the guest did not care
>> about the tail of the image?
>>
>=20
> Yes.
>=20
> # ./qemu-img create -f qcow2 -o size=3D4G image.qcow2
>=20
> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
> # ./qemu-io -c "write -P 0x22 1G 1G" image.qcow2
>=20
> # qemu-img map ./image.qcow2
> Offset          Length          Mapped to       File
> 0               0x20000000      0x50000         ./image.qcow2
> 0x20000000      0x20000000      0x20060000      ./image.qcow2
> 0x40000000      0x20000000      0x40070000      ./image.qcow2
> 0x60000000      0x20000000      0x60080000      ./image.qcow2
>=20
> # ./qemu-io -c "discard 1G 1G" ./image.qcow2
>=20
> # qemu-img map ./image.qcow2
> Offset          Length          Mapped to       File0 0x20000000    =20
> 0x50000         ./image.qcow2
> 0x20000000      0x20000000      0x20060000      ./image.qcow2

No, it isn't, because qemu-io is a debugging tool and a debugging tool on=
ly.

We could require the user to perform a trim operation or something in
the guest instead -- but I'd prefer a plain new flag for qemu-img resize
that says the user is OK with shrinking the image and thus throwing data
way.

I think it's fine to have this flag only as part of the qemu-img
interface, not e.g. for the block-resize QMP command. I think it's
reasonable to assume someone sending a QMP command (i.e. usually the
management layer) to know exactly what they are doing. OTOH, I wouldn't
oppose a flag there, though, I just don't think it's absolutely necessary=
=2E

Max


--jTUJVCnxoqinucqfJNDd62Xrf02hbBWTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLulaEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQK2f
B/9/BSbKTWlcj7Qw5R0SG25Diw3PlRK8Qm2tfaUtTEbQw10djoOPzasS7zHmyW0V
guY7n6fg2PiDe6Zd6pdmat6O3b3K8YWiMvfl02O9h8HbxiLVRPVBERVgA0F+3Khh
k4kpNrYqRUoYSJUIjKGC4WHNkHFyDAihbG4C9I/t0QdIP0Dl5kEK/3cGiuTXFRjx
oWobh7YEM52jSROtrnZGICIGZ+xmX83JZ5WN8xmBFZjCYuFlMmVUO9XJTGSWQDAS
5vLq3a3l0A96s03Yc6mqn+mggroCQtvs+pVGVYqGApYTe172fV41mtXnHUoCMb8w
IW/6ysphJ7r0sj4thUfIuN7p
=vxZZ
-----END PGP SIGNATURE-----

--jTUJVCnxoqinucqfJNDd62Xrf02hbBWTi--
