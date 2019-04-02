Received: from eggs.gnu.org ([209.51.188.92]:54385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBNLr-0005Hs-Bz
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 13:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBNLq-0007BN-0l
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 13:37:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hBNLp-00079z-A4
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 13:37:33 -0400
Date: Tue, 2 Apr 2019 18:37:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190402173722.GI2861@work-vm>
References: <20190322101211.GA2703@work-vm> <20190325033948.GG9149@xz-x1>
	<CAEn6zmF0DRqqUxjKpdxWYdb_ofGXV_wACfELA991qLfvo9N6vA@mail.gmail.com>
	<CAEn6zmEzcNJGQWrkbP2_v3aidj5o=S39pQgm8kPHqSn8Os=J+g@mail.gmail.com>
	<CAFEAcA_=7E9nrFLLmhXBwk5k10ufhKQKX+ZCttfWOxOYt=hZog@mail.gmail.com>
	<CAEn6zmGmNLp5dF-1ViQn_HFnim9+FuGSXAptrReouQCQbsa=KQ@mail.gmail.com>
	<20190402075801.GE11008@xz-x1>
	<CAEn6zmEjYh6uK3Y5cyenLKDKe+cCpjC5HOnNNoM6SniDAKPwzQ@mail.gmail.com>
	<20190402123659.GG11008@xz-x1>
	<CAEn6zmG6GMgYkDNwYFtBPx0XYWNoixDAgiasso+BL_Vyrs74yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEn6zmG6GMgYkDNwYFtBPx0XYWNoixDAgiasso+BL_Vyrs74yQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: avoid copying ignore-shared
 ramblock when in incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Catherine Ho <catherine.hecx@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Yury Kotov <yury-kotov@yandex-team.ru>

* Catherine Ho (catherine.hecx@gmail.com) wrote:
> On Tue, 2 Apr 2019 at 20:37, Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Tue, Apr 02, 2019 at 05:06:15PM +0800, Catherine Ho wrote:
> > > On Tue, 2 Apr 2019 at 15:58, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > > On Tue, Apr 02, 2019 at 03:47:16PM +0800, Catherine Ho wrote:
> > > > > Hi Peter Maydell
> > > > >
> > > > > On Tue, 2 Apr 2019 at 11:05, Peter Maydell <peter.maydell@linar=
o.org
> > >
> > > > wrote:
> > > > >
> > > > > > On Tue, 2 Apr 2019 at 09:57, Catherine Ho <
> > catherine.hecx@gmail.com>
> > > > > > wrote:
> > > > > > > The root cause is the used idx is moved forward after 1st t=
ime
> > > > incoming,
> > > > > > and in 2nd time incoming,
> > > > > > > the last_avail_idx will be incorrectly restored from the sa=
ved
> > device
> > > > > > state file(not in the ram).
> > > > > > >
> > > > > > > I watched this even on x86 for a virtio-scsi disk
> > > > > > >
> > > > > > > Any ideas for supporting 2nd time, 3rd time... incoming
> > restoring?
> > > > > >
> > > > > > Does the destination end go through reset between the 1st and=
 2nd
> > > > > >
> > > > > seems not, please see my step below
> > > > >
> > > > > > incoming attempts? I'm not a migration expert, but I thought =
that
> > > > > > devices were allowed to assume that their state is "state of =
the
> > > > > > device following QEMU reset" before the start of an incoming
> > > > > > migration attempt.
> > > > > >
> > > > >
> > > > > Here  is my step:
> > > > > 1. start guest normal by qemu with shared memory-backend file
> > > > > 2. stop the vm. save the device state to another file via monit=
or
> > migrate
> > > > > "exec: cat>..."
> > > > > 3. quit the vm
> > > > > 4. retore the vm by qemu -incoming "exec:cat ..."
> > > > > 5. continue the vm via monito, the 1st incoming works fine
> > > > > 6. quit the vm
> > > > > 7. retore the vm by qemu -incoming "exec:cat ..." for 2nd time
> > > > > 8. continue   -> error happened
> > > > > Actually, this can be fixed by forcely restore the idx by
> > > > > virtio_queue_restore_last_avail_idx(=EF=BC=89
> > > > > But I am sure whether it is reasonable.
> > > >
> > > > Yeah I really suspect its validity.
> > > >
> > > > IMHO normal migration streams keep the device state and RAM data
> > > > together in the dumped file, so they always match.
> > > >
> > > > In your shared case, the device states are in the dumped file how=
ever
> > > > the RAM data is located somewhere else.  After you quit the VM fr=
om
> > > > the 1st incoming migration the RAM is new (because that's a share=
d
> > > > memory file) and the device data is still old.  They do not match
> > > > already, then I'd say you can't migrate with that any more.
> > > >
> > > > If you want to do that, you'd better take snapshot of the RAM bac=
kend
> > > > file if your filesystem supports (or even simpler, to back it up
> > > > before hand) before you start any incoming migration.  Then with =
the
> > > > dumped file (which contains the device states) and that snapshot =
file
> > > > (which contains the exact RAM data that matches the device states=
)
> > > > you'll alway be able to migrate for as many times as you want.
> > > >
> > >
> > > Understood, thanks Peter Xu
> > > Is there any feasible way to indicate the snapshot of the RAM backe=
nd
> > file
> > > is
> > > matched with the device data?
> > > >VQ 2 size 0x400 < last_avail_idx 0x1639 - used_idx 0x2688
> > > >Failed to load virtio-scsi:virtio
> > >
> > > Because I thought reporting above error is not so friendly. Could w=
e add
> > a
> > > version id in both RAM backend file and device date file?
> >
> > It would be non-trivial I'd say - AFAIK we don't have an existing way
> > to tag the memory-backend-file content (IIUC that's what you use).
> >
> > And since you mentioned about versioning of these states, I just
> > remembered that even with this you may not be able to get a complete
> > matched state of the VM, because AFAICT actually besides RAM state &
> > device state, you probably also need to consider the disk state as
> > well.  After you started the VM of the 1st incoming, there could be
> > data flushed to the VM backend disk and then that state is changed as
> > well.  So here even if you snapshot the RAM file you'll still lose th=
e
> > disk state IIUC so it could still be broken.  In other words, to make
> > a migration/snapshot to work you'll need to make all these three
> > states to match.
> >
>=20
> Yes, thanks
>=20
> >
> > Before we discuss further on the topic... could you share me with you=
r
> > requirement first?  I started to get a bit confused now since when I
> > thought about shared mem I was thinking about migrating within the
> > same host to e.g. upgrade the hypervisor but that obviously does not
> > need you to do incoming migration for multiple times.  Then what do
> > you finally want to achieve?
> >
> Actually, I am investigating the ignore-shared capability case support =
on
> arm64. This feature is used in Kata containers project as "vm template"
>  The rom reset failure is the first bug.
> Ok, now I can confirm that doing incoming migration for multiple times =
is
> supported. Thanks for the detailed explanation :)

I think the kata case should be OK;  it's just you've got to be
careful of what you're doing once you start splitting the state into
separate chunks.  That's always been true with the disk/ram split and
it just gets a bit hairier when you split the RAM/devices.

Dave

> B.R.
> Catherine
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
