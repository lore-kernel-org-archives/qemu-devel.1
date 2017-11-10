Received: from eggs.gnu.org ([2001:4830:134:3::10]:48557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDB9Z-0001VN-Hf
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDB9Y-0001T2-48
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:23:33 -0500
References: <20171109204315.27072-1-mreitz@redhat.com>
	<20171110024557.GB4849@lemon>
	<20171110131752.GD5466@localhost.localdomain>
	<20171110133207.GA9235@lemon.Home>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
Date: Fri, 10 Nov 2017 16:23:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171110133207.GA9235@lemon.Home>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bMXtmIn20xetU9fow92xwbBDQumEtdeNW"
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
To: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bMXtmIn20xetU9fow92xwbBDQumEtdeNW
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
References: <20171109204315.27072-1-mreitz@redhat.com>
 <20171110024557.GB4849@lemon> <20171110131752.GD5466@localhost.localdomain>
 <20171110133207.GA9235@lemon.Home>
In-Reply-To: <20171110133207.GA9235@lemon.Home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 14:32, Fam Zheng wrote:
> On Fri, 11/10 14:17, Kevin Wolf wrote:
>> Am 10.11.2017 um 03:45 hat Fam Zheng geschrieben:
>>> On Thu, 11/09 21:43, Max Reitz wrote:
>>>> Draining a BDS may lead to graph modifications, which in turn may re=
sult
>>>> in it and other BDS being stripped of their current references.  If
>>>> bdrv_drain_all_begin() and bdrv_drain_all_end() do not keep strong
>>>> references themselves, the BDS they are trying to drain (or undrain)=
 may
>>>> disappear right under their feet -- or, more specifically, under the=

>>>> feet of BDRV_POLL_WHILE() in bdrv_drain_recurse().
>>>>
>>>> This fixes an occasional hang of iotest 194.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  block/io.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 44 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/block/io.c b/block/io.c
>>>> index 3d5ef2cabe..a0a2833e8e 100644
>>>> --- a/block/io.c
>>>> +++ b/block/io.c
>>>> @@ -340,7 +340,10 @@ void bdrv_drain_all_begin(void)
>>>>      bool waited =3D true;
>>>>      BlockDriverState *bs;
>>>>      BdrvNextIterator it;
>>>> -    GSList *aio_ctxs =3D NULL, *ctx;
>>>> +    GSList *aio_ctxs =3D NULL, *ctx, *bs_list =3D NULL, *bs_list_en=
try;
>>>> +
>>>> +    /* Must be called from the main loop */
>>>> +    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_conte=
xt());
>>>> =20
>>>>      block_job_pause_all();
>>>> =20
>>>> @@ -355,6 +358,12 @@ void bdrv_drain_all_begin(void)
>>>>          if (!g_slist_find(aio_ctxs, aio_context)) {
>>>>              aio_ctxs =3D g_slist_prepend(aio_ctxs, aio_context);
>>>>          }
>>>> +
>>>> +        /* Keep a strong reference to all root BDS and copy them in=
to
>>>> +         * an own list because draining them may lead to graph
>>>> +         * modifications. */
>>>> +        bdrv_ref(bs);
>>>> +        bs_list =3D g_slist_prepend(bs_list, bs);
>>>>      }
>>>> =20
>>>>      /* Note that completion of an asynchronous I/O operation can tr=
igger any
>>>> @@ -370,7 +379,11 @@ void bdrv_drain_all_begin(void)
>>>>              AioContext *aio_context =3D ctx->data;
>>>> =20
>>>>              aio_context_acquire(aio_context);
>>>> -            for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it))=
 {
>>>> +            for (bs_list_entry =3D bs_list; bs_list_entry;
>>>> +                 bs_list_entry =3D bs_list_entry->next)
>>>> +            {
>>>> +                bs =3D bs_list_entry->data;
>>>> +
>>>>                  if (aio_context =3D=3D bdrv_get_aio_context(bs)) {
>>>>                      waited |=3D bdrv_drain_recurse(bs, true);
>>>>                  }
>>>> @@ -379,24 +392,52 @@ void bdrv_drain_all_begin(void)
>>>>          }
>>>>      }
>>>> =20
>>>> +    for (bs_list_entry =3D bs_list; bs_list_entry;
>>>> +         bs_list_entry =3D bs_list_entry->next)
>>>> +    {
>>>> +        bdrv_unref(bs_list_entry->data);
>>>> +    }
>>>> +
>>>>      g_slist_free(aio_ctxs);
>>>> +    g_slist_free(bs_list);
>>>>  }
>>>> =20
>>>>  void bdrv_drain_all_end(void)
>>>>  {
>>>>      BlockDriverState *bs;
>>>>      BdrvNextIterator it;
>>>> +    GSList *bs_list =3D NULL, *bs_list_entry;
>>>> +
>>>> +    /* Must be called from the main loop */
>>>> +    assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_conte=
xt());
>>>> =20
>>>> +    /* Keep a strong reference to all root BDS and copy them into a=
n
>>>> +     * own list because draining them may lead to graph modificatio=
ns.
>>>> +     */
>>>>      for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
>>>> -        AioContext *aio_context =3D bdrv_get_aio_context(bs);
>>>> +        bdrv_ref(bs);
>>>> +        bs_list =3D g_slist_prepend(bs_list, bs);
>>>> +    }
>>>> +
>>>> +    for (bs_list_entry =3D bs_list; bs_list_entry;
>>>> +         bs_list_entry =3D bs_list_entry->next)
>>>> +    {
>>>> +        AioContext *aio_context;
>>>> +
>>>> +        bs =3D bs_list_entry->data;
>>>> +        aio_context =3D bdrv_get_aio_context(bs);
>>>> =20
>>>>          aio_context_acquire(aio_context);
>>>>          aio_enable_external(aio_context);
>>>>          bdrv_parent_drained_end(bs);
>>>>          bdrv_drain_recurse(bs, false);
>>>>          aio_context_release(aio_context);
>>>> +
>>>> +        bdrv_unref(bs);
>>>>      }
>>>> =20
>>>> +    g_slist_free(bs_list);
>>>> +
>>>>      block_job_resume_all();
>>>>  }
>>>
>>> It is better to put the references into BdrvNextIterator and introduc=
e
>>> bdrv_next_iterator_destroy() to free them? You'll need to touch all c=
allers
>>> because it is not C++, but it secures all of rest, which seems vulner=
able in the
>>> same pattern, for example the aio_poll() in iothread_stop_all().
>>
>> You could automatically free the references when bdrv_next() returns
>> NULL. Then you need an explicit bdrv_next_iterator_destroy() only for
>> callers that stop iterating halfway through the list.
>> Yes, good idea.

But bdrv_unref() is safe only in the main loop.  Without having checked,
I'm not sure whether all callers of bdrv_next() are running in the main
loop.

I'd rather introduce a bdrv_next_safe() which is used by those callers
which need it.

>> Do you actually need to keep references to all BDSes in the whole list=

>> while using the iterator or would it be enough to just keep a referenc=
e
>> to the current one?
>=20
> To fix the bug we now see I think keeping the current is enough, but I =
think
> implementing just like this patch is also good with some future-proofin=
g: we
> cannot know what will be wedged into the nexted aio_poll()'s over time =
(and yes,
> we should really reduce the number of them.)

I don't really want to think about whether it's safe to only keep a
reference to the current BDS.  I can't imagine any case where destroying
one root BDS leads to destroying another, but I'd rather be safe and not
have to think about it.  (Unless there is an important reason to only
keep a strong reference to the current one.)

Max


--bMXtmIn20xetU9fow92xwbBDQumEtdeNW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloFxGUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYwgH/18pWBIcVZ2cvQaVtq1OVu3X8oLJhA8f
hG5xN1YWdk2kb1UKwbRyEF5Vz1vzsOQgIWzrV53kqCliSjfjKNcLTLMwJgpAqixa
wnk5eV0jJMemcfIDLPEYh2lbj0DsmmX2dbLT4ZbyU277djXmFb4hOd2ZH9ouDGv8
EzUX8CJyPrg/HwVH36p1RI85KimBH/mwHygJtIXM0If8zltGEqPH0zAK9nwAje14
9//K9QnpDp7YgNWZn1GGxtdccRkMwGnWJz9PJ2LxQDGQiJlJdpNMAaeAWznKSo5z
4M0dl4VW7YNPfXgc/kZjzJSoIdexActdYk8VrTee6IhT0AF7guBUT9c=
=67ua
-----END PGP SIGNATURE-----

--bMXtmIn20xetU9fow92xwbBDQumEtdeNW--
