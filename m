Received: from eggs.gnu.org ([2001:4830:134:3::10]:42519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dizSU-00050O-6P
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 04:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dizSP-0006Pk-VL
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 04:50:18 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dizSP-0006Ni-Kn
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 04:50:13 -0400
Received: by mail-pf0-x241.google.com with SMTP id j83so794938pfe.1
	for <qemu-devel@nongnu.org>; Sat, 19 Aug 2017 01:50:11 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20170818133118.8650-1-stefanha@redhat.com>
	<72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
	<37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
	<8cb05e90-d7f0-6448-b6ff-68a75ebb67d0@ozlabs.ru>
Message-ID: <3620ddfa-5e8a-0730-7218-32d351d6e1e5@ozlabs.ru>
Date: Sat, 19 Aug 2017 18:50:03 +1000
MIME-Version: 1.0
In-Reply-To: <8cb05e90-d7f0-6448-b6ff-68a75ebb67d0@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tQEEh8qM8WQQWolT9UNEj1SALS4sShUpk"
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
--tQEEh8qM8WQQWolT9UNEj1SALS4sShUpk
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <3620ddfa-5e8a-0730-7218-32d351d6e1e5@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
References: <20170818133118.8650-1-stefanha@redhat.com>
 <72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
 <37256b65-cd64-e4ca-4655-b6dc8d780335@ozlabs.ru>
 <8cb05e90-d7f0-6448-b6ff-68a75ebb67d0@ozlabs.ru>
In-Reply-To: <8cb05e90-d7f0-6448-b6ff-68a75ebb67d0@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/08/17 12:53, Alexey Kardashevskiy wrote:
> On 19/08/17 12:46, Alexey Kardashevskiy wrote:
>> On 19/08/17 01:18, Eric Blake wrote:
>>> On 08/18/2017 08:31 AM, Stefan Hajnoczi wrote:
>>>> Most qcow2 files are uncompressed so it is wasteful to allocate (32 =
+ 1)
>>>> * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
>>>> s->cluster_data when the first read operation is performance on a
>>>> compressed cluster.
>>>>
>>>> The buffers are freed in .bdrv_close().  .bdrv_open() no longer has =
any
>>>> code paths that can allocate these buffers, so remove the free funct=
ions
>>>> in the error code path.
>>>>
>>>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> ---
>>>> Alexey: Does this improve your memory profiling results?
>>>
>>> Is this a regression from earlier versions?=20
>>
>> Hm, I have not thought about this.
>>
>> So. I did bisect and this started happening from
>> 9a4c0e220d8a4f82b5665d0ee95ef94d8e1509d5
>> "hw/virtio-pci: fix virtio behaviour"
>>
>> Before that, the very same command line would take less than 1GB of
>> resident memory. That thing basically enforces virtio-1.0 for QEMU <=3D=
2.6
>> which means that upstream with "-machine pseries-2.6" works fine (less=
 than
>> 1GB), "-machine pseries-2.7" does not (close to 7GB, sometime even 9GB=
).
>>
>> Then I tried bisecting again, with
>> "scsi=3Doff,disable-modern=3Doff,disable-legacy=3Don" on my 150 virtio=
-block
>> devices, started from
>> e266d421490e0 "virtio-pci: add flags to enable/disable legacy/modern" =
(it
>> added the disable-modern switch) which uses 2GB of memory.
>>
>> I ended up with ada434cd0b44 "virtio-pci: implement cfg capability".
>>
>> Then I removed proxy->modern_as on v2.10.0-rc3 (see below) and got 1.5=
GB of
>> used memory (yay!)
>>
>> I do not really know how to reinterpret all of this, do you?
>>
>>
>> Note: 1GB..9GB numbers from below are the peak values from valgrind's
>=20
> s/from below/from above/ , sorry, bad cut-n-paste :)


Just realized - I should have replied with this to "Memory use with >100
virtio devices" actually, sorry for the confusion.


--=20
Alexey


--tQEEh8qM8WQQWolT9UNEj1SALS4sShUpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZl/u8DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5rlUP/3Qh
jNeoMPJd5UO55DFgmLNial/MKv1AN5tkRlCEKS+7bP4hXRfcr24VYTtK1QlvPNMK
XNIiX3cR03pLfIPX2wvZFTWV9RilZeB4yW8JkylAW1zUIs6SFQoWInoIQr+nxHR6
9OkCh2z6LfxibmhLhCunmayq5JMxN97JyGyawrqtCUfcnxsHw9IJ3STeMU/1G+jM
2EnoDNIZzEWTrSXWlvpWI9r/Xw7y+KhyCNxZbHSd8eJrdX39dYfs0Xmq1Qm7aP1/
rcb2oVrmKPQvd6fpYE3HFjtoHJGygmRYiQ7phkqmjBDHrYDcyzheR0iSbV5ZwoxY
b5XwShzITnY/Bv9QW6zF5WjIiV5kLv2Q/K+T/vsRSvAYKutVXRNhTTKqDmLQ8Ftk
NaQgSJ5B1KTsnelfivYbQl6iITLyJQxXzNZaA13eExA9UZZCc1SCwTUkb+VpR1PT
dwg5Mfxql8INGi9B3NnOy+eQhpSxZrSmY5DWPcoeo8vH2GfhNKnAxl+uX3UNT6cB
e3KORBiBe3/NUF+NHFxNz8cMLs7lbPzzPTQbimMoAgPfgFa1Ot2m1vT0Hc0HFZYV
rC9eOTBA7pmzjJlD8fOrxm9o+MGCqgp1bbkuw7rDbBTJh894rmab8xv6cCuaekci
EhUKbL577oZMvl/GaR7y3XaX/qRJhHIQENaHZKT+
=Nedt
-----END PGP SIGNATURE-----

--tQEEh8qM8WQQWolT9UNEj1SALS4sShUpk--
