Received: from eggs.gnu.org ([2001:4830:134:3::10]:43616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG5AG-0004kL-Mg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG5AF-0003eh-Kq
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:04:00 -0400
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
Date: Wed, 31 May 2017 10:03:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4sLfH0kpV9CV320fxC07tRxbOGEdjIcrk"
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4sLfH0kpV9CV320fxC07tRxbOGEdjIcrk
From: Eric Blake <eblake@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com
Message-ID: <5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
Subject: Re: [PATCH 0/2] Add reduce image for qcow2
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
In-Reply-To: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 09:43 AM, Pavel Butsykin wrote:
> This patch adds the reduction of the image file for qcow2. As a result,=
 this
> allows us to reduce the virtual image size and free up space on the dis=
k without
> copying the image. Image can be fragmented and reduction is done by pun=
ching
> holes in the image file.
>=20
> # ./qemu-img create -f qcow2 -o size=3D4G image.qcow2
> Formatting 'image.qcow2', fmt=3Dqcow2 size=3D4294967296 encryption=3Dof=
f cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>=20
> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2

So this is 1G of guest-visible data...

> # ./qemu-img resize image.qcow2 128M
> Image resized.

=2E..and you are truncating the image by throwing away guest-visible
content, with no warning or double-checking (such as requiring a -f
force parameter or something) about the data loss.  Shrinking images is
something we should allow, but it feels like is a rare enough operation
that you don't want it to be casually easy to throw away data.

Is it feasible to require that a shrink operation will not be performed
unless all clusters being eliminated have been previously discarded (or
maybe written to zero), as an assurance that the guest did not care
about the tail of the image?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4sLfH0kpV9CV320fxC07tRxbOGEdjIcrk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLttXAAoJEKeha0olJ0NqzbMH/1hHIf1AT+/iubEJbsyjL6up
sNbRXelGC+XnOJrPHfjRD+Mul45AWhECgpTzoMCpe2xctVgjK438g2yPJRnnu9vB
X+E16R4zpZS0FWeLpUKoVGXs+tCG2FiSuA34B0H3TiukmNUId3uDCpDCacsUTzSk
s/nJwr6HeXy+CnnFYHI+rtuGC7ISiiXY8hJ0ThZL8SpjR38ZgirLVqvtwxe4R7jA
rJHEQD5W4MOAOQdPCIZVpNZSd042O+1Vt41EzZ9r9a+NePZLI5NmOg0VmIA0/8bd
LCOztFQ4NqM8RLPl/Yi/f4DmZJPz4cCdEXGNa7N52orI1zY8G/QJthcVfZJCvZQ=
=Lh/m
-----END PGP SIGNATURE-----

--4sLfH0kpV9CV320fxC07tRxbOGEdjIcrk--
