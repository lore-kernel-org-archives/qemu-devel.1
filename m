Received: from eggs.gnu.org ([2001:4830:134:3::10]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chLAP-0007Qs-Vg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chLAM-0007W1-SL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:04:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chLAM-0007Vd-K3
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:04:30 -0500
References: <20170224172714.26026-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4652c1e-44db-f2c4-028b-3777bcbe7fa0@redhat.com>
Date: Fri, 24 Feb 2017 13:04:26 -0600
MIME-Version: 1.0
In-Reply-To: <20170224172714.26026-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GSbdIGPOm7mibNa2gFjrrRU2jtifkBBQP"
Subject: Re: [Qemu-devel] [PATCH] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Jitendra Kolhe <jitendra.kolhe@hpe.com>, Michal Privoznik <mprivozn@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GSbdIGPOm7mibNa2gFjrrRU2jtifkBBQP
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Jitendra Kolhe <jitendra.kolhe@hpe.com>,
 Michal Privoznik <mprivozn@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4652c1e-44db-f2c4-028b-3777bcbe7fa0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] os: don't corrupt pre-existing
 memory-backend data with prealloc
References: <20170224172714.26026-1-berrange@redhat.com>
In-Reply-To: <20170224172714.26026-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 11:27 AM, Daniel P. Berrange wrote:
> When using a memory-backend object with prealloc turned on, QEMU
> will memset() the first byte in every memory page to zero. While
> this might have been acceptable for memory backends associated
> with RAM, this corrupts application data for NVDIMMs.
>=20
> Instead of setting every page to zero, read the current byte
> value and then just write that same value back, so we are not
> corrupting the original data. Directly write the value instead
> of memset()ing it, since there's no benefit to memset for a
> single byte write.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20

>          /* MAP_POPULATE silently ignores failures */
>          for (i =3D 0; i < numpages; i++) {
> -            memset(area + (hpagesize * i), 0, 1);
> +            /*
> +             * Read & write back the same value, so we don't
> +             * corrupt existinng user/app data that might be

s/existinng/existing/

> +             * stored.
> +             *
> +             * 'volatile' to stop compiler optimizing this away
> +             * to a no-op
> +             *
> +             * TODO: get a better solution from kernel so we
> +             * don't need to write at all so we don't cause
> +             * wear on the storage backing the region...
> +             */
> +            volatile char val =3D *(area + (hpagesize * i));
> +            *(area + (hpagesize * i)) =3D val;
>          }
>      }
> =20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GSbdIGPOm7mibNa2gFjrrRU2jtifkBBQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsIO6AAoJEKeha0olJ0NqK1QH/Rx4IMcHakudOwAUjIoBH01N
b+04dlrzKJkhA8AEnSOkG+EFsDPEbVnMM4f2LfRDiSmpn190DhniySjvogK0czr9
tjgIlPKhA9j1pvBcl0cZRqp77mYxC5BPaQV76XrAfWVXSfAtTrzZ8pjeFIXcb7LD
/O1eQcy++S/cCt0vMtZkEqnrkqgnkztguCPOoDILJ2gxp3TdpunR/6NeklzyAFyr
PNbzmzrFookKbpqESdu2FGjBE3BcdAx6PIIsXLk0Vus8nhc/TsU03fsnb1xXpAq+
GOJoBjSkYOY80bEAEElVJf7aIzgMz4ChS+UTl3ehNCr2EL72CnsX67gWlWxlHxE=
=deS5
-----END PGP SIGNATURE-----

--GSbdIGPOm7mibNa2gFjrrRU2jtifkBBQP--
