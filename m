Received: from eggs.gnu.org ([2001:4830:134:3::10]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1g08Xb-0001t1-CH
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1g08XY-0003Tz-06
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:02:59 -0400
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
	<20180629124052.331406-3-dplotnikov@virtuozzo.com>
	<20180910124136.GF4901@dhcp-200-186.str.redhat.com>
	<81346e2a-5ce2-50d3-791e-3cab5e2464d9@virtuozzo.com>
	<20180912131503.GD5846@localhost.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <5706f9f2-386f-aca9-4b7d-9fb924c68a7e@openvz.org>
Date: Wed, 12 Sep 2018 20:03:10 +0300
MIME-Version: 1.0
In-Reply-To: <20180912131503.GD5846@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v0 2/2] block: postpone the coroutine
 executing if the BDS's is drained
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: mreitz@redhat.com, stefanha@redhat.com, vsementsov@virtuozzo.com, famz@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org

On 09/12/2018 04:15 PM, Kevin Wolf wrote:
> Am 12.09.2018 um 14:03 hat Denis Plotnikov geschrieben:
>> On 10.09.2018 15:41, Kevin Wolf wrote:
>>> Am 29.06.2018 um 14:40 hat Denis Plotnikov geschrieben:
>>>> Fixes the problem of ide request appearing when the BDS is in
>>>> the "drained section".
>>>>
>>>> Without the patch the request can come and be processed by the main
>>>> event loop, as the ide requests are processed by the main event loop
>>>> and the main event loop doesn't stop when its context is in the
>>>> "drained section".
>>>> The request execution is postponed until the end of "drained section".
>>>>
>>>> The patch doesn't modify ide specific code, as well as any other
>>>> device code. Instead, it modifies the infrastructure of asynchronous
>>>> Block Backend requests, in favor of postponing the requests arisen
>>>> when in "drained section" to remove the possibility of request appeari=
ng
>>>> for all the infrastructure clients.
>>>>
>>>> This approach doesn't make vCPU processing the request wait untill
>>>> the end of request processing.
>>>>
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> I generally agree with the idea that requests should be queued during a
>>> drained section. However, I think there are a few fundamental problems
>>> with the implementation in this series:
>>>
>>> 1) aio_disable_external() is already a layering violation and we'd like
>>>     to get rid of it (by replacing it with a BlockDevOps callback from
>>>     BlockBackend to the devices), so adding more functionality there
>>>     feels like a step in the wrong direction.
>>>
>>> 2) Only blk_aio_* are fixed, while we also have synchronous public
>>>     interfaces (blk_pread/pwrite) as well as coroutine-based ones
>>>     (blk_co_*). They need to be postponed as well.
>> Good point! Thanks!

Should we really prohibit all public interfaces, as they are reused
inside block
level?

There is also a problem which is not stated in the clear words yet.
We have potential deadlock in the code under the following
conditions, which should be also taken into the consideration.

<path from the controller>
bdrv_co_pwritev
=C2=A0=C2=A0=C2=A0 bdrv_inc_in_flight
=C2=A0=C2=A0=C2=A0 bdrv_aligned_pwritev
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 notifier_list_with_return_notify
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ba=
ckup_before_write_notify
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 backup_do_cow
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup_cow_with_bounce_buffer
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_c=
o_preadv

Here blk_co_preadv() must finish its work before we
will release the notifier and finish request initiated
from the controller and which has incremented
in-fligh counter.

Thus we should differentiate requests initiated at the
controller level and requests initiated in the block layer.
This is sad but true.

The idea to touch only these interfaces was to avoid
interference with block jobs code. It is revealed that
the approach is a mistake and we should have a
segregation by request kinds. Thus the idea of the
flag for use in the controller code should not be that
awful.


>>>     blk_co_preadv/pwritev() are the common point in the call chain for
>>>     all of these variants, so this is where the fix needs to live.
>> Using the common point might be a good idea, but in case aio requests we
>> also have to mane completions which out of the scope of
>> blk_co_p(read|write)v:
> I don't understand what you mean here (possibly because I fail to
> understand the word "mane") and what completions have to do with
> queueing of requests.
>
> Just to clarify, we are talking about the following situation, right?
> bdrv_drain_all_begin() has returned, so all the old requests have
> already been drained and their completion callback has already been
> called. For any new requests that come in, we need to queue them until
> the drained section ends. In other words, they won't reach the point
> where they could possibly complete before .drained_end.

Such requests should not reach the point once they will start to
execute EXCEPT notifiers. There is a big problem with synchronous
which can queue new requests and that requests are to be finished.

Den
