Received: from eggs.gnu.org ([209.51.188.92]:37347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hBBIB-0006Jq-1N
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 00:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hBBI8-0006H7-QW
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 00:44:58 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hB9cC-0007v6-RX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 22:57:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id e5so10617463otk.12
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 19:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <1553010562-13561-1-git-send-email-catherine.hecx@gmail.com>
	<20190320050735.GB8956@xz-x1>
	<CAEn6zmEzwQD_Ot8sttJj0KwML3Zkhfg9+QBxbOLn6bUsDpVn7w@mail.gmail.com>
	<20190321061024.GB9149@xz-x1>
	<CAEn6zmGFv+UbhyriwakFKB=UhnC6=thhybDF9D1E9JzoYL-1oA@mail.gmail.com>
	<CAFEAcA8q0c5BFh-11KNRJWCi6+Yer_5peekmQptmaw8Ag3SNhw@mail.gmail.com>
	<20190322101211.GA2703@work-vm> <20190325033948.GG9149@xz-x1>
	<CAEn6zmF0DRqqUxjKpdxWYdb_ofGXV_wACfELA991qLfvo9N6vA@mail.gmail.com>
In-Reply-To: <CAEn6zmF0DRqqUxjKpdxWYdb_ofGXV_wACfELA991qLfvo9N6vA@mail.gmail.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Tue, 2 Apr 2019 10:57:18 +0800
Message-ID: <CAEn6zmEzcNJGQWrkbP2_v3aidj5o=S39pQgm8kPHqSn8Os=J+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, yury-kotov@yandex-team.ru

Hi all,
I found an insterested issue here besides writting "dtb" rom into ram.
That is, should qemu support incoming from the ignore-shared memory backend
file repeatedly?
After I resolve the issue of writting "dtb" rom into ram, the incoming from
the ignore-shared memory backend file works fine at the *first* time, but
failed in the 2nd time.
It will report:
VQ 2 size 0x400 < last_avail_idx 0x1639 - used_idx 0x2688
Failed to load virtio-scsi:virtio
error while loading state for instance 0x0 of device
'virtio-mmio@000000000a003e00/virtio-scsi'
load of migration failed: Operation not permitted

The root cause is the used idx is moved forward after 1st time incoming,
and in 2nd time incoming,
the last_avail_idx will be incorrectly restored from the saved device state
file(not in the ram).

I watched this even on x86 for a virtio-scsi disk

Any ideas for supporting 2nd time, 3rd time... incoming restoring?

B.R.
Catherine


On Wed, 27 Mar 2019 at 08:45, Catherine Ho <catherine.hecx@gmail.com> wrote:

> Hi all, thanks for the comments, I am digging into another potential
> error in the
> ignore-shared live migration. After that, I will send out the v2 asap
> B.R.
> Catherine
>
>
> On Mon, 25 Mar 2019 at 11:39, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Mar 22, 2019 at 10:12:11AM +0000, Dr. David Alan Gilbert wrote:
> >
> > [...]
> >
> > > > In general, when we reset the system, we want to bring it
> > > > back to exactly the state that it was in when QEMU was
> > > > first started. That means we need to reload all the rom blob
> > > > data into memory (because the guest might have modified
> > > > that memory while it was running).
> > > >
> > > > If I understand correctly from other threads, the idea is
> > > > that some of the RAM is shared between source and destination
> > > > so it does not need to be manually copied during migration.
> > > > If that is correct, then perhaps the right thing is that
> > > > in the rom_reset code:
> > > >  * if this rom blob is being loaded into a "shared" ram block
> > > >  * and this reset is happening specifically before an
> > > >    inbound migration
> > > >  * then skip loading the rom blob data
> > > >
> > > > ?
> > > >
> > > > I don't know the right way to determine either the "is this
> > > > a shared ram area" or "is this the reset prior to inbound
> > > > migration", but perhaps you can fill that in.
> > >
> > > Right, so in Catherine's patch there's a simple in_incoming_migration
> > > and checking ramblock_is_ignored;  it might be better to use the
> > > qemu_ram_is_shared() call and I wonder if we can just check for being
> in
> > > RUN_STATE_INMIGRATE - if that's early enough.
> >
> > Yes I feel like runstate_check(RUN_STATE_INMIGRATE) should be enough
> > to replace the new variable.  And I'm even thinking whether we need to
> > check qemu_ram_is_shared() at all... if rom_reset() simply refills the
> > ROM data into the RAMs, then IIUC that operation could be skipped for
> > all incoming migrations because all those ROM data (no matter they are
> > filled into shared RAM or not) should already have been filled on the
> > source side and:
> >
> > - if the ROM data's RAMBlock is shared backend, the latest data should
> >   already been there on the shared backend files, or,
> >
> > - if the ROM data's RAMBlock is not shared backend, they'll eventually
> >   be migrated to the destination later on after this rom_reset() on
> >   destination by the general RAM migration code.
> >
> > Regards,
> >
> > --
> > Peter Xu
>
