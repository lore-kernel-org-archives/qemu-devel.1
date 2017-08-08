Received: from eggs.gnu.org ([2001:4830:134:3::10]:44917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5v0-0004CV-ER
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5uz-0005Dp-7R
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:55:38 -0400
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-29-git-send-email-armbru@redhat.com>
	<993e9832-d7f0-9523-9143-5286d3b0ba33@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01127d94-fb77-cf13-3036-216dac25860f@redhat.com>
Date: Tue, 8 Aug 2017 09:55:19 -0500
MIME-Version: 1.0
In-Reply-To: <993e9832-d7f0-9523-9143-5286d3b0ba33@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tke6GkItLjPfHnXMh1hIRNphwlRiWVuhp"
Subject: Re: [Qemu-devel] [RFC PATCH 28/56] block: Widen dirty bitmap
 granularity to uint64_t for safety
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tke6GkItLjPfHnXMh1hIRNphwlRiWVuhp
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com,
 mreitz@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Message-ID: <01127d94-fb77-cf13-3036-216dac25860f@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 28/56] block: Widen dirty bitmap
 granularity to uint64_t for safety
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
 <1502117160-24655-29-git-send-email-armbru@redhat.com>
 <993e9832-d7f0-9523-9143-5286d3b0ba33@redhat.com>
In-Reply-To: <993e9832-d7f0-9523-9143-5286d3b0ba33@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 08:55 PM, John Snow wrote:
>=20
>=20
> On 08/07/2017 10:45 AM, Markus Armbruster wrote:
>> Block dirty bitmaps represent granularity in bytes as uint32_t.  It
>> must be a power of two and a multiple of BDRV_SECTOR_SIZE.
>>
>> The trouble with uint32_t is computations like this one in
>> mirror_do_read():
>>
>>     uint64_t max_bytes;
>>
>>     max_bytes =3D s->granularity * s->max_iov;
>>
>> The operands of * are uint32_t and int, so the product is computed in
>> uint32_t (assuming 32 bit int), then zero-extended to uint64_t.
>>
>> Since granularity is generally combined with 64 bit file offsets, it's=

>> best to make it 64 bits, too.  Less opportunity to screw up.

And definitely conflicts with my work on byte-based block status.


>> =20
>> -uint32_t bdrv_dirty_bitmap_meta_granularity(BdrvDirtyBitmap *bitmap)
>> -{
>> -    return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->meta);
>> -}
>=20
> Why? Unused? Not cool enough to mention?

Already deleted as unused in my byte-based series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tke6GkItLjPfHnXMh1hIRNphwlRiWVuhp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJ0NcACgkQp6FrSiUn
Q2r/QAf/S8wW4yHUZjbQ/QSppD88uI0L17bf9/DoH+K/4CEsrN3p8t0DsT0YH3KF
vB3nWVxdCYZNaGqiP7ed/D2yBHOLQWgKsPeYPdb1S5Ip99NNRxWNQoV0ncB7xXrY
eUC17R5Uga6tziAq6nLjUECmlq52nOp36n6yT7LwzRgCF7SfhkRzroRxS53ucYMz
wqx+BkDomQHZh+x/b64AFjplwu87qsKZ83FpQdPIhcTskPnYqOkSA5fYBDWk9Wzd
+RKT58qdwIfzcqwSrgeICHUM0mzpeeCLNK3U4f4grTrPxjeB7Nk4oirbbiOBIFx9
QPpeHH8io40SAJ05GNufl6+jXtJ5lg==
=QKeh
-----END PGP SIGNATURE-----

--tke6GkItLjPfHnXMh1hIRNphwlRiWVuhp--
