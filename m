Received: from eggs.gnu.org ([2001:4830:134:3::10]:34512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g70SY-0003rz-OW
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g70SX-00034t-54
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:50:10 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-5-vsementsov@virtuozzo.com>
	<08a610aa-9c78-1c83-5e48-b93080aac87b@redhat.com>
	<cc4cd44f-5628-9a02-0b97-2bf46fa72d58@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a2dc0710-093e-f6ee-8525-c015262eb692@redhat.com>
Date: Mon, 1 Oct 2018 17:49:59 +0200
MIME-Version: 1.0
In-Reply-To: <cc4cd44f-5628-9a02-0b97-2bf46fa72d58@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QWHKiXj93YcF9U3zOUOZvzllpMIZH8h2X"
Subject: Re: [Qemu-devel] [PATCH 4/7] qcow2: async scheme for qcow2_co_preadv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QWHKiXj93YcF9U3zOUOZvzllpMIZH8h2X
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <a2dc0710-093e-f6ee-8525-c015262eb692@redhat.com>
Subject: Re: [PATCH 4/7] qcow2: async scheme for qcow2_co_preadv
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
 <20180807174311.32454-5-vsementsov@virtuozzo.com>
 <08a610aa-9c78-1c83-5e48-b93080aac87b@redhat.com>
 <cc4cd44f-5628-9a02-0b97-2bf46fa72d58@virtuozzo.com>
In-Reply-To: <cc4cd44f-5628-9a02-0b97-2bf46fa72d58@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.18 17:33, Vladimir Sementsov-Ogievskiy wrote:
> 27.09.2018 21:35, Max Reitz wrote:
>> On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
>>> Start several async requests instead of read chunk by chunk.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 block/qcow2.c | 208
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>> =C2=A0 1 file changed, 204 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 5e7f2ee318..a0df8d4e50 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -1869,6 +1869,197 @@ out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> =C2=A0 +typedef struct Qcow2WorkerTask {
>>> +=C2=A0=C2=A0=C2=A0 uint64_t file_cluster_offset;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t offset;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t bytes;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t bytes_done;
>>> +} Qcow2WorkerTask;
>> Why don't you make this a union of request-specific structs?
>=20
> ok, will try
>=20
>>
>>> +
>>> +typedef int (*Qcow2DoWorkFunc)(BlockDriverState *bs, QEMUIOVector
>>> *qiov,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2WorkerTask *task);
>>> +
>>> +typedef struct Qcow2RWState {
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> +=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t bytes;
>> Maybe make it total_bytes so it doesn't conflict with the value in
>> Qcow2WorkerTask?
>=20
> ok
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 bool waiting_one;
>>> +=C2=A0=C2=A0=C2=A0 bool waiting_all;
>>> +=C2=A0=C2=A0=C2=A0 bool finalize;
>>> +=C2=A0=C2=A0=C2=A0 Coroutine *co;
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_HEAD(, Qcow2Worker) free_workers;
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_HEAD(, Qcow2Worker) busy_workers;
>>> +=C2=A0=C2=A0=C2=A0 int online_workers;
>>> +=C2=A0=C2=A0=C2=A0 Qcow2DoWorkFunc do_work_func;
>>> +} Qcow2RWState;
>>> +
>>> +typedef struct Qcow2Worker {
>>> +=C2=A0=C2=A0=C2=A0 Qcow2RWState *rws;
>>> +=C2=A0=C2=A0=C2=A0 Coroutine *co;
>>> +=C2=A0=C2=A0=C2=A0 Qcow2WorkerTask task;
>>> +=C2=A0=C2=A0=C2=A0 bool busy;
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_ENTRY(Qcow2Worker) entry;
>>> +} Qcow2Worker;
>>> +#define QCOW2_MAX_WORKERS 64
>> That's really a bit hidden here.=C2=A0 I think it should go into the h=
eader.
>>
>> Also I'm not quite sure about the number.=C2=A0 In other places we've =
always
>> used 16.
>>
>> (With the encryption code always allocating a new bounce buffer, this
>> can mean quite a bit of memory usage.)
>=20
> No doubts.
>=20
>>
>>> +
>>> +static coroutine_fn void qcow2_rw_worker(void *opaque);
>>> +static Qcow2Worker *qcow2_new_worker(Qcow2RWState *rws)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 Qcow2Worker *w =3D g_new0(Qcow2Worker, 1);
>>> +=C2=A0=C2=A0=C2=A0 w->rws =3D rws;
>>> +=C2=A0=C2=A0=C2=A0 w->co =3D qemu_coroutine_create(qcow2_rw_worker, =
w);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return w;
>>> +}
>>> +
>>> +static void qcow2_free_worker(Qcow2Worker *w)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 g_free(w);
>>> +}
>>> +
>>> +static coroutine_fn void qcow2_rw_worker(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 Qcow2Worker *w =3D opaque;
>>> +=C2=A0=C2=A0=C2=A0 Qcow2RWState *rws =3D w->rws;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 rws->online_workers++;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 while (!rws->finalize) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D rws->do_work_=
func(rws->bs, rws->qiov, &w->task);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0 && rws->ret =3D=
=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
ws->ret =3D ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rws->waiting_all || r=
ws->ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w->busy =3D false;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE(&rws->bus=
y_workers, w, Qcow2Worker, entry);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_INSERT_TAIL(&rws=
->free_workers, w, entry);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rws->waiting_one) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
ws->waiting_one =3D false;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* we must unset it here, to prevent queuing rws->co in
>>> several
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * workers (it may happen if other worker already waits
>>> us on mutex,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * so it will be entered after our yield and before
>>> rws->co enter)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * TODO: rethink this comment, as here (and in other
>>> places in the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * file) we moved from qemu_coroutine_add_next to
>>> aio_co_wake.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
io_co_wake(rws->co);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_coroutine_yield();
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (w->busy) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w->busy =3D false;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE(&rws->bus=
y_workers, w, Qcow2Worker, entry);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 qcow2_free_worker(w);
>>> +=C2=A0=C2=A0=C2=A0 rws->online_workers--;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (rws->waiting_all && rws->online_workers =3D=3D=
 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_co_wake(rws->co);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static coroutine_fn void qcow2_rws_add_task(Qcow2RWState *rws,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t
>>> file_cluster_offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t bytes_done)
>> I'd propose just taking a const Qcow2WorkerTask * here.=C2=A0 (Makes e=
ven
>> more sense if you make it a union.)
>=20
> ok, I'll try this way
>=20
>>
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 Qcow2Worker *w;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 assert(rws->co =3D=3D qemu_coroutine_self());
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (bytes_done =3D=3D 0 && bytes =3D=3D rws->byte=
s) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2WorkerTask task =3D =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
file_cluster_offset =3D file_cluster_offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
offset =3D offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
bytes =3D bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
bytes_done =3D bytes_done
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rws->ret =3D rws->do_work=
_func(rws->bs, rws->qiov, &task);
>> (If so, you'd just pass the pointer along here)
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>> I like this fast path, but I think it deserves a small comment.=C2=A0 =
(That
>> is a fast path and bypasses the whole worker infrastructure.)
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!QSIMPLEQ_EMPTY(&rws->free_workers)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w =3D QSIMPLEQ_FIRST(&rws=
->free_workers);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE_HEAD(&rws=
->free_workers, entry);
>>> +=C2=A0=C2=A0=C2=A0 } else if (rws->online_workers < QCOW2_MAX_WORKER=
S) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w =3D qcow2_new_worker(rw=
s);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rws->waiting_one =3D true=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_coroutine_yield();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(!rws->waiting_one)=
; /* already unset by worker */
>> Sometimes I hate coroutines.=C2=A0 OK.=C2=A0 So, how does the yield en=
sure that
>> any worker is scheduled?=C2=A0 Doesn't yield just give control to the =
parent?
>=20
> hm. I don't follow. All workers are busy - we sure, because there no
> free workers,
> and we can't create one more, second condition isn't satisfied too.
> So, we give control to the parent. And only worker can wake us up.

Ah, I see.  And then something at the bottom just continues to ppoll()
or whatever.

>> Right now I think it would be clearer to me if you'd just wake all bus=
y
>> coroutines (looping over them) until one has settled.
>=20
> but all workers are busy, we should not touch them (they may be yielded=

> in io operation)..

I would have assumed that if they are yielded in an I/O operation, they
could handle spurious wakeups.  But I'm very likely wrong.

>> This would also save you the aio_co_wake() in the worker itself, as
>> they'd just have to yield in all cases.
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w =3D QSIMPLEQ_FIRST(&rws=
->free_workers);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE_HEAD(&rws=
->free_workers, entry);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 w->busy =3D true;
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_INSERT_TAIL(&rws->busy_workers, w, entry=
);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 w->task.file_cluster_offset =3D file_cluster_offs=
et;
>>> +=C2=A0=C2=A0=C2=A0 w->task.offset =3D offset;
>>> +=C2=A0=C2=A0=C2=A0 w->task.bytes =3D bytes;
>>> +=C2=A0=C2=A0=C2=A0 w->task.bytes_done =3D bytes_done;
>> (And you'd copy it with w->task =3D *task here)
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_coroutine_enter(w->co);
>>> +}
>>> +
>>> +static void qcow2_init_rws(Qcow2RWState *rws, BlockDriverState *bs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 QEMUIOVector *qiov, uint64_t bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Qcow2DoWorkFunc do_work_func)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 memset(rws, 0, sizeof(*rws));
>>> +=C2=A0=C2=A0=C2=A0 rws->bs =3D bs;
>>> +=C2=A0=C2=A0=C2=A0 rws->qiov =3D qiov;
>>> +=C2=A0=C2=A0=C2=A0 rws->bytes =3D bytes;
>>> +=C2=A0=C2=A0=C2=A0 rws->co =3D qemu_coroutine_self();
>>> +=C2=A0=C2=A0=C2=A0 rws->do_work_func =3D do_work_func;
>> Maybe you'd like to use
>>
>> *rws =3D (Qcow2RWState) {
>> =C2=A0=C2=A0=C2=A0=C2=A0 .bs =3D bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>> };
>>
>> Then you could save yourself the memset().
>=20
> ok
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_INIT(&rws->free_workers);
>>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_INIT(&rws->busy_workers);
>>> +}
>>> +
>>> +static void qcow2_finalize_rws(Qcow2RWState *rws)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 assert(rws->co =3D=3D qemu_coroutine_self());
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* kill waiting workers */
>>> +=C2=A0=C2=A0=C2=A0 rws->finalize =3D true;
>>> +=C2=A0=C2=A0=C2=A0 while (!QSIMPLEQ_EMPTY(&rws->free_workers)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2Worker *w =3D QSIMPL=
EQ_FIRST(&rws->free_workers);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE_HEAD(&rws=
->free_workers, entry);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_coroutine_enter(w->c=
o);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* wait others */
>>> +=C2=A0=C2=A0=C2=A0 if (rws->online_workers > 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rws->waiting_all =3D true=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_coroutine_yield();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rws->waiting_all =3D fals=
e;
>> Why don't you enter the busy workers here?=C2=A0 (And keep doing so un=
til
>> online_workers is 0.)=C2=A0 That way, you could save yourself the othe=
r
>> aio_co_wake() in qcow2_rw_worker().
>=20
> We shouldn't enter busy workers, as they may yielded on io operation.
> The operation should complete.

Yes.

I think my misunderstanding was that I like to assume that everything
that yields checks whether I/O is done by itself, whereas in reality
that's probably usually done with some central polling and those
yielding coroutines assume they only wake up when that polling assures
them the I/O is done.

So I have no objections to the control flow now.

Max


--QWHKiXj93YcF9U3zOUOZvzllpMIZH8h2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluyQicACgkQ9AfbAGHV
z0BpMQf/Vr2F6mSm5s6LJ9ZyIJs2KTrOcdfCOMynDGK8j4sfnxx550+owkjo9HrF
c0KAXIzWJlJxzqGMSUmzHFuh8LGToh46kLrZHHfTSJN0gsca6BV5SugaWrKZ3BBB
pBRYIffgcm1SBfCCsUP97KIIHxz+xWPuXhipEXdzTLZNaAfIvFG2m60m/eQB70Df
NMv1RVcnpGRAv1tenNW9b545ae3oS/JTVQ+Jwq7MB+J5QPYmXmnnSSYXe/IWq0mZ
irjal+EmIbhzwDsyJSxGPdkWypmVTuhmPWDOIDNkbkcwkBHJ0XmEX5vds6TsMYDi
6lLjQftV8xmTuip1+yS9y6BhrevBWw==
=MxDV
-----END PGP SIGNATURE-----

--QWHKiXj93YcF9U3zOUOZvzllpMIZH8h2X--
