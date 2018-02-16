Received: from eggs.gnu.org ([2001:4830:134:3::10]:52122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emmV2-0001NH-Jh
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emmV1-0008Tg-Cf
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:20:52 -0500
Date: Fri, 16 Feb 2018 20:20:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180216202020.GG2308@work-vm>
References: <20170919143829.GH2107@work-vm>
	<48cdd8ff-4940-9aa1-9aba-1acf8ce74ebe@kamp.de>
	<20170919144130.GI2107@work-vm>
	<a271a2f8-173e-45c8-bd64-16f4963b3518@kamp.de>
	<20170921123625.GE2717@work-vm>
	<b7f1d6ec-9511-ef3d-80d1-c52cf8adfc24@kamp.de>
	<20171212170533.GG2409@work-vm>
	<8ed6cb1e-4770-21ec-164e-7142e649eab3@kamp.de>
	<20180207182930.GV2665@work-vm>
	<66CC7380-04E1-4656-A9BF-F075FC109C94@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <66CC7380-04E1-4656-A9BF-F075FC109C94@kamp.de>
Subject: Re: [Qemu-devel] Block Migration and CPU throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu block <qemu-block@nongnu.org>, jjherne@linux.vnet.ibm.com

* Peter Lieven (pl@kamp.de) wrote:
>=20
> > Am 07.02.2018 um 19:29 schrieb Dr. David Alan Gilbert <dgilbert@redhat.=
com>:
> >=20
> > * Peter Lieven (pl@kamp.de) wrote:
> >> Am 12.12.2017 um 18:05 schrieb Dr. David Alan Gilbert:
> >>> * Peter Lieven (pl@kamp.de) wrote:
> >>>> Am 21.09.2017 um 14:36 schrieb Dr. David Alan Gilbert:
> >>>>> * Peter Lieven (pl@kamp.de) wrote:
> >>>>>> Am 19.09.2017 um 16:41 schrieb Dr. David Alan Gilbert:
> >>>>>>> * Peter Lieven (pl@kamp.de) wrote:
> >>>>>>>> Am 19.09.2017 um 16:38 schrieb Dr. David Alan Gilbert:
> >>>>>>>>> * Peter Lieven (pl@kamp.de) wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>=20
> >>>>>>>>>> I just noticed that CPU throttling and Block Migration don't w=
ork together very well.
> >>>>>>>>>> During block migration the throttling heuristic detects that w=
e obviously make no progress
> >>>>>>>>>> in ram transfer. But the reason is the running block migration=
 and not a too high dirty pages rate.
> >>>>>>>>>>=20
> >>>>>>>>>> The result is that any VM is throttled by 99% during block mig=
ration.
> >>>>>>>>> Hmm that's unfortunate; do you have a bandwidth set lower than =
your
> >>>>>>>>> actual network connection? I'm just wondering if it's actually =
going
> >>>>>>>>> between the block and RAM iterative sections or getting stuck i=
n ne.
> >>>>>>>> It happens also if source and dest are on the same machine and s=
peed is set to 100G.
> >>>>>>> But does it happen if they're not and the speed is set low?
> >>>>>> Yes, it does. I noticed it in our test environment between differe=
nt nodes with a 10G
> >>>>>> link in between. But its totally clear why it happens. During bloc=
k migration we transfer
> >>>>>> all dirty memory pages in each round (if there is moderate memory =
load), but all dirty
> >>>>>> pages are obviously more than 50% of the transferred ram in that r=
ound.
> >>>>>> It is more exactly 100%. But the current logic triggers on this co=
ndition.
> >>>>>>=20
> >>>>>> I think I will go forward and send a patch which disables auto con=
verge during
> >>>>>> block migration bulk stage.
> >>>>> Yes, that's fair;  it probably would also make sense to throttle th=
e RAM
> >>>>> migration during the block migration bulk stage, since the chances =
are
> >>>>> it's not going to get far.  (I think in the nbd setup, the main
> >>>>> migration process isn't started until the end of bulk).
> >>>> Catching up with the idea of delaying ram migration until block bulk=
 has completed.
> >>>> What do you think is the easiest way to achieve this?
> >>> <excavates inbox, and notices I never replied>
> >>>=20
> >>> I think the answer depends whether we think this is a 'special' or we
> >>> need a new general purpose mechanism.
> >>>=20
> >>> If it was really general then we'd probably want to split the iterati=
ve
> >>> stage in two somehow, and only do RAM in the second half.
> >>>=20
> >>> But I'm not sure it's worth it; I suspect the easiest way is:
> >>>=20
> >>>    a) Add a counter in migration/ram.c or in the RAM state somewhere
> >>>    b) Make ram_save_inhibit increment the counter
> >>>    c) Check the counter at the head of ram_save_iterate and just exit
> >>>      if it's none 0
> >>>    d) Call ram_save_inhibit from block_save_setup
> >>>    e) Then release it when you've finished the bulk stage
> >>>=20
> >>> Make sure you still count the RAM in the pending totals, otherwise
> >>> migration might think it's finished a bit early.
> >>=20
> >> Is there any culprit I don't see or is it as easy as this?
> >=20
> > Hmm, looks promising doesn't it;  might need an include or two tidied
> > up, but looks worth a try.   Just be careful that there are no cases
> > where block migration can't transfer data in that state, otherwise we'll
> > keep coming back to here and spewing empty sections.
>=20
> I already tested it and it actually works.

OK.

> What would you expect to be cleaned up before it would be a proper patch?

It's simple enough so not much; maybe add a trace for when it does the
exit just to make it easier to watch; I hadn't realised ram.c already
included migration/block.h for the !bulk case.

> Are there any implications with RDMA

Hmm; don't think so; it's mainly concerned with how the RAM is
transferred; and the ram_control_* hooks are called after your test,
and on the load side only once it's read the flags and got a block.

> and/or post copy migration?

Again I don't think so;  I think block migration always shows the
outstanding amount of block storage, and so it won't flip into postcopy
mode until the bulk of block migration is done.
Also the 'ram_save_complete' does it's own scan of blocks and doesn't
share the iterate code, so it won't be affected by your change.

> Is block migration possible at all with those?

Yes I think so in both cases; with RDMA I'm pretty sure it is, and I
think people have had it running with postcopy as well.   The postcopy
case isn't great (because the actual block storage isn't postcopied)
and there's work afoot to add other syncing mechanisms on top (see Max
Reitz's series).

To be honest I don't use/test block migration much and hence know it
less; but what you've got seems to make sense, but I would like a nod
=66rom Fam to check from that side.

Dave

> Peter
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
