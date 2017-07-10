Received: from eggs.gnu.org ([2001:4830:134:3::10]:48403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUaJm-0003VU-Rg
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUaJm-0002Mu-10
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:09:46 -0400
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-5-famz@redhat.com>
	<20170710145943.GI14195@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6ce3371-7d15-91fe-4232-bf8170c77c9d@redhat.com>
Date: Mon, 10 Jul 2017 17:09:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170710145943.GI14195@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Tw7xSeiVsq2XVq6tLMxa6VXtm0fCGSJn"
Subject: Re: [Qemu-devel] [PATCH v3 4/6] block/nvme: Implement .bdrv_dma_map
 and .bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Tw7xSeiVsq2XVq6tLMxa6VXtm0fCGSJn
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>
Message-ID: <a6ce3371-7d15-91fe-4232-bf8170c77c9d@redhat.com>
Subject: Re: [PATCH v3 4/6] block/nvme: Implement .bdrv_dma_map and
 .bdrv_dma_unmap
References: <20170705133635.11850-1-famz@redhat.com>
 <20170705133635.11850-5-famz@redhat.com>
 <20170710145943.GI14195@stefanha-x1.localdomain>
In-Reply-To: <20170710145943.GI14195@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/07/2017 16:59, Stefan Hajnoczi wrote:
>> +static void nvme_dma_map(BlockDriverState *bs, void *host, size_t siz=
e)
>> +{
>> +    BDRVNVMeState *s =3D bs->opaque;
>> +
>> +    nvme_vfio_dma_map(s->vfio, host, size, false, NULL);
> Since temporary=3Dfalse repeated calls to map/unmap will run out of spa=
ce
> and stop working after some time?

Yes, the point of bdrv_dma_map/unmap is to add a permanent mapping.
Temporary mappings are only valid inside nvme.c, because the
corresponding iova is not recorded anywhere.  Instead,
bdrv_dma_map/unmap cache the iova just like we do for RAMBlock areas
during system emulation.

The solution is simply not to do that, just like img_bench only calls
map/unmap once.  If it happens, things just become slower as the driver
falls back to temporary mappings.

Paolo


--5Tw7xSeiVsq2XVq6tLMxa6VXtm0fCGSJn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlljmKUACgkQv/vSX3jH
roO6Bwf/R7kyraxCl9rzzwGOL+mTce7U1Jx/6pEKUlkBKsS1QzVUMsI0z9PPMBYZ
56rUyy2MZU+Lc3dGreZ/MRI4mMT80osXOWgMsAUzEg38+KRXJPy/PKv8JpULV5EM
J8bqMMMESJ4AH5DYlQoWwgtAOR/b5whhT3hTW387tfnTY96942L5gCAEoMc2BVIW
MFZ0KILTgI+K4Yxk2QL3XZtBqc40YK/j3k+ijW8imeKpi91cAZlTM1xd2zMRnOyw
oWKQRYwSCtrSjGrmb/DM2gBnZHSvOXTC5Dr1VguvJFp1eXnpU8c9yiG1ymVz0PjC
WEzK7pJAyOahB20Oq+FlYlhFjXV05g==
=v2ht
-----END PGP SIGNATURE-----

--5Tw7xSeiVsq2XVq6tLMxa6VXtm0fCGSJn--
