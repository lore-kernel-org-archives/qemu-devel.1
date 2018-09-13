Received: from eggs.gnu.org ([2001:4830:134:3::10]:43818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0NFM-000428-KL
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0NFL-0001M8-KH
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:45:08 -0400
Date: Thu, 13 Sep 2018 10:44:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180913084450.GA5172@localhost.localdomain>
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
	<20180629124052.331406-3-dplotnikov@virtuozzo.com>
	<20180910124136.GF4901@dhcp-200-186.str.redhat.com>
	<81346e2a-5ce2-50d3-791e-3cab5e2464d9@virtuozzo.com>
	<20180912131503.GD5846@localhost.localdomain>
	<5706f9f2-386f-aca9-4b7d-9fb924c68a7e@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5706f9f2-386f-aca9-4b7d-9fb924c68a7e@openvz.org>
Content-Transfer-Encoding: quoted-printable
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
To: "Denis V. Lunev" <den@openvz.org>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, mreitz@redhat.com, stefanha@redhat.com, vsementsov@virtuozzo.com, famz@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 12.09.2018 um 19:03 hat Denis V. Lunev geschrieben:
> On 09/12/2018 04:15 PM, Kevin Wolf wrote:
> > Am 12.09.2018 um 14:03 hat Denis Plotnikov geschrieben:
> >> On 10.09.2018 15:41, Kevin Wolf wrote:
> >>> Am 29.06.2018 um 14:40 hat Denis Plotnikov geschrieben:
> >>>> Fixes the problem of ide request appearing when the BDS is in
> >>>> the "drained section".
> >>>>
> >>>> Without the patch the request can come and be processed by the mai=
n
> >>>> event loop, as the ide requests are processed by the main event lo=
op
> >>>> and the main event loop doesn't stop when its context is in the
> >>>> "drained section".
> >>>> The request execution is postponed until the end of "drained secti=
on".
> >>>>
> >>>> The patch doesn't modify ide specific code, as well as any other
> >>>> device code. Instead, it modifies the infrastructure of asynchrono=
us
> >>>> Block Backend requests, in favor of postponing the requests arisen
> >>>> when in "drained section" to remove the possibility of request app=
earing
> >>>> for all the infrastructure clients.
> >>>>
> >>>> This approach doesn't make vCPU processing the request wait untill
> >>>> the end of request processing.
> >>>>
> >>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >>> I generally agree with the idea that requests should be queued duri=
ng a
> >>> drained section. However, I think there are a few fundamental probl=
ems
> >>> with the implementation in this series:
> >>>
> >>> 1) aio_disable_external() is already a layering violation and we'd =
like
> >>>     to get rid of it (by replacing it with a BlockDevOps callback f=
rom
> >>>     BlockBackend to the devices), so adding more functionality ther=
e
> >>>     feels like a step in the wrong direction.
> >>>
> >>> 2) Only blk_aio_* are fixed, while we also have synchronous public
> >>>     interfaces (blk_pread/pwrite) as well as coroutine-based ones
> >>>     (blk_co_*). They need to be postponed as well.
> >> Good point! Thanks!
>=20
> Should we really prohibit all public interfaces, as they are reused
> inside block level?

We need to fix that. blk_*() should never be called from inside the BDS
layer.

> There is also a problem which is not stated in the clear words yet.
> We have potential deadlock in the code under the following
> conditions, which should be also taken into the consideration.
>=20
> <path from the controller>
> bdrv_co_pwritev
> =A0=A0=A0 bdrv_inc_in_flight
> =A0=A0=A0 bdrv_aligned_pwritev
> =A0=A0=A0=A0=A0=A0=A0 notifier_list_with_return_notify
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 backup_before_write_notify
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 backup_do_cow
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 backup_cow=
_with_bounce_buffer
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 blk_co_preadv
>=20
> Here blk_co_preadv() must finish its work before we will release the
> notifier and finish request initiated from the controller and which
> has incremented in-fligh counter.

Yes, before_write notifiers are evil. I've objected to them since the
day they were introduced and I'm surprised it's becoming a problem only
now.

We should probably change the backup job to insert a job node rather
sooner than later. Then it doesn't need to call blk_*() any more.

> Thus we should differentiate requests initiated at the controller
> level and requests initiated in the block layer.  This is sad but
> true.

The difference is supposed to be whether a request goes through a
BlockBackend or not.

Kevin
