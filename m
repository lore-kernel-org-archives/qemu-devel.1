Received: from eggs.gnu.org ([2001:4830:134:3::10]:54195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJj1K-0004Qr-Em
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJj1J-0007qN-Hj
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:46:06 -0500
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-4-kwolf@redhat.com>
	<9bd2921d-64c6-724c-0d80-b43e33f41817@redhat.com>
	<20171128162850.GF3703@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <678f5030-926f-2cb5-80a6-629ee8f86c3f@redhat.com>
Date: Tue, 28 Nov 2017 17:45:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171128162850.GF3703@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/4] coroutine: Cancel
 aio_co_schedule() on direct entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On 28/11/2017 17:28, Kevin Wolf wrote:
> To be honest, I just wasn't sure what to do with this case anyway. It
> means that the coroutine is already running when someone else schedules
> it. We don't really know whether we have to enter it a second time or
> not.
>
> So if it can indeed happen in practice, we need to think a bit more
> about this.

>>> This means that the coroutine just needs to
>>> +     * prevent other callers from calling aio_co_schedule() before i=
t yields
>>> +     * (e.g. block job coroutines by setting job->busy =3D true).
>>> +     *
>>> +     * We still want to ensure that the second case doesn't happen, =
so reset
>>> +     * co->scheduled only after setting co->caller to make the above=
 check
>>> +     * effective for the co_schedule_bh_cb() case. */
>>> +    atomic_set(&co->scheduled, NULL);
>>
>> This doesn't work.  The coroutine is still in the list, and if someone
>> calls aio_co_schedule again now, any coroutines linked from "co" via
>> co_scheduled_next are lost.
>=20
> Why would they? We still iterate the whole list in co_schedule_bh_cb(),
> we just skip the single qemu_coroutine_enter().

Because you modify co_scheduled_next (in QSLIST_INSERT_HEAD_ATOMIC)
before it has been consumed.

>> (Also, the AioContext lock is by design not protecting any state in
>> AioContext itself; the AioContext lock is only protecting things that
>> run in an AioContext but do not have their own lock).
>=20
> Such as the coroutine we want to enter, no?

If you mean the Coroutine object then no, coroutines are entirely
thread-safe.  All you need to do is: 1) re-enter them with aio_co_wake
or aio_co_schedule after the first time you've entered them; 2) make
sure you don't enter/schedule them twice.

Paolo
