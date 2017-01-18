Received: from eggs.gnu.org ([2001:4830:134:3::10]:59340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTsLk-0006HQ-LZ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTsLh-0004Nu-EN
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:40:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTsLh-0004Nm-5Y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:40:33 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3067F7FB9C
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:40:33 +0000 (UTC)
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-2-pbonzini@redhat.com>
	<20170118143346.GA30347@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b665a226-cd82-9cf2-858b-39eb8a98ae34@redhat.com>
Date: Wed, 18 Jan 2017 16:40:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170118143346.GA30347@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/16] aio: introduce aio_co_schedule and
 aio_co_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com



On 18/01/2017 15:33, Stefan Hajnoczi wrote:
> On Fri, Jan 13, 2017 at 02:17:16PM +0100, Paolo Bonzini wrote:
>> +static void co_schedule_bh_cb(void *opaque)
>> +{
>> +    AioContext *ctx =3D opaque;
>> +    QSLIST_HEAD(, Coroutine) straight, reversed;
>> +
>> +    QSLIST_MOVE_ATOMIC(&reversed, &ctx->scheduled_coroutines);
>> +    QSLIST_INIT(&straight);
>> +
>> +    while (!QSLIST_EMPTY(&reversed)) {
>> +        Coroutine *co =3D QSLIST_FIRST(&reversed);
>> +        QSLIST_REMOVE_HEAD(&reversed, co_scheduled_next);
>> +        QSLIST_INSERT_HEAD(&straight, co, co_scheduled_next);
>> +    }
>> +
>> +    while (!QSLIST_EMPTY(&straight)) {
>> +        Coroutine *co =3D QSLIST_FIRST(&straight);
>> +        QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
>> +        trace_aio_co_schedule_bh_cb(ctx, co);
>> +        qemu_coroutine_enter(co);
>> +    }
>> +}
>=20
> ctx->scheduled_coroutines is a specialized CoQueue.  Was there no way t=
o
> modify and then use CoQueue instead of open coding it?

First of all, I'm trying to avoid a circular dependency when CoQueue can
use aio_co_schedule (indirectly through aio_co_wake) after patch 7.

Secondarily, co_schedule_bh_cb can perform a single pass on
ctx->scheduled_coroutines because it will be rescheduled by
aio_co_schedule.  The same is not true for qemu_co_queue_restart_all.

Also, CoQueue can have multiple consumers, while scheduled_coroutines
cannot.  Currently, CoQueue needs no thread-safety because it's
protected by AioContext and/or by the non-preemptive nature of
coroutines.  Later, it's going to be protected by an external CoMutex,
just like a mutex/condvar pair.  scheduled_coroutines is different in
this respect.

>> +void aio_co_wake(struct Coroutine *co)
>> +{
>> +    AioContext *ctx;
>> +
>> +    /* Read coroutine before co->ctx.  Matches smp_wmb in
>> +     * qemu_coroutine_enter.
>> +     */
>> +    smp_read_barrier_depends();
>> +    ctx =3D atomic_read(&co->ctx);
>> +
>> +    if (ctx !=3D qemu_get_current_aio_context()) {
>> +        aio_co_schedule(ctx, co);
>> +        return;
>> +    }
>> +
>> +    if (qemu_in_coroutine()) {
>> +        Coroutine *self =3D qemu_coroutine_self();
>> +        assert(self !=3D co);
>> +        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_nex=
t);
>> +    } else {
>> +        aio_context_acquire(ctx);
>> +        qemu_coroutine_enter(co);
>> +        aio_context_release(ctx);
>=20
> Why is it necessary to acquire AioContext here?  We're already in ctx.

We're in its thread, but we've not necessarily acquired it yet.
aio_co_wake is called "aio_*" because it's a central place for
AioContext to acquire itself for coroutines.  This way, coroutines only
care about CoMutexes, and not about AioContext.  This was "highly
recommended" :) by Kevin last year and it's the main change since the
previous posting
(https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg05416.html for
example).

Paolo
