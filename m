Received: from eggs.gnu.org ([2001:4830:134:3::10]:43002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dv3Zt-0001Xv-SA
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dv3Zs-00009w-Ho
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:39:49 -0400
Date: Thu, 21 Sep 2017 18:39:35 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170921153935.ffyvqej37qhfkrm5@postretch>
References: <20170921131707.17364-1-el13635@mail.ntua.gr>
	<20170921131707.17364-2-el13635@mail.ntua.gr>
	<20170921132943.GE13703@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4375hxdetoo2llw"
Content-Disposition: inline
In-Reply-To: <20170921132943.GE13703@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: add bdrv_co_drain_end
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--t4375hxdetoo2llw
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 09:29:43PM +0800, Fam Zheng wrote:
>On Thu, 09/21 16:17, Manos Pitsidianakis wrote:
>> BlockDriverState has a bdrv_do_drain() callback but no equivalent for th=
e end
>
>s/bdrv_do_drain/bdrv_co_drain/
>
>> of the drain. The throttle driver (block/throttle.c) needs a way to mark=
 the
>> end of the drain in order to toggle io_limits_disabled correctly, thus
>> bdrv_co_drain_end is needed.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  include/block/block_int.h |  6 ++++++
>>  block/io.c                | 48 +++++++++++++++++++++++++++++++++-------=
-------
>>  2 files changed, 40 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index ba4c383393..21950cfda3 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -356,8 +356,14 @@ struct BlockDriver {
>>      /**
>>       * Drain and stop any internal sources of requests in the driver, a=
nd
>>       * remain so until next I/O callback (e.g. bdrv_co_writev) is calle=
d.
>
>This line needs update too, maybe:
>
>       /**
>        * bdrv_co_drain drains and stops any ... and remain so until
>        * bdrv_co_drain_end is called.
>
>> +     *
>> +     * The callbacks are called at the beginning and ending of the drain
>> +     * respectively. They should be implemented if the driver needs to =
e.g.
>
>As implied by above change, should we explicitly require "should both be
>implemented"? It may not be technically required, but I think is cleaner a=
nd
>easier to reason about.
>

It might imply to someone that there's an=20
assert(drv->bdrv_co_drain_begin && drv->bdrv_co_drain_end) somewhere=20
unless you state they don't have to be implemented at the same time. How=20
about we be completely explicit:

  bdrv_co_drain_begin is called if implemented in the beggining of a
  drain operation to drain and stop any internal sources of requests in
  the driver.
  bdrv_co_drain_end is called if implemented at the end of the drain.

  They should be used by the driver to e.g. manage scheduled I/O
  requests, or toggle an internal state. After the end of the drain new
  requests will continue normally.

I hope this is easier for a reader to understand!

>> +     * manage scheduled I/O requests, or toggle an internal state.=20
>> After an
>
>s/After an/After a/
>
>> +     * bdrv_co_drain_end() invocation new requests will continue normal=
ly.
>>       */
>>      void coroutine_fn (*bdrv_co_drain)(BlockDriverState *bs);
>> +    void coroutine_fn (*bdrv_co_drain_end)(BlockDriverState *bs);
>>
>>      void (*bdrv_add_child)(BlockDriverState *parent, BlockDriverState *=
child,
>>                             Error **errp);
>> diff --git a/block/io.c b/block/io.c
>> index 4378ae4c7d..b0a10ad3ef 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -153,6 +153,7 @@ typedef struct {
>>      Coroutine *co;
>>      BlockDriverState *bs;
>>      bool done;
>> +    bool begin;
>>  } BdrvCoDrainData;
>>
>>  static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
>> @@ -160,18 +161,23 @@ static void coroutine_fn bdrv_drain_invoke_entry(v=
oid *opaque)
>>      BdrvCoDrainData *data =3D opaque;
>>      BlockDriverState *bs =3D data->bs;
>>
>> -    bs->drv->bdrv_co_drain(bs);
>> +    if (data->begin) {
>> +        bs->drv->bdrv_co_drain(bs);
>> +    } else {
>> +        bs->drv->bdrv_co_drain_end(bs);
>> +    }
>>
>>      /* Set data->done before reading bs->wakeup.  */
>>      atomic_mb_set(&data->done, true);
>>      bdrv_wakeup(bs);
>>  }
>>
>> -static void bdrv_drain_invoke(BlockDriverState *bs)
>> +static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
>>  {
>> -    BdrvCoDrainData data =3D { .bs =3D bs, .done =3D false };
>> +    BdrvCoDrainData data =3D { .bs =3D bs, .done =3D false, .begin =3D =
begin};
>>
>> -    if (!bs->drv || !bs->drv->bdrv_co_drain) {
>> +    if (!bs->drv || (begin && !bs->drv->bdrv_co_drain) ||
>> +            (!begin && !bs->drv->bdrv_co_drain_end)) {
>>          return;
>>      }
>>
>> @@ -180,15 +186,16 @@ static void bdrv_drain_invoke(BlockDriverState *bs)
>>      BDRV_POLL_WHILE(bs, !data.done);
>>  }
>>
>> -static bool bdrv_drain_recurse(BlockDriverState *bs)
>> +static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
>>  {
>>      BdrvChild *child, *tmp;
>>      bool waited;
>>
>> -    waited =3D BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
>> -
>>      /* Ensure any pending metadata writes are submitted to bs->file.  */
>> -    bdrv_drain_invoke(bs);
>> +    bdrv_drain_invoke(bs, begin);
>> +
>> +    /* Wait for drained requests to finish */
>> +    waited =3D BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
>>
>>      QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
>>          BlockDriverState *bs =3D child->bs;
>> @@ -205,7 +212,7 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
>>               */
>>              bdrv_ref(bs);
>>          }
>> -        waited |=3D bdrv_drain_recurse(bs);
>> +        waited |=3D bdrv_drain_recurse(bs, begin);
>>          if (in_main_loop) {
>>              bdrv_unref(bs);
>>          }
>> @@ -221,12 +228,18 @@ static void bdrv_co_drain_bh_cb(void *opaque)
>>      BlockDriverState *bs =3D data->bs;
>>
>>      bdrv_dec_in_flight(bs);
>> -    bdrv_drained_begin(bs);
>> +    if (data->begin) {
>> +        bdrv_drained_begin(bs);
>> +    } else {
>> +        bdrv_drained_end(bs);
>> +    }
>> +
>>      data->done =3D true;
>>      aio_co_wake(co);
>>  }
>>
>> -static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs)
>> +static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
>> +                                                bool begin)
>>  {
>>      BdrvCoDrainData data;
>>
>> @@ -239,6 +252,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(Bloc=
kDriverState *bs)
>>          .co =3D qemu_coroutine_self(),
>>          .bs =3D bs,
>>          .done =3D false,
>> +        .begin =3D begin,
>>      };
>>      bdrv_inc_in_flight(bs);
>>      aio_bh_schedule_oneshot(bdrv_get_aio_context(bs),
>> @@ -253,7 +267,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(Bloc=
kDriverState *bs)
>>  void bdrv_drained_begin(BlockDriverState *bs)
>>  {
>>      if (qemu_in_coroutine()) {
>> -        bdrv_co_yield_to_drain(bs);
>> +        bdrv_co_yield_to_drain(bs, true);
>>          return;
>>      }
>>
>> @@ -262,17 +276,22 @@ void bdrv_drained_begin(BlockDriverState *bs)
>>          bdrv_parent_drained_begin(bs);
>>      }
>>
>> -    bdrv_drain_recurse(bs);
>> +    bdrv_drain_recurse(bs, true);
>>  }
>>
>>  void bdrv_drained_end(BlockDriverState *bs)
>>  {
>> +    if (qemu_in_coroutine()) {
>> +        bdrv_co_yield_to_drain(bs, false);
>> +        return;
>> +    }
>>      assert(bs->quiesce_counter > 0);
>>      if (atomic_fetch_dec(&bs->quiesce_counter) > 1) {
>>          return;
>>      }
>>
>>      bdrv_parent_drained_end(bs);
>> +    bdrv_drain_recurse(bs, false);
>>      aio_enable_external(bdrv_get_aio_context(bs));
>>  }
>>
>> @@ -350,7 +369,7 @@ void bdrv_drain_all_begin(void)
>>              aio_context_acquire(aio_context);
>>              for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
>>                  if (aio_context =3D=3D bdrv_get_aio_context(bs)) {
>> -                    waited |=3D bdrv_drain_recurse(bs);
>> +                    waited |=3D bdrv_drain_recurse(bs, true);
>>                  }
>>              }
>>              aio_context_release(aio_context);
>> @@ -371,6 +390,7 @@ void bdrv_drain_all_end(void)
>>          aio_context_acquire(aio_context);
>>          aio_enable_external(aio_context);
>>          bdrv_parent_drained_end(bs);
>> +        bdrv_drain_recurse(bs, false);
>>          aio_context_release(aio_context);
>>      }
>>
>> --
>> 2.11.0
>>
>

--t4375hxdetoo2llw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnD3TcACgkQc2J8L2kN
9xAESRAAoxQnmD14OkfEJ2dln1cMOnFRS4iNC4NgBtP69j5hnTVEbxUKsQzDdwXA
1PgxPWmtxGDNFUXEc2OjPi+UiVx5rTtJafaS0FXxib2zp3v0/Q1IDG/anUvRVZOh
WE+djonl2McGv9qN0SE0tJ2ouey+9r1GjRa0evw95cfm075OUe4+fz9jJurTMTcR
rq1dCdgWfPFKSQ7WwL36vYgpM/9wnAaotWmmoDd38xcQI56nE9th1LBMDr/xcA7J
HcwFlUg/gWLPFSuSXtgfPbhzKk1tmlzrTKy0vk9ORryl5loW+ROMbteA8P7PHfsb
2Cd1pJB+aF/QSVkcjxhAh+C3spksQJ8sVItM74OUbnPMP7N88xmJx3sNd+tpESPr
2SlvWAPIQeHXp/8pF859FoaDkNjNCZMrFgqamySGTtLBxukwFgRzeSPn9TKMc7PC
tqyH6KXK35JltcAsmEpUR+XEWQcwSy0733ebTQFhGKgwtLaxXoPb8bS8biAG4lH6
5yy+UnzOj6Co+HOkZa7aKUfaQCP2kTuILRX2Sr6OjYboIJM+9l4e5IvA9lhzb9YI
m8FW5TeiAvHGwtphpdi/xTer+HHsms6Jwbp5K8X9qGuqXx1ufqMPxHYkG6yl8ozp
AQRxxTDEhyV5Q5NWrmS4hUNeWdMz1SmsIqjQiU+wbzkHzlUZz8I=
=OAL9
-----END PGP SIGNATURE-----

--t4375hxdetoo2llw--
