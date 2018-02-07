Received: from eggs.gnu.org ([2001:4830:134:3::10]:36540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejUTr-00037O-Ss
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejUTn-0004nV-Lz
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:30:03 -0500
Date: Wed, 7 Feb 2018 18:29:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180207182930.GV2665@work-vm>
References: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
	<20170919143829.GH2107@work-vm>
	<48cdd8ff-4940-9aa1-9aba-1acf8ce74ebe@kamp.de>
	<20170919144130.GI2107@work-vm>
	<a271a2f8-173e-45c8-bd64-16f4963b3518@kamp.de>
	<20170921123625.GE2717@work-vm>
	<b7f1d6ec-9511-ef3d-80d1-c52cf8adfc24@kamp.de>
	<20171212170533.GG2409@work-vm>
	<8ed6cb1e-4770-21ec-164e-7142e649eab3@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8ed6cb1e-4770-21ec-164e-7142e649eab3@kamp.de>
Content-Transfer-Encoding: quoted-printable
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
> Am 12.12.2017 um 18:05 schrieb Dr. David Alan Gilbert:
> > * Peter Lieven (pl@kamp.de) wrote:
> > > Am 21.09.2017 um 14:36 schrieb Dr. David Alan Gilbert:
> > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > Am 19.09.2017 um 16:41 schrieb Dr. David Alan Gilbert:
> > > > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > > > Am 19.09.2017 um 16:38 schrieb Dr. David Alan Gilbert:
> > > > > > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > > > > > Hi,
> > > > > > > > >=20
> > > > > > > > > I just noticed that CPU throttling and Block Migration =
don't work together very well.
> > > > > > > > > During block migration the throttling heuristic detects=
 that we obviously make no progress
> > > > > > > > > in ram transfer. But the reason is the running block mi=
gration and not a too high dirty pages rate.
> > > > > > > > >=20
> > > > > > > > > The result is that any VM is throttled by 99% during bl=
ock migration.
> > > > > > > > Hmm that's unfortunate; do you have a bandwidth set lower=
 than your
> > > > > > > > actual network connection? I'm just wondering if it's act=
ually going
> > > > > > > > between the block and RAM iterative sections or getting s=
tuck in ne.
> > > > > > > It happens also if source and dest are on the same machine =
and speed is set to 100G.
> > > > > > But does it happen if they're not and the speed is set low?
> > > > > Yes, it does. I noticed it in our test environment between diff=
erent nodes with a 10G
> > > > > link in between. But its totally clear why it happens. During b=
lock migration we transfer
> > > > > all dirty memory pages in each round (if there is moderate memo=
ry load), but all dirty
> > > > > pages are obviously more than 50% of the transferred ram in tha=
t round.
> > > > > It is more exactly 100%. But the current logic triggers on this=
 condition.
> > > > >=20
> > > > > I think I will go forward and send a patch which disables auto =
converge during
> > > > > block migration bulk stage.
> > > > Yes, that's fair;  it probably would also make sense to throttle =
the RAM
> > > > migration during the block migration bulk stage, since the chance=
s are
> > > > it's not going to get far.  (I think in the nbd setup, the main
> > > > migration process isn't started until the end of bulk).
> > > Catching up with the idea of delaying ram migration until block bul=
k has completed.
> > > What do you think is the easiest way to achieve this?
> > <excavates inbox, and notices I never replied>
> >=20
> > I think the answer depends whether we think this is a 'special' or we
> > need a new general purpose mechanism.
> >=20
> > If it was really general then we'd probably want to split the iterati=
ve
> > stage in two somehow, and only do RAM in the second half.
> >=20
> > But I'm not sure it's worth it; I suspect the easiest way is:
> >=20
> >     a) Add a counter in migration/ram.c or in the RAM state somewhere
> >     b) Make ram_save_inhibit increment the counter
> >     c) Check the counter at the head of ram_save_iterate and just exi=
t
> >       if it's none 0
> >     d) Call ram_save_inhibit from block_save_setup
> >     e) Then release it when you've finished the bulk stage
> >=20
> > Make sure you still count the RAM in the pending totals, otherwise
> > migration might think it's finished a bit early.
>=20
> Is there any culprit I don't see or is it as easy as this?

Hmm, looks promising doesn't it;  might need an include or two tidied
up, but looks worth a try.   Just be careful that there are no cases
where block migration can't transfer data in that state, otherwise we'll
keep coming back to here and spewing empty sections.

Dave

> diff --git a/migration/ram.c b/migration/ram.c
> index cb1950f..c67bcf1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2255,6 +2255,13 @@ static int ram_save_iterate(QEMUFile *f, void *o=
paque)
> =A0=A0=A0=A0 int64_t t0;
> =A0=A0=A0=A0 int done =3D 0;
>=20
> +=A0=A0=A0 if (blk_mig_bulk_active()) {
> +=A0=A0=A0=A0=A0=A0=A0 /* Avoid transferring RAM during bulk phase of b=
lock migration as
> +=A0=A0=A0=A0=A0=A0=A0=A0 * the bulk phase will usually take a lot of t=
ime and transferring
> +=A0=A0=A0=A0=A0=A0=A0=A0 * RAM updates again and again is pointless. *=
/
> +=A0=A0=A0=A0=A0=A0=A0 goto out;
> +=A0=A0=A0 }
> +
> =A0=A0=A0=A0 rcu_read_lock();
> =A0=A0=A0=A0 if (ram_list.version !=3D rs->last_version) {
> =A0=A0=A0=A0=A0=A0=A0=A0 ram_state_reset(rs);
> @@ -2301,6 +2308,7 @@ static int ram_save_iterate(QEMUFile *f, void *op=
aque)
> =A0=A0=A0=A0=A0 */
> =A0=A0=A0=A0 ram_control_after_iterate(f, RAM_CONTROL_ROUND);
>=20
> +out:
> =A0=A0=A0=A0 qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> =A0=A0=A0=A0 ram_counters.transferred +=3D 8;
>=20
>=20
> Peter
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
