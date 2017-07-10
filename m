Received: from eggs.gnu.org ([2001:4830:134:3::10]:46022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUbXF-0006jc-92
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUbXE-0000Bk-Aa
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:27:45 -0400
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-12-pbonzini@redhat.com>
	<20170710162419.GS14195@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5efa0c6-92a1-76f6-c1ba-34b36ef93cbd@redhat.com>
Date: Mon, 10 Jul 2017 18:27:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170710162419.GS14195@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XragdgLR95AjSTVka0DrsnNv5D5QHGcXC"
Subject: Re: [Qemu-devel] [PATCH 11/11] block/snapshot: do not take
 AioContext lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XragdgLR95AjSTVka0DrsnNv5D5QHGcXC
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org
Message-ID: <c5efa0c6-92a1-76f6-c1ba-34b36ef93cbd@redhat.com>
Subject: Re: [PATCH 11/11] block/snapshot: do not take AioContext lock
References: <20170706163828.24082-1-pbonzini@redhat.com>
 <20170706163828.24082-12-pbonzini@redhat.com>
 <20170710162419.GS14195@stefanha-x1.localdomain>
In-Reply-To: <20170710162419.GS14195@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/07/2017 18:24, Stefan Hajnoczi wrote:
> On Thu, Jul 06, 2017 at 06:38:28PM +0200, Paolo Bonzini wrote:
>> Snapshots are only created/destroyed/loaded under the BQL, while no
>> other I/O is happening.  Snapshot information could be accessed while
>> other I/O is happening, but also under the BQL so they cannot be
>> modified concurrently.  The AioContext lock is overkill.  If needed,
>> in the future the BQL could be split to a separate lock covering all
>> snapshot operations, and the create/destroy/goto callbacks changed
>> to run in a coroutine (so the driver can do mutual exclusion as usual)=
=2E
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  block/snapshot.c          | 28 +---------------------------
>>  blockdev.c                | 43 ++++++++++++--------------------------=
-----
>>  hmp.c                     |  7 -------
>>  include/block/block_int.h |  5 +++++
>>  include/block/snapshot.h  |  4 +---
>>  migration/savevm.c        | 22 ----------------------
>>  monitor.c                 | 10 ++--------
>>  7 files changed, 21 insertions(+), 98 deletions(-)
>>
>> diff --git a/block/snapshot.c b/block/snapshot.c
>> index a46564e7b7..08c59d6166 100644
>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>> @@ -384,9 +384,7 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriv=
erState *bs,
>>  }
>> =20
>> =20
>> -/* Group operations. All block drivers are involved.
>> - * These functions will properly handle dataplane (take aio_context_a=
cquire
>> - * when appropriate for appropriate block drivers) */
>> +/* Group operations. All block drivers are involved.  */
>=20
> Perhaps "These functions must be called under the BQL"?
>=20
> My concern with this patch series in general is that it will lead to
> bugs due to inconsistencies and lack of locking documentation:
>=20
> bdrv_all_delete_snapshot() is called by hmp_delvm() outside a
> bdrv_drained_begin() region.  That's okay because internally
> bdrv_snapshot_delete() will call bdrv_drained_begin() for the crucial
> operations that require a quiesced BDS.
>=20
> Compare that with bdrv_all_goto_snapshot(), which is called inside a
> bdrv_drained_begin() region by load_snapshot().  Internally it doesn't
> drain.

I think generally we should move bdrv_drained_begin/end calls _out_ of
block.c and into qmp_*.  If you agree, I can add this before this patch.

> Previously the bdrv_all_*() functions behaved consistently.  We could
> say that they will acquire AioContexts themselves.  Now they behave
> inconsistently and while the code currently happens to work, there is n=
o
> structure that will keep it working as it is modified.
>=20
> I think we're reaching a point where every BlockDriver callback and
> every bdrv_*() function needs the following information:
>=20
> 1. Must be called under BQL?
> 2. Can I/O requests be in flight?
> 3. Is it thread-safe?
>=20
> Otherwise it will be a nightmare to modify the code since these
> constraints are not enforced by the compiler and undocumented.

Good point.  Are (1) and (3) different ways to say the same thing or do
you have other differences in mind?

More long term, I think snapshot functions should be changed to run in
coroutines.  This way they can just take the driver CoMutex.

Paolo


--XragdgLR95AjSTVka0DrsnNv5D5QHGcXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlljqu8ACgkQv/vSX3jH
roNlIQgAklUhdhwlXY0okxqLKRAR5FKw3HzZqpYl29U0eyW0YNB8Dy7idWAc8rAD
SsXqRF0alKiQWDKjpj9UqSGxQ42vhvEjc8BoufeVo5Z/2oI2RTRjMXXMz+SnMeYa
cd9KdSxFrAIPGA+k0yS/hdA+Ep6gGDasvonYT9WD70sBpYi+BcgmxqbMatT6TqS2
4NFcbQ9ULl+eo5X7H0VPapxOQlSa1mRDthZDOT/90hfQr0dulv0JEoP8FDpDRuJk
VyWlJSIZVPRyNQfC+3682zX0aMIUXcKVrocy6YSVaqAalN4B7oozFRo9W9qOo00F
r1ivQKIG+G0bzqBPc0Dzi4DSJuCxHw==
=/Sij
-----END PGP SIGNATURE-----

--XragdgLR95AjSTVka0DrsnNv5D5QHGcXC--
