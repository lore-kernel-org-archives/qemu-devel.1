Received: from eggs.gnu.org ([2001:4830:134:3::10]:45549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8TlF-0005Zg-Fb
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8TlD-0007Am-Vz
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:42:45 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-18-eblake@redhat.com>
	<ada8b8e3-aa6e-b06a-d2bf-6f7e994f0e7d@redhat.com>
	<1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <67d0c3bf-d6a1-a9bb-8b17-75b1db412e19@redhat.com>
Date: Wed, 10 May 2017 10:42:30 -0500
MIME-Version: 1.0
In-Reply-To: <1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mcQ16mOnjV0tcnVQvopOcFaNlFx6EvFcA"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 17/17] block: Make
 bdrv_is_allocated_above() byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Fam Zheng <famz@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mcQ16mOnjV0tcnVQvopOcFaNlFx6EvFcA
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Changlong Xie <xiecl.fnst@cn.fujitsu.com>,
 Fam Zheng <famz@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <67d0c3bf-d6a1-a9bb-8b17-75b1db412e19@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 17/17] block: Make
 bdrv_is_allocated_above() byte-based
References: <20170411222945.11741-1-eblake@redhat.com>
 <20170411222945.11741-18-eblake@redhat.com>
 <ada8b8e3-aa6e-b06a-d2bf-6f7e994f0e7d@redhat.com>
 <1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
In-Reply-To: <1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2017 08:48 PM, Eric Blake wrote:
> On 04/24/2017 06:06 PM, John Snow wrote:
>>
>>
>> On 04/11/2017 06:29 PM, Eric Blake wrote:
>>> We are gradually moving away from sector-based interfaces, towards
>>> byte-based.  In the common case, allocation is unlikely to ever use
>>> values that are not naturally sector-aligned, but it is possible
>>> that byte-based values will let us be more precise about allocation
>>> at the end of an unaligned file that can do byte-based access.
>>>
>>> Changing the signature of the function to use int64_t *pnum ensures
>>> that the compiler enforces that all callers are updated.  For now,
>>> the io.c layer still assert()s that all callers are sector-aligned,
>>> but that can be relaxed when a later patch implements byte-based
>>> block status.  Therefore, for the most part this patch is just the
>>> addition of scaling at the callers followed by inverse scaling at
>>> bdrv_is_allocated().  But some code, particularly stream_run(),
>>> gets a lot simpler because it no longer has to mess with sectors.
>>>
>=20
>>> +++ b/block/io.c
>>> @@ -1930,52 +1930,46 @@ int coroutine_fn bdrv_is_allocated(BlockDrive=
rState *bs, int64_t offset,
>>>  /*
>>>   * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [T=
OP]
>>>   *
>>> - * Return true if the given sector is allocated in any image between=

>>> + * Return true if the given offset is allocated in any image between=

>>
>> perhaps "range" instead of "offset"?
>>
>>>   * BASE and TOP (inclusive).  BASE can be NULL to check if the given=

>>> - * sector is allocated in any image of the chain.  Return false othe=
rwise,
>>> + * offset is allocated in any image of the chain.  Return false othe=
rwise,
>>>   * or negative errno on failure.
>=20
> Seems reasonable.

Actually, not quite. Suppose we have the following sector allocations:

backing: -- -- XX --
active:  -- -- -- XX

bdrv_is_allocated_above(active, NULL, 0, 2048, &num)

will return 0 with num set to 1024 (offset is not allocated, and the
not-allocated range is at least 1024 bytes).  But calling

bdr_is_allocated_above(backing, NULL, 1024, 1024, &num)

will return 1 with num set to 512 (the entire range is not allocated,
but the 512-byte prefix of the range IS allocated).  Meanwhile, note that=
:

bdrv_is_allocated_above(active, NULL, 1024, 1024, &num)

will ALSO return 1 with num set to 512, even though it would be nicer if
it could return 1024 (from the active layer, all 1024 bytes of the given
range ARE allocated, just not from the same location).  So callers have
to manually coalesce multiple bdrv_is_allocated_above() calls to get a
full picture of what is allocated.

The same is ALSO true if you have a fragmented image.  For example:

$ qemu-img create -f qcow2 -o cluster_size=3D1m file3 10m
$ qemu-io -f qcow2 -c 'w 0 5m' -c 'discard 0 2m' -c 'w 1m 1m' \
  -c 'w 0 1m' -c 'w 8m 2m' file3

The image is now fragmented (the clusters at 0 and 1m swapped mappings):

[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data":
true, "offset": 6291456},
{ "start": 1048576, "length": 1048576, "depth": 0, "zero": false,
"data": true, "offset": 5242880},
{ "start": 2097152, "length": 3145728, "depth": 0, "zero": false,
"data": true, "offset": 7340032},
{ "start": 5242880, "length": 3145728, "depth": 0, "zero": true, "data":
false},
{ "start": 8388608, "length": 2097152, "depth": 0, "zero": false,
"data": true, "offset": 10485760}]


'qemu-io alloc' and 'qemu-io map' are callers which coalesce similar
results:

$ ./qemu-io -f qcow2 file3
qemu-io> alloc 0 10m
7340032/10485760 bytes allocated at offset 0 bytes
qemu-io> map
5 MiB (0x500000) bytes     allocated at offset 0 bytes (0x0)
3 MiB (0x300000) bytes not allocated at offset 5 MiB (0x500000)
2 MiB (0x200000) bytes     allocated at offset 8 MiB (0x800000)

although tracing under gdb showed 5 calls to bdrv_is_allocated() during
'alloc' (at [0, 10m], [1m, 9m], [2m, 8m], [5m, 5m], [8m, 2m]), and 8
calls during 'map' (at [0, 10m], [1m, 9m], [2m, 8m], [5m, 5m], [5m, 5m],
[8m, 2m], [8m, 2m], [10m, 0]).  Part of that is that the qemu-io map
implementation is rather inefficient - it makes a wasted query for 0
bytes, and at every transition between allocated and unallocated it ends
up asking for status on the same offset a second time around, rather
than remembering what it already learned on the previous iteration.

It might be worth followup patches to improve the efficiency of qemu-io
map; but also to change semantics such that bdrv_is_allocated_above()
gives the largest answer possible, rather than making the callers
coalesce identical answers.  Part of that would include teaching
=2Ebdrv_co_get_block_status() new semantics: if file=3D=3DNULL, then don'=
t
return BDRV_BLOCK_OFFSET_VALID, but merely grab as much
BDRV_BLOCK_DATA/BDRV_BLOCK_ZERO information as possible (in spite of
fragmentation) [in the example above, it would mean returning
BDRV_BLOCK_DATA for 5m, rather than three separate returns of 1m/1m/3m];
as well as teaching bdrv_is_allocated_above() to concatenate all answers
along the backing chain until it reaches an actual change in status.
Looks like I've just added more work to my queue.

That said, there still has to be coalescing somewhere.  For example,
qcow2 images can easily return status for any range covered by a single
L2 cluster, but intentionally quits its response at the end of an L2
cluster because the cost of loading up the next cluster (with the
potential of dropping locks and racing with other threads doing writes)
becomes too hard to control within the qcow2 layer, and callers may need
to realize that the larger a request is on an actively-changing image,
the more likely the overall response can be inaccurate by the time
multiple sub-queries have been coalesced.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mcQ16mOnjV0tcnVQvopOcFaNlFx6EvFcA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEzTnAAoJEKeha0olJ0NqC9cH/2n4rNMiHCNbu224Y3JC3EQB
IA0+IDeecGK23hgOQmJuJ0E3TCTfgTy790xX7cEBYkkFr0Z7WfLeDbuGpUbXErlF
ny/voru5tXwX3FxtHYMe67JdFpTvXCFiB4OqSrc3CNKoxDAlcby0WA2vPlxvi/f0
PCZn1N3Ex0ES+TPTU6rmaSTLhqeEyeCgzQLX9iKkfHOtvZSqTxCvGgQkQ2Pt5Vue
DaI2VignNCy2sRXrJsJZURcWR2TW7+xQXhcFC05EXfleMd3juQrJsmt/Ao9ezKrE
p6I02NnTExyEkW19Opdmh1l8AVGklPsxkLHwHqvU24Xt0OVyMCzH8uSN4b8VHlc=
=8S0b
-----END PGP SIGNATURE-----

--mcQ16mOnjV0tcnVQvopOcFaNlFx6EvFcA--
