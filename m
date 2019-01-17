Received: from eggs.gnu.org ([209.51.188.92]:49734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gk8af-0003VB-1O
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gk8ad-00059q-Sx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:24:17 -0500
Date: Thu, 17 Jan 2019 15:23:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190117142353.GA6761@localhost.localdomain>
References: <20181207122647.GE5119@linux.fritz.box>
	<bb51b8f9-a3a4-90e6-2f69-57e90ccd623a@virtuozzo.com>
	<20181212122457.GB5415@linux.fritz.box>
	<d0d2cab4-2157-1f9f-3bc9-a70f28a211b0@virtuozzo.com>
	<20181213122039.GC5427@linux.fritz.box>
	<f2fcbcc2-5e0f-053d-f4c7-fe0f5f6092f0@virtuozzo.com>
	<2ee882bf-00cc-addf-d866-c5c916a00774@virtuozzo.com>
	<9d97e822-7c9b-c095-6a27-a74facf21e47@virtuozzo.com>
	<ccb5e146-a601-81d6-28ca-8717adbdb701@virtuozzo.com>
	<83610386-bc64-6691-9af8-e98eb0a68342@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <83610386-bc64-6691-9af8-e98eb0a68342@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] PING: [PATCH] blk: postpone request execution on a
 context protected with "drained section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: "keith.busch@intel.com" <keith.busch@intel.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>, "famz@redhat.com" <famz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Am 17.01.2019 um 13:57 hat Denis Plotnikov geschrieben:
> Kevin,
>=20
> could you please take a look at my last comments?

I read it, and what it told me is essentially that I need to work on it
myself to fully understand the problem and possible acceptable solutions
because you can't seem to find one yourself. I will, but I can't
guarantee when I can find the time for it.

Kevin

> On 15.01.2019 10:22, Denis Plotnikov wrote:
> > ping ping ping ping!!!!
> >=20
> > On 09.01.2019 11:18, Denis Plotnikov wrote:
> >> ping ping!!!
> >>
> >> On 18.12.2018 11:53, Denis Plotnikov wrote:
> >>> ping ping
> >>>
> >>> On 14.12.2018 14:54, Denis Plotnikov wrote:
> >>>>
> >>>>
> >>>> On 13.12.2018 15:20, Kevin Wolf wrote:
> >>>>> Am 13.12.2018 um 12:07 hat Denis Plotnikov geschrieben:
> >>>>>> On 12.12.2018 15:24, Kevin Wolf wrote:
> >>>>>>> Am 11.12.2018 um 17:55 hat Denis Plotnikov geschrieben:
> >>>>>>>>> Why involve the AioContext at all? This could all be kept at =
the
> >>>>>>>>> BlockBackend level without extending the layering violation t=
hat
> >>>>>>>>> aio_disable_external() is.
> >>>>>>>>>
> >>>>>>>>> BlockBackends get notified when their root node is drained, s=
o=20
> >>>>>>>>> hooking
> >>>>>>>>> things up there should be as easy, if not even easier than in
> >>>>>>>>> AioContext.
> >>>>>>>>
> >>>>>>>> Just want to make sure that I understood correctly what you=20
> >>>>>>>> meant by
> >>>>>>>> "BlockBackends get notified". Did you mean that bdrv_drain_end=
=20
> >>>>>>>> calls
> >>>>>>>> child's role callback blk_root_drained_end by calling
> >>>>>>>> bdrv_parent_drained_end?
> >>>>>>>
> >>>>>>> Yes, blk_root_drained_begin/end calls are all you need.=20
> >>>>>>> Specifically,
> >>>>>>> their adjustments to blk->quiesce_counter that are already ther=
e,=20
> >>>>>>> and in
> >>>>>>> the 'if (--blk->quiesce_counter =3D=3D 0)' block of=20
> >>>>>>> blk_root_drained_end()
> >>>>>>> we can resume the queued requests.
> >>>>>> Sounds it should be so, but it doesn't work that way and that's =
why:
> >>>>>> when doing mirror we may resume postponed coroutines too early=20
> >>>>>> when the
> >>>>>> underlying bs is protected from writing at and thus we encounter=
 the
> >>>>>> assert on a write request execution at bdrv_co_write_req_prepare=
 when
> >>>>>> resuming the postponed coroutines.
> >>>>>>
> >>>>>> The thing is that the bs is protected for writing before executi=
on of
> >>>>>> bdrv_replace_node at mirror_exit_common and bdrv_replace_node ca=
lls
> >>>>>> bdrv_replace_child_noperm which, in turn, calls=20
> >>>>>> child->role->drained_end
> >>>>>> where one of the callbacks is blk_root_drained_end which check
> >>>>>> if(--blk->quiesce_counter =3D=3D 0) and runs the postponed reque=
sts
> >>>>>> (coroutines) if the coundition is true.
> >>>>>
> >>>>> Hm, so something is messed up with the drain sections in the mirr=
or
> >>>>> driver. We have:
> >>>>>
> >>>>> =A0=A0=A0=A0 bdrv_drained_begin(target_bs);
> >>>>> =A0=A0=A0=A0 bdrv_replace_node(to_replace, target_bs, &local_err)=
;
> >>>>> =A0=A0=A0=A0 bdrv_drained_end(target_bs);
> >>>>>
> >>>>> Obviously, the intention was to keep the BlockBackend drained dur=
ing
> >>>>> bdrv_replace_node(). So how could blk->quiesce_counter ever get t=
o 0
> >>>>> inside bdrv_replace_node() when target_bs is drained?
> >>>>>
> >>>>> Looking at bdrv_replace_child_noperm(), it seems that the functio=
n has
> >>>>> a bug: Even if old_bs and new_bs are both drained, the quiesce_co=
unter
> >>>>> for the parent reaches 0 for a moment because we call .drained_en=
d for
> >>>>> the old child first and .drained_begin for the new one later.
> >>>>>
> >>>>> So it seems the fix would be to reverse the order and first call
> >>>>> .drained_begin for the new child and then .drained_end for the ol=
d
> >>>>> child. Sounds like a good new testcase for tests/test-bdrv-drain.=
c,=20
> >>>>> too.
> >>>> Yes, it's true, but it's not enough...
> >>>> In mirror_exit_common() we actively manipulate with block driver=20
> >>>> states.
> >>>> When we replaced a node in the snippet you showed we can't allow t=
he=20
> >>>> postponed coroutines to run because the block tree isn't ready to=20
> >>>> receive the requests yet.
> >>>> To be ready, we need to insert a proper block driver state to the=20
> >>>> block backend which is done here
> >>>>
> >>>> =A0=A0=A0=A0 blk_remove_bs(bjob->blk);
> >>>> =A0=A0=A0=A0 blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort=
);
> >>>> =A0=A0=A0=A0 blk_insert_bs(bjob->blk, mirror_top_bs, &error_abort)=
; << << << <<
> >>>>
> >>>> =A0=A0=A0=A0 bs_opaque->job =3D NULL;
> >>>>
> >>>> =A0=A0=A0=A0 bdrv_drained_end(src);
> >>>>
> >>>> If the tree isn't ready and we resume the coroutines, we'll end up=
=20
> >>>> with the request landed in a wrong block driver state.
> >>>>
> >>>> So, we explicitly should stop all activities on all the driver sta=
tes
> >>>> and its parents and allow the activities when everything is ready =
to=20
> >>>> go.
> >>>>
> >>>> Why explicitly, because the block driver states may belong to=20
> >>>> different block backends at the moment of the manipulation beginni=
ng.
> >>>>
> >>>> So, it seems we need to disable all their contexts until the=20
> >>>> manipulation ends.
> >>>>
> >>>> Please, correct me if I'm wrong.
> >>>>
> >>>>>
> >>>>>> In seems that if the external requests disabled on the context w=
e=20
> >>>>>> can't
> >>>>>> rely on anything or should check where the underlying bs and its
> >>>>>> underlying nodes are ready to receive requests which sounds quit=
e
> >>>>>> complicated.
> >>>>>> Please correct me if still don't understand something in that=20
> >>>>>> routine.
> >>>>>
> >>>>> I think the reason why reyling on aio_disable_external() works is=
=20
> >>>>> simply
> >>>>> because src is also drained, which keeps external events in the
> >>>>> AioContext disabled despite the bug in draining the target node.
> >>>>>
> >>>>> The bug would become apparent even with aio_disable_external() if=
 we
> >>>>> didn't drain src, or even if we just supported src and target bei=
ng in
> >>>>> different AioContexts.
> >>>>
> >>>> Why don't we disable all those contexts involved until the end of=20
> >>>> the block device tree reconstruction?
> >>>>
> >>>> Thanks!
> >>>>
> >>>> Denis
> >>>>>
> >>>>> Kevin
> >>>>>
> >>>>
> >>>
> >>
> >=20
>=20
> --=20
> Best,
> Denis
