Received: from eggs.gnu.org ([2001:4830:134:3::10]:51534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dittd-0007dw-6f
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 22:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ditta-0007ED-3J
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 22:53:57 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dittZ-0007Dx-MW
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 22:53:53 -0400
Received: by mail-pg0-x244.google.com with SMTP id i12so2122884pgr.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 19:53:53 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20170818133118.8650-1-stefanha@redhat.com>
	<72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
	<37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
Message-ID: <8cb05e90-d7f0-6448-b6ff-68a75ebb67d0@ozlabs.ru>
Date: Sat, 19 Aug 2017 12:53:46 +1000
MIME-Version: 1.0
In-Reply-To: <37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OjEQpdWbwXnPBHFMkgW4sU05a8ipwg26H"
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OjEQpdWbwXnPBHFMkgW4sU05a8ipwg26H
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <8cb05e90-d7f0-6448-b6ff-68a75ebb67d0@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
References: <20170818133118.8650-1-stefanha@redhat.com>
 <72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
 <37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
In-Reply-To: <37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/08/17 12:46, Alexey Kardashevskiy wrote:
> On 19/08/17 01:18, Eric Blake wrote:
>> On 08/18/2017 08:31 AM, Stefan Hajnoczi wrote:
>>> Most qcow2 files are uncompressed so it is wasteful to allocate (32 +=
 1)
>>> * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
>>> s->cluster_data when the first read operation is performance on a
>>> compressed cluster.
>>>
>>> The buffers are freed in .bdrv_close().  .bdrv_open() no longer has a=
ny
>>> code paths that can allocate these buffers, so remove the free functi=
ons
>>> in the error code path.
>>>
>>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>> Alexey: Does this improve your memory profiling results?
>>
>> Is this a regression from earlier versions?=20
>=20
> Hm, I have not thought about this.
>=20
> So. I did bisect and this started happening from
> 9a4c0e220d8a4f82b5665d0ee95ef94d8e1509d5
> "hw/virtio-pci: fix virtio behaviour"
>=20
> Before that, the very same command line would take less than 1GB of
> resident memory. That thing basically enforces virtio-1.0 for QEMU <=3D=
2.6
> which means that upstream with "-machine pseries-2.6" works fine (less =
than
> 1GB), "-machine pseries-2.7" does not (close to 7GB, sometime even 9GB)=
=2E
>=20
> Then I tried bisecting again, with
> "scsi=3Doff,disable-modern=3Doff,disable-legacy=3Don" on my 150 virtio-=
block
> devices, started from
> e266d421490e0 "virtio-pci: add flags to enable/disable legacy/modern" (=
it
> added the disable-modern switch) which uses 2GB of memory.
>=20
> I ended up with ada434cd0b44 "virtio-pci: implement cfg capability".
>=20
> Then I removed proxy->modern_as on v2.10.0-rc3 (see below) and got 1.5G=
B of
> used memory (yay!)
>=20
> I do not really know how to reinterpret all of this, do you?
>=20
>=20
> Note: 1GB..9GB numbers from below are the peak values from valgrind's

s/from below/from above/ , sorry, bad cut-n-paste :)


--=20
Alexey


--OjEQpdWbwXnPBHFMkgW4sU05a8ipwg26H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZl6g6DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC57JYQAIr+
nRG4DTlo6B5GWyYcOPfo1sIl4nV/QgSM/ae6o9R1Sqfox+nHS4PKrJis+6GX9pcn
pckefpVmp9fiyfEofp2TXIfpnZYu538CCJxJ7pLvj1V6P+LqTQrUY00q3m+mEiGz
XKI3RX5PgUYzG5ctF9rWAN93bXtQDQlk4YpFHOZheDu4dyq85hoCzwtQ6CmE5fJJ
s8+VEp8Vh9TAm1pVBbYm9V239FhfqoSepENPteE/jWmuiQd/WBi3DZmuGkt/E/mK
byq0BI+LFlVpgBmLSuIbNYASnOd+QrWRChyByZT2svOvRlbA2SLEZkC4WNJF7ZD0
roVJHCWo0qqkAM5peVrxpwzaD/uGv9I/fQywWReQHAcRwBWDktfy7tZkc5EqkiHH
ZEGjEHzqj9IX1476HLSbd6Jhz5VXrjEveMC2R2YBShsTcg35ERlxivBkUtngIkZ+
+A3EG2skW+g3BhfFoFe2Y11p8NZ/n3hZfWcioIW7l3vk2XHIbNuaMTzLBeF6Aucu
83rCTfduEIbsrxgJHA3W4vz4MkuSmhP4UBXOfEfHdAUHdDUd2CP/QZjIpscple3g
N88hK3GG6tPoMUMvP22+a/y3rtjRDSIQTZhxWtDwLvvy9HKdX/aq2GKWOQuZqCLx
eILNZHLdUHD1PdExpzAVO1tKahB60x83Y0pGG3WL
=45Zm
-----END PGP SIGNATURE-----

--OjEQpdWbwXnPBHFMkgW4sU05a8ipwg26H--
