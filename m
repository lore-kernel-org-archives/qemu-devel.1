Received: from eggs.gnu.org ([2001:4830:134:3::10]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDBD1-0004e0-0e
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDBCz-00079m-Sy
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:27:07 -0500
References: <20171109204315.27072-1-mreitz@redhat.com>
	<20171110091921.GB31658@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cc646d7c-3b4f-4616-f234-3b4cce2a6479@redhat.com>
Date: Fri, 10 Nov 2017 16:26:49 +0100
MIME-Version: 1.0
In-Reply-To: <20171110091921.GB31658@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CrusimRrlpDIpA6TaD05wBIMjE5jKU18O"
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CrusimRrlpDIpA6TaD05wBIMjE5jKU18O
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng
 <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <cc646d7c-3b4f-4616-f234-3b4cce2a6479@redhat.com>
Subject: Re: [PATCH for-2.11] block: Keep strong reference when draining all
 BDS
References: <20171109204315.27072-1-mreitz@redhat.com>
 <20171110091921.GB31658@stefanha-x1.localdomain>
In-Reply-To: <20171110091921.GB31658@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 10:19, Stefan Hajnoczi wrote:
> On Thu, Nov 09, 2017 at 09:43:15PM +0100, Max Reitz wrote:
>> Draining a BDS may lead to graph modifications, which in turn may resu=
lt
>> in it and other BDS being stripped of their current references.  If
>> bdrv_drain_all_begin() and bdrv_drain_all_end() do not keep strong
>> references themselves, the BDS they are trying to drain (or undrain) m=
ay
>> disappear right under their feet -- or, more specifically, under the
>> feet of BDRV_POLL_WHILE() in bdrv_drain_recurse().
>>
>> This fixes an occasional hang of iotest 194.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/io.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 3d5ef2cabe..a0a2833e8e 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -340,7 +340,10 @@ void bdrv_drain_all_begin(void)
>>      bool waited =3D true;
>>      BlockDriverState *bs;
>>      BdrvNextIterator it;
>> -    GSList *aio_ctxs =3D NULL, *ctx;
>> +    GSList *aio_ctxs =3D NULL, *ctx, *bs_list =3D NULL, *bs_list_entr=
y;
>> +
>> +    /* Must be called from the main loop */
>> +    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context=
());
>> =20
>>      block_job_pause_all();
>> =20
>> @@ -355,6 +358,12 @@ void bdrv_drain_all_begin(void)
>>          if (!g_slist_find(aio_ctxs, aio_context)) {
>>              aio_ctxs =3D g_slist_prepend(aio_ctxs, aio_context);
>>          }
>> +
>> +        /* Keep a strong reference to all root BDS and copy them into=

>> +         * an own list because draining them may lead to graph
>> +         * modifications. */
>> +        bdrv_ref(bs);
>> +        bs_list =3D g_slist_prepend(bs_list, bs);
>>      }
>> =20
>>      /* Note that completion of an asynchronous I/O operation can trig=
ger any
>> @@ -370,7 +379,11 @@ void bdrv_drain_all_begin(void)
>>              AioContext *aio_context =3D ctx->data;
>> =20
>>              aio_context_acquire(aio_context);
>> -            for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {=

>> +            for (bs_list_entry =3D bs_list; bs_list_entry;
>> +                 bs_list_entry =3D bs_list_entry->next)
>> +            {
>> +                bs =3D bs_list_entry->data;
>> +
>>                  if (aio_context =3D=3D bdrv_get_aio_context(bs)) {
>>                      waited |=3D bdrv_drain_recurse(bs, true);
>>                  }
>> @@ -379,24 +392,52 @@ void bdrv_drain_all_begin(void)
>>          }
>>      }
>> =20
>> +    for (bs_list_entry =3D bs_list; bs_list_entry;
>> +         bs_list_entry =3D bs_list_entry->next)
>> +    {
>> +        bdrv_unref(bs_list_entry->data);
>> +    }
>> +
>>      g_slist_free(aio_ctxs);
>> +    g_slist_free(bs_list);
>>  }
>=20
> Which specific parts of this function access bs without a reference?
>=20
> I see bdrv_next() may do QTAILQ_NEXT(bs, monitor_list) after
> bdrv_drain_recurse() has returned.
>=20
> Anything else?
>=20
> If bdrv_next() is the only issue then I agree with Fam that it makes
> sense to build the ref/unref into bdrv_next().

These don't.  It's BDRV_POLL_WHILE() in bdrv_drain_recurse(), as written
in the commit message.

You cannot add a bdrv_ref()/bdrv_unref() pair there because
bdrv_drain_recurse() is called from bdrv_close() with a refcount of 0,
so having a bdrv_unref() there would cause an infinite recursion.

I think it's reasonable to expect callers of any bdrv_* function (except
for bdrv_unref()) to make sure that the BDS isn't deleted over the
course of that function.  Therefore, I think that the actual issue is
here and we need to make sure here that we have a strong reference
before invoking bdrv_drain_recurse().

Max


--CrusimRrlpDIpA6TaD05wBIMjE5jKU18O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloFxTkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABH0IAKqTrnWzDvUqpO0gHolrfNPLwl+cHe+a
gNZNZIekOSd5uINWnJHe9ZgePEg2Ts73IVm2AiWGNhFdt1zVaoiNQ7wytjxsf+OH
cA7nsprhf8I3SZqOraHCHdhOs9KN4jDInZKRqzfS2NUyRYi1GHrV+wu68xEUB3xG
n79YL7205RCv8jtT6OqOFLDF7JixB5v5EE9XQ+P4Zpf7HbrL5D0/VzR9FLdwRtMY
GIXGe49nPxpMvn3mPgSvwgw9+ncZzgIIpa7y8fBnVle+SKluM4KcMlt3pnzl15mP
/0LULAjKUfxkrN28AcjFYAjr1d8kFVCudNb/DjDjzlB+/FqV5sKdbKs=
=AIr+
-----END PGP SIGNATURE-----

--CrusimRrlpDIpA6TaD05wBIMjE5jKU18O--
