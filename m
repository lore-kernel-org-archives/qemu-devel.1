Received: from eggs.gnu.org ([2001:4830:134:3::10]:38484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDycC-0001So-2P
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDycA-0002Qv-Ue
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:40:08 -0400
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-13-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bf5923b7-60aa-f2b9-4a22-7d5ff814698a@redhat.com>
Date: Thu, 25 May 2017 14:39:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170525163851.8047-13-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mTeOAGpb9n4aGQ9K8SfveAXFdWLQ3boQe"
Subject: Re: [Qemu-devel] [PATCH v7 12/20] qcow2: extend specification to
 cover LUKS encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mTeOAGpb9n4aGQ9K8SfveAXFdWLQ3boQe
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <bf5923b7-60aa-f2b9-4a22-7d5ff814698a@redhat.com>
Subject: Re: [PATCH v7 12/20] qcow2: extend specification to cover LUKS
 encryption
References: <20170525163851.8047-1-berrange@redhat.com>
 <20170525163851.8047-13-berrange@redhat.com>
In-Reply-To: <20170525163851.8047-13-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 11:38 AM, Daniel P. Berrange wrote:
> Update the qcow2 specification to describe how the LUKS header is
> placed inside a qcow2 file, when using LUKS encryption for the
> qcow2 payload instead of the legacy AES-CBC encryption
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  docs/specs/qcow2.txt | 96 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 96 insertions(+)
>=20

> +
> +The first 592 bytes of the header clusters will contain the LUKS
> +partition header. This is then followed by the key material data areas=
=2E
> +The size of the key material data areas is determined by the number of=

> +stripes in the key slot and key size. Refer to the LUKS format
> +specification ('docs/on-disk-format.pdf' in the cryptsetup source
> +package) for details of the LUKS partition header format.
> +
> +In the LUKS partition header, the "payload-offset" field will be
> +calculated as normal for the LUKS spec. ie the size of the LUKS
> +header, plus key material regions, plus padding, relative to the
> +start of the LUKS header. Its value is never used in the context
> +of qcow2, however, since the qcow2 file format itself defines where
> +the real payload offset is.

Is it possible/valid for the LUKS payload-offset field to NOT be
qcow2-cluster-aligned?  (I'm guessing yes, for example, if we have 2M
clusters; and that we don't care, because you documented that we don't
actually use that offset).  Is it worth documenting this?

> +=3D=3D Data encryption =3D=3D
> +
> +When an encryption method is requested in the header, the image payloa=
d
> +data must be encrypted/decrypted on every write/read. The image header=
s
> +and metadata is never encrypted.

s/is/are/

> +
> +The algorithms used for encryption vary depending on the method
> +
> + - AES:
> +
> +   The AES cipher, in CBC mode, with 256 bit keys.
> +
> +   Initialization vectors generated using plain64 method, with
> +   the virtual disk sector as the input tweak.

Worth documenting that implementations should avoid creating new images
with this encryption (ie. make it officially part of the spec that this
is not recommended, but merely documented for back-compat data
liberation purposes)?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mTeOAGpb9n4aGQ9K8SfveAXFdWLQ3boQe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJzMMAAoJEKeha0olJ0NqRiMIAK9XBkFFcr+ik6tKK+mgvBpI
kfJdMk0IfFydw+PiAYAKayZVCtPlWcCx0dPZ7MByvMn9FrrwY9s6OD7ohUOqi5s8
zRm5Z/49YBUXP2Lzi5+IvTnzjXCPu6yBKnhtqRczHrUQddPDC/Tgwq1DsGlAJYIf
SyKjGy9nl3hESC58nspQmX8AVxB5DLUpiBh1nFNbblhvkzPENh0PAkkpKxZF6hrv
UVq+bPSL+KorstoTfxSZkM9K/+61ttBlJkyfYQ5KZRZ7L8hDIQ5SZHvblJSyvONA
c2TQOxPVYgDpWaVG+dxjHgnARot4YnEaFXEhki95ieengYqiWfKyp5lWlTzlOK4=
=8zA6
-----END PGP SIGNATURE-----

--mTeOAGpb9n4aGQ9K8SfveAXFdWLQ3boQe--
